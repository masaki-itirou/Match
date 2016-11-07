module ApplicationHelper
  def thumbnail_src(user)
    #public配下の場合
    path = "/image/"
    name = user.thumbnail
    if File.exist?(File.expand_path("../../../public/image/"+name,__FILE__))
      return path+name
    else
      return path+Image::DEFAULT_NAME                  
    end
  end
end
