Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156DFC47DB3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:08:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A7643CF91C
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:08:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E353CE0C3
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5AA060B2EA
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B83A421E5E;
 Wed, 31 Jan 2024 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iwo9wkZbJqbXz5sljPm4VUQ8bxO9D8TriflbP8/ymto=;
 b=VvAWRzeGjrN0E3T5LgD1oR5tq7pN33il3FfNfFWnJ4SuOcvJQCuE0NktgYp+YEmog0fahu
 Aq/Z8UeQcazXZmpHK6rmjOMh73WG6VjzuQaZ265XB8BkrRnULigPYmW/muKZsNHPdrXiJE
 u9L5HnBVEbmi+hsdbZXqyvZjlyploFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iwo9wkZbJqbXz5sljPm4VUQ8bxO9D8TriflbP8/ymto=;
 b=vfqgKNxPfnzkRQ5wZTkKL2HQyWWciBhvFhTTNiaXkXZasaDSAULIsxmoEm4K7unw5L+PAx
 jAg6Wq55Y3IUDKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iwo9wkZbJqbXz5sljPm4VUQ8bxO9D8TriflbP8/ymto=;
 b=VvAWRzeGjrN0E3T5LgD1oR5tq7pN33il3FfNfFWnJ4SuOcvJQCuE0NktgYp+YEmog0fahu
 Aq/Z8UeQcazXZmpHK6rmjOMh73WG6VjzuQaZ265XB8BkrRnULigPYmW/muKZsNHPdrXiJE
 u9L5HnBVEbmi+hsdbZXqyvZjlyploFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iwo9wkZbJqbXz5sljPm4VUQ8bxO9D8TriflbP8/ymto=;
 b=vfqgKNxPfnzkRQ5wZTkKL2HQyWWciBhvFhTTNiaXkXZasaDSAULIsxmoEm4K7unw5L+PAx
 jAg6Wq55Y3IUDKDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 92589139FB;
 Wed, 31 Jan 2024 18:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 8L12IUaMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:55 +0100
Message-ID: <20240131180659.23587-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131180659.23587-1-pvorel@suse.cz>
References: <20240131180659.23587-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] hugemmap: Move MNTPOINT definition to header
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also, change it from "hugetlbfs/" to the usual "mntpoint".

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c | 1 -
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c | 1 -
 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c           | 1 -
 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c           | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c           | 1 -
 testcases/kernel/mem/hugetlb/lib/hugetlb.h                   | 2 ++
 30 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index e4bb21e40..e083ca542 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -23,7 +23,6 @@
 #include "hugetlb.h"
 #include "lapi/fallocate.h"
 
-#define MNTPOINT "hugetlbfs/"
 
 static int  fd = -1;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index 4a25666ac..0c8262360 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -22,7 +22,6 @@
 #include "lapi/fallocate.h"
 
 #define MAX_PAGES_TO_USE 5
-#define MNTPOINT "hugetlbfs/"
 
 static int  fd = -1;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 90cefdba2..7d11daa1d 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -26,7 +26,6 @@
 #define C1		0x1234ABCD
 #define C2		~0x1234ABCD
 #define C3		0xfeef5678
-#define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
 static long hpage_size;
 
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
index de495f087..48524a7ce 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -19,7 +19,6 @@ static int shmid = -1;
 
 #define NR_HUGEPAGES 5
 #define NUMPROCS MIN(50L, tst_ncpus_available())
-#define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 846d22ff2..2276c5f39 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -23,7 +23,6 @@
 #include "hugetlb.h"
 #include "tst_safe_stdio.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int huge_fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index f01a9f365..6617f6289 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -30,7 +30,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 #define WITH_OVERCOMMIT 0
 #define WITHOUT_OVERCOMMIT 1
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 336ccdf65..18c37d07c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -22,7 +22,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int huge_fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 0e1b64541..4370c3a6f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -24,7 +24,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
 static int private_resv;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 496a814b5..3c3bdc5be 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -24,7 +24,6 @@
 #define P0 "ffffffff"
 #define IOSZ 4096
 #define NORMAL_PATH ""
