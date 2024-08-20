Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C610AC3DA4A
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724147531; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fW6/nXRv62pkaFDh102HTGB65qzVOlbFIaOnM0zm3IA=;
 b=P1gCWnQkUEzEbeNJXzEVq0/iWV0dyeeL4mUI0KFJpq331l34/sS/Tl3uMETfAIBpRRPQ6
 gf7VXKRCkUZac1QuRGYyVMN+a1ySCpWWmpCRFqC5yWS10yj+fT35XzOTb2S2+VFU8v1ebbM
 nnv0qzSs/leNhfUjhE9TwEEx58Pni6I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4319F3CAF82
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 11:52:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B99EB3CAE74
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 11:51:50 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67A48140119E
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 11:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724147510; x=1755683510;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=i2VvTp50wgO9wgwh7rlAuTP2XCZpbzH/VDLZS3x+sRw=;
 b=FOwbnCHpkCHsaViKHmRaxJO9EG/jJdztCV/GQ5vHamHy4lEahqyTAXfI
 V2yk1Im69O4GgOVndtTRpqhE8zIM87rwldeBoMYNDfuc4QD2WeToLn1lg
 oDMgJ8NZOrttGgzc8Du593tLaPrRBX63VTIOA9lBeJYTHeSNcS9QoBptk
 wZrpxaLHsDwdrTOCU7NMV7F6kqSwOpkj7cpcF4BssQpUEOAuOCj7R5QrO
 vGkhy72LwblPomTiAucoCqPuuPJdDoNfPJ+/EmKSp+/drSZN99h4RXJwU
 2JjgqMj6/A/Vis5Eq/UpfEyu5v3pwRXqjJuac1I24azFgVo/87uCoeQeO w==;
X-CSE-ConnectionGUID: o/+cBx/NSju4v56o02Zq/Q==
X-CSE-MsgGUID: ZZeF0jwGRNuoJiWIYWkCkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="171080570"
X-IronPort-AV: E=Sophos;i="6.10,161,1719846000"; d="scan'208";a="171080570"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 18:51:48 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5B4FD6473
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:51:45 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 020A4BF496
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:51:45 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 86B682007FAD7
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 18:51:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 080B81A0002;
 Tue, 20 Aug 2024 17:51:44 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Aug 2024 17:53:28 +0800
Message-ID: <20240820095328.2746374-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28606.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28606.006
X-TMASE-Result: 10--13.081700-10.000000
X-TMASE-MatchedRID: n4ZlyiRA5T2HYSb76u64f7nHu4BcYSmtwTlc9CcHMZerwqxtE531VIPc
 XuILVCba6ty84tJHXtDUT3Vz86hSOuxHzg5Fmt6yVyAKAMvj1po1gRGJ6Up9hS196sn93sBv1Ie
 ckOrbKEx1y1FDNWuiN3xgS8RxkgXCKXGXWv7oGoh2o0eWLPgBZ5v7eN3eThF+F0dfZ5kV9l/hpJ
 sYQnO7i8NEi3Fp+1Wq9X995Z/EitmzKi4V7faB154CIKY/Hg3AaZGo0EeYG97fwtq4jZ/G3iq2r
 l3dzGQ1CxuRVv6FB9nT2ITdA7KJwKRZSgjHYxrch+TvqdrMXSwqrWJid74SWg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Test API: Fix typos
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed spelling mistakes:
inbetween --> between
Similarily --> Similarly

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 doc/old/C-Test-API.asciidoc     | 7 +++----
 doc/old/Shell-Test-API.asciidoc | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 08a76c403..493f4c3f6 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -2019,9 +2019,8 @@ static struct tst_test test = {
 --------------------------------------------------------------------------------
 
 Above is a minimal template for a test using fuzzy-sync. In a simple case, you
-just need to put the bits you want to race inbetween 'start_race' and
-'end_race'. Meanwhile, any setup you need to do per-iteration goes outside the
-windows.
+just need to put the bits you want to race between 'start_race' and 'end_race'.
+Meanwhile, any setup you need to do per-iteration goes outside the windows.
 
 Fuzzy sync synchronises 'run_a' and 'run_b', which act as barriers, so that
 neither thread can progress until the other has caught up with it. There is
@@ -2339,7 +2338,7 @@ Some tests require at least size(MB) of free RAM or Swap.
 To make sure that test will run only on systems with more than minimal
 required amount of RAM set `.min_mem_avail = N`.
 
-Similarily for tests that require certain amount of free Swap use
+Similarly for tests that require certain amount of free Swap use
 `.min_swap_avail = N`.
 
 1.40 Test tags
diff --git a/doc/old/Shell-Test-API.asciidoc b/doc/old/Shell-Test-API.asciidoc
index 4cf630dab..c38fb0698 100644
--- a/doc/old/Shell-Test-API.asciidoc
+++ b/doc/old/Shell-Test-API.asciidoc
@@ -188,7 +188,7 @@ space as default value is used. Of course, it's possible to use separate functio
 1.2 Library environment variables and functions for shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Similarily to the C library various checks and preparations can be requested
+Similarly to the C library various checks and preparations can be requested
 simply by setting right '$TST_FOO'.
 
 [options="header"]
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
