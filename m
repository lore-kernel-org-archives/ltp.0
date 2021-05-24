From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 24 May 2021 15:47:44 +0100
Subject: [LTP] [RFC PATCH 3/4] API: Mostly automatic removal of TEST() usage
 by Coccinelle
In-Reply-To: <20210524144745.10887-1-rpalethorpe@suse.com>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
Message-ID: <20210524144745.10887-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only manual change is to set ret = -1 due to prevent compiler warning
in cgroup read.
---
 lib/tst_af_alg.c             | 46 ++++++++++++++++++++----------------
 lib/tst_cgroup.c             | 13 +++++-----
 lib/tst_crypto.c             | 20 +++++++++-------
 lib/tst_supported_fs_types.c | 10 ++++----
 4 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index d3895a83d..05caa6301 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -13,25 +13,28 @@
 
 int tst_alg_create(void)
 {
-	TEST(socket(AF_ALG, SOCK_SEQPACKET, 0));
-	if (TST_RET >= 0)
-		return TST_RET;
-	if (TST_ERR == EAFNOSUPPORT)
+	const long ret = socket(AF_ALG, SOCK_SEQPACKET, 0);
+
+	if (ret >= 0)
+		return ret;
+	if (errno == EAFNOSUPPORT)
 		tst_brk(TCONF, "kernel doesn't support AF_ALG");
-	tst_brk(TBROK | TTERRNO, "unexpected error creating AF_ALG socket");
+	tst_brk(TBROK | TERRNO, "unexpected error creating AF_ALG socket");
 	return -1;
 }
 
 void tst_alg_bind_addr(int algfd, const struct sockaddr_alg *addr)
 {
-	TEST(bind(algfd, (const struct sockaddr *)addr, sizeof(*addr)));
-	if (TST_RET == 0)
+	const long ret = bind(algfd, (const struct sockaddr *)addr,
+			      sizeof(*addr));
+
+	if (ret == 0)
 		return;
-	if (TST_ERR == ENOENT) {
+	if (errno == ENOENT) {
 		tst_brk(TCONF, "kernel doesn't support %s algorithm '%s'",
 			addr->salg_type, addr->salg_name);
 	}
-	tst_brk(TBROK | TTERRNO,
+	tst_brk(TBROK | TERRNO,
 		"unexpected error binding AF_ALG socket to %s algorithm '%s'",
 		addr->salg_type, addr->salg_name);
 }
@@ -63,6 +66,7 @@ void tst_alg_bind(int algfd, const char *algtype, const char *algname)
 
 bool tst_have_alg(const char *algtype, const char *algname)
 {
+	long ret;
 	int algfd;
 	struct sockaddr_alg addr;
 	bool have_alg = true;
@@ -71,10 +75,10 @@ bool tst_have_alg(const char *algtype, const char *algname)
 
 	init_sockaddr_alg(&addr, algtype, algname);
 
-	TEST(bind(algfd, (const struct sockaddr *)&addr, sizeof(addr)));
-	if (TST_RET != 0) {
-		if (TST_ERR != ENOENT) {
-			tst_brk(TBROK | TTERRNO,
+	ret = bind(algfd, (const struct sockaddr *)&addr, sizeof(addr));
+	if (ret != 0) {
+		if (errno != ENOENT) {
+			tst_brk(TBROK | TERRNO,
 				"unexpected error binding AF_ALG socket to %s algorithm '%s'",
 				algtype, algname);
 		}
@@ -96,6 +100,7 @@ void tst_require_alg(const char *algtype, const char *algname)
 
 void tst_alg_setkey(int algfd, const uint8_t *key, unsigned int keylen)
 {
+	long ret;
 	uint8_t *keybuf = NULL;
 	unsigned int i;
 
@@ -106,9 +111,9 @@ void tst_alg_setkey(int algfd, const uint8_t *key, unsigned int keylen)
 			keybuf[i] = rand();
 		key = keybuf;
 	}
-	TEST(setsockopt(algfd, SOL_ALG, ALG_SET_KEY, key, keylen));
-	if (TST_RET != 0) {
-		tst_brk(TBROK | TTERRNO,
+	ret = setsockopt(algfd, SOL_ALG, ALG_SET_KEY, key, keylen);
+	if (ret != 0) {
+		tst_brk(TBROK | TERRNO,
 			"unexpected error setting key (len=%u)", keylen);
 	}
 	free(keybuf);
@@ -116,12 +121,13 @@ void tst_alg_setkey(int algfd, const uint8_t *key, unsigned int keylen)
 
 int tst_alg_accept(int algfd)
 {
-	TEST(accept(algfd, NULL, NULL));
-	if (TST_RET < 0) {
-		tst_brk(TBROK | TTERRNO,
+	const long ret = accept(algfd, NULL, NULL);
+
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO,
 			"unexpected error accept()ing AF_ALG request socket");
 	}
-	return TST_RET;
+	return ret;
 }
 
 int tst_alg_setup(const char *algtype, const char *algname,
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1e036d3c3..5d13e2829 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1037,6 +1037,7 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 			 const char *const file_name,
 			 char *const out, const size_t len)
 {
+	long ret = -1;
 	const struct cgroup_file *const cfile =
 		cgroup_file_find(file, lineno, file_name);
 	struct cgroup_dir *const *dir;
@@ -1051,9 +1052,9 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 		if (prev_len)
 			memcpy(prev_buf, out, prev_len);
 
-		TEST(safe_file_readat(file, lineno,
-				      (*dir)->dir_fd, alias, out, len));
-		if (TST_RET < 0)
+		ret = safe_file_readat(file, lineno, (*dir)->dir_fd, alias,
+				       out, len);
+		if (ret < 0)
 			continue;
 
 		if (prev_len && memcmp(out, prev_buf, prev_len)) {
@@ -1063,12 +1064,12 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 			break;
 		}
 
-		prev_len = MIN(sizeof(prev_buf), (size_t)TST_RET);
+		prev_len = MIN(sizeof(prev_buf), (size_t) ret);
 	}
 
-	out[MAX(TST_RET, 0)] = '\0';
+	out[MAX(ret, 0)] = '\0';
 
-	return TST_RET;
+	return ret;
 }
 
 void safe_cgroup_printf(const char *const file, const int lineno,
diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
index 685e0871e..c01632c2a 100644
--- a/lib/tst_crypto.c
+++ b/lib/tst_crypto.c
@@ -14,16 +14,17 @@
 
 void tst_crypto_open(struct tst_crypto_session *ses)
 {
-	TEST(socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO));
-	if (TST_RET < 0 && TST_ERR == EPROTONOSUPPORT)
-		tst_brk(TCONF | TTERRNO, "NETLINK_CRYPTO is probably disabled");
+	const long ret = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO);
 
-	if (TST_RET < 0) {
-		tst_brk(TBROK | TTERRNO,
+	if (ret < 0 && errno == EPROTONOSUPPORT)
+		tst_brk(TCONF | TERRNO, "NETLINK_CRYPTO is probably disabled");
+
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO,
 			"socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO)");
 	}
 
-	ses->fd = TST_RET;
+	ses->fd = ret;
 	ses->seq_num = 0;
 }
 
@@ -83,6 +84,7 @@ int tst_crypto_add_alg(struct tst_crypto_session *ses,
 int tst_crypto_del_alg(struct tst_crypto_session *ses,
 		       const struct crypto_user_alg *alg)
 {
+	long ret;
 	unsigned int i = 0;
 	struct nlmsghdr nh = {
 		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*alg),
@@ -96,8 +98,8 @@ int tst_crypto_del_alg(struct tst_crypto_session *ses,
 
 		SAFE_NETLINK_SEND(ses->fd, &nh, alg);
 
-		TEST(tst_crypto_recv_ack(ses));
-		if (TST_RET != -EBUSY || i >= ses->retries)
+		ret = tst_crypto_recv_ack(ses);
+		if (ret != -EBUSY || i >= ses->retries)
 			break;
 
 		if (usleep(1) && errno != EINTR)
@@ -106,5 +108,5 @@ int tst_crypto_del_alg(struct tst_crypto_session *ses,
 		++i;
 	}
 
-	return TST_RET;
+	return ret;
 }
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 592a526ae..d0f745490 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -167,14 +167,16 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 
 int tst_check_quota_support(const char *device, int format, char *quotafile)
 {
-	TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format, quotafile));
+	const long ret = quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format,
+				  quotafile);
 
 	/* Not supported */
-	if (TST_RET == -1 && TST_ERR == ESRCH)
+
+	if (ret == -1 && errno == ESRCH)
 		return 0;
 
 	/* Broken */
-	if (TST_RET)
+	if (ret)
 		return -1;
 
 	quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), device, 0, 0);
@@ -192,5 +194,5 @@ void tst_require_quota_support_(const char *file, const int lineno,
 	}
 
 	if (status < 0)
-		tst_brk_(file, lineno, TBROK|TTERRNO, "FS quotas are broken");
+		tst_brk_(file, lineno, TBROK|TERRNO, "FS quotas are broken");
 }
-- 
2.31.1

