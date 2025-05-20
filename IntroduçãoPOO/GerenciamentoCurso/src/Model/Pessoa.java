package Model;

public abstract class Pessoa {
    //atributos(Encapsulamento)
    private String nome;
    private String cpf;
    //métodos
    //construtor
    public Pessoa(String nome, String cpf){
            this.nome=nome;
            this.cpf=cpf;
    }
    //getters em setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpf;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    //exibir informações
    public void exibirInformacoes(){
        System.out.println("Nome: "+nome);
        System.out.println("CPF: "+cpf);
    }

}
