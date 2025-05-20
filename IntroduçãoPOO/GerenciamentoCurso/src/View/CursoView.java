package View;

import java.util.Scanner;

import Controller.CursoController;
import Model.Aluno;
import Model.Professor;

public class CursoView {
    // atributos
    Professor jp = new Professor("João Pereira", "123.456.789-09", 15000.00);
    CursoController cursoJava = new CursoController("Programação Java", jp);
    private int operacao;
    private boolean continuar = true;
    Scanner sc = new Scanner(System.in);

    // métodos
    public void menu() {
        while (continuar) {
            System.out.println("==Gerenciamento Curso==");
            System.out.println("|1. Cadastrar aluno");
            System.out.println("|2. Informações do Curso");
            System.out.println("|3. Lançar nota dos alunos");
            System.out.println("|4. Ver status da turma");
            System.out.println("|5. Sair");
            System.out.println("==Escolha a opção desejada==");
            operacao = sc.nextInt();
            switch (operacao) {
                case 1:
                    Aluno aluno = cadastrarAluno();
                    cursoJava.adicionarAluno(aluno);
                    break;
                case 2:
                    cursoJava.exibirInformacoesCurso();
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:
                System.out.println("Saindo...");
                continuar = false;
                break;

                default:
                System.out.println("Informe uma opção válida");
                    break;
            }
        }
    }

    private Aluno cadastrarAluno() {
        System.out.println("Digite o nome do aluno");
        String nome = sc.next();
        System.out.println("Digite o CPF do aluno");
        String cpf = sc.next();
        System.out.println("Informe a matricula do aluno");
        String matricula = sc.next();
        return new Aluno(nome, cpf, matricula);
    }

    
}
