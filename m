From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Mar 2021 14:03:49 +0100
Subject: [LTP] [PATCH] crypto_user02: Find a valid template
Message-ID: <20210315130349.1155389-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test requires a crypto template, that is not in use by someone else,
otherwise deleting it is not possible.
This adds a list of templates, that are tested in order, until one is found,
that can be used for the test, otherwise TCONF is returned.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/crypto/crypto_user02.c | 65 ++++++++++++++++++-------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index 384e344f2..23dff5b5f 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright 2019 Google LLC
+ * Copyright (c) 2019 Google LLC
+ * Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
  */
 
 /*
@@ -26,37 +27,65 @@
 #include "tst_crypto.h"
 #include "tst_timer.h"
 
+/*
+ * List of possible templates to use try (not exhaustive).
+ * The template has to be valid (i.e. the drivers must exists
+ * and be a valid combination) and it has to be deleteable.
+ * To be deletable it cannot be used by someone else.
+ * The first algorithm, that fullfils the criteria is used for the test.
+ */
+static const char* TEMPLATE_CANDIDATES[] = {
+	"hmac(sha1-generic)",
+	"hmac(sha224-generic)",
+	"hmac(sha256-generic)",
+	"hmac(sha384-generic)",
+	"hmac(md5-generic)"
+};
+
+static const char* template = NULL;
 static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
 
+
 static void setup(void)
 {
+	int rc;
+	unsigned i;
+	struct crypto_user_alg alg, alg_out;
 	tst_crypto_open(&ses);
+
+	/* find an algorithm, that is not in use */
+	for (i = 0; i < ARRAY_SIZE(TEMPLATE_CANDIDATES); ++i) {
+		memset(&alg, 0, sizeof(alg));
+		strcpy(alg.cru_driver_name, TEMPLATE_CANDIDATES[i]);
+
+		/* try to add it, to see if it is valid */
+		rc = tst_crypto_add_alg(&ses, &alg);
+		if (rc != 0)
+			continue;
+
+		/* it also has to be deletable */
+		rc = tst_crypto_del_alg(&ses, &alg);
+		if (rc == 0) {
+			template = TEMPLATE_CANDIDATES[i];
+			break;
+		}
+	}
+	if (!template) {
+		tst_brk(TCONF, "No viable template found");
+	}
 }
 
 static void run(void)
 {
-	struct crypto_user_alg alg = {
-		/*
-		 * Any algorithm instantiated from a template can do here, but
-		 * choose something that's commonly available.
-		 */
-		.cru_driver_name = "hmac(sha256-generic)",
-	};
+	struct crypto_user_alg alg = {};
 	pid_t pid;
 	int status;
 
-	/* Check whether the algorithm is supported before continuing. */
-	TEST(tst_crypto_add_alg(&ses, &alg));
-	if (TST_RET != 0 && TST_RET != -EEXIST) {
-		if (TST_RET == -ENOENT)
-			tst_brk(TCONF, "%s not supported", alg.cru_driver_name);
-
-		tst_brk(TBROK | TRERRNO,
-			"unexpected error checking for algorithm support");
-	}
+	strcpy(alg.cru_driver_name, template);
 
 	tst_res(TINFO,
-		"Starting crypto_user larval deletion test.  May crash buggy kernels.");
+		"Starting crypto_user larval deletion test using template %s. May crash buggy kernels.",
+		template);
 
 	tst_timer_start(CLOCK_MONOTONIC);
 
-- 
2.25.1

