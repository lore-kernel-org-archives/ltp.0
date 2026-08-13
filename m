Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F7CC5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 14:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69F573C305F
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 16:06:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63D363C25F9
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:06:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6A1D61A00646
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786629990; x=1818165990;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Z/dOmXt3DWaRM/pmNhQKK00+T/OxIgHS9yNzxmRaae8=;
 b=YhV1WmglwMCJasaSorDx0aAjDDVPkfIIWnR51PwK4kEEu0sQiBZSQI7o
 F3THxAuUOFWkJ1JKQZl2TXL0772YMEPBsn6bfelpFFViyUdFhb2r3LUmK
 bAplPvbG72rReelPlCgkmBVEAFeD2lgHucoqdKcBKD4QI0chwDjc17NWL
 uJEcForJnvQkxJUnKTj9m7GvS61T1D9v4EjBQWNPyyvr73ldYHHnEfsz1
 TEI12QzCzxyghMCsPTi7C3qSw66BIcD7vR/78QFnGQft+nEYZ1GCBtARb
 ZQOdXX2ZgMDoeHLGUias4wvOElPhfQTw9mZSvGgSlvSIT9Z3sz3CqKrOy w==;
X-CSE-ConnectionGUID: IAfJKC8nQU+CMoK8/tC/lA==
X-CSE-MsgGUID: EYlmdCTOQQWhAXA+GNbnDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86324078"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86324078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:06:15 -0700
X-CSE-ConnectionGUID: MDHzoZHXTsOq9QkHdyotvA==
X-CSE-MsgGUID: 3f3Sos/ATRa85qbHQg0WPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="302206876"
Received: from igk-lkp-server01.igk.intel.com (HELO igk-lkp-server01)
 ([10.211.93.152])
 by orviesa001.jf.intel.com with ESMTP; 13 Aug 2026 07:06:14 -0700
Received: from [10.245.244.58] (helo=frankran-MOBL)
 by igk-lkp-server01 with esmtp (Exim 4.96)
 (envelope-from <frank.ranner@intel.com>) id 1wuW4S-003F6I-0i;
 Thu, 13 Aug 2026 16:06:12 +0200
From: Frank Ranner <frank.ranner@intel.com>
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 16:06:09 +0200
Message-ID: <20260813140609.57520-1-frank.ranner@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH ltp] testcases/kernel/crypto/crypto_user02.c: fix hmac
 candidate probing
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Frank Ranner <frank.ranner@intel.com>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit a4be708b4 ("try non-generic hmac names first") added a list of
plain algorithm names (e.g. "hmac(sha256)") that was probed by copying
each string directly into cru_driver_name, the same way the pre-existing
"-generic" fallback names were already being probed.

That approach relies on the newly (or already) registered algorithm's
actual cra_driver_name being identical to the probed string, which is
not guaranteed. On current kernels, "hmac(sha256)" is satisfied by a
non-instance "hmac-sha256-lib" driver matched via the loose cra_name
fallback in crypto_alg_match(), while template instantiation of "hmac"
produces driver names such as "hmac-shash(sha256-generic)". Since
CRYPTO_MSG_DELALG always requires an exact cru_driver_name match, every
one of the new candidates fails to delete, and setup() silently falls
through to the legacy "-generic" names, which are themselves absent on
kernels that dropped the generic hash implementations. The net effect
is that the test still reports "No viable algorithm found" on affected
kernels, unchanged from before the commit.

Fix this by not guessing the driver name at all. Probe each candidate
by algorithm name (cru_name) instead of driver name, which lets the
kernel resolve it however it currently does, then use a new
CRYPTO_MSG_GETALG request to ask the kernel what driver name actually
satisfies that algorithm. Only that authoritative, kernel-reported
driver name is used for the deletability check and for the later
CRYPTO_MSG_DELALG calls in the actual race loop. The race loop's own
CRYPTO_MSG_NEWALG calls also switch to adding by algorithm name, since
re-instantiating the same driver on each iteration requires the
template-parseable "hmac(...)" form rather than its resulting driver
name.

This adds tst_crypto_get_alg() to the shared crypto netlink helpers,
built directly on the existing low-level tst_netlink send/recv
primitives, so any future crypto test needing to resolve a driver name
can reuse it instead of re-deriving this logic.

Verified locally: on a live 7.0 kernel, all of the plain hmac(<hash>)
candidates for sha1/sha224/sha256/sha384/md5 resolve to permanent
"-lib"-style drivers and are correctly rejected as non-deletable, while
hmac(sm3) resolves to a genuine "hmac(sm3-avx)" template instance and
is correctly selected; the race loop then runs to completion cleanly.
Rebuilding the pre-fix version of this file on the same kernel confirms
it falls through every new candidate and only succeeds via the legacy
"hmac(sm3-generic)" fallback, reproducing the reported failure mode.

