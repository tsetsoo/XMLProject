var xslDoc;
var xmlDoc;
var xmlHttpObject;
// var sortKey = {'name', "category","expiration", "price", "stock"};
var sortKey =  "available";
var sortOrder = 'ascending'
var sortType = 'number';
/*
var sortData = {
  'processors' : {
    sortKey: 'available',
    sortOrder: 'ascending',
    sortType: 'number',
  },
  'ram-sticks' : {
    sortKey: 'available',
    sortOrder: 'ascending',
    sortType: 'number',
  },
  'video-cards' : {
    sortKey: 'available',
    sortOrder: 'ascending',
    sortType: 'number',
  },
  'disks' : {
    sortKey: 'available',
    sortOrder: 'ascending',
    sortType: 'number',
  },
  'motherboards' : {
    sortKey: 'available',
    sortOrder: 'ascending',
    sortType: 'number',
  },
}*/

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
    // for (var key in sortData) {
    //   console.log(key, sortData[key]);
    //   processor.setParameter(null, 'sortKey-'+key, sortKey);
    //   processor.setParameter(null, 'sortOrder-'+key, sortOrder);
    //   processor.setParameter(null, 'sortType-'+key, sortType);
    //
    // }

    // processor.setParameter(null, 'sortData', sortData);
    var newDocument = processor.transformToDocument(xmlDoc);
    document.getElementById('table').innerHTML = new XMLSerializer().serializeToString(newDocument);
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


function sort(which, category)
{
  sortData = xsltProcessor.getParameter(null, "sortData");
  console.log(sortData);
  // console.log(category);
  if (sortData[category].sortKey == which) {
    sortData[category].sortOrder = (sortData[category].sortOrder == 'ascending') ? 'descending' : 'ascending';
  } else {
    sortData[category].sortKey = which;
    sortData[category].sortOrder = 'ascending';
  }


  if ( sortData[category].sortKey == 'name' || sortData[category].sortKey == 'manufacturer' || sortData[category].sortKey == 'expiration' ) {
    sortData[category].sortType = 'text';
  }
  else {
    sortData[category].sortType = 'number';
  }
  // console.log(sortData);

  //console.log(sortKey);
  // console.log(sortOrder);
  // console.log(sortType);
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
