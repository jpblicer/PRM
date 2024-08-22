class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user = current_user


    if @note.save
      # redirect_to @contact
      respond_to do |format|
        # format.html { redirect_to batch_path(@batch) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:notes, partial: "notes/notes",
            locals: { contact: @note.noteable })
        end
      end
    else
      render contact_path(@contact), status: :unprocessable_entity
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :noteable_id, :noteable_type)
  end
end
