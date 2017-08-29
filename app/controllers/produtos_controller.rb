class ProdutosController < ApplicationController
  before_action :set_produto, only: [:edit, :update, :destroy]

  def index
    @produtos_por_nome = Produto.order(:nome).limit 5
    @produtos_por_preco = Produto.order(:preco).limit 2
  end

  def new
    @produto = Produto.new
    @departamentos = Departamento.all
  end

  def create
    @produto = Produto.new produto_params
    if @produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_url
    else
      renderiza :new
    end
  end

  def edit
    renderiza :edit
  end

  def update
    if @produto.update produto_params
      flash[:notice] = "Produto atualizado com sucesso!"
      redirect_to root_url
    else
      renderiza :edit
    end
  end

  def destroy
    @produto.destroy
    redirect_to root_url
  end

  def busca
    @nome_busca = params[:nome]
    @produtos = Produto.where "nome like ?", "%#{@nome_busca}%"
  end

  private

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

  def set_produto
    id = params[:id]
    @produto = Produto.find id
  end

  def produto_params
    params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
  end

end
