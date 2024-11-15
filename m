Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E71DD6DDDA
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731654153; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pGcjAndbOv+8wAYKYLNWLS1cGszkqGhkqVe0TjovYWg=;
 b=SoeUoZbalHEFzQIZt/Stu/KQLCy6q+dWxKvZFYkC0Xm5ZVLMCPx28RzNPtqjFWXlRZUhG
 0qwgtvHtbGyx/z1u1pJlqrTApQa8AbkJB9It5oqJGK3XDyKdRsHSiHgjd8IzIuOEpkdkf2C
 R59O4cx2fWhCYdbRUsgMqJw+JgHng18=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632B63D74AC
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 08:02:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A660B3D746E
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 08:02:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 09D871BE1BF0
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 08:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1731654132; x=1763190132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X5lALcREZK/l9luZPxMFc44+jHMCC1G30dX5MA/2SIo=;
 b=rZWEUg9eruJCw2/IFZQhmsGk8Pup9WO4DUMzgK42ZkPmDxCYKgwhHZ+n
 7g62ieRXAL0Xxreia+gIc6U+zNAYim64HL75Y0jzY6GGEkNjdz3ZvMAiC
 HMFm22LV2TNCMoZiG7p0nuyYR8dm9J4c7Ca2KYbi93Q1dhmr81Hae7EHV
 ChEQ+ZxAQgZxOXUVGAo7/Sf32Y55lMQIF2yG2P6ze9ktati0o9eun8oMS
 67buTV9HDb/306RW9Fl+8F7JZC+vhz/M2KYOOXhJuqkpw/v0x+96Apd5m
 ECI5D4qxm25H7x2X9xCDk7wk+3eAp4EfTTlUblIMEg/QQ4GpNChQ9J6xF w==;
X-CSE-ConnectionGUID: NFYTN7XoQ3WSFJ+m8wIzaw==
X-CSE-MsgGUID: yzlvnVecRXKJhuulRiH/jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="159510601"
X-IronPort-AV: E=Sophos;i="6.12,156,1728918000"; d="scan'208";a="159510601"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2024 16:02:09 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 28FBF9674B
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:02:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BBC80385D3
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:02:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4FD17E2059
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:02:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id EA3F21A000B;
 Fri, 15 Nov 2024 15:02:05 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 15:01:53 +0800
Message-ID: <20241115070153.133523-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28798.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28798.005
X-TMASE-Result: 10--3.711800-10.000000
X-TMASE-MatchedRID: /CzucCovGFKhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrlcGuTueJkNIuLS
 dVP2tZn5KhUWD07FA+x0GLVq9e5VbIV30ZD7XA/l1l+BjLM8lsqtOrovcQWGr88jvrgttXWzAwV
 YwE7hIhzi8zVgXoAltsIJ+4gwXrEt33fj+sMArfOUZ3IP5ATaHzeHv7ksikI9ikqMYL+xXvlWei
 dhmIlWKwATu+ilBB6jer82lSuD5riCtvJtlw9an0euqjnBJSKxhowD6QK9FnACUb3VB7BlShFlt
 GxCTkwFQHVA+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] preadv202: Convert docs to docparse
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

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/preadv2/preadv202.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv202.c b/testcases/kernel/syscalls/preadv2/preadv202.c
index fd3b7c9d7..f7279e0ad 100644
--- a/testcases/kernel/syscalls/preadv2/preadv202.c
+++ b/testcases/kernel/syscalls/preadv2/preadv202.c
@@ -4,20 +4,19 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
- * Check various errnos for preadv2(2).
- * 1) preadv2() fails and sets errno to EINVAL if iov_len is invalid.
- * 2) preadv2() fails and sets errno to EINVAL if the vector count iovcnt
- *    is less than zero.
- * 3) preadv2() fails and sets errno to EOPNOTSUPP if flag is invalid.
- * 4) preadv2() fails and sets errno to EFAULT when attempts to read into
- *    a invalid address.
- * 5) preadv2() fails and sets errno to EBADF if file descriptor is invalid.
- * 6) preadv2() fails and sets errno to EBADF if file descriptor is not
- *    open for reading.
- * 7) preadv2() fails and sets errno to EISDIR when fd refers to a directory.
- * 8) preadv2() fails and sets errno to ESPIPE if fd is associated with a pipe.
+/*\
+ * [Description]
+ *
+ * Verify that, preadv2(2) fails and sets errno to
+ *
+ * 1. EINVAL if iov_len is invalid.
+ * 2. EINVAL if the vector count iovcnt is less than zero.
+ * 3. EOPNOTSUPP if flag is invalid.
+ * 4. EFAULT when attempting to read into an invalid address.
+ * 5. EBADF if file descriptor is invalid.
+ * 6. EBADF if file descriptor is not open for reading.
+ * 7. EISDIR when fd refers to a directory.
+ * 8. ESPIPE if fd is associated with a pipe.
  */
 
 #define _GNU_SOURCE
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
