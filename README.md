# AMPlab

This project was developed for Audio and Music Processing Lab subject in Sound and Music Computing Master.

For this project, I analysed the musical piece 'Deux Arabesques' by Debussy and generated a new jazz version of it for piano and voice. The harmony was extracted manually and the melody was generated with an algorithm proposed. I hypothesize that dynamics are very important for this piece, in the sense that notes played slightly stronger are intended to illustrate the main melody, while the rest are not as relevant. Based on this hipothesis, I wrote a script that takes the midi input of the musical piece, frames it, and takes notes over a relative threshold in terms of dynamics. 

This repository includes the code employed for the selection of the melody and other processes executed to better analyse the piece before deciding what to transform the original piece into.
