Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D00C61DD6
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788302742; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=MnCAFMqrYnE/H7mkXCSOBYED/BoL5YCFPK5oSAY4C0Y=;
 b=gjyN8vC2DUb0QkBEkcoSXEOogK5SE2jZxnrI4R8evljmau/fmfknNloSyLmQCOSj8QYUy
 FTZPDRbzE7v1o27rigGWfstCwrs5/+mLjsJHj5nHfNXe8LmFBMIcr1P9oPQHeMgGoHVqQzQ
 oGnn2IXqbs4FFFzdzxtGrSmZi3tMl8c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34EC3E997F
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 00:45:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6F23C568A
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 00:45:16 +0200 (CEST)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com
 [IPv6:2607:f8b0:4864:20::1046])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F44A100036E
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 00:45:16 +0200 (CEST)
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so858335a91.0
 for <ltp@lists.linux.it>; Tue, 01 Sep 2026 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788302715; x=1788907515; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UJkmG4JyBLtjoSsdOvC9Ca0o3KW3Gqrf7ESwI9BLwjg=;
 b=ZetIvU2pQpXK1mIVqQKGMmQcQJf2/JMYfSzJ++zu0x9aLovoiSU98sY98sLasuFPFh
 EzdNbyu1JK3etx8qGKKmQDSai5uqImUQCSvfv6CWgxRKGxzDAY2+Qo2lMguntn/9pP8h
 k4SHVwpCxNhTy8nSbtIgma8T7fAix99tcCSQG3VyRoJC9M+nIY1JydisC9ai4WVhKZsY
 TS4hjWdL5FTJwXzGXAsmBNxDRbuQEkzX7pt/MJnGV+cw4NEgMvMOvutjWQrWBadVrfc4
 zTRXI7dN4GwfP9+gVBTVKlE8UUo6edznZhnyi1uftOsE3pbYR2+e7x3K+QVrJ+7yaCVx
 bsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788302715; x=1788907515;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UJkmG4JyBLtjoSsdOvC9Ca0o3KW3Gqrf7ESwI9BLwjg=;
 b=TdBm3a3Rk1cXSmQVv7MKNBnosOj9i2ix73qxW3Dpmq8kBnIl8CSZg/RRqEI+tebeu/
 esnFKT0ZdOQlmyro2iQTmIa9bcI/Vf+RVaE/Aa2SvEXO0vplx8suQlF1/rN9GubD5rwi
 3s27TnyHMe5S/3kh5cL/jZ/0Ph4t6lfENFHxxIep70xf6hlJBe/WU5+DN1WO8GEUdKqT
 TSPouFI1qIfMakELwJb3l+kGpf0FKBoNSKbSaHVup2ZLwukaPFSf2mHmv544NdDRLSo6
 RTcXy7c6u8rp8pRraD3vXiTcs+11/KcW+wlHHCEMlAyZ8wGxJd8LoaIT6tQTNi4ngla3
 XdIg==
X-Gm-Message-State: AFuF++ndO5EoZEg8VO+zWQ7dw2cnglreenhdGQR2NaCJFaYo5WIxaBN3
 MTXQMWH/fkWcB7MhbnQJX2ZesalM10NnMF8SbYHwe8CEbFJg/3d8zRxzkXpITU4x8gFgjrGP+Xk
 cx28YhHy4jZrpa6pQqXd/VetS+2z3UmoXGOzeal9b41mNFPnWXqHhLDMVj21ipMZXyNt06HT+0a
 Zj1L0cyhTMdnWsKoEv5S7UiI4GLw==
X-Received: from pjbsb15.prod.google.com ([2002:a17:90b:50cf:b0:383:c59b:fc00])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b04:b0:398:9be5:b416
 with SMTP id 98e67ed59e1d1-39aee1c5eadmr211572a91.17.1788302714246; Tue, 01
 Sep 2026 15:45:14 -0700 (PDT)
Date: Tue,  1 Sep 2026 22:45:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901224512.1180203-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/sched: Fix sched_getattr/setattr fallback
 definitions
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
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit c48700d8cdbe ("sched_attr: Do not define for glibc >= 2.41")
guarded the definitions of struct sched_attr, sched_setattr(), and
sched_getattr() under "#ifndef SCHED_ATTR_SIZE_VER0" to avoid conflicts
when glibc >= 2.41 provides these definitions.

However, SCHED_ATTR_SIZE_VER0 is a standard Linux kernel UAPI macro
defined in <linux/sched/types.h>. When headers include the kernel types
(such as on Android Bionic, musl, or older glibc with kernel headers),
SCHED_ATTR_SIZE_VER0 is defined even though libc does not provide the
sched_setattr() or sched_getattr() functions. This causes the fallback
syscall wrappers to be omitted, leading to unresolved symbol errors.

Add autotools checks for sched_getattr, sched_setattr, and
struct sched_attr. Guard the fallback functions with
HAVE_SCHED_GETATTR and HAVE_SCHED_SETATTR, and remove const from
sched_setattr's attr parameter to match the kernel and libc signatures.

Fixes: c48700d8cdbe ("sched_attr: Do not define for glibc >= 2.41")
Signed-off-by: Wake Liu <wakel@google.com>
---
 configure.ac         |  3 +++
 include/lapi/sched.h | 16 ++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 19fc5e1b8..8aa3ff539 100644
--- a/configure.ac
+++ b/configure.ac
@@ -155,7 +155,9 @@ AC_CHECK_FUNCS_ONCE([ \
     rand_r \
     recvmmsg \
     renameat2 \
+    sched_getattr \
     sched_getcpu \
+    sched_setattr \
     sendmmsg \
     sethostid \
     setns \
@@ -199,6 +201,7 @@ AC_CHECK_DECLS([TCA_PEDIT_PARMS_EX, TCA_PEDIT_KEYS_EX, TCA_PEDIT_KEY_EX,
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct clone_args],,,[#include <sched.h>])
+AC_CHECK_TYPES([struct sched_attr],,,[#include <sched.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
 		struct fanotify_event_info_header, struct fanotify_event_info_pidfd,
 		struct fanotify_event_info_range],,,[#include <sys/fanotify.h>])
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..d835537e7 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -14,8 +14,8 @@
 #include "config.h"
 #include "lapi/syscalls.h"
 
-/* sched_attr is not defined in glibc < 2.41 */
 #ifndef SCHED_ATTR_SIZE_VER0
+# ifndef HAVE_STRUCT_SCHED_ATTR
 struct sched_attr {
 	uint32_t size;
 
@@ -33,20 +33,24 @@ struct sched_attr {
 	uint64_t sched_deadline;
 	uint64_t sched_period;
 };
+# endif
+# define SCHED_ATTR_SIZE_VER0 48	/* sizeof first published struct */
+#endif
 
-static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
-                                unsigned int flags)
+#ifndef HAVE_SCHED_SETATTR
+static inline int sched_setattr(pid_t pid, struct sched_attr *attr,
+				unsigned int flags)
 {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
+#endif
 
+#ifndef HAVE_SCHED_GETATTR
 static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
-                                unsigned int size, unsigned int flags)
+				unsigned int size, unsigned int flags)
 {
 	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
-
-# define SCHED_ATTR_SIZE_VER0 48	/* sizeof first published struct */
 #endif
 
 struct clone_args_minimal {
-- 
2.55.0.966.g6673acef38-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
