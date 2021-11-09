Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB5C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D2261178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12D2261178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5C7C3C07B9
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:53:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FF383C08C9
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:42 +0100 (CET)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CF0F14125F0
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455160; i=@fujitsu.com;
 bh=N9Y1CJo/1Q9LYoAyYU9UoZaW8eSM61VgVerXnA5u4vo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=wzEg1XH3Pm2pZ+cM9NTYOn5jbAQoaziLthoej8UeYMj7Lm6+KshytLOJDDb/7FBXz
 WVTicAtKCo7+3zNQ4JWWC8/jmxXEDqAEHIV/EVKiXiiXh4Cgte+uR/8M8pQ7NzPnJq
 bcuO7EO+IMRXOvgW+3cxSBgtkWxNsRFy3NQMgKPMvi29Ro4ALOf7tKvaAYzBdnNHod
 3Oxkg5EDzhBpq33F6ZzSv7/XvZTaoSaCV2Jlx6RRmk1NUx4gcU9ScWNGgwRyvGkIa7
 ZhFI3rRoWbHrg/sXjTZQXRf55i4HjsYs/EE5Wil7WMrfZGUs2LVfFBSmjAeUbONrhy
 KriARygZ1kxUQ==
Received: from [100.112.196.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 1E/12-05453-8F25A816;
 Tue, 09 Nov 2021 10:52:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8MRqvsjqCv
 RYPJeZosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPG5iuMBbs5Kh6+X8zSwHiMvYuRi0NIoJFJ
 Yt+OGcwQzm5GiWWbrjB1MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6BVYjLOAlceJZP
 0sXIwcHi4CKxLHNaSBhXgEPid/7/4GVSAgoSEx5+J4ZpIRTwFPi70dXkLAQUMmO558ZIcoFJU
 7OfMICMV1C4uCLF8wQrYoSlzq+MULYFRKzZrUxTWDkn4WkZRaSlgWMTKsYzZOKMtMzSnITM3N
 0DQ0MdA0NjXQNLc11zQz0Eqt0k/RSS3XLU4tLdA31EsuL9Yorc5NzUvTyUks2MQJDMaXgqM0O
 xg+vP+gdYpTkYFIS5b0s1pUoxJeUn1KZkVicEV9UmpNafIhRhoNDSYI3wR8oJ1iUmp5akZaZA
 4wLmLQEB4+SCK+eD1Cat7ggMbc4Mx0idYpRl+Pdz8WLmIVY8vLzUqXEeRsDgYoEQIoySvPgRs
 Bi9BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd5KkCk8mXklcJteAR3BBHTEwS/tIEeUJCK
 kpBqY1F82/Zz//cKzwMcH2Psj2TccePO5U+XfwSlhlt8vBU08yMT9W+3wwUcyzTdqEm92SZ3J
 1Pnx5tif6t2VixblcF3c9UjlivzB1esfTPNQdp4sfnqd87fM+ABRfnOfi8rtp/bOWF7iZB+9b
 0NxSNvydR/mPD/2wPXK/YMGT63XGIaKKfwQX/HW4XJ33jvFL3eY3m+XOj6PtWzBvpOqP24VTp
 Or76vgb7qrfePJuYRc+Rzjw+fPMfPOzl/mcW/Jh3rt01J+JlbuIpGx1fuWXSyZ9TFJ6HvWMm/
 h++LBMqb25jaSyZwyHjkVSluuJUenBUyVeJJQskOxKqj89o5AKb1J3SwHXh6yKLuTuz6DyenM
 PyWW4oxEQy3mouJEADS4lqBMAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-285.messagelabs.com!1636455159!9223!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2419 invoked from network); 9 Nov 2021 10:52:40 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
 by server-7.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:52:40 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1A9Aqd9w017913
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 9 Nov 2021 10:52:39 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:52:37 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:52:38 +0800
Message-ID: <1636455161-8278-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/12] syscalls/quotactl04: Remove useless mount
 option
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

When use -O quota options for mkfs.ext4, quota mount option will be ignored
since 3.5 kernel[1]. Since the Oldest tested kernel version is 3.10,
we can remove mount option directly.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index fd3afc888..f3e2cf3a5 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -141,7 +141,7 @@ static void setup(void)
 		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
+	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 }
 
 static void cleanup(void)
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
