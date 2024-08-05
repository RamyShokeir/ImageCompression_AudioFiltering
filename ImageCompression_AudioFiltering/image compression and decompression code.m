I=imread('Image_PATH');
R_channel=im2double(I(:,:,1));
G_channel=im2double(I(:,:,2));
B_channel=im2double(I(:,:,3));
m=1;
for o=0:134
       for i=0:239
           R_block=R_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           G_block=G_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           B_block=B_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           DCT_R_block=dct2(R_block);
           DCT_G_block=dct2(G_block);
           DCT_B_block=dct2(B_block);
           compressed_R_DCT_block=DCT_R_block(1:m,1:m);
           compressed_G_DCT_block=DCT_G_block(1:m,1:m);
           compressed_B_DCT_block=DCT_B_block(1:m,1:m);
           R_new_compressed(m*o+1:m*o+m,m*i+1:m*i+m)=compressed_R_DCT_block;
           G_new_compressed(m*o+1:m*o+m,m*i+1:m*i+m)=compressed_G_DCT_block;
           B_new_compressed(m*o+1:m*o+m,m*i+1:m*i+m)=compressed_B_DCT_block;
        end
end
compressed=cat(3,R_new_compressed,G_new_compressed,B_new_compressed);
imwrite(compressed,'comp1.bmp');
for m=1:8
    for o=0:134
       for i=0:239
           R_block=R_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           G_block=G_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           B_block=B_channel(8*o+1:8*o+8,8*i+1:8*i+8);
           DCT_R_block=dct2(R_block);
           DCT_G_block=dct2(G_block);
           DCT_B_block=dct2(B_block);
           compressed_R_DCT_block=DCT_R_block(1:m,1:m);
           compressed_G_DCT_block=DCT_G_block(1:m,1:m);
           compressed_B_DCT_block=DCT_B_block(1:m,1:m);
           Z=zeros(8);
           Z(1:m,1:m)=compressed_R_DCT_block(1:m,1:m);
           R_new_decompressed(8*o+1:8*o+8,8*i+1:8*i+8)=idct2(Z);
           Z(1:m,1:m)=compressed_G_DCT_block(1:m,1:m);
           G_new_decompressed(8*o+1:8*o+8,8*i+1:8*i+8)=idct2(Z);
           Z(1:m,1:m)=compressed_B_DCT_block(1:m,1:m);
           B_new_decompressed(8*o+1:8*o+8,8*i+1:8*i+8)=idct2(Z);
        end
     end
    decompressed=cat(3,R_new_decompressed,G_new_decompressed,B_new_decompressed);
    PSNR=psnr(decompressed,im2double(I));
    Y_axis(1,m)=PSNR;
end
X_axis=1:8;
plot(X_axis,Y_axis)
xlabel('m')
ylabel('PSNR')