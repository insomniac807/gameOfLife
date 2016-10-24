int rows = 300;
int cols = 300;
float cellWidth;
float cellHeight;

void setup()
{
  frameRate(10);
  background(0);
  //size(1000,700);
  fullScreen();
  cellWidth = width/cols;
  cellHeight = height/rows;
  
  //randInit();
  //stroke(255);
}//end setup()


boolean[][] board = new boolean[rows][cols]; 
boolean[][] board2 = new boolean[rows][cols];  

void randInit()
{
  for(int i=0; i<rows; i++)
  {    
    for(int j=0; j<cols; j++)
    {
      if(random(0,1) < 0.1f)
      {
        board[i][j] = true;
      }//end if
    }//end for cols 
  }//end for rows
}//end randInit



boolean getCell(int row, int col)
{
 if( row < rows && row >= 0 && col < cols && col >= 0)
 {
   return board[row][col];
 }
 else
 {
    return false; 
 }
}//end get cell


int getNeighbours(int row, int col)
{
  int liveCells = 0; 
    for(int i= row-1; i<=row+1; i++)
    {
      for(int j=col-1; j<=col+1; j++)
      {
        if( (!(i==row && j==col)) && getCell(i,j))
        {
          liveCells++;
        }//end if
      }//end for cols
    }//end for rows
  
  return liveCells;
}//end get neighbours


void upDate()
{ 
  for(int i=0; i<rows; i++)
  {
    for(int j=0; j<cols; j++)
    {
      if(getNeighbours(i,j)< 2)
      {
        board2[i][j] = false;
      }
      else if(getNeighbours(i,j) == 3)
      {
        board2[i][j] = true;
      }
      else if(getNeighbours(i,j) == 2 && board[i][j])
      {
        board[i][j] = true;
      }
      else if(getNeighbours(i,j) > 3)
      {
        board2[i][j] = false;
      }
      else
      {
        board2[i][j] = false;
      }
    }
  }//end loop
  
  board =  board2;
}

 boolean pause = true;
 
void mousePressed()
{
  float row = mouseX/cellWidth;       
  float col = mouseY/cellHeight;
  board[(int)row][(int)col] = !(board[(int)row][(int)col]);
}


void mouseDragged()
{
  float row = mouseX/cellWidth;       
  float col = mouseY/cellHeight;
  board[(int)row][(int)col] = true;
}


void keyPressed()
  {
    if(key == 's' || key == 'S')
    {
      pause = !pause;
    }
    if(key == 'c' || key == 'C')
    {
      for(int i=0; i<rows; i++)
      {
        for(int j=0; j<cols; j++)
        {
          board[i][j] = false;
        }
      }
    }
  }
 

void draw()
{   
  
  if(pause == false)
  {
    upDate(); 
  } 
    for(int i=0; i<rows; i++)
    {
      for(int j=0; j<cols; j++)
      {
        if(board[i][j] == true)
        {
          fill(0,255,0);
          rect(i*cellWidth, j*cellHeight, cellWidth, cellHeight);
        }//end if
        else
        {
          fill(0);
          rect(i*cellWidth, j*cellHeight, cellWidth, cellHeight);
        }
      }//end for cols
    }//end for rows
  
      
}