class TubesController

  def index

    @search = params[:search] || 'youtube'
    @num = params[:number] || 3

    developer_key = 'AIzaSyCo03PzJr-BpstJWgqxrTWICr3X_rESmaM'

    youtube = Unirest.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{@search}&type=video&maxResults=#{@num}&key=#{developer_key}").body

    @youtube = youtube['items']

  end

end
