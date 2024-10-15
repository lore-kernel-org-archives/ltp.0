Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE8D1815E
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 01:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728954986; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1EEhyseT2sIIjSwzNs+/qvcD/+5Od/e5a0R6+G/M+G8=;
 b=k0qpmpX0XfZcb3PPgEEA8rhjasN3BSt53y5le+KTb/JhznKveESD3GhajUPwvBCRgbW8Q
 kv4JZvIUWLByVxXiX2iyBN/M74gV5R8ONjYfVrzk3o3ZgHGJCUSg/VYDmk3DCmjFelse9mB
 A4PnNjH8NJcZyOqpdIYCUn5Z0F4KYmM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A7B43C6681
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 03:16:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5C183C015A
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 03:16:05 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBD53616D53
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 03:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1728954965; x=1760490965;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4mWS4juQqRKPkkmoh4ttFXzrOKBzr/wwIA/Rn9e9pFI=;
 b=jwcllqz4w+yZ0kypkQJmSGe+XHq+OB2gjhy77PB6hNazajF+CTFow96u
 WP6bl0VSxfuyJBDSDk46sV8WL/g/xChPsz8+61o4Wvz2D06CY5K+SYTIb
 oJSg5BQP1s+UFKb1sgxysdr2Z2d1IZNdq2bktInSEwdbUQCHvsRRO9EcW
 67AasfKJ8BFNuxAZttKl6WdM0rNAmpOswvH1NcRHKYg+Ys9Qh73Ngxfe/
 SINtE7BF2+Ib1+qmdQY9gaerG3IWwqFlnQljuIjU9pYPPkP1VaFPRhWxV
 fojEBgTI7qviBFro2x20D4nuP4VbdwJ2RUt6dFoiMJWLVzb+S4tIlYDoF A==;
X-CSE-ConnectionGUID: UrJq4NPeQGWDDCM7eBvnpg==
X-CSE-MsgGUID: 4WBuelWFS4OQkpNzqQiJSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="176726420"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; d="scan'208";a="176726420"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2024 10:16:01 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2527BC68E5
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:15:58 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C6E5D5108
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:15:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D7E806B837
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:15:56 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3ADE51A000B;
 Tue, 15 Oct 2024 09:15:56 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 15 Oct 2024 09:15:52 +0800
Message-ID: <20241015011552.1407905-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28732.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28732.003
X-TMASE-Result: 10--1.623600-10.000000
X-TMASE-MatchedRID: 8m8ElNxIV52oUIsWPZ70ORIRh9wkXSlFG24YVeuZGmPAuQ0xDMaXkH4q
 tYI9sRE/4CtjYmQpb2kMPXsPeYwLgQTfGrZCsENRGYJhRh6ssesfimmlcABuN95r6osAM+COo8W
 MkQWv6iV3LAytsQR4e1cppCzPq+1UxlblqLlYqXKFOr+sAYZQ0ro71F3+sAmaiNeUB0vsG07jxD
 f9Qd/hvUes5PfXdGeavLJPoRWN1tM5f7p5bs2293RuExviwvu/8ORb5j/HbacRZbRsQk5MBUB1Q
 Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] configure.ac: Fix temporary directory ./confXXXXXX
 not cleanup
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
From: Li Zhijian via ltp <ltp@lists.linux.it>
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

configure
 ->config.status
  -> create temporary directory ./confXXXXXX
  -> cd include/lapi/syscalls
  -> ./regen.sh
  -> cleanup ./confXXXXXX, registered in trap

Where config.status changes the working directory, ./confXXXXXX is not
removed as a result.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: a07008fbec ("configure.ac: Generate linux_syscall_headers.h")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b4ab81e265..d327974efa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -386,7 +386,7 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
-AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
+AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh; cd - >/dev/null])
 
 # custom functions
 # NOTE: don't create custom functions for simple checks, put them into this file
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
