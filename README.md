# Modified_Advanced_Hill_Cipher
We explored the application of linear algebra in the encryption of images. We choose to use an adaptation of the encryption technique known as an Advanced Hill Cipher. This method of encryption uses a series of matrix manipulations based on a private key matrix to alter the color values of each pixel. This process takes place across the red, green, and blue (R-G-B) levels of the image matrix. Our algorithm is able to efficiently encrypt images of varying sizes and types while maintaining an effective level of encryption. Should an unauthorized entity try to decrypt our images and their decryption matrix is off by one value, it can result in improper recovery of between 31.25% and 68.75% of the image.

The idea for this encryption process is heavily based on information from:
Bibhudendra Acharya, Saroj Kumar Panigrahy, Sarat Kumar Patra, Ganapati Panda. Image Encryption Using Advanced Hill Cipher Algorithm} Int. J R.T Eng. Vol. 1, No. 1, 663 - 667, May 2009

With additional syntax help from  
"MATLAB Speaks SDR." MathWorks – Makers of MATLAB and Simulink. N.p., n.d. Web. Mar. 2016.
Dempsey Rogers

All images are from Google Images. All rights belong to their respective owners.
