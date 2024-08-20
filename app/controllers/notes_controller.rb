class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to @contact
    else
      render contact_path(@contact), status: :unprocessable_entity
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
