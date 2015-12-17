$(document).ready(function(){
  $(document).on("pageInit", "#page-address-new", function(e, pageId, $page) {
    appendSelectAhead($("#select_city"));
    appendSelectAhead($("#select_district"));
  });
  $(document).on('change', "#page-address-new #select_province", function(){
    changeProvince();
  });
  $(document).on('change', "#page-address-new #select_city", function(){
    changeCity();
  });
});
function changeProvince(){
  /*清空city、district*/
  appendSelectAhead($("#select_city"));
  appendSelectAhead($("#select_district"));
  /*获取city数据*/
  var selectValue = $("#select_province").val();
  if(!selectValue){
    return;
  }
  $.ajax({
    type:"post",
    url:"/mobile/region_city",
    data:{"province": selectValue},
    dataType:"json",
    success:function(data){
      if(data && data.length>0){
        for (var item in data) {
          $("#select_city").append("<option value='"+data[item].code+"'>"+data[item].name+"</option>");
        };
      }
    },
    error:function(XMLHttpRequest, textStatus, errorThrown){
    }
  });
}
function changeCity(){
  /*清空district*/
  appendSelectAhead($("#select_district"));
  /*获取district数据*/
  var selectValue = $("#select_city").val();
  if(!selectValue){
    return;
  }
  $.ajax({
    type:"post",
    url:"/mobile/region_district",
    data:{"city": selectValue},
    dataType:"json",
    success:function(data){
      if(data && data.length>0){
        for (var item in data) {
          $("#select_district").append("<option value='"+data[item].code+"'>"+data[item].name+"</option>");
        };
      }
    },
    error:function(XMLHttpRequest, textStatus, errorThrown){
    }
  });
}
/*在最前面加个选项*/
function appendSelectAhead(select){
  select.empty();
  select.prepend("<option value=''>-- 请选择 --</option>");
}