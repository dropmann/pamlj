
const events = {
  
    update: function(ui) {
         console.log("Updating analysis");
         update_model(ui,this);
    },
      
    onChange_factors: function(ui) {
      
         update_model(ui,this);

    },
    
    onChange_factors_list_change: function(ui) {
      console.log("list changed");
      update_df(ui,this);
      
    }

};

module.exports = events;

    

var update_model = function( ui, context) {

      console.log("factors changed");
      var nfactors = ui.factors.value();
      
      if ( nfactors == 0) {
        ui.factors_group.$el.hide();
        ui.factors_list.setValue([]);
        return
        
      }
      
      ui.factors_group.$el.show();
      var factors = context.cloneArray(ui.factors_list.value(), []);   

      var newarray = new Array(nfactors).fill(0)
      newarray.forEach(function(value, i, arr){
        if (typeof factors[i] === 'undefined')
               arr[i] = {var: "factor " + (i+1), levels: 0};
        else 
               arr[i] = factors[i]
      });
      ui.factors_list.setValue(newarray);


}

var update_df = function( ui, context) {

      var factors = context.cloneArray(ui.factors_list.value(), []);   
      var df_factors=[];
      factors.forEach((value) => {
        if (value.levels > 1) df_factors.push(value.levels-1);
      });
      var df1 = 0;
      if (df_factors.length > 0 ) {
          var inter = getCombinations(df_factors);
          var order = order_num(ui.factors_order.value());
              inter = inter.filter(obj => {return obj.length < order});
              df1= inter.map( (value) => value.reduce( (a,b) => a*b)).reduce( (a,b) => a+b);
      }
    
      var ncovs=ui.covs.value();
      var df_covs= []
      var df2 = 0;
      if (ncovs > 0 ) {
            df_covs = new Array(ncovs).fill(1);
        var order=order_num(ui.covs_order.value());
        var inter = getCombinations(df_covs);
            inter = inter.filter(obj => {return obj.length < order});
            df2= inter.map( (value) => value.reduce( (a,b) => a*b)).reduce( (a,b) => a+b);
      }    
      var df3 = 0;
          order = order_num(ui.mixed_order.value());
      if (order > 1 && df_factors.length > 0 &&  df_covs.length > 0) {
           var covs_comb = getCombinations(df_covs);
           var fact_comb = getCombinations(df_factors);
               inter = covs_comb.flatMap(d => fact_comb.map(v => d.concat(v)));
               var sel = inter.filter((obj) =>  obj.length < order);
               df3=  sel.map( (value) => value.reduce( (a,b) => a*b)).reduce( (a,b) => a+b);
      }

     var df = df1+df2+df3 ;
     ui.df_model.setValue(df);
     console.log("df_model updated to: " + df);
}

var order_num = function(avalue) {
  
  if (avalue==="main")
     return(2)
  if (avalue==="order2")
     return(3)
  if (avalue==="order3")
     return(4)
  if (avalue==="orderall")
     return(1000) // if you want order>1000 you need to think it twice
  if (avalue==="none")
     return(1)

}
var getCombinations = function(valuesArray) {

    var combi = [];
    var temp = [];
    var slent = Math.pow(2, valuesArray.length);
  
    for (var i = 0; i < slent; i++)  {
        temp = [];
        for (var j = 0; j < valuesArray.length; j++) {
            if ((i & Math.pow(2, j))) {
                temp.push(valuesArray[j]);
            }
        }
        if (temp.length > 0)  {
            combi.push(temp);
        }
    }
    
    combi.sort((a, b) => a.length - b.length);
return combi;
}