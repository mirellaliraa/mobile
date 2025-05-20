package Model;

public class Aluno extends Pessoa{
    //atributos
    private String matricula;
    private double nota;
    //métodos
    //construtor
    public Aluno(String nome, String cpf, String matricula) {
        super(nome, cpf);
        this.matricula = matricula;
    }
    //getters e setters
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
    // Sobreescrita do exibirinformações
    @Override
    public void exibirInformacoes(){
        super.exibirInformacoes();
        System.out.println("matrícula: "+matricula);
        System.out.println("Nota: "+nota);
    }
}