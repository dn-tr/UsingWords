
# Logic

Some algorithms of project

## Search similar words

* Words from one letter don't compare
* Words from two letters are compare with bigger words only
* Compare words by letters for get [similar percent](https://github.com/dn-tr/UsingWords/tree/master/Logic#get-similar-percent) between two words

_NOTE: Maybe we'll do exception for one- and two-letters words with **least frequency** using. It will do on the end search e.g._

### Get similar percent

Compare letters in two words by position. Set 1 for equal and 0 for different. Sum up units and divide on bigger word length. Take one of the best option.
Example:
```
HelloWorld    helloworld
HeloWorld     _heloworld
              0000111111  6/10 =  0.6
              h_eloworld
              1001111111  8/10 =  0.8
              he_loworld  
              1101111111  9/10 =  0.9   <--one of the BEST option
              hel_oworld
              1110111111  9/10 =  0.9   <--one of the BEST option
              helo_world
              1110011111  8/10 =  0.8
              helow_orld
              1110001111  7/10 =  0.7
              helowo_rld
              1110000111  6/10 =  0.6
              helowor_ld
              1110000011  5/10 =  0.5
              heloworl_d
              1110000001  4/10 =  0.4
              heloworld_
              1110000000  3/10 =  0.3
              
HelloWorld    helloworld
HeloWord      __heloword
              _h_eloword
              _he_loword
              _hel_oword
              _helo_word
              _helow_ord
              _helowo_rd
              _helowor_d
              _heloword_
              
              h__eloword
              h_e_loword
              h_el_oword
              h_elo_word
              h_elow_ord
              h_elowo_rd
              h_elowor_d
              h_eloword_
              
              h__eloword
              he__loword
              he_l_oword
              he_lo_word
              he_low_ord
              he_lowo_rd
              he_lowor_d  8/10 =  0.8   <--one of the BEST option
              he_loword_
              ..........
--------------------------------------
Word          word
Wrd           w_rd
              1011        3/4 =   0.75  <--one of the BEST option
              ..........
```
