var xslDoc;
var xmlDoc;
var xmlHttpObject;
// var sortKey = {'name', "category","expiration", "price", "stock"};
var sortKey =  "stock";
var sortOrder = 'ascending'
var sortType = 'number';

function CreateXmlHttpRequestObject()
{
  var xmlObject;

  if (window.ActiveXObject) {
    alert('Sorry, old browsers are not supported!');
    window.stop();
  } else {
    xmlObject = new XMLHttpRequest();
  }

  return xmlObject;
}

function getStyleSheet()
{
  xmlHttpObject = CreateXmlHttpRequestObject();
  try {
    xmlHttpObject.open('GET', 'index.xsl', false);
    xmlHttpObject.send(null);
  } catch (e) {
    alert('Try to open with Firefox or other browser with different security settings.');
  }
  if (xmlHttpObject.status == 200 || xmlHttpObject.status == 0) {
    xslDoc = xmlHttpObject.responseXML;
  } else {
    alert('error loading stylesheet' + xmlHttpObject.status);
  }
}

function getDataFile()
{
  xmlHttpObject = CreateXmlHttpRequestObject();
  xmlHttpObject.open('GET', 'test.xml', false);
  xmlHttpObject.send(null);

  if (xmlHttpObject.status == 200 || xmlHttpObject.status == 0) {
    xmlDoc = xmlHttpObject.responseXML;
  } else {
    alert('error loading data file ' + xmlHttpObject.status);
  }
}

function doTranslation()
{
  try {
    var processor = new XSLTProcessor();
    processor.importStylesheet(xslDoc);
    processor.setParameter(null, 'sortKey', sortKey);
    processor.setParameter(null, 'sortOrder', sortOrder);
    processor.setParameter(null, 'sortType', sortType);
    var newDocument = processor.transformToDocument(xmlDoc);
    document.getElementById('table').innerHTML = new XMLSerializer().serializeToString(newDocument);
    console.log(xmlDoc);

  } catch (e) {
    alert('error with translation');
  }
}


function initialize()
{
  getStyleSheet();
  getDataFile();
  doTranslation();
}


function sort(which)
{
  if (sortKey == which) {
    sortOrder = (sortOrder == 'ascending') ? 'descending' : 'ascending';
  } else {
    sortKey = which;
    sortOrder = 'ascending';
  }


  if ( sortKey == 'name' || sortKey == 'category' || sortKey == 'stock' || sortKey == 'expiration' ) {
    sortType = 'text';
  }
  else {
    sortType = 'number';
  }

  console.log(sortKey);
  console.log(sortOrder);
  console.log(sortType);
  // for (var i = sortKey.length - 1; i >= 0; i--) {
  //     sortKey[i]
  //     switch (sortKey[i]) {
  // case "name":
  //     key = sortKey[i];
  //     sortOrder = (sortOrder == 'ascending') ? 'descending' : 'ascending';
  //     sortType = "text";
  //     break;
  // case "price":
  //     key = sortKey[i];
  //     sortOrder = (sortOrder == 'ascending') ? 'descending' : 'ascending';
  //     sortType = "number";
  //     break;
  // }
  //     };
  doTranslation();
}
