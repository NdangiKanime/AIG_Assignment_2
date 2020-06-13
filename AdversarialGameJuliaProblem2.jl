using Printf, Statistics
function MahjongGame
   function __init__(own)
     own.startGame()
   end
   function startGame(own)
       own.recentState = [[".",".","."],
                          [".",".","."],
                          [".",".","."]]
       #PlayerX always starts game
       own.playerTurn = "X"
   end

   function drawBoard(own)
                for i in range(0, 3)
                    for j in range(0, 3)
                      print()
                    end
                  print()
                end
    end
   function isValid(own, playerX, playerY)
       if playerX < 0 || playerX >2 || playerY < 0 || playerY > 2
           return false
       elseif own.recentState[playerX][playerY] != "."
           return false
       else
           return true
       end
   end
   function isEnd(own)
       for i in range(0, 3)
           if (own.recentState[0][i] != "." && own.recentState[0][i] == own.recentState[1][i] && own.recentState[1][i] == own.recentState[2][i])
              return own.recentState[0][i]
           end
       end
       for i in range(0, 3)
           if (own.recentState[i] == ["X","X","X"])
               return "X"
           elseif (own.recentState[i]== ["O","O","O"])
               return "O"
           end
       end
       #Main diagonal
       if (own.recentState[0][0] != "." && own.recentState[0][0] == own.recentState[1][1] && own.recentState[0][0] == own.recentState[2][2])
           return own.recentState[0][0]
       end
       #Second diagonal win
       if (own.recentState[0][2] != "." && own.recentState[0][2] == own.recentState[1][1] && own.recentState[0][2] == own.recentState[2][0])
           return own.recentState[0][2]
       end
       #Is whole board full
       for i in range(0, 3)
           for j in range(0, 3)
       #There's an empty field, we continue the game
               if (own.recentState[i][j] == ".")
                   return None
               end
           end
       #It's a draw!
         return "."
       end

   function maxAlphaBeta(own, alpha, beta)
            maxV = -2
            playerX = None
            playerY = None
            result = own.isEnd()

           if result == "X"
               return (-1, 0, 0)
           elseif result == "O"
               return (1, 0, 0)
           elseif result == "."
               return (0, 0, 0)
           end
           for i in range(0, 3)
               for j in range(0, 3)
                   if own.recentAnswer[i][j] == "."
                       own.recentState[i][j] = "O"
                       (m, minI, inJ) = own.minAlphaBeta(alpha, beta)
                       if m > maxV
                           maxV = m
                           playerX = i
                           playerY = j
                         own.recentState[i][j] = "."
                       end




       #Next two ifs in max and min are the diff between regular algo and minimax
                       if maxV >= beta
                            return(maxV, playerX, playerY)
                       end
                       if maxV > alpha
                           alpha = maxV
                       end
                   end
               end
           end
       end

       function minAlphaBeta(own, alpha, beta)
                   min = 2

                   userX = None
                   userY = None

                   result = own.isEnd()

            if result == "X"
                return (-1, 0, 0)
            elseif result == "O"
                return (1, 0, 0)
            elseif result == "."
                return (0, 0, 0)
            end


            for i in range(0, 3)
                for j in range(0, 3)
                   if own.recentState[i][j] == "."
                       own.recentState[i][j] = "X"
                       (m, maxI, maxJ) = own.maxAlphaBeta(alpha, beta)
                       if m < minV
                          minV = m
                          userX = i
                          userY = j
                         own.recentState[i][j] = "."
                        end


                        if minV <= alpha
                           return (minV, userX, userY)

                       end
                    end
                end
            end
        end
       #Game loop
       function playAlphaBeta(own)
               while true
                  own.drawBoard()
                  own.result = own.isEnd()

                  if own.result != None
                      if own.result == "X"
                         print("The winner is X!")
                      elseif own.result == "O"
                         print("The winner is O!")
                      elseif own.reult == "."
                         print("It's a draw")
                         own.startGame()
                         return
                       end
                   end

                   if own.playerTurn == "X"
                       while true
                           (m, userX, userY) = own.minAlphaBeta(-2, 2)

                           playerX = int(input("Insert the X position: "))
                           playerY =  int(input("Insert the Y position"))

                           userX = playerX
                           userY = playerY

                           if own.isValid(playerx, playerY)
                               own.recentState[pplayerX][playerY] = "X"
                               own.playerTurn = "O"
                               break
                           else print("Invalid move")
                           end
                       end
                   end
                   else (m, playerX, playerY) = own.maxAlphaBeta(-2, 2)
                        own.recentState[playerX][playerY] = "O"
                        own.playerTurn = "X"
                   end
               end
           end
       end

       function main()
                g = Game()
                g.play()

       if __name__ == "__main__"
           main()
       end
    end
end
