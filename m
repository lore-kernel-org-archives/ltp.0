Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D3DC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736937523; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=3/uVt27/T7AiM2PjnEQXgVg5MhE0wM9c9zPUDkMmTnc=;
 b=MClYBl2kxkws8KFWtVhLajUf4t9t1ke7MqSXiE15eepYA9oMF4VD5FsCZGQdk8MnIKhYL
 vXeAfTdeakbMCBDPdlD0uzTRyqGAKRo6GCeKzXAqB/qB/EGZL9M1+0x5hA1ONudUiyq8GT0
 27Xgmhe3HnKG5wy+JCRy50Wv+KTs6dg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 475243C7B63
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:38:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 656AE3C7B48
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:38:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99BC5234175
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736937500; x=1768473500;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZxIDukeFhQY685y2VeAvZatuSF8ETj1rJy7vojsLAV4=;
 b=oHWwDL+7NDWkU8Ogj7W0V/fMZwaMLJRzZAv7abLFsT0a+ZiX/399sl7t
 uM9cN47vrvZp6dzIn6kVYg31S+cwRPE+Iv5uDhGJgYUsLI4PXsdkKCZjb
 4bJwCsGikczPDFqiCjA6Z8/87rFzVJOwhyeBJm8PABGbuazOz/M39cZre
 J7lqJ4eVrG6s6RC7VomY4zUeo+BhT67b5u6A7klT7ctbfy3mnLGGcSgj9
 OYf90HMy7+Dqt3yTT5G/fAadP8t65kLEkTT8Tb07tMz/j0G28fVFbPyS4
 dr7eIBr/YkS+cVlzicEmyA312iaJcWsrD8F2uJ5uQUI1PT6C8O1nDIZ9o A==;
X-CSE-ConnectionGUID: NTTs5I7oTYCvYtZ9jO+TFA==
X-CSE-MsgGUID: 26300JilTAyTd9BtPGGmOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="174619142"
X-IronPort-AV: E=Sophos;i="6.12,317,1728918000"; d="scan'208";a="174619142"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 19:38:18 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0183AD6EA5
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 19:38:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C16DDD3F2E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 19:38:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4959A6BEFE
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 19:38:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 947F21A000B;
 Wed, 15 Jan 2025 18:38:14 +0800 (CST)
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 15 Jan 2025 18:38:13 +0800
Message-ID: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.007
X-TMASE-Result: 10-0.030200-10.000000
X-TMASE-MatchedRID: aulLGGssQIPyq/cli2hvDbnHu4BcYSmtwTlc9CcHMZeRlBdzYSbt4hDO
 9b78NniRqrPmcwxLbKVqzED31CYLQJ5l5tqvE/eV6T0GzY0FZMefjJ25h/keVZsoi2XrUn/Jn6K
 dMrRsL14qtq5d3cxkNQwWxr7XDKH8PBKKdqcBoGfCoQn08En4B9o9qwQhdOhUyArxylrE1F4llo
 5c+AK6ClPkRWMxgiAVvjwkj2SPxnCro73lPUO//jp2LVoWTflzFcG3+ZRETICP9kUX1Z+buE3Lu
 mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] posix_fadvise: Convert docs to docparse
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fadvise/posix_fadvise01.c  | 17 +++--------------
 .../kernel/syscalls/fadvise/posix_fadvise02.c  | 17 +++--------------
 .../kernel/syscalls/fadvise/posix_fadvise03.c  | 18 ++++--------------
 .../kernel/syscalls/fadvise/posix_fadvise04.c  | 17 +++--------------
 4 files changed, 13 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 71e6454d8..650459455 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -3,21 +3,10 @@
  * Copyright (c) Red Hat Inc., 2007
  */
 
-/*
- * NAME
- *	posix_fadvise01.c
- *
- * DESCRIPTION
- *	Check the value that posix_fadvise returns for wrong ADVISE value.
- *
- * USAGE
- *	posix_fadvise01
- *
- * HISTORY
- *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Verify that posix_fadvise() returns 0 for permissible ADVISE value.
  */
 
 #include <fcntl.h>
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
index 303f776e4..39a1f1b57 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -3,21 +3,10 @@
  * Copyright (c) Red Hat Inc., 2007
  */
 
-/*
- * NAME
- *	posix_fadvise02.c
- *
- * DESCRIPTION
- *	Check the value that posix_fadvise returns for wrong file descriptor.
- *
- * USAGE
- *	posix_fadvise02
- *
- * HISTORY
- *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Verify that posix_fadvise() returns EBADF for wrong file descriptor.
  */
 
 #include <fcntl.h>
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 98d8d2930..9bfd42439 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -3,21 +3,11 @@
  * Copyright (c) Red Hat Inc., 2007
  */
 
-/*
- * NAME
- *	posix_fadvise03.c
- *
- * DESCRIPTION
- *	Check the value that posix_fadvise returns for wrong ADVISE value.
- *
- * USAGE
- *	posix_fadvise03
- *
- * HISTORY
- *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Verify that posix_fadvise() returns EINVAL for the ADVISE value not
+ * permissible on the architecture.
  */
 
 #include <fcntl.h>
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index 8baf91bb0..2fe7e3577 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -3,21 +3,10 @@
  * Copyright (c) Red Hat Inc., 2007
  */
 
-/*
- * NAME
- *	posix_fadvise04.c
- *
- * DESCRIPTION
- *	Check the value that posix_fadvise returns for pipe descriptor.
- *
- * USAGE
- *	posix_fadvise04
- *
- * HISTORY
- *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Verify that posix_fadvise() returns ESPIPE for pipe descriptor.
  */
 
 #include <fcntl.h>
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
