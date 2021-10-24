#include <stdio.h>
#include <stdlib.h>

int makePlayerMove(int index);
void printLabyrinth (void);
int makeMove(int index);

int step = 0;
int W = 21;
int H = 11;
int startX = 1;
int playerPos = 1;
int totalElements = 231;
char temp[100];
char map[232] = "I.IIIIIIIIIIIIIIIIIII"
                "I....I....I.......I.I"
                "III.IIIII.I.I.III.I.I"
                "I.I.....I..I..I.....I"
                "I.I.III.II...II.I.III"
                "I...I...III.I...I...I"
                "IIIII.IIIII.III.III.I"
                "I.............I.I...I"
                "IIIIIIIIIIIIIII.I.III"
                "@...............I..II"
                "IIIIIIIIIIIIIIIIIIIII";


int main()
{
    char userMove ;


    printf("Welcome to The aMAZEing Game!\n");
    printf("----------------------Menu------------------------\n");
	printf("Your moves are:\n");
	printf("  W to go up. \n");
	printf("  S to go down. \n");
    printf("  A to go left. \n");
	printf("  D to go right. \n");
	printf("  E to have the best route. \n");

    printLabyrinth();

    while(userMove != 'E'){

        printf("\nPlease enter your move:\t");
        scanf("\n%c", &userMove);

        switch (userMove){

        case 'W':

            step = -W;
            if((playerPos+step) <=0 || map[playerPos+step] == 'I'){
                printf("\nNot possible move...");
            }else{
                playerPos += step;

                if(makePlayerMove(playerPos-step)==1){
                    return(0);
                }
                printLabyrinth();
            }
            break;

        case 'S':

            step = W;
            if((playerPos+step  ) >=totalElements || map[playerPos+step] == 'I'){
                printf("\nNot possible move...");
            }else{
                playerPos +=step;
                if(makePlayerMove(playerPos-step)==1){ //checkarei an exei vrei to telos kai teleiwnei
                    return(0);
                }
                printLabyrinth();
            }

            break;
        case 'A':

            step = -1;
            if((playerPos+step) <0 || map[playerPos+step] == 'I'){
                printf("\nNot possible move...");
            }else{
                playerPos += step;
                if(makePlayerMove(playerPos-step)==1){ //checkarei an exei vrei to telos kai teleiwnei
                    return(0);
                }
                printLabyrinth();
            }

            break;
        case 'D':

            step =1;
            if((playerPos+step) >=totalElements || map[playerPos+step] == 'I'){
                printf("\nNot possible move...");
            }else{
                playerPos +=step;
                if(makePlayerMove(playerPos-step)==1){ //checkarei an exei vrei to telos kai teleiwnei
                    return(0);
                }
                printLabyrinth();
            }

            break;
        case 'E':

            makeMove(startX);
            printLabyrinth();
            break;

         default:
         break;
    }
 }
  return 0;
}

void printLabyrinth (void){
    int i,j,k=0;

    usleep(20000);

    printf("\nHere is your Labyrinth:\n");
    for (i=0; i<H; i++){

        for(j=0; j<W; j++){

            if(k == playerPos)
                temp[j]='P'; //load address edw
            else
                temp[j] = map[k];

            k++;
        }

        temp[j+1]='\0';
        printf("%s\n", temp);
    }
}


int makeMove(int index){
if( index<0 || index>=totalElements)
    return 0;

    if(map[index]=='.' || map[index]=='P'){
        map[index]='*';

        if(makeMove(index+1)==1){
            map[index]='#';
        return 1;
        }
        if(makeMove(index+W)==1){
            map[index]='#';
        return 1;
        }
        if(makeMove(index-1)==1){
            map[index]='#';
        return 1;
        }
        if(makeMove(index-W)==1){
            map[index]='#';
        return 1;
        }
    }else if (map[index]=='@'){
        map[index]='%';
        return 1;
}

return 0;
}


int makePlayerMove(int index){ //end

   if(map[index-1] =='@')
            {
              map[index-1]= '%';
              map[index] = 'P';
              map[index+1] = '.';

              playerPos = index;
              printLabyrinth();

              printf("Winner Winner Chicken Dinner!\n");
              return 1;
            }

    if(map[index+1] =='@')
            {
              map[index+1]= '%';
              map[index] = 'P';
              map[index -1] = '.';

              playerPos = index;
              printLabyrinth();

              printf("Winner Winner Chicken Dinner!\n");
              return 1;
            }

    if(map[index+W] =='@')
            {
              map[index +W]= '%';
              map[index] = 'P';
              map[index -W] = '.';

              playerPos = index;
              printLabyrinth();

              printf("Winner Winner Chicken Dinner!\n");
              return 1;
            }

    if(map[index-W] =='@')
            {
              map[index -W]= '%';
              map[index] = 'P';
              map[index +W] = '.';

              playerPos = index;
              printLabyrinth();

              printf("Winner Winner Chicken Dinner!\n");
              return 1;
            }
    return 0;
}

void usleep(int index){

 for(int i=0;i<index;i++){
    for(int j=0;j<index;j++){
    }
 }
}
