#!/bin/sh
#
#  Remove the ACSS implementation from OpenSSH, and disable its use so that the
#  rest of the package can still be built.
#
> acss.c
patch -sp0 << EOF
--- cipher.c.orig       2005-07-17 09:02:10.000000000 +0200
+++ cipher.c    2005-09-06 14:52:06.000000000 +0200
@@ -45,6 +45,9 @@

 /* compatibility with old or broken OpenSSL versions */
 #include "openbsd-compat/openssl-compat.h"
+#undef USE_CIPHER_ACSS
+#undef EVP_acss
+#define EVP_acss NULL

 extern const EVP_CIPHER *evp_ssh1_bf(void);
 extern const EVP_CIPHER *evp_ssh1_3des(void);
EOF
