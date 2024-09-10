Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4054ECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725961616; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=uxw0QCsk6kXu8ONT8sUv3Uj29piwyabbG7o66kSPlVc=;
 b=UjK+uvJr+/eHUUduLC7+bKj8Mm7UklyNr66o56C8xPtLkszzx8B3i5acV36jlUd9S0GFp
 q46slSYyNNK4mtYRZpxJ9FUw1d4bvtFAvBaUh/OR4oQoYk7gM+N/IW4Sk5KoWy+SQ6maRYl
 EDbLxXzYCb6h82FkDbz+h1S8i0M/fNc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D5753C1AB7
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 11:46:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A19303C00BE
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:46:35 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1419E1A00897
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 11:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1725961596; x=1757497596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s8WxqHsYyEHAJkp3yONXF7PRN6K/j1zNkM1hACBy0xc=;
 b=FvQ6YPv6FqrUY7vAHpmRMdRc8qCFUv7s9BnCtKQwBzQRxFpn03hg/wcf
 C+Q0GLia1y+K4Sg+robYraeF0b8oneSlQonOSu9RNUZtnteK8FtbxdLs1
 JvzTQ8g9mt0KygN5avgt0PLWYH/6p4YZiczI2Rv86XPLfOl/piBBr1m7p
 L6uFLTyV1uhRCmJVJH29Phz5GmFA0rtkV91/py08WF+wVT4I6ImbjoZMo
 cUd6SdPJgnhDzjHgmgfbctoue+dtXbqpC/jsLYGupldCNSeq1xZlrSi/I
 VCSELHBNNDwc5VGetXq5Afl+FfhDdd4EOk17dG2kmcOD5lLLxKegv2ihe Q==;
X-CSE-ConnectionGUID: 3kpBY0Q8TLSso2Asm0EeHQ==
X-CSE-MsgGUID: s7cR9ocXQheyNr3rHe82dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="173297513"
X-IronPort-AV: E=Sophos;i="6.10,216,1719846000"; d="scan'208";a="173297513"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 18:46:33 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D5CDBD64B4
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:46:30 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 154C0D4C01
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:46:30 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 93F9B409A0
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 18:46:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 089B01A000B;
 Tue, 10 Sep 2024 17:46:28 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 10 Sep 2024 17:47:55 +0800
Message-ID: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28654.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28654.006
X-TMASE-Result: 10-2.307500-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vk/lcuYMIHMbRqkhv3OdF4DDGPdYDozjWOkNS9uwltRRMEU
 cMyoWTeOIvrftAIhWmJ8eC2pVr1wb49oUcx9VMLggxsfzkNRlfJjFT88f69nG/oLR4+zsDTtjoc
 zmuoPCq0QPCWyQhJT2jEJ0OhUdu4LzXPCUfoztfTpm40lDbMLBKgz2eKO2qRYxK4AmAFj7z0Prq
 r2/4d+oSG/VUg4eAbH8FS1gooKhPH1QSVXlIwIKsu3Xpha3HN4X02llt10e/veIZBhQ9mZ7s7nW
 +rXGFOy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1: add
 _GNU_SOURCE define
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VG8gZ2V0IHJpZCBvZiBlcnJvciAi4oCYTUFQX0FOT05ZTU9VU+KAmSB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbikiCm9uIHNvbWUgc3lzdGVtcyAoRmVkb3JhIDM3LCBldGMp
LgoKU2lnbmVkLW9mZi1ieTogTWEgWGluamlhbiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPgotLS0K
IC4uLi9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV90aW1lZHdhaXQvMi0xLmMgICAgICAgICAg
ICAgICAgICAgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2Vz
L3NlbV90aW1lZHdhaXQvMi0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29u
Zm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGltZWR3YWl0LzItMS5jCmluZGV4IDJlY2E4ZGZmNi4u
NGNjZWY3MjYxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29u
Zm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGltZWR3YWl0LzItMS5jCisrKyBiL3Rlc3RjYXNlcy9v
cGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV90aW1lZHdhaXQv
Mi0xLmMKQEAgLTExLDYgKzExLDcgQEAKICAqLwogCiAKKyNkZWZpbmUgX0dOVV9TT1VSQ0UKICNp
bmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+
Ci0tIAoyLjQyLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