Fixes: a4be708b4 ("testcases/kernel/crypto/crypto_user02.c: try non-generic hmac names first")
Signed-off-by: Frank Ranner <frank.ranner@intel.com>
---
 include/tst_crypto.h                    | 22 +++++++++
 lib/tst_crypto.c                        | 42 ++++++++++++++++
 testcases/kernel/crypto/crypto_user02.c | 65 ++++++++++++++++++-------
 3 files changed, 111 insertions(+), 18 deletions(-)

diff --git a/include/tst_crypto.h b/include/tst_crypto.h
index 4511adf22..db71a5f3b 100644
--- a/include/tst_crypto.h
+++ b/include/tst_crypto.h
@@ -54,4 +54,26 @@ int tst_crypto_add_alg(struct tst_netlink_context *ctx,
 int tst_crypto_del_alg(struct tst_netlink_context *ctx,
 	const struct crypto_user_alg *alg, unsigned int retries);
 
+/**
+ * tst_crypto_get_alg() - Look up the kernel's registration info for an alg.
+ *
+ * @ctx: Initialized netlink context
+ * @alg: On input, the algorithm to query, normally identified by cru_name.
+ *       On success it is overwritten with the kernel's authoritative view of
+ *       the matched algorithm, including its actual cru_driver_name.
+ *
+ * Sends a CRYPTO_MSG_GETALG request and parses the response. This is useful
+ * because the driver name that ends up registered for a given algorithm name
+ * is a kernel implementation detail: it can be satisfied by a permanent,
+ * non-instance driver (e.g. a "-lib" fast path) or by a freshly instantiated
+ * template, and the exact driver name string used for either has changed
+ * across kernel versions. Looking it up dynamically avoids depending on any
+ * particular naming convention.
+ *
+ * Return: On success it will return 0 otherwise it will return an inverted
+ * error code from the crypto layer.
+ */
+int tst_crypto_get_alg(struct tst_netlink_context *ctx,
+	struct crypto_user_alg *alg);
+
 #endif	/* TST_CRYPTO_H */
diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
index 4495d0baa..c64dbbe44 100644
--- a/lib/tst_crypto.c
+++ b/lib/tst_crypto.c
@@ -50,3 +50,45 @@ int tst_crypto_del_alg(struct tst_netlink_context *ctx,
 
 	return ret;
 }
+
+int tst_crypto_get_alg(struct tst_netlink_context *ctx,
+	struct crypto_user_alg *alg)
+{
+	struct nlmsghdr nh = {
+		.nlmsg_type = CRYPTO_MSG_GETALG,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+	};
+	struct tst_netlink_message *response;
+	int ret = -ENOENT;
+	int i;
+
+	NETLINK_ADD_MESSAGE(ctx, &nh, alg, sizeof(struct crypto_user_alg));
+
+	if (tst_netlink_send(__FILE__, __LINE__, ctx) <= 0)
+		return -tst_netlink_errno;
+
+	tst_netlink_wait(ctx);
+	response = tst_netlink_recv(__FILE__, __LINE__, ctx);
+
+	if (!response)
+		return -ENOENT;
+
+	for (i = 0; response[i].header; i++) {
+		if (response[i].err) {
+			if (response[i].err->error)
+				ret = response[i].err->error;
+			continue;
+		}
+
+		if (response[i].header->nlmsg_type == CRYPTO_MSG_GETALG &&
+		    response[i].payload_size >= sizeof(struct crypto_user_alg)) {
+			memcpy(alg, response[i].payload,
+				sizeof(struct crypto_user_alg));
+			ret = 0;
+		}
+	}
+
+	tst_netlink_free_message(response);
+
+	return ret;
+}
diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index c08d35c84..d59be0f1a 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -28,11 +28,19 @@
 #include "tst_timer.h"
 
 /*
- * List of possible algorithms to use try (not exhaustive).
- * The algorithm has to be valid (i.e. the drivers must exists
- * and be a valid combination) and it has to be deleteable.
- * To be deletable it cannot be used by someone else.
- * The first algorithm, that fullfils the criteria is used for the test.
+ * List of possible algorithms to try (not exhaustive). Each entry is an
+ * algorithm *name*, not a driver name: the driver name that ends up
+ * registered for a given name is a kernel implementation detail that has
+ * changed across kernel versions (e.g. "hmac(sha256)" may be satisfied by a
+ * permanent, non-instance "hmac-sha256-lib" driver, while genuinely
+ * instantiating the "hmac" template produces a driver such as
+ * "hmac-shash(sha256-generic)"). setup() therefore resolves the real driver
+ * name dynamically via CRYPTO_MSG_GETALG instead of assuming any naming
+ * convention.
+ *
+ * The algorithm also has to be deletable, i.e. it must be a template
+ * instance and not a permanent built-in driver, and it cannot be in use by
+ * someone else. The first candidate that fulfils both criteria is used.
  */
 static const char * const ALGORITHM_CANDIDATES[] = {
 	"hmac(sha1)",
@@ -65,7 +73,8 @@ static const char * const ALGORITHM_CANDIDATES[] = {
 	"hmac(streebog512-generic)"
 };
 
-static const char* algorithm = NULL;
+static const char *algorithm_name;
+static char driver_name[CRYPTO_MAX_NAME];
 static struct tst_netlink_context *ctx;
 
 
@@ -74,42 +83,62 @@ static void setup(void)
 	int rc;
 	unsigned i;
 	struct crypto_user_alg alg;
+	struct crypto_user_alg report;
 
 	ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 
 	/* find an algorithm, that is not in use */
 	for (i = 0; i < ARRAY_SIZE(ALGORITHM_CANDIDATES); ++i) {
 		memset(&alg, 0, sizeof(alg));
-		strcpy(alg.cru_driver_name, ALGORITHM_CANDIDATES[i]);
+		strcpy(alg.cru_name, ALGORITHM_CANDIDATES[i]);
 
-		/* try to add it, to see if it is valid */
+		/*
+		 * Try to add it by name, to see if it is valid. -EEXIST just
+		 * means some driver (which may or may not be deletable)
+		 * already satisfies this name.
+		 */
 		rc = tst_crypto_add_alg(ctx, &alg);
-		if (rc != 0)
+		if (rc != 0 && rc != -EEXIST)
+			continue;
+
+		/* find out which driver actually satisfies this name */
+		memset(&report, 0, sizeof(report));
+		strcpy(report.cru_name, ALGORITHM_CANDIDATES[i]);
+		if (tst_crypto_get_alg(ctx, &report) != 0)
 			continue;
 
 		/* it also has to be deletable */
-		rc = tst_crypto_del_alg(ctx, &alg, 1000);
+		rc = tst_crypto_del_alg(ctx, &report, 1000);
 		if (rc == 0) {
-			algorithm = ALGORITHM_CANDIDATES[i];
+			algorithm_name = ALGORITHM_CANDIDATES[i];
+			strcpy(driver_name, report.cru_driver_name);
 			break;
 		}
 	}
 
-	if (!algorithm)
+	if (!algorithm_name)
 		tst_brk(TCONF, "No viable algorithm found");
 }
 
 static void run(void)
 {
-	struct crypto_user_alg alg = {};
+	struct crypto_user_alg add_alg = {};
+	struct crypto_user_alg del_alg = {};
 	pid_t pid;
 	int status;
 
-	strcpy(alg.cru_driver_name, algorithm);
+	/*
+	 * The add request must reference the algorithm by name so the
+	 * kernel can parse it as "template(args)" and re-instantiate it on
+	 * every iteration. The delete request requires an exact driver name
+	 * match, so it uses the driver name resolved once in setup().
+	 */
+	strcpy(add_alg.cru_name, algorithm_name);
+	strcpy(del_alg.cru_driver_name, driver_name);
 
 	tst_res(TINFO,
-		"Starting crypto_user larval deletion test using algorithm %s. May crash buggy kernels.",
-		algorithm);
+		"Starting crypto_user larval deletion test using algorithm %s (driver %s). May crash buggy kernels.",
+		algorithm_name, driver_name);
 
 	tst_timer_start(CLOCK_MONOTONIC);
 
@@ -120,7 +149,7 @@ static void run(void)
 			/* Child process: execute CRYPTO_MSG_NEWALG. */
 			ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 			for (;;) {
-				TEST(tst_crypto_add_alg(ctx, &alg));
+				TEST(tst_crypto_add_alg(ctx, &add_alg));
 				if (TST_RET && TST_RET != -EEXIST)
 					tst_brk(TBROK | TRERRNO,
 						"unexpected error from tst_crypto_add_alg()");
@@ -138,7 +167,7 @@ static void run(void)
 		SAFE_WAIT(&status);
 		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
 			tst_brk(TBROK, "child %s", tst_strstatus(status));
-		TEST(tst_crypto_del_alg(ctx, &alg, 1000));
+		TEST(tst_crypto_del_alg(ctx, &del_alg, 1000));
 		if (TST_RET && TST_RET != -ENOENT)
 			tst_brk(TBROK | TRERRNO,
 				"unexpected error from tst_crypto_del_alg()");
-- 
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
