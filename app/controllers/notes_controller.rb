class NotesController < ApplicationController
  def index
  end

  def create
    @task = Task.find(params[ :task_id])
    @note = @task.notes.new(note_params)

    if @note.save
      redirect_to @task
    else
      render 'tasks/show'
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to note.task
  end
  private
  def note_params
    params.require(:note).permit(:content)
  end
end
