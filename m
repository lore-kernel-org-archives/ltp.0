Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D924E7718A
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734666898; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4mp1ZHP2w/5Np3Kby2Opw1n9w7KvaQ7X4j3+dJIKqeg=;
 b=fxrIEU1RXn8Pg0XL+LTX3W8PL8lvADotS4x2KbXWfz1r6UMxbKds5NNA/A9BMLmcmOnBP
 GnAhGgA+/Fk4YyXrW5NpA11E1peC8v/Eas68cWPN1cA1pMxmJhm3fHUczabeAtsYA9otVg4
 zGQvrZgWYNEaGImkPpRDE+AGYyQYbVU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 037FD3EDF9E
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 04:54:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B0753EDD00
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 04:54:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0700C1A001B0
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 04:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734666876; x=1766202876;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GDNPohzEmHmLYZ4AeVyfgDgrDVIE/Udbohvg5KE9LOA=;
 b=RuZIhK/cyRUfhogsLX8nJQQK6v++g+Fs/0uMs971bgee4E994/z2bcZ7
 gJibWgDLIcycCoL9Z342t87AbpJbjX1uCiyyQCsOumrzvQnNWzxyZe/kV
 gKywQDM6RtGj1zz5LXErrtG3iUhD8WOKwOUUOm5WY/RGme5OvkIdWR8Yh
 ZwLtu1dOn1GtM0PCF0dSU0N0Natk3TZxMJqWevYmBFiFUG9nXj6YsV7bD
 GPe37E2a8oUKWYOofx0Ex2NsuElzT7BnxPHQs05qfwkgi29J5Et+b3X7O
 13idjBMweoekd5wsZBafIvTLgq4w2JKbuhSTSaYeJA/H3WJ5JZtP9Ck3Q g==;
X-CSE-ConnectionGUID: NgkD0LnhQjSmr11xQyhrBQ==
X-CSE-MsgGUID: E+Vkttg/RA68Y4GAs1t0UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="183566554"
X-IronPort-AV: E=Sophos;i="6.12,249,1728918000"; d="scan'208";a="183566554"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2024 12:54:34 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0925AD6EA7
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 12:54:31 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C8C1BCFB67
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 12:54:30 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 578FE10206
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 12:54:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B98D11A006C;
 Fri, 20 Dec 2024 11:54:29 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 20 Dec 2024 11:54:04 +0800
Message-ID: <20241220035404.3270912-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28870.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28870.004
X-TMASE-Result: 10--1.990800-10.000000
X-TMASE-MatchedRID: umENZJXhj4tJiMtrv6qGB31JIA4rhsZ/yqyllX6UJIsTxwvzfR5QyoCu
 qghmtWfXIvrftAIhWmLoj21zNtGCrhqvZJgGS7ODqdwbW9Wx9tCAaxj78ZrSLnepM/I+teqco8W
 MkQWv6iV3LAytsQR4e42j49Ftap9ExlblqLlYqXIU7QLBiL9EeeOI8TgJcDgUE+QLowzYF0O6j6
 IXP497AsDvURnwRZ5aGMdfN0om9LeDN6LAM2tGPOWRq7YEH95Z4x8EB7Li3fERZbRsQk5MBUB1Q
 Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: Fix the dummy declaration for `lio_listio`
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

The second parameter should be "struct aiocb *const [restrict]" instead
of "struct aiocb *restrict const [restrict]" based on the header file "aio.h".

For "struct aiocb *restrict const [restrict]", it will report "-Wincompatible-pointer-types"
issue while compiling:
- With gcc 11.5.0, it's a warning issue.
- With gcc 14.2.0, it becomes an error.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../open_posix_testsuite/conformance/definitions/aio_h/4-1.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/definitions/aio_h/4-1.c b/testcases/open_posix_testsuite/conformance/definitions/aio_h/4-1.c
index f30f14df2..9283e1de8 100644
--- a/testcases/open_posix_testsuite/conformance/definitions/aio_h/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/definitions/aio_h/4-1.c
@@ -16,7 +16,7 @@ static ssize_t (*dummy4) (struct aiocb*) = aio_return;
 static int (*dummy5) (const struct aiocb* const[], int,
 	       const struct timespec *) = aio_suspend;
 static int (*dummy6) (struct aiocb *) = aio_write;
-static int (*dummy7) (int, struct aiocb *restrict const [restrict],
+static int (*dummy7) (int, struct aiocb *const [restrict],
 	       int, struct sigevent *restrict) = lio_listio;
 
 int main(void)
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
