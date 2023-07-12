XML xml;
String url = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml";
String dead = "Dead";
String[] q = splitTokens("Dead", "Dies");
PFont font, deadfont;
void setup() {
  size(800, 700);
  font = createFont("Inter-Medium.otf", 1000);
  deadfont = createFont("Moms_typewriter.ttf", 1000);
}

void draw() {
  background(0);

  //Load RSS Feed
  xml = loadXML(url);

  //Get title of each element
  XML[] children = xml.getChildren("channel/item/title");
  XML[] links = xml.getChildren("channel/item/link");
  XML[] images = xml.getChildren("channel/image/url");



  //image(image, i*100, 50);
  int count = 0;
  for (int i = 0; i < children.length; i++) {
    String title = children[i].getContent();
    String[] title2 = split(title, dead);
    if ((title.contains("Dead")) || title.contains("Dies")) {
      fill(#FF0000);
      textFont(deadfont);
      textSize(16);
      textLeading(22);
      text(title, 20, 130+(i*20));
      count++;
    } else {
      fill(#FFFFFF);
      textFont(font);
      textSize(14);
      text(title, 20, 130+(i*20));
    }
  }
  fill(#FF0000);
  rectMode(CENTER);
  rect(mouseX, mouseY, 110, 30);
  textFont(font);
  textSize(16);
  //textAlign(CENTER, CENTER);
  fill(0);
  text("DeadCount: " + count, mouseX-50, mouseY);

  push();
  rectMode(CORNER);
  fill(255);
  rect(0, 0, width, 100);
  fill(0);
  textFont(deadfont);
  textSize(17);
  text("Death Report.", 282, 80);
  pop();
  for (int i = 0; i < images.length; i++) {
    String imageURL = images[i].getContent();
    PImage image = loadImage(imageURL);
    push();
    image(image, 20, 50);
    pop();
  }
  if (frameCount == 1) {
    // saveFrame();
  }
}
