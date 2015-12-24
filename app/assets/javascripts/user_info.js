$(document).ready(function(){
  $(document).on("pageInit", "#page-address-new", function(e, pageId, $page) {
    appendSelectAhead($("#address_city"));
    appendSelectAhead($("#address_area"));
  });
  $(document).on('change', "#page-address-new #address_province", function(){
    changeProvince();
  });
  $(document).on('change', "#page-address-new #address_city", function(){
    changeCity();
  });
  $(document).on("pageInit", "#page-address-edit", function(e, pageId, $page) {
    appendSelectAhead($("#address_city"));
    appendSelectAhead($("#address_area"));
  });
  $(document).on('change', "#page-address-edit #address_province", function(){
    changeProvince();
  });
  $(document).on('change', "#page-address-edit #address_city", function(){
    changeCity();
  });
  $(document).on("click", "a[data-method='delete']", function(e){
    return false;
    var the_href = this.href;
    this.href = "#";
    e.preventDefault();
    toConfirmDelete();
    toAjaxAction();
  });
});
function changeProvince(){
  /*清空city、district*/
  appendSelectAhead($("#address_city"));
  appendSelectAhead($("#address_area"));
  /*获取city数据*/
  var selectValue = $("#address_province").val();
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
          $("#address_city").append("<option value='"+data[item].code+"'>"+data[item].name+"</option>");
        };
      }
    },
    error:function(XMLHttpRequest, textStatus, errorThrown){
    }
  });
}
function changeCity(){
  /*清空district*/
  appendSelectAhead($("#address_area"));
  /*获取district数据*/
  var selectValue = $("#address_city").val();
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
          $("#address_area").append("<option value='"+data[item].code+"'>"+data[item].name+"</option>");
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
//处理弹窗
function toConfirmDelete(){
  $.confirm('确定删除?', function () {
    $.alert('你点击了确定按钮!');
  });
}
  //处理请求
function toAjaxAction(){
}