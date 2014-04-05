#!/usr/bin/env Rscript
library("rgl", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
library("geometry", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
library("plot3D", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
library("plotrix", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#source("test_programm.R")
rotation_matrix_z <- function(t) {
  return (matrix(c(cos(t), sin(t),0 , -sin(t), cos(t), 0, 0, 0, 1), ncol=3, nrow=3, byrow = TRUE))
}

rotation_matrix_x <- function(t) {
  return (matrix(c(1, 0, 0, 0, cos(t), -sin(t), 0 , sin(t), cos(t)), ncol=3, nrow=3, byrow = TRUE))
}

rotation_matrix_y <- function(t) {
  return (matrix(c(cos(t), 0, sin(t), 0 , 1, 0, -sin(t), 0, cos(t)), ncol=3, nrow=3, byrow = TRUE))
}


rotation_matrix2d <- function(t) {
  return (matrix(c(cos(t), sin(t), -sin(t), cos(t)), ncol=2, nrow=2))
}

dist_points<-function(x1,y1,z1,x2,y2,z2){
  dist_tmp<-sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1))
  return (dist_tmp)
}

product_vector<-function(x1,y1,z1, x2,y2,z2){
  tmp<-(y1*z2-z1*y2)*(y1*z2-z1*y2)+(z1*x2-x1*z2)*(z1*x2-x1*z2)+(x1*y2-x2*y1)*(x1*y2-x2*y1)
  tmp<-sqrt(tmp)
  return (tmp)
}

dist_line<-function(x1,y1,z1, m,n,p,vD, D, x0,y0,z0){
  tmp_x<-x0-x1
  tmp_y<-y0-y1
  tmp_z<-z0-z1
  tmp<-product_vector(tmp_x,tmp_y,tmp_Z, m,n,p)
  tmp<-(tmp/D)
  return (tmp)
}

orientation<-function(x1,y1,z1, m,n,p,vD){
  tmp<- m*x1+n*y1+p*z1+vD
  if (tmp>0) {
    ind<-1
  } else {
    if (tmp<0) {
      ind<-(-1)
    } else {
      ind<-0
    }
  }
  return (ind)
}

proection_test<-function(h, m,n,p,vD,D){
  #print(c(m,n,p,vD,D))
  #print(h)
  tmp_h<-matrix(nrow=nrow(h), ncol=3)
  for (i in 1:nrow(h)){
    if ((m!=0) && (n!=0) && (p!=0)){
    tmp_z<-p/D/D*(-m*h[i,1]+(m*m+n*n)/p*h[i,3]-n*h[i,2]-vD)
    tmp_x<-(m*tmp_z+p*h[i,1]-m*h[i,3])/p
    tmp_y<-(n*tmp_z+p*h[i,2]-n*h[i,3])/p
    tmp<-c(0,0,0)
    tmp[1]<-tmp_x
    tmp[2]<-tmp_y
    tmp[3]<-tmp_z
    tmp_h[i,]<-tmp
    #print(c("tmp", tmp))
    #tmp[4]<-alpha
    }
    else {if ((n==0) || (p==0)) {
      tmp_z<-h[i,3]
      tmp_x<--vD/m
      tmp_y<-h[i,2]
      tmp<-c(0,0,0)
      tmp[1]<-tmp_x
      tmp[2]<-tmp_y
      tmp[3]<-tmp_z
      tmp_h[i,]<-tmp
      #print(c("tmp", tmp))
      }
      else {if ((n==0) || (m==0)) {
        tmp_z<--vD/p
        tmp_x<-h[i,1]
        tmp_y<-h[i,2]
        tmp<-c(0,0,0)
        tmp[1]<-tmp_x
        tmp[2]<-tmp_y
        tmp[3]<-tmp_z
        tmp_h[i,]<-tmp
       # print(c("tmp", tmp))
      } 
      else {if ((p==0) || (m==0)) {
        tmp_z<-h[i,3]
        tmp_x<-h[i,1]
        tmp_y<--vD/n
        tmp<-c(0,0,0)
        tmp[1]<-tmp_x
        tmp[2]<-tmp_y
        tmp[3]<-tmp_z
        tmp_h[i,]<-tmp
       # print(c("tmp", tmp))
      } 
    }
    }
    }
  }
  #print(c("tmp_h", tmp_h))
  return (tmp_h) 
}

proection_test2<-function(h, m,n,p,vD2,D){
  #print(c(m,n,p,vD,D))
  #print(h)
  tmp_h<-matrix(nrow=nrow(h), ncol=3)
  for (i in 1:nrow(h)){
    if ((m!=0) && (n!=0) && (p!=0)){
      tmp_z<-p/D/D*(-m*h[i,1]+(m*m+n*n)/p*h[i,3]-n*h[i,2]-vD2)
      tmp_x<-(m*tmp_z+p*h[i,1]-m*h[i,3])/p
      tmp_y<-(n*tmp_z+p*h[i,2]-n*h[i,3])/p
      tmp<-c(0,0,0)
      tmp[1]<-tmp_x
      tmp[2]<-tmp_y
      tmp[3]<-tmp_z
      tmp_h[i,]<-tmp
      #print(c("tmp", tmp))
      #tmp[4]<-alpha
    }
    else {if ((n==0) || (p==0)) {
      tmp_z<-h[i,3]
      tmp_x<--vD2/m
      tmp_y<-h[i,2]
      tmp<-c(0,0,0)
      tmp[1]<-tmp_x
      tmp[2]<-tmp_y
      tmp[3]<-tmp_z
      tmp_h[i,]<-tmp
      #print(c("tmp", tmp))
    }
    else {if ((n==0) || (m==0)) {
      tmp_z<--vD2/p
      tmp_x<-h[i,1]
      tmp_y<-h[i,2]
      tmp<-c(0,0,0)
      tmp[1]<-tmp_x
      tmp[2]<-tmp_y
      tmp[3]<-tmp_z
      tmp_h[i,]<-tmp
      # print(c("tmp", tmp))
    } 
    else {if ((p==0) || (m==0)) {
      tmp_z<-h[i,3]
      tmp_x<-h[i,1]
      tmp_y<--vD2/n
      tmp<-c(0,0,0)
      tmp[1]<-tmp_x
      tmp[2]<-tmp_y
      tmp[3]<-tmp_z
      tmp_h[i,]<-tmp
      # print(c("tmp", tmp))
    } 
    }
    }
    }
  }
  #print(c("tmp_h", tmp_h))
  return (tmp_h) 
}

proection<-function(h, m,n,p,vD,D){
  tmp_h<-matrix(nrow=nrow(h), ncol=3)
  for (i in 1:nrow(h)){
    alpha<--vD-h[i,1]*m-h[i,2]*n-h[i,3]*p
    alpha<-alpha/D
    tmp<-c(0,0,0)
    temp<-h[i,1]+m*alpha
    tmp[1]<-temp
    temp<-h[i,2]+n*alpha
    tmp[2]<-temp
    temp<-h[i,3]+p*alpha
    tmp[3]<-temp
    tmp_h[i,]<-tmp
    #tmp[4]<-alpha
  }
  #print(tmp_h)
  return (tmp_h) 
}

proection2<-function(h, m,n,p,vD2,D){
  tmp_h<-matrix(nrow=nrow(h), ncol=3)
  for (i in 1:nrow(h)){
    alpha<--vD2-h[i,1]*m-h[i,2]*n-h[i,3]*p
    alpha<-alpha/D
    tmp<-c(0,0,0)
    temp<-h[i,1]+m*alpha
    tmp[1]<-temp
    temp<-h[i,2]+n*alpha
    tmp[2]<-temp
    temp<-h[i,3]+p*alpha
    tmp[3]<-temp
    tmp_h[i,]<-tmp
    #tmp[4]<-alpha
  }
  #print(tmp_h)
  return (tmp_h) 
}

dist_points2d<-function(x1,y1,x2,y2){
  dist_tmp<-sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
  return (dist_tmp)
}
dist_line2d<-function(x1,y1,A,B,C,D){
  dist_tmp<-abs(A*x1+B*y1+C)
  dist_tmp<-(dist_tmp/D)
  return (dist_tmp)
}
orientation2d<-function(x1,y1,A,B,C){
  tmp<- A*x1+B*y1+C
  #print(tmp)
  if (tmp>0) {
    ind<-1
  } else {
    if (tmp<0) {
      ind<-(-1)
    } else {
      ind<-0
    }
  }
  return (ind)
}



make3d<-function(per, m,n,p, x,y,z){
  tmp<-matrix(nrow=4, ncol=3)
  for (i in 1:nrow(per)){
  tmp[i,1]<-per[i,1]
  tmp[i,2]<-per[i,2]
  if (p!=0) {
  temp<-(-m*(x-per[i,1])-n*(y-per[i,2]))/p
  temp<-z-temp
  tmp[i,3]<-temp
  }
  else {tmp[i,3]<-z}
  }
  return (tmp)
}

mean_x<-function(x,n){
  tmp_s<-0
  for (i in 1:n){
    tmp_s<-tmp_s+x[i]
  }
  tmp_s<-tmp_s/n
  
  return (tmp_s)
}

sigma_x<-function(x, mean, n) {
  tmp_x<-c(1:n)
  tmp_x<-x-mean
  tmp_s<-0
  for (i in 1:n) {
    tmp_s<-tmp_s+tmp_x[i]
  }
  tmp_s<-tmp_s/n
  tmp_s<-sqrt(tmp_s)
  
  return(tmp_s)
}

Petunin2d<-function(a)
{
  #print(a)
  hpts <- chull(a)
  hpts<-c(hpts,hpts[1])
  tmp_dist<-length(hpts)*(length(hpts)-1)/2
  dist_v<-matrix (nrow=tmp_dist, ncol=1)
  m<-1
  #print(length(hpts))
  for (j in 1:(length(hpts)-1)){
    for (k in (j+1):length(hpts)){
      dist_v[m,1]<-dist_points2d(a[hpts[j],1],a[hpts[j],2],a[hpts[k],1],a[hpts[k],2]) 
      m<-m+1
    }
  }
  #print(dist_v)
  tmp_w<-which.max(dist_v[,1])
  #print(tmp_w)
  tmp_d<-length(hpts)-1
  while (tmp_w>tmp_d){
    tmp_w<-tmp_w-tmp_d
    tmp_d<-tmp_d-1
  }
  i1<-length(hpts)-tmp_d
  i2<-i1+tmp_w
  A<-(a[hpts[i2],2]-a[hpts[i1],2])
  B<-(a[hpts[i1],1]-a[hpts[i2],1])
  C<-(a[hpts[i1],2]*(a[hpts[i2],1]-a[hpts[i1],1])-a[hpts[i1],1]*(a[hpts[i2],2]-a[hpts[i1],2]))
  D2<-sqrt(A*A+B*B)
  D<-sqrt(A*A+B*B+C*C);
  
  max_j<-0
  maxn_j<-0
  max_k<-0
  maxn_k<-0
  
  if (min(i1,i2)!=1){
    for (j in 1:(min(i1,i2)-1)){
      tmp_max<-dist_line2d(a[hpts[j],1],a[hpts[j],2],A,B,C,D) 
      tmp_o<-orientation2d(a[hpts[j],1],a[hpts[j],2],A,B,C)
      if (tmp_o==(-1)){
        if (tmp_max>max_j){
          max_j<-tmp_max
          maxn_j<-j
        }
      }
      else {
        if (tmp_o==1){
          if (tmp_max>max_k){
            max_k<-tmp_max
            maxn_k<-j
          }
        }
      }
    }
  }
  for (j in (min(i1,i2)+1):(max(i1,i2)-1)){
    tmp_max<-dist_line2d(a[hpts[j],1],a[hpts[j],2],A,B,C,D) 
    tmp_o<-orientation2d(a[hpts[j],1],a[hpts[j],2],A,B,C)
    if (tmp_o==(-1)){
      if (tmp_max>max_j){
        max_j<-tmp_max
        maxn_j<-j
      }
    }
    else {
      if (tmp_o==1){
        if (tmp_max>max_k){
          max_k<-tmp_max
          maxn_k<-j
        }
      }
    }
  }
  
  for (j in (max(i1,i2)+1):length(hpts)){
    tmp_max<-dist_line2d(a[hpts[j],1],a[hpts[j],2],A,B,C,D2) 
    tmp_o<-orientation2d(a[hpts[j],1],a[hpts[j],2],A,B,C)
    if (tmp_o==(-1)){
      if (tmp_max>max_j){
        max_j<-tmp_max
        maxn_j<-j
      }
    }
    else {
      if (tmp_o==1){
        if (tmp_max>max_k){
          max_k<-tmp_max
          maxn_k<-j
        }
      }
    }
  }
  if (maxn_k!=0) { 
  C1<-(-A*a[hpts[maxn_k],1]-B*a[hpts[maxn_k],2])
  }
  else {C1<-0}
  if (maxn_j!=0) {
  C2<-(-A*a[hpts[maxn_j],1]-B*a[hpts[maxn_j],2])
  }
  else {C2<-0}
  #else {C2<-C1}
  if (maxn_k==0) {C1<-C2}
  if (maxn_j==0) {C2<-C1}
  C3<-(B*a[hpts[i1],1]-A*a[hpts[i1],2])
  C4<-(B*a[hpts[i2],1]-A*a[hpts[i2],2])
  
  tmp_y_per<-(-C1*B-C3*A)/D2/D2
  if (A==0) {
    tmp_x_per<-C3/B
  } else {
    if (B==0) {
      tmp_x_per<-(-C1)/A
    }  else   {
      tmp_x_per<-(-C1-B*tmp_y_per)/A
    }
  }
  
  tmp_y_per2<-(-C2*B-C3*A)/D2/D2
  if (A==0) {
    tmp_x_per2<-C3/B
  } else {
    if (B==0) {
      tmp_x_per2<-(-C2)/A
    } else {
      tmp_x_per2<-(-C2-B*tmp_y_per2)/A
    }
  }
  
  tmp_y_per3<-(-C2*B-C4*A)/D2/D2
  if (A==0) {
    tmp_x_per3<-C4/B
  } else {
    if (B==0) {
      tmp_x_per3<-(-C2)/A
    } else {
      tmp_x_per3<-(-C2-B*tmp_y_per3)/A
    }
  }
  
  tmp_y_per4<-(-C1*B-C4*A)/D2/D2
  if (A==0) {
    tmp_x_per4<-C4/B
  } else {
    if (B==0) {
      tmp_x_per4<-(-C1)/A
    } else {
      tmp_x_per4<-(-C1-B*tmp_y_per4)/A
    }
  }
  #print(tmp_x_per)
  #print(tmp_y_per)
  #print(tmp_x_per2)
  #print(tmp_y_per2)
  #print(tmp_x_per3)
  #print(tmp_y_per3)
  #print(tmp_x_per4)
  #print(tmp_y_per5)
  #Sys.sleep(0.9)
  #per_x<-tmp_x_per2
  #per_y<-tmp_y_per2
  d<-matrix(nrow=4, ncol=2)
  d[1,1]<-tmp_x_per
  d[1,2]<-tmp_y_per
  d[2,1]<-tmp_x_per2
  d[2,2]<-tmp_y_per2
  d[3,1]<-tmp_x_per3
  d[3,2]<-tmp_y_per3
  d[4,1]<-tmp_x_per4
  d[4,2]<-tmp_y_per4
  #d[5,1]<-tmp_x_per
  #d[5,2]<-tmp_y_per
  #lines3d(d)
  return(d)  
}

El_pilling<-function(a)
{
  NN2<-NN
  count<-1
  result_p<-matrix(nrow=NN, ncol=5)
  result_p[,1]<-a[,1]
  result_p[,2]<-a[,2]
  result_p[,3]<-a[,3]
  for (kk in 1:NN) {
    result_p[kk,4]<-kk
  }
  kk<-1
  #for (kk in 1:NN2) {
  #plot3d(red_test,green_test,blue_test, type="p", xlim=c(50,150), ylim=c(50,150), zlim=c(50,150), col="red", asp=1)
  #Sys.sleep(0.9)
  #hpts <- chull(a)
  #print(a)
  hpts2<-convhulln(a)
  tt<-3*nrow(hpts2)
  hpts<-c(seq(1:tt))
  for (i in 1:nrow(hpts2)){
    j<-3*(i-1)+1
    hpts[j]<-hpts2[i,1]
    j<-3*(i-1)+2
    hpts[j]<-hpts2[i,2]
    j<-3*(i-1)+3
    hpts[j]<-hpts2[i,3]
  }
  #print(hpts)
  hpts<-unique(hpts)
  j<-1
  #hpts<-c(hpts,hpts[1])
  tmp_dist<-length(hpts)*(length(hpts)-1)/2
  dist_v<-matrix (nrow=tmp_dist, ncol=1)
  m<-1
  for (j in 1:(length(hpts)-1)){
    for (k in (j+1):length(hpts)){
      dist_v[m,1]<-dist_points(a[hpts[j],1],a[hpts[j],2],a[hpts[j],3],a[hpts[k],1],a[hpts[k],2],a[hpts[k],3]) 
      m<-m+1
    }
  }
  #print(dist_v)
  #print(which.max(dist_v[,1]))
  tmp_w<-which.max(dist_v[,1])
  tmp_d<-length(hpts)-1
  while (tmp_w>tmp_d){
    tmp_w<-tmp_w-tmp_d
    tmp_d<-tmp_d-1
  }
  i1<-length(hpts)-tmp_d
  i2<-i1+tmp_w
  #print(i1)
  #print(i2)
  b<-matrix(nrow=2, ncol=3)
  b[1,]<-a[hpts[i1],]
  b[2,]<-a[hpts[i2],]
  #lines3d(b)
  tmp_a<-b[1,2]-b[2,2]
  tmp_b<-b[1,1]-b[2,1]
  theta<-atan(tmp_a/tmp_b)
  #print(c("theta", deg(theta)))
  #identity<- matrix(1,nrow=N,ncol=1)
  #a_new<-matrix(nrow=N, ncol=4)
  #a_new<-cbind(a,identity)
  #print(deg(2*pi-theta))
  a_new <- a%*%rotation_matrix_z(2*pi-theta)
  #print(a_new)
  #plot.new()
  #Sys.sleep(0.9)
  #plot3d(a_new[,1],a_new[,2],a_new[,3], xlim=c(-10,250), ylim=c(-10,250), zlim=c(-10,250), type="p", col="green")
  #hpts <- chull(a_new)
  #hpts<-c(hpts,hpts[1])
  b[1,]<-a_new[hpts[i1],]
  b[2,]<-a_new[hpts[i2],]
  #lines3d(b)
  # The box, that contains all of the points
  #print(a_new[hpts[i2],1])
  m<-(a_new[hpts[i2],1]-a_new[hpts[i1],1])
  n<-(a_new[hpts[i2],2]-a_new[hpts[i1],2])
  p<-(a_new[hpts[i2],3]-a_new[hpts[i1],3])
  vD<--m*a_new[hpts[i2],1]-n*a_new[hpts[i2],2]-p*a_new[hpts[i2],3]
  vD2<--m*a_new[hpts[i1],1]-n*a_new[hpts[i1],2]-p*a_new[hpts[i1],3]
  #D2<-sqrt(A*A+B*B)
  D<-sqrt(m*m+n*n+p*p);
  h_new<-matrix(nrow=nrow(a_new), ncol=3)
  #print(c("m", m, "n", n, "p", p, "vD2", vD2, "vD", vD, "D", D))
  h_new<-proection_test(a_new,m,n,p,vD,D)
  #print(h_new)
  #print(h_new)
  #plot.new()
  #h_new2<-matrix(nrow=nrow(a_new), ncol=3)
  h_new2<-proection_test2(a_new,m,n,p,vD2,D)
  #plot3d(h_new2[,1],h_new2[,2],h_new2[,3], xlim=c(-10,250), ylim=c(-10,250), zlim=c(-10,250), type="p", col="green")
  per<-matrix(nrow=4, ncol=2)
  h_new2<-matrix(nrow=nrow(h_new), ncol=2)
  h_new2<-h_new[,-3]
  per<-Petunin2d(h_new2)
  #print(per)
  per_new<-matrix(nrow=4, ncol=3)
  per_new<-make3d(per, m,n,p, h_new[1,1], h_new[1,2], h_new[1,3])
  per_new2<-matrix(nrow=4, ncol=3)
  #print(per_new)
  per_new2<-proection_test2(per_new,m,n,p,vD2,D)
 
  
  # Rotate and Moving to the origin per_new[1,]
  #print(per_new)
  
  theta2<-acos(abs(p)/D)
  a_new <- a_new%*%rotation_matrix_y(theta2)
  per_new <- per_new%*%rotation_matrix_y(theta2)
  per_new2 <- per_new2%*%rotation_matrix_y(theta2)
  #print(c("theta2", deg(theta2)))
  #print(per_new)
  #print(a_new)
  
  tmp_a<-(per_new[2,1]-per_new[3,1])*(per_new[2,1]-per_new[3,1])+(per_new[2,2]-per_new[3,2])*(per_new[2,2]-per_new[3,2])+(per_new[2,3]-per_new[3,3])*(per_new[2,3]-per_new[3,3])
  tmp_a<-sqrt(tmp_a)
  tmp_b<-(per_new[2,1]-per_new[3,1])/tmp_a
  theta3<-acos(abs(tmp_b))

  #print(c("theta3", deg(theta3)))
  a_new <- a_new%*%rotation_matrix_z(pi/2-theta3)
  per_new <- per_new%*%rotation_matrix_z(pi/2-theta3)
  per_new2 <- per_new2%*%rotation_matrix_z(pi/2-theta3)
  
  #translation#
  a_new[,1]<-a_new[,1]-per_new[1,1]
  a_new[,2]<-a_new[,2]-per_new[1,2]
  a_new[,3]<-a_new[,3]-per_new[1,3]
  per_new2[,1]<-per_new2[,1]-per_new[1,1]
  per_new2[,2]<-per_new2[,2]-per_new[1,2]
  per_new2[,3]<-per_new2[,3]-per_new[1,3]
  per_new[,1]<-per_new[,1]-per_new[1,1]
  per_new[,2]<-per_new[,2]-per_new[1,2]
  per_new[,3]<-per_new[,3]-per_new[1,3]
  #print(a_new)
  #coefficient of compression#
  tmp_d<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new[1,1],per_new[1,2],per_new[1,3])
  tmp_d2<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new[3,1],per_new[3,2],per_new[3,3])
  tmp_d3<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new2[2,1],per_new2[2,2],per_new2[2,3])
  #print(tmp_d)
  #print(tmp_d2)
  #print(tmp_d3)
  if (tmp_d<tmp_d2) {
    alpha1<-tmp_d/tmp_d2 #z
    alpha2<-tmp_d/tmp_d3 #y  
    a_new[,2]<-a_new[,2]*alpha1
    a_new[,3]<-a_new[,3]*alpha2
    per_new2[,2]<-per_new2[,2]*alpha1
    per_new2[,3]<-per_new2[,3]*alpha2
    per_new[,2]<-per_new[,2]*alpha1
    per_new[,3]<-per_new[,3]*alpha2
  }
  else {
    alpha1<-tmp_d2/tmp_d #x
    alpha2<-tmp_d2/tmp_d3 #y 
    a_new[,1]<-a_new[,1]*alpha1
    a_new[,3]<-a_new[,3]*alpha2
    per_new2[,1]<-per_new2[,1]*alpha1
    per_new2[,3]<-per_new2[,3]*alpha2
    per_new[,1]<-per_new[,1]*alpha1
    per_new[,3]<-per_new[,3]*alpha2
  }
  tmp_d<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new[1,1],per_new[1,2],per_new[1,3])
  tmp_d2<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new[3,1],per_new[3,2],per_new[3,3])
  tmp_d3<-dist_points(per_new[2,1],per_new[2,2],per_new[2,3], per_new2[2,1],per_new2[2,2],per_new2[2,3])
  #print(tmp_d)
  #print(tmp_d2)
  #print(tmp_d3)
  
  plot3d(a_new[,1],a_new[,2],a_new[,3], xlim=c(-10,250), ylim=c(-10,250), zlim=c(-10,250), type="p", col="green")

  #lines3d(d3, col="black")
  
  #Draw sphere and ellipsoid
  x_c<-(per_new[1,1]+per_new[3,1])/2
  y_c<-(per_new[1,2]+per_new[3,2])/2
  z_c<-(per_new[1,3]+per_new[3,3])/2
  #print(a_new)
  radius<-matrix(nrow=(nrow(a_new)), ncol=1)
  radius[,1]<-dist_points(x_c,y_c,z_c, a_new[,1],a_new[,2],a_new[,3])
  #tmp_r<-which.max(radius[,1])
  #print(tmp_r)
  #result_p[count,]<-a[tmp_r,]
  #count_m<-0
  for (jj in 1:NN2) {
    result_p[jj,5]=radius[jj,1]  
  }
  #result_p[tmp_r+count_m,5]<-count
  #result_p[tmp_r+count_m,6]<-1
  #else {
  #  result_p[tmp_r+count-1]<-count
  #  print(tmp_r+count-1)  
  #}
  #count<-count+1
  #a<-a[-tmp_r,]
  #a_bonus<-a_bonus[-tmp_r]
  #NN<-NN-1
  #for (j in 1:2){
  #  ee <- rgl.ellipsoid(x = x_c, y = y_c, z = z_c, a = radius[j,1], b = radius[j,1], c = radius[j,1], col="white", override = FALSE)
  #  shapelist3d(ee)
  #}
  #ellipse3d(x_c,y_c,z_c,r[1,1],r[2,1],r[3,1], border="blue")
  #plot3d(ellipse3d(matrix(c(tmp_r,0,0,0,tmp_r,0,0,0,tmp_r), 3,3), centre=c(x_c, y_c, z_c)), col="blue", alpha=0.08, aspect=TRUE)
  #print(result_p)
  #print(a)
  #}
  #print(result_p)
  return (result_p)
}

