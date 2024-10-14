Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0597CF258E
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728867249; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xjqVNOLP+IQhzW8WrxQZMoE/Bfr2EASKT1p/tAu9trc=;
 b=aqXWyi44cAPt3tzYDWBG970ANIr7OBcTW7bpVaTHnlaENFCa3qNtUBWl1uTiKCOCuGBQ3
 p/rO0tlBkJIDq8eFYtwa/YN5HuC4/vQW9Y5Piehh96vzW+8KZqSSjdZEYi/FzyQg3iHtbCC
 F+JPa0Hs0hCrZh47Js2ClA2uCmtIWO0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AD913C6589
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 02:54:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B17C3C06F0
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 02:53:49 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D898140004B
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 02:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1728867228; x=1760403228;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+pEHBIllo2aJNaPnC/gRejz252+jMds2OnLq7MI49vE=;
 b=EU9I5RMuemb4OHzNbGwtcymshyYZyye7uZw8xrN9EdasTEV+Etk4QejP
 GedI3tzcbw8c8tRkQwj6DSag/8yCi+aWYr8AckM8JpZO9krJFhM+os4e+
 hkOi+51tFSwn4XZ0so/aiORNDmjmgFHujN2AmpR0KnueNl6+StHOoty6p
 cLYSvppLtgl3ISpkuULCcqyupI3eZ/oc+fw/eRl+zsDtR9+/3q/lFExpK
 BUmhyMo/t+Y6SMBukPekAbVqBBeC6aQ8303tecDmZJt83UqhaGtg9yS2F
 SOqQhqceQ157lmM9b4ZiGtwKuCH5/9Yv+KdYsSbGJJx0ckldemgdXs4ut A==;
X-CSE-ConnectionGUID: CpoaTdJORZaA8BIWgaT3VQ==
X-CSE-MsgGUID: c6E3t9FRT8KzBT6ogx1c6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="155556394"
X-IronPort-AV: E=Sophos;i="6.11,201,1725289200"; d="scan'208";a="155556394"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2024 09:53:45 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 71F79D800A
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 09:53:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A65C0D7731
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 09:53:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D0D6200649E2
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 09:53:42 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8D5F21A000B;
 Mon, 14 Oct 2024 08:53:41 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 14 Oct 2024 08:53:38 +0800
Message-ID: <20241014005339.460608-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28730.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28730.003
X-TMASE-Result: 10--4.123600-10.000000
X-TMASE-MatchedRID: 8m8ElNxIV52oUIsWPZ70ORIRh9wkXSlFwTlc9CcHMZerwqxtE531VL6p
 xbTOjavy43erU5Oy0Te/pnG/GWI+xNbNQByfRPHgSs47mbT7SAT1DkSwbTVb3psoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpnH7sbImOEBQANcMCMUtf//Ntoga2L6mHs+XhuUI9BvPxYh
 0KVzwfZzzO5FGptYuXvb7lWPf7/xtEuUY/V+ri5IxTLOjIJxebPHa38tWKdCqbDRBqS2n66yzP5
 xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] configure.ac: Fix temperory directory ./confXXXXXX
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
  -> create temperory directory ./confXXXXXX
  -> cd include/lapi/syscalls
  -> ./regen.sh
  -> cleanup ./confXXXXXX, registered in trap

Where config.status changes the working directory, ./confXXXXXX is not
removed as a result.

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
