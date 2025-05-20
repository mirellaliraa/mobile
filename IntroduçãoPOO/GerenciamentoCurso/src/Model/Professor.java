package Model;

public class Professor extends Pessoa {
    private double salario;

    public Professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
    }

    public double getsalario() {
        return salario;
    }

    public void setsalario(double salario) {
        this.salario = salario;
    }
    @Override
    public void exibirInformacoes(){
        super.exibirInformacoes();
        System.out.println("Salário: "+salario);
    }
}
