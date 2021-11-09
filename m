Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BAAC433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 03:17:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A6C6112D
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 03:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67A6C6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 399003C07B7
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 04:17:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 920BC3C0511
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 04:17:34 +0100 (CET)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F6271A01CDB
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 04:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636427851; i=@fujitsu.com;
 bh=mZfyyADcMR53/YlUv/m9DFjs2mumPEzqwLp3sHR+Ceg=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=MEyHyp8bGWuPIfVCL0qMATC6TJ9Gteoxg8K4PXts4Rj6PjuzndYuP06/4zbjQ84eI
 q+Bv7m9DoVAUMtaJwfUh+uqMZJB/8mhyxAquo30LZMrfjlKodOvnbMeCk5woDMPkuR
 /9BrdLrjpZ1qJ0d/BV7N7W++GGEb6tmbLuJaJuW9Jx2J5P8qHbkxT/kDaiTmyvT+79
 M1qIZi3RzVNltJU6bO5vm0c9qjW9n3MN1+v/Utc5b/oSclpE3eH2OIEmm63Be0rQkA
 qXydLoSIwBNtVFfxhY4PWyXKLsSGgVH4wdlhrJLKfT/zw96tnet6bfBBpf0jvWTK8t
 mbc11ExrCMFhA==
Received: from [100.112.196.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.eu-west-1.aws.symcld.net id BD/5B-08711-A48E9816;
 Tue, 09 Nov 2021 03:17:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8MxVdfrRWe
 iweml4hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bPpi1MBRPYKu4sOcrawLiUtYuRi0NIoJFJ
 YsraC2wQzm5GiX1PHjB2MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6xQRiCwtYSfycs
 44NxGYRUJFY1nIYrIZXwEPi2ab9YDUSAgoSUx6+Z4aIC0qcnPmEBWKOhMTBFy+YIWoUJS51fG
 OEsCskZs1qY5rAyDsLScssJC0LGJlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGlpa6BoaG+glVuk
 m6aWW6panFpfoGuollhfrFVfmJuek6OWllmxiBAZYSsGxph2MJ19/0DvEKMnBpCTK27WpM1GI
 Lyk/pTIjsTgjvqg0J7X4EKMMB4eSBO+Op0A5waLU9NSKtMwcYLDDpCU4eJREeN89A0rzFhck5
 hZnpkOkTjEqSonzvgRJCIAkMkrz4NpgEXaJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvb5
 ApPJl5JXDTXwEtZgJafPBLO8jikkSElFQD017J5w9WJE5mdzXI6ggSyCpRnLsqNYzVv8pl/6O
 rk5Y6vdnrfrF8vUOC6qKun+o1pfqz6+efqVLbqdAcelTW9+MxTe7AlZaGsZ7fBBS/Mn23KpY+
 cPDez/AS0dP1JlcvJYfH7dpxYN3C5V9Wpcd87lHzC3nov3bxnXsfX8xN5i5q/i/YqmqvrKjnc
 GOLOo/Pj+cCGUm2vwRS0zM38cVobhdU3fJ5klDju/XesSVLl3C9LM3cnd0fKr3fsPnlJs6E4l
 cpnjd3fufw3jyxRH3ujegVmUZR/4Q5WXesfpm1V3GhnjjP607+3ZZFryxPsUut1/54d9N1zlt
 hTX9WBx+RF6uViV73+kizyLZL+Z9dlViKMxINtZiLihMBr5K9RisDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-285.messagelabs.com!1636427850!408877!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1752 invoked from network); 9 Nov 2021 03:17:30 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-14.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 03:17:30 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1A93HOa0031278
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 9 Nov 2021 03:17:30 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 03:17:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 11:17:38 +0800
Message-ID: <1636427858-2182-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_kconfig.c: supplement config path
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

We should add /lib/modules/$(uname -r)/build/.config for parsing.
So we can avoid parsing not-found-error when using our own compiled kernel.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/tst_kconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 5af67b0a5..d433b8cf6 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -32,6 +32,12 @@ static const char *kconfig_path(char *path_buf, size_t path_buf_len)
 
 	uname(&un);
 
+	/* Common install module path */
+	snprintf(path_buf, path_buf_len, "/lib/modules/%s/build/.config", un.release);
+
+	if (!access(path_buf, F_OK))
+		return path_buf;
+
 	/* Debian and derivatives */
 	snprintf(path_buf, path_buf_len, "/boot/config-%s", un.release);
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
