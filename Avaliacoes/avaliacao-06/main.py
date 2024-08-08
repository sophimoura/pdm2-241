from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from database import Aluno, SessionLocal, init_db

# Inicializa o banco de dados
init_db()

# Cria a instância do FastAPI
app = FastAPI()

# Definição do modelo Pydantic para Aluno
class AlunoCreate(BaseModel):
    aluno_nome: str
    endereco: str

class AlunoUpdate(BaseModel):
    aluno_nome: str
    endereco: str

# Função para obter a sessão do banco de dados
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/criar_aluno/")
def criar_aluno(aluno: AlunoCreate, db: Session = Depends(get_db)):
    db_aluno = Aluno(aluno_nome=aluno.aluno_nome, endereco=aluno.endereco)
    db.add(db_aluno)
    db.commit()
    db.refresh(db_aluno)
    return db_aluno

@app.get("/listar_alunos/")
def listar_alunos(db: Session = Depends(get_db)):
    return db.query(Aluno).all()

@app.get("/listar_um_aluno/{aluno_id}")
def listar_um_aluno(aluno_id: int, db: Session = Depends(get_db)):
    aluno = db.query(Aluno).filter(Aluno.id == aluno_id).first()
    if aluno is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")
    return aluno

@app.put("/atualizar_aluno/{aluno_id}")
def atualizar_aluno(aluno_id: int, aluno: AlunoUpdate, db: Session = Depends(get_db)):
    db_aluno = db.query(Aluno).filter(Aluno.id == aluno_id).first()
    if db_aluno is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")
    
    db_aluno.aluno_nome = aluno.aluno_nome
    db_aluno.endereco = aluno.endereco
    db.commit()
    db.refresh(db_aluno)
    return db_aluno

@app.delete("/excluir_aluno/{aluno_id}")
def excluir_aluno(aluno_id: int, db: Session = Depends(get_db)):
    db_aluno = db.query(Aluno).filter(Aluno.id == aluno_id).first()
    if db_aluno is None:
        raise HTTPException(status_code=404, detail="Aluno não encontrado")
    
    db.delete(db_aluno)
    db.commit()
    return {"detail": "Aluno excluído"}