-#define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
 static int fd = -1, nfd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 81367c513..63ed3d51b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -24,7 +24,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int  fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 42b80064e..91ba83130 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -26,7 +26,6 @@
 #include "hugetlb.h"
 
 #define FOURGB (1ULL << 32)
-#define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
 static unsigned long hpage_size;
 static int page_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index c54a746b3..21d645e88 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -25,7 +25,6 @@
 #include "hugetlb.h"
 
 #define FOURGB (1ULL << 32)
-#define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
 static unsigned long long hpage_size;
 static int page_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 4d1984070..5e548747c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -39,7 +39,6 @@
 
 /* Seems to be enough to trigger reliably */
 #define NUM_REPETITIONS	64
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int  fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index 2003e7013..15254e5a8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -24,7 +24,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
 static long hpage_size;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
index b8105bbf3..7dfa631b7 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -31,7 +31,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 #define MAP_LENGTH	(4UL * hpage_size)
 #if defined(__s390__) && __WORDSIZE == 32
 #define TRUNCATE_POINT 0x20000000UL
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index 607072937..5f96f00cf 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -30,7 +30,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int  fd = -1;
 static long page_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
index 11060125b..667703b85 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -30,7 +30,6 @@
 #include "hugetlb.h"
 
 #define RANDOM_CONSTANT	0x1234ABCD
-#define MNTPOINT "hugetlbfs/"
 static int page_size;
 static long hpage_size;
 static int  fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index e6b6bda76..ef41e71f6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -13,7 +13,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 #define FLAGS_DESC(x) .flags = x, .flags_str = #x
 
 static int fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index 7abfda92d..77f82343d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -17,7 +17,6 @@
 
 #define THREADS 5
 #define NR_HUGEPAGES 6
-#define MNTPOINT "hugetlbfs/"
 
 static int fd = -1;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index c2deab477..38ff34a1c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -17,7 +17,6 @@
 #include "hugetlb.h"
 
 #define NR_HUGEPAGES 2
-#define MNTPOINT "hugetlbfs/"
 
 static unsigned long hpage_size;
 static int fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index d755161c9..a9f2f1932 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -16,7 +16,6 @@
 #include <setjmp.h>
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 #define RANDOM_CONSTANT 0x1234ABCD
 #define FLAGS_DESC(x) x, #x
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 431dc1bbf..0c44eb486 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -19,7 +19,6 @@
 #include "hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
-#define MNTPOINT "hugetlbfs/"
 
 static int  fd = -1;
 static unsigned long slice_boundary;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 71beb90d3..4e4b76690 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -18,7 +18,6 @@
 #define _GNU_SOURCE
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 
 static int fd = -1;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index 609f2b63b..9788257ec 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -18,7 +18,6 @@
 #define _GNU_SOURCE
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 
 static int fd = -1;
 static long hpage_size, page_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index 218d9e190..6a2a4ba97 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -16,7 +16,6 @@
 #include <setjmp.h>
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int fd1 = -1, fd2 = -1;
 static sigjmp_buf sig_escape;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 060d1c858..682d58e52 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -14,7 +14,6 @@
 
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index 6bff2c8e6..1a047fcef 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -19,7 +19,6 @@
 #define C1 0x1234ABCD
 #define C2 0xFEDC9876
 
-#define MNTPOINT "hugetlbfs/"
 static unsigned long hpage_size;
 static int fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index 7ed9046f3..94ab9db7b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -18,7 +18,6 @@
 #define _GNU_SOURCE
 #include "hugetlb.h"
 
-#define MNTPOINT "hugetlbfs/"
 static long hpage_size;
 static int fd = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 9072e9de4..c12187413 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -15,7 +15,6 @@
 #include "hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
-#define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
 static int fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 34fe08c24..0f5707621 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -20,6 +20,8 @@
 #include "old_tmpdir.h"
 #include "mem.h"
 
+#define MNTPOINT "mntpoint"
+
 #define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
 
 #define SHM_RD	0400
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
