class SongsController < ApplicationController
  skip_before_action :require_login
  before_action :set_song, only: [:show]

  # GET /songs.json
  def index
    @songs = Song.all
    render json: @songs
  end

  # GET /songs/1.json
  def show
    render json: {id: @song.id, title: @song.title, bpm: @song.bpm, analysed: @song.analysed, mp3_url: rails_blob_path(@song.mp3_attachment)}
  end

  # POST /songs.json
  def create
    @song = Song.new(song_params)
    @song.save!
    render json: { status: 200 }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :bpm, :analysed, :mp3)
    end
end
