module GroupsHelper
    def current_group
        #→group/showに移動したときにsessions[:group_id]にparams[:id]を代入するコードが必要
        @current_group = Group.find_by(id: session[:group_id])
    end
end
