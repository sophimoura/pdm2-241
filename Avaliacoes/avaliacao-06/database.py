from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Definição da URL do banco de dados
DATABASE_URL = "sqlite:///./dbalunos.db"

# Criação do motor de banco de dados
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})

# Criação da base para as classes
Base = declarative_base()

# Definição da entidade Aluno
class Aluno(Base):
    __tablename__ = "TB_ALUNO"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    aluno_nome = Column(String(50), index=True)
    endereco = Column(String(100))

# Criação das tabelas
def init_db():
    Base.metadata.create_all(bind=engine)

# Criação da sessão
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
