From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 20 Aug 2020 11:19:17 -0700
Subject: [LTP] [LTP PATCH 1/2] lib/tst_af_alg: add tst_alg_sendmsg()
In-Reply-To: <20200820181918.404758-1-ebiggers@kernel.org>
References: <20200820181918.404758-1-ebiggers@kernel.org>
Message-ID: <20200820181918.404758-2-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a helper function which sends data to an AF_ALG request socket,
including control data.  This is needed by af_alg02, but it may also be
useful for other AF_ALG tests in the future.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/tst_af_alg.h | 32 ++++++++++++++++++++++
 lib/tst_af_alg.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/tst_af_alg.h b/include/tst_af_alg.h
index fc4b1989a..fd2ff0647 100644
--- a/include/tst_af_alg.h
+++ b/include/tst_af_alg.h
@@ -133,4 +133,36 @@ int tst_alg_setup(const char *algtype, const char *algname,
 int tst_alg_setup_reqfd(const char *algtype, const char *algname,
 			const uint8_t *key, unsigned int keylen);
 
+/** Specification of control data to send to an AF_ALG request socket */
+struct tst_alg_sendmsg_params {
+
+	/** If true, send ALG_SET_OP with ALG_OP_ENCRYPT */
+	bool encrypt;
+
+	/** If true, send ALG_SET_OP with ALG_OP_DECRYPT */
+	bool decrypt;
+
+	/** If ivlen != 0, send ALG_SET_IV */
+	const uint8_t *iv;
+	unsigned int ivlen;
+
+	/** If assoclen != 0, send ALG_SET_AEAD_ASSOCLEN */
+	unsigned int assoclen;
+
+	/* Value to use as msghdr::msg_flags */
+	uint32_t msg_flags;
+};
+
+/**
+ * Send some data to an AF_ALG request socket, including control data.
+ * @param reqfd An AF_ALG request socket
+ * @param data The data to send
+ * @param datalen The length of data in bytes
+ * @param params Specification of the control data to send
+ *
+ * On failure, tst_brk() is called with TBROK.
+ */
+void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
+		     const struct tst_alg_sendmsg_params *params);
+
 #endif /* TST_AF_ALG_H */
diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index 97be548b4..d3895a83d 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -146,3 +146,67 @@ int tst_alg_setup_reqfd(const char *algtype, const char *algname,
 	close(algfd);
 	return reqfd;
 }
+
+void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
+		     const struct tst_alg_sendmsg_params *params)
+{
+	struct iovec iov = {
+		.iov_base = (void *)data,
+		.iov_len = datalen,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_flags = params->msg_flags,
+	};
+	size_t controllen;
+	uint8_t *control;
+	struct cmsghdr *cmsg;
+	struct af_alg_iv *alg_iv;
+
+	if (params->encrypt && params->decrypt)
+		tst_brk(TBROK, "Both encrypt and decrypt are specified");
+
+	controllen = 0;
+	if (params->encrypt || params->decrypt)
+		controllen += CMSG_SPACE(sizeof(uint32_t));
+	if (params->ivlen)
+		controllen += CMSG_SPACE(sizeof(struct af_alg_iv) +
+					 params->ivlen);
+	if (params->assoclen)
+		controllen += CMSG_SPACE(sizeof(uint32_t));
+
+	control = SAFE_MALLOC(controllen);
+	memset(control, 0, controllen);
+	msg.msg_control = control;
+	msg.msg_controllen = controllen;
+	cmsg = CMSG_FIRSTHDR(&msg);
+
+	if (params->encrypt || params->decrypt) {
+		cmsg->cmsg_level = SOL_ALG;
+		cmsg->cmsg_type = ALG_SET_OP;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+		*(uint32_t *)CMSG_DATA(cmsg) =
+			params->encrypt ? ALG_OP_ENCRYPT : ALG_OP_DECRYPT;
+		cmsg = CMSG_NXTHDR(&msg, cmsg);
+	}
+	if (params->ivlen) {
+		cmsg->cmsg_level = SOL_ALG;
+		cmsg->cmsg_type = ALG_SET_IV;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) +
+					  params->ivlen);
+		alg_iv = (struct af_alg_iv *)CMSG_DATA(cmsg);
+		alg_iv->ivlen = params->ivlen;
+		memcpy(alg_iv->iv, params->iv, params->ivlen);
+		cmsg = CMSG_NXTHDR(&msg, cmsg);
+	}
+	if (params->assoclen) {
+		cmsg->cmsg_level = SOL_ALG;
+		cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+		*(uint32_t *)CMSG_DATA(cmsg) = params->assoclen;
+		cmsg = CMSG_NXTHDR(&msg, cmsg);
+	}
+
+	SAFE_SENDMSG(datalen, reqfd, &msg, 0);
+}
-- 
2.28.0

