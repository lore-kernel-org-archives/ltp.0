Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85028C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737017220; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lkSkkrpqpOMufga7t5tBINg86wZz24obyvkqpsq0x/E=;
 b=R5bogSGPf8eq1grK/PxFL5fYluhV5DoVTJvlzmpDTqjIrLxRNe5znr4EOcvua8vrZPJRV
 6Y410ewCC8vJd3RFJRIGWeXJcFYfhaRSJ2ZzF/8tocXdHWlxwZR2IcEaT495BcXeDhWONAK
 xYPdW7zZvO6qC9XuhmbA0NLYZxU3NIg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 151CA3C7BB8
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:47:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C493C7B8C
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:46:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE1E661FEAE
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737017199; x=1768553199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=95ZLOi9KZxQ4VkkltW+C9GyUQWO15UA3gBVXgnTwp2Y=;
 b=nYrSqimK+y0F8IrMppqlbZFXEYv3EfP9QyN3LkDPZEZ73Ct81u0I34Sq
 VHtzo+fik+FXhB2HW8HN83zIU7YGzuw0PvG0LeS4AJSVi1bJ8HcM4ZNE8
 7EGtxVzxkxqIxozPoiKwztbG76R1wpX8XjLpId7QKlIV0963PCmzXa1SB
 dCYqZmerdLbfnn2ET9Bu2jj5CjhEU6gOxN7pr4i2GMTcUMSRjuF/RwC52
 KoZur47RjAVRD7AeksJnbBDkMuIzvXERfYSqyS9VlfAu4QsU3EQCD3qE1
 D4GE3ORuePP4XyJfjth5e/WKt8DvSdfmiOvd5coQpBIQhfehzg3D9vokx g==;
X-CSE-ConnectionGUID: 3YovMtwPSW+C0zSQTWzxBQ==
X-CSE-MsgGUID: QhxdoKBjTNCFvEBag+1Low==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="174096761"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; d="scan'208";a="174096761"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 17:46:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2791FD4C88
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:46:35 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id F3737D4BCC
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:46:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 801126B9AC
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:46:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 01C7D1A0073;
 Thu, 16 Jan 2025 16:46:33 +0800 (CST)
To: ltp@lists.linux.it,
	rbm@suse.com,
	pvorel@suse.cz
Date: Thu, 16 Jan 2025 16:46:33 +0800
Message-ID: <20250116084633.511484-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
References: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.006
X-TMASE-Result: 10-0.017000-10.000000
X-TMASE-MatchedRID: mJkk328f4R7yq/cli2hvDbnHu4BcYSmtwTlc9CcHMZe0sAt86s8nFOCG
 89wh97wnu+jFdzsOret3+NW7wWSu+QD+B72U7cPsfOaYwP8dcX5HA3z4TI9B3mcFIeJg29r7o8W
 MkQWv6iUoTQl7wNH8PgP5zT0d393c4kYXbobxJbJtwx+p5fx659lxNCazOLO8PIpzkBd/WpUS5T
 hvo071HHpmV92gn3TzxPoZi9SM329W2W1zTm0dQFlpnyNp6JR4Mx4tRY094G8bAVxwfpwYKZsNE
 GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] posix_fadvise: Convert docs to docparse
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
 .../kernel/syscalls/fadvise/posix_fadvise01.c | 18 ++++--------------
 .../kernel/syscalls/fadvise/posix_fadvise02.c | 18 ++++--------------
 .../kernel/syscalls/fadvise/posix_fadvise03.c | 19 +++++--------------
 .../kernel/syscalls/fadvise/posix_fadvise04.c | 18 ++++--------------
 4 files changed, 17 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 71e6454d8..2c6d57941 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -1,23 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Red Hat Inc., 2007
+ * Author: Masatake YAMATO <yamato@redhat.com>
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
index 303f776e4..bbfbd102e 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -1,23 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Red Hat Inc., 2007
+ * Author: Masatake YAMATO <yamato@redhat.com>
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
index 98d8d2930..7bf500a2b 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -1,23 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Red Hat Inc., 2007
+ * Author: Masatake YAMATO <yamato@redhat.com>
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
index 8baf91bb0..beece6410 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -1,23 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Red Hat Inc., 2007
+ * Author: Masatake YAMATO <yamato@redhat.com>
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
