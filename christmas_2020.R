library(bioseq)
library(sangr)
library(tidyverse)
library(ggpubr)
theme_set(theme_classic(base_size=20))

(seq_rev_translate(as_aa("HAPPY")) %>%
    seq_disambiguate_IUPAC()
)[[1]][1] %>% as.character() -> happy

(seq_rev_translate(as_aa("CHRISTMAS")) %>%
    seq_disambiguate_IUPAC()
)[[1]][1] %>% as.character() -> christmas

card <- ggarrange(
  ggplot()+
  ggtitle("Happy Christmas","from Babraham Bioinformatics") +
  theme_void() + theme( plot.title=element_text(
      hjust=0.5, vjust=0, family="serif", face="bold",
      size = 40,color = "red3"))+
    theme(plot.subtitle=element_text(
      hjust=0.5, vjust=0, size = 20,family="serif",face="italic")
  ),
  simulate_sanger_data(happy, noise=0, degrade = 1) %>%
    draw_chromatogram("-H--A--P--P--Y-"),
  simulate_sanger_data(christmas, noise=0, degrade = 1) %>%
    draw_chromatogram("-C--H--R--I--S--T--M--A--S-"),
  nrow=3,heights = c(1,2,2))

if (interactive()) {
  print(card)
}else {
  ggsave(plot=card, filename="christmas2020.png",height=8,width=7)
}

