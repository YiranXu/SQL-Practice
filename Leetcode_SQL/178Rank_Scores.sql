--rank score in descending order and display 'rank'
Select Score,
       Dense_rank() Over (Order By Score Desc) `Rank`
From Scores