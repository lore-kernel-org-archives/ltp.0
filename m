Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C3ECA5FD4
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790946372; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nH4Jt4qFxPj1h9KD3TjR/moV0OrpZn0kdd7zbg+flRk=;
 b=BpSAEL67PBZT80zJ+xodPehJ6uFcas4u1/mN4KOd80QcdfQQg9D4tHYFXdunLM+7fVx4g
 +forEouj5SqQW2a91KylHaQ2ApuZszX5OQgdfPpT84sgJK8rrdpSxpnjSlRbL8UgQhNf3LY
 kghehoUrSLSNR92SFxZXCf1H3c2FesY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A9A23E6F48
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:06:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0953E5580
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:05:51 +0200 (CEST)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com
 [IPv6:2607:f8b0:4864:20::446])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 151D960047E
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:05:51 +0200 (CEST)
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-88679c4f94cso2720875b3a.0
 for <ltp@lists.linux.it>; Fri, 02 Oct 2026 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790946349; x=1791551149; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KtrwqLlhRU5gPZaWiFe5qhhW+gDRPLJ2g3fIfG60BWQ=;
 b=JH/SjHIwxVy8WTnxCIQnXhrwKe2ayByeHBwjNsqWFo9kWa7/B62iiTfUvYimGrIBRD
 PHp/TD/un06uiMCfHYKtAG1gXGdiLnW/Yf6ZiNsrWUG3Q4g+EqGtLTZnZ7NuBGVIgCVq
 HlL+LMXkD4xQlmQ/FUX7tXyp4tHpnBO0kQ+rfe2RC/knG4ltwkd3IOwzRt8N2/wk7ptV
 e2w1XqzEyZMtl7+Xe/Y8Xs+ccGvWK8t7AUClBwUgrEmNNKIHfuDgo3W6BpvnDS+ebw/c
 JOhpldQTcRfXtgQiG1jWS4sORAWgcg3Yd2ZEKbeu/ScrGvVN9kLaZSrQhLRN1ncrwXt6
 mH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946349; x=1791551149;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KtrwqLlhRU5gPZaWiFe5qhhW+gDRPLJ2g3fIfG60BWQ=;
 b=MeTEQ4kDO3oa3b2IU0CDygdvMFY2Tp5Eb5VzAPOLVVlXa9UJ6xpHxaQ9h5xyPFk6hp
 pzbuqVkdNMsts9zHxunssOe/XYUH/ye2rwdoJUICfRwO9oJzQgAvBpAOV8OfAVuBdqzi
 10PUVBMjcrrejUEmRBZasAdlNKowMLqoYS7uBvYKJkIICAiVnt3ODe7NbKF1BbdjJK6m
 2xTWpt3yuxU8H2C6N0dhUDMMqdaO9vCVccNJnBle1Xqfu41gkDNS73e3gzyqp/hCMEFZ
 7vebhCDMcs4AHSvpI4xSOLtPUM1AdgMgh2rqtkyGx6sqKHkPxmlUCoUoo9XLINkl7CkG
 0cag==
X-Gm-Message-State: AFuF++nS4mrznLaTDr27NvbzZEKnbB9UwZECYFJYuhpvk+jMNoGG9mzt
 qGvCE3mBauVIGOLM4l4AlyA1LH61yN5YU8TWKcS+g1YfHfqWNw6YBOauMHpnqIFLjBghbnZqNMe
 IaZiXWXkjJj+0jP1VOXL7DKFdyMkSmBibNIYxbGmpQJbg4e/f8frwrmrAWYUxw6KDXSPv4Z1fO0
 H46FrCDnkg8wjB63RYsL+gUpn/Lg==
X-Received: from pfbdk15.prod.google.com
 ([2002:a05:6a00:488f:b0:88b:cb5b:e6a3])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f06:b0:880:849d:c087
 with SMTP id d2e1a72fcca58-88af4b4826dmr2599715b3a.24.1790946348877; Fri, 02
 Oct 2026 06:05:48 -0700 (PDT)
Date: Fri,  2 Oct 2026 13:05:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002130546.1236713-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] keyctl: Fix struct keyctl_dh_params build on Bionic
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Bionic generates its copy of the UAPI headers with the C++ keyword
'private' renamed to '__linux_private', so its struct keyctl_dh_params
only provides the 'priv' alias added in kernel 4.20. Since keyctl25-28
were switched to 'private', they fail to build on Android:

    error: no member named 'private' in 'struct keyctl_dh_params'

Detect the 'private' member in configure and access the member via a
new KEYCTL_DH_PRIVATE() macro, which falls back to 'priv' when
'private' is not available, similar to FSID_VAL_MEMBER() in
lapi/fanotify.h.

Checking for 'private' rather than 'priv' leaves every build whose UAPI
headers provide 'private' unchanged, including headers older than 4.20
which lack 'priv'. It also makes 'priv' the default when configure is
not run, as in the Android build, which uses a hand-maintained
config.h. The LTP fallback definition provides both members.

Fixes: 71353a6c009b ("keyctl: Use struct keyctl_dh_params 'private' instead of 'priv'")
Signed-off-by: Wake Liu <wakel@google.com>
---
 configure.ac                                |  1 +
 include/lapi/keyctl.h                       | 14 ++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl25.c |  5 +++--
 testcases/kernel/syscalls/keyctl/keyctl26.c |  5 +++--
 testcases/kernel/syscalls/keyctl/keyctl27.c |  5 +++--
 testcases/kernel/syscalls/keyctl/keyctl28.c |  2 +-
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index e979de0e7..4087856c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -302,6 +302,7 @@ AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
 	struct keyctl_pkey_query, struct keyctl_pkey_params],,,
 	[#include <linux/keyctl.h>])
+AC_CHECK_MEMBERS([struct keyctl_dh_params.private],,,[#include <linux/keyctl.h>])
 
 # Tools knobs
 
diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index eb4d25c42..788c4d509 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -67,6 +67,20 @@ struct keyctl_dh_params {
 };
 #endif
 
+/**
+ * KEYCTL_DH_PRIVATE - Access the private key in struct keyctl_dh_params.
+ * @params: Pointer to struct keyctl_dh_params.
+ *
+ * Uses 'private' if the UAPI headers provide it, 'priv' otherwise. UAPI
+ * headers older than 4.20 provide only 'private'. Bionic renames 'private'
+ * (a C++ keyword) to '__linux_private', so only 'priv' is usable there.
+ */
+#ifdef HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIVATE
+# define KEYCTL_DH_PRIVATE(params) ((params)->private)
+#else
+# define KEYCTL_DH_PRIVATE(params) ((params)->priv)
+#endif
+
 #ifndef HAVE_STRUCT_KEYCTL_KDF_PARAMS
 struct keyctl_kdf_params {
 	char *hashname;
diff --git a/testcases/kernel/syscalls/keyctl/keyctl25.c b/testcases/kernel/syscalls/keyctl/keyctl25.c
index 84e76c019..80a341cf3 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl25.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl25.c
@@ -22,8 +22,9 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	dh_params->private = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
-				       KEY_SPEC_PROCESS_KEYRING);
+	KEYCTL_DH_PRIVATE(dh_params) =
+		SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				  KEY_SPEC_PROCESS_KEYRING);
 	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
 					KEY_SPEC_PROCESS_KEYRING);
 	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
diff --git a/testcases/kernel/syscalls/keyctl/keyctl26.c b/testcases/kernel/syscalls/keyctl/keyctl26.c
index 9488e736f..3d693e0ec 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl26.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl26.c
@@ -21,8 +21,9 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	dh_params->private = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
-				       KEY_SPEC_PROCESS_KEYRING);
+	KEYCTL_DH_PRIVATE(dh_params) =
+		SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				  KEY_SPEC_PROCESS_KEYRING);
 	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
 					KEY_SPEC_PROCESS_KEYRING);
 	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
diff --git a/testcases/kernel/syscalls/keyctl/keyctl27.c b/testcases/kernel/syscalls/keyctl/keyctl27.c
index e69b52064..1ba338dcb 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl27.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl27.c
@@ -27,8 +27,9 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	dh_params->private = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
-				       KEY_SPEC_PROCESS_KEYRING);
+	KEYCTL_DH_PRIVATE(dh_params) =
+		SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
+				  KEY_SPEC_PROCESS_KEYRING);
 	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
 					KEY_SPEC_PROCESS_KEYRING);
 	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
diff --git a/testcases/kernel/syscalls/keyctl/keyctl28.c b/testcases/kernel/syscalls/keyctl/keyctl28.c
index 15ca3b8fe..4e7710d25 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl28.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl28.c
@@ -78,7 +78,7 @@ static void setup(void)
 	key_base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
 				KEY_SPEC_PROCESS_KEYRING);
 
-	dh_params->private = key_priv;
+	KEYCTL_DH_PRIVATE(dh_params) = key_priv;
 	dh_params->prime = key_prime;
 	dh_params->base = key_base;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
