import sqlite3


def criar_tabela():
    conn = sqlite3.connect('exemplo.db')
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            idade INTEGER
        )
    """)

    conn.commit()
    conn.close()


def inserir_users(nome, idade):
    conn = sqlite3.connect('exemplo.db')
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO users (nome, idade) VALUES
            (?, ?)
    """, (nome, idade))
    conn.commit()
    conn.close()


def listar_users():
    conn = sqlite3.connect('exemplo.db')
    cursor = conn.cursor()

    cursor.execute("""
        SELECT * FROM users
        ORDER BY nome ASC;
    """)

    usuarios = cursor.fetchall()

    for usuario in usuarios:
        print(usuario)
    conn.close()


def atualizar_user(id, nome, idade):
    conn = sqlite3.connect('exemplo.db')
    cursor = conn.cursor()

    cursor.execute("""
        UPDATE users 
        SET nome = ?, idade = ?
        WHERE id = ?
    """, (nome, idade, id))

    conn.commit()
    conn.close()


def delete_user(id):
    conn = sqlite3.connect('exemplo.db')
    cursor = conn.cursor()

    cursor.execute("""
        DELETE FROM users
        WHERE id = ?
    """, (id, ))

    conn.commit()
    conn.close()


def menu():
    print("\n1. Adicionar usuário")
    print("2. Listar usuários")
    print("3. Atualizar usuário")
    print("4. Deletar usuário")
    print("5. Sair")


def main():
    criar_tabela()

    while True:
        menu()
        escolha = input("Escolha: ")

        if escolha == '1':
            nome = input("Nome: ")
            idade = int(input("Idade: "))
            inserir_users(nome, idade)
            print("User inserido")
        elif escolha == '2':
            print('\nTodos os usuarios')
            listar_users()
        elif escolha == '3':
            id = int(input("Id: "))
            nome = input("Nome: ")
            idade = int(input("Idade: "))
            atualizar_user(id, nome, idade)
            print('Usuario atualizado')
        elif escolha == '4':
            id = int(input("Id: "))
            delete_user(id)
            print("User deletado")
        elif escolha == '5':
            print("Saindo do programa")
            break
        else:
            print("Opçao invalida")


main()
