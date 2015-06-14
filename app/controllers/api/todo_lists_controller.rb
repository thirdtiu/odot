class Api::TodoListsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    def index
        render json: TodoList.all
    end

    def show
        list = TodoList.find(params[:id])
        render json: list
    end

    def create
        list = TodoList.new(list_params)
        if list.save
            render json: {
                status: 200,
                message: "Successfully created todo list",
                todo_list: list
            }.to_json
        else
            render json: {
                status: 500,
                errors: list.errors
            }.to_json
        end
    end

    def update
        list = TodoList.find(params[:id])
        if list.update(list_params)
            render json: {
                status: 200,
                message: "Successfully updated",
                todo_list: list
            }.to_json
        else
            render json: {
                status: 500,
                errors: list.errors
            }.to_json
        end
    end

    def destroy
        list = TodoList.find(params[:id])
        list.destroy
        render json: {
            status: 200,
            message: "Successfully deleted To-do list"
        }.to_json
    end

    private
    def list_params
        params.require("todo_list").permit('title', 'description')
    end

end