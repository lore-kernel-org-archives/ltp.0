Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1BAC3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 06:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721887733; h=to : date :
 message-id : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=YIhKu4t4DX7c6/l0GvAWa0vRO3POVX0aq7G+/yW6zTs=;
 b=mJ3zbZojwuW78UZgma8Nm6afju4asbn+1jyvpj5CQ/oJhK9oZvad1AywXP4nW81Iv148q
 uLAfKviAVa2YIe1X43ROBFNSTABIgOqxmPf2ndcVw7rBOPzPqCwmTd2N421r7XsCsexoecI
 5L6qFUlJ6/FGNxjxs7PV2Q2oIyaBOzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126A63D1C75
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 08:08:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A24E3D1A55
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 08:08:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 452E41BC1C14
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 08:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721887711; x=1753423711;
 h=from:to:cc:subject:date:message-id;
 bh=qRo9Cl13pMa5rRaPrSCb6AMzSa7mPNOaKkvwn360C3o=;
 b=CA7T3vhbkzj6m1JzwlNrvqliCOoA5PjrSUT+TsF+zuJQlm8Gf0JF8iX4
 BtTjegbH4IiB7vjGTLGXEbMjJOqb2Y+bMNS3RChQGFfjQzy+zcZ69j/+N
 FqYPwv4XZI/Vyzq2Or3MP5+xYvzLsA2nQUJEG3KSuLTnF/A06tw4+VXUM
 HgFA5PWYvNidBvIRSyzjAEplPYKnZWeYXolKAtb969PfLBmsIlz6e8bdq
 XIdyJ/0T+rFHnHdekegYIsXJlIgNDJWbPU32hlnT6EkIkUusjtfaNhe42
 M/epw5y24mHr88UK5mpVTOdTj1GLywH3uX0TN7YTS1M9snxy1c6TDPK7K w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="168520343"
X-IronPort-AV: E=Sophos;i="6.09,235,1716217200"; d="scan'208";a="168520343"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 15:08:28 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 17FBECA1EA
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 15:08:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 66E61BDC83
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 15:08:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EF964200897CE
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 15:08:24 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8CBE31A000A;
 Thu, 25 Jul 2024 14:08:24 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 25 Jul 2024 14:08:05 +0800
Message-Id: <20240725060805.4243-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28550.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28550.005
X-TMASE-Result: 10--2.550400-10.000000
X-TMASE-MatchedRID: wjdoQEOKyrblWiNI/3lAD07nLUqYrlslFIuBIWrdOePfUZT83lbkEFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9spH0YXYnbGozFEUknJ/kEl5MvUK9rYp8a9PokMAKQp/bFdA
 //ep4QUPdB/CxWTRRu+rAZ8KTspSzKnARoetBPM6MD+fJgJjRESZTG6nwfmOuadSz7kPT9sPYKT
 aubBR6dXCNPQeSHA1XaJ3s319O3l9vODLobppWF4oVBsaob5fmiB6mlDKe1V7S/yytHeCN9GXv4
 CQeNUk7G6qTOwq/n71+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscall: Convert docs to docparse
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/syscall/syscall01.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 76e793221..26398a3af 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -3,9 +3,13 @@
  * Copyright (c) International Business Machines Corp., 2002
  * 01/02/2003	Port to LTP avenkat@us.ibm.com
  * 06/30/2001	Port to Linux nsharoff@us.ibm.com
+ * Copyright (c) Linux Test Project, 2002-2024
+ *
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Basic test for syscall().
  */
 
-- 
2.18.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