# Read cell source("filtration.R")
ptm<-proc.time()
blue <- read.table("blue.txt")
red <- read.table("red.txt")
green <- read.table("green.txt")
N<-159
NN<-N*N
red_test<-matrix(nrow=1, ncol=NN)
green_test<-matrix(nrow=1, ncol=NN)
blue_test<-matrix(nrow=1, ncol=NN)
# Test Elliptical pilling on 10x10x10 matrix
k<-0
for (i in 1:N) {
  for (j in 1:N) {
    k<-k+1
    red_test[k]<-red[i,j]
    blue_test[k]<-blue[i,j]
    green_test[k]<-green[i,j]
  }
}
t(red_test)
t(green_test)
t(blue_test)
a<-matrix (nrow=NN, ncol=3)
a[,1] <-red_test
a[,2] <-green_test
a[,3] <-blue_test
#print(a)
result_pilling<-matrix(nrow=NN, ncol=6)
result_pilling<-El_pilling(a)
result_pilling<-result_pilling[sort.list(result_pilling[,5]), ]
plot(0:160, 0:160, type="n")
pilling_tmp<-c(1:NN)
pilling_tmp2<-c(1:NN)
pilling_tmp<-result_pilling[,4]%/%N
pilling_tmp2<-result_pilling[,4]-N*pilling_tmp
#print(pilling_tmp)
sigma_pilling<-sigma_x(result_pilling[,5], result_pilling[1,5], NN)
print(sigma_pilling)
for (ii in 1:(NN/2)){
  points(pilling_tmp[ii], pilling_tmp2[ii], col="red", cex=1) 
}
for (ii in (NN/2+1):NN){
  points(pilling_tmp[ii], pilling_tmp2[ii], col="blue", cex=1) 
}
#order(result_pilling[,5], decreasing = FALSE)
#print(result_pilling)
#write.table(result_pilling,file="result.txt", ncolumns=3)
write.table(result_pilling,file="result.txt", eol = "\n")
# source("test_programm.R")
result_time<-proc.time() - ptm
print(result_time)
