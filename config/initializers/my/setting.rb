module Image
  THUMBNAIL_PATH = "public/image/"  
  DEFAULT_NAME = "default.jpg"  
  TYPE = ".jpg"
  MOZAIKU = "ejoainbaoufeaopfjakf477454654120"
  #IMB
  #LIMIT = 1048576
  WIDTH = 120
  HEIGHT = 120
end

Image.freeze

module UserLimit
  NAME = 20 #文字数
  WORD = 200#ワード
  CONTACT = 100
end

UserLimit.freeze

module MatchLimit
  #10min * 60s = 600 
  VALID_TIME = 600
  #SHOW_NUMBER = 50  
  SHOW_NUMBER = 10
end

MatchLimit.freeze

module MyMail
  AD = ""
end

MyMail.freeze