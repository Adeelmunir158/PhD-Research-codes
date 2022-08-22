
require(readxl)
require(seminr)
attach(sustainability)
View(sustainability)
#===========================================

measurements = constructs(
  composite("Technical",multi_items("TC",1:3)),
  composite("Management",multi_items("MC",1:3)),
  composite("Human Resource",multi_items("HC",1:3)),
  composite("Data driven",multi_items("DD",1:3)),
  higher_composite("SCAC",c("Technical","Management","Human Resource","Data driven"), method = "two stage"),  
  
 composite("Economic",multi_items("Economic",1:5)),
 composite("Environmental",multi_items("Environmental",1:5)),
 composite("Social",multi_items("Social",1:5)),
  higher_composite("Sustainability",c("Economic","Environmental","Social"), method = "two stage"),  
  
 composite("Exploitative",multi_items("EXT",1:4)),
 composite("Explorative",multi_items("EXR",1:4)),
higher_composite("Ambidexterity",c("Exploitative","Explorative"), method = "two stage"),
composite("Sensing",multi_items("Sensing",1:5)),
composite("Seizing",multi_items("Seizing",1:6)),
composite("Reconf",multi_items("Reconf",1:5)),
higher_composite("Agility",c("Sensing","Seizing","Reconf"), method = "two stage"))

#------------------------------------------
# Quickly create multiple paths "from" and "to" sets of constructs



structure_pls = relationships(
  paths(from = "SCAC", to = "Ambidexterity"),
  paths(from = "SCAC", to = "Agility"),
  paths(from = "SCAC", to = "Sustainability"),
  paths(from = "Ambidexterity", to = "Agility"),
  paths(from = "Ambidexterity", to = "Sustainability")
)

plot(structure_pls)



#===========================================

pls_model = estimate_pls(sustainability,
                         measurements,
                         structure_pls)

plot(pls_model, cex=3)
s=summary(pls_model)

s
s$descriptives
#Validity
s$validity

#Reliability
sink("mock_values.doc")
s$reliability
sink()
#Loadings
s$loadings

#Structural Model
s$paths
s$total_effects
s$total_indirect_effects
s$vif_antecedents
s$fSquare
s$it_criteria
s$composite_scores
# Bootstrap
p5=bootstrap_model(pls_model,nboot = 500)
s2=summary(p5)
s2

#===========================================