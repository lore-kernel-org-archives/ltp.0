From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 10 Dec 2018 22:03:15 -0800
Subject: [LTP] [PATCH v2 1/3] lapi/cryptouser.h: add more declarations
In-Reply-To: <20181211060317.18698-1-ebiggers@kernel.org>
References: <20181211060317.18698-1-ebiggers@kernel.org>
Message-ID: <20181211060317.18698-2-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add some missing declarations for the crypto user configuration API,
a.k.a. NETLINK_CRYPTO.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/lapi/cryptouser.h | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/include/lapi/cryptouser.h b/include/lapi/cryptouser.h
index 61ff21ad3..94d641446 100644
--- a/include/lapi/cryptouser.h
+++ b/include/lapi/cryptouser.h
@@ -34,6 +34,24 @@ enum {
 	__CRYPTO_MSG_MAX
 };
 
+enum crypto_attr_type_t {
+	CRYPTOCFGA_UNSPEC,
+	CRYPTOCFGA_PRIORITY_VAL,	/* uint32_t */
+	CRYPTOCFGA_REPORT_LARVAL,	/* struct crypto_report_larval */
+	CRYPTOCFGA_REPORT_HASH,		/* struct crypto_report_hash */
+	CRYPTOCFGA_REPORT_BLKCIPHER,	/* struct crypto_report_blkcipher */
+	CRYPTOCFGA_REPORT_AEAD,		/* struct crypto_report_aead */
+	CRYPTOCFGA_REPORT_COMPRESS,	/* struct crypto_report_comp */
+	CRYPTOCFGA_REPORT_RNG,		/* struct crypto_report_rng */
+	CRYPTOCFGA_REPORT_CIPHER,	/* struct crypto_report_cipher */
+	CRYPTOCFGA_REPORT_AKCIPHER,	/* struct crypto_report_akcipher */
+	CRYPTOCFGA_REPORT_KPP,		/* struct crypto_report_kpp */
+	CRYPTOCFGA_REPORT_ACOMP,	/* struct crypto_report_acomp */
+	__CRYPTOCFGA_MAX
+
+#define CRYPTOCFGA_MAX (__CRYPTOCFGA_MAX - 1)
+};
+
 struct crypto_user_alg {
 	char cru_name[CRYPTO_MAX_NAME];
 	char cru_driver_name[CRYPTO_MAX_NAME];
@@ -44,6 +62,61 @@ struct crypto_user_alg {
 	uint32_t cru_flags;
 };
 
+struct crypto_report_larval {
+	char type[CRYPTO_MAX_NAME];
+};
+
+struct crypto_report_hash {
+	char type[CRYPTO_MAX_NAME];
+	unsigned int blocksize;
+	unsigned int digestsize;
+};
+
+struct crypto_report_cipher {
+	char type[CRYPTO_MAX_NAME];
+	unsigned int blocksize;
+	unsigned int min_keysize;
+	unsigned int max_keysize;
+};
+
+struct crypto_report_blkcipher {
+	char type[CRYPTO_MAX_NAME];
+	char geniv[CRYPTO_MAX_NAME];
+	unsigned int blocksize;
+	unsigned int min_keysize;
+	unsigned int max_keysize;
+	unsigned int ivsize;
+};
+
+struct crypto_report_aead {
+	char type[CRYPTO_MAX_NAME];
+	char geniv[CRYPTO_MAX_NAME];
+	unsigned int blocksize;
+	unsigned int maxauthsize;
+	unsigned int ivsize;
+};
+
+struct crypto_report_comp {
+	char type[CRYPTO_MAX_NAME];
+};
+
+struct crypto_report_rng {
+	char type[CRYPTO_MAX_NAME];
+	unsigned int seedsize;
+};
+
+struct crypto_report_akcipher {
+	char type[CRYPTO_MAX_NAME];
+};
+
+struct crypto_report_kpp {
+	char type[CRYPTO_MAX_NAME];
+};
+
+struct crypto_report_acomp {
+	char type[CRYPTO_MAX_NAME];
+};
+
 #endif	/* HAVE_LINUX_CRYPTOUSER_H */
 
 /* These are taken from include/crypto.h in the kernel tree. They are not
-- 
2.19.2

