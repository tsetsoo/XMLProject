var xslDoc;
var xmlDoc;
var xmlHttpObject;
var sortKey =  "available";
var sortOrder = "ascending";
var sortType = "number";
var sortKey_processor = "available";
var sortOrder_processor = "ascending";
var sortType_processor = "number";

var sortKey_ram_stick = "available";
var sortOrder_ram_stick = "ascending";
var sortType_ram_stick = "number";

var sortKey_video_card = "available";
var sortOrder_video_card = "ascending";
var sortType_video_card = "number";

var sortKey_disk = "available";
var sortOrder_disk = "ascending";
var sortType_disk = "number";

var sortKey_motherboard = "available";
var sortOrder_motherboard = "ascending";
var sortType_motherboard = "number";

function CreateXmlHttpRequestObject() {
  var xmlObject;

  if (window.ActiveXObject) {
    alert('Sorry, old browsers are not supported!');
    window.stop();
  } else {
    xmlObject = new XMLHttpRequest();
  }

  return xmlObject;
}

function getStyleSheet() {
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

function getDataFile() {
  xmlHttpObject = CreateXmlHttpRequestObject();
  xmlHttpObject.open('GET', 'product.xml', false);
  xmlHttpObject.send(null);

  if (xmlHttpObject.status == 200 || xmlHttpObject.status == 0) {
    xmlDoc = xmlHttpObject.responseXML;
  } else {
    alert('error loading data file ' + xmlHttpObject.status);
  }
}

function doTranslation() {
  try {
    var processor = new XSLTProcessor();
    processor.importStylesheet(xslDoc);

    processor.setParameter(null, 'sortKey', sortKey);
    processor.setParameter(null, 'sortOrder', sortOrder);
    processor.setParameter(null, 'sortType', sortType);

    processor.setParameter(null, 'sortKey-processor', sortKey_processor);
    processor.setParameter(null, 'sortOrder-processor', sortOrder_processor);
    processor.setParameter(null, 'sortType-processor', sortType_processor);

    processor.setParameter(null, 'sortKey-ram-stick', sortKey_ram_stick);
    processor.setParameter(null, 'sortOrder-ram-stick', sortOrder_ram_stick);
    processor.setParameter(null, 'sortType-ram-stick', sortType_ram_stick);

    processor.setParameter(null, 'sortKey-video-card', sortKey_video_card);
    processor.setParameter(null, 'sortOrder-video-card', sortOrder_video_card);
    processor.setParameter(null, 'sortType-video-card', sortType_video_card);

    processor.setParameter(null, 'sortKey-disk', sortKey_disk);
    processor.setParameter(null, 'sortOrder-disk', sortOrder_disk);
    processor.setParameter(null, 'sortType-disk', sortType_disk);

    processor.setParameter(null, 'sortKey-motherboard', sortKey_motherboard);
    processor.setParameter(null, 'sortOrder-motherboard', sortOrder_motherboard);
    processor.setParameter(null, 'sortType-motherboard', sortType_motherboard);

    var newDocument = processor.transformToDocument(xmlDoc);

    document.getElementById('table').innerHTML = new XMLSerializer().serializeToString(newDocument);
  } catch (e) {
    console.log('error with translation', e, e.filename,' at line: ', e.lineNumber);
  }
}


function initialize() {
  getStyleSheet();
  getDataFile();
  doTranslation();
}


function sort(which, category) {
  console.log(category)
  switch (category) {
    case 'processors':
      current_sortKey = sortKey_processor;
      current_sortOrder = sortOrder_processor;
      current_sortType = sortType_processor;
      break;
    case 'ram-sticks':
      current_sortKey = sortKey_ram_stick;
      current_sortOrder = sortOrder_ram_stick;
      current_sortType = sortType_ram_stick;
      break;
    case 'video-cards':
      current_sortKey = sortKey_video_card;
      current_sortOrder = sortOrder_video_card;
      current_sortType = sortType_video_card;
      break;
    case 'disks':
      current_sortKey = sortKey_disk;
      current_sortOrder = sortOrder_disk;
      current_sortType = sortType_disk;
      break;
    case 'motherboards':
      current_sortKey = sortKey_motherboard;
      current_sortOrder = sortOrder_motherboard;
      current_sortType = sortType_motherboard;
      break;
    default:
      current_sortKey = sortKey;
      current_sortOrder = sortOrder;
      current_sortType = sortType;

  }
  if (current_sortKey == which) {
    current_sortOrder = (current_sortOrder == 'ascending') ? 'descending' : 'ascending';
  } else {
    current_sortKey = which;
    current_sortOrder = 'ascending';
  }

  if ( current_sortKey == 'name' || current_sortKey == 'manufacturer' || current_sortKey == 'expiration' ) {
    current_sortType = 'text';
  }
  else {
    current_sortType = 'number';
  }

  switch (category) {
    case 'processors':
      sortKey_processor = current_sortKey;
      sortOrder_processor = current_sortOrder;
      sortType_processor = current_sortType;
      break;
    case 'ram-sticks':
      sortKey_ram_stick = current_sortKey;
      sortOrder_ram_stick = current_sortOrder;
      sortType_ram_stick = current_sortType;
      break;
    case 'video-cards':
      sortKey_video_card = current_sortKey;
      sortOrder_video_card = current_sortOrder;
      sortType_video_card = current_sortType;
      break;
    case 'disks':
      sortKey_disk = current_sortKey;
       sortOrder_disk = current_sortOrder;
       sortType_disk = current_sortType;
      break;
    case 'motherboards':
       sortKey_motherboard = current_sortKey;
      sortOrder_motherboard = current_sortOrder ;
      sortType_motherboard = current_sortType ;
      break;
    default:
      sortKey = current_sortKey;
       sortOrder = current_sortOrder;
       sortType = current_sortType;

  }
doTranslation();
}
