plink --bfile 18 --maf 0.05 --geno 0.2 --out test --recode
plink --make-bed --file R+HI --allow-extra-chr --out R+HI --geno 0.99 --threads 10
plink --bfile R+HI --assoc fisher --out R+HI --allow-no-sex --adjust 
