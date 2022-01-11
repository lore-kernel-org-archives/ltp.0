Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003EC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF2663C93EE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:11:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D092F3C93FE
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:32 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12078100054C
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641881431; i=@fujitsu.com;
 bh=YWhL6tS9mblITDmcGjLwmsI4Amg6Jk4Na6VQOF9nc94=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=TCAer/g7VRB9UYXUHOC/WVpMz6yuVsM6+MO4m9y6GXeRepjNVDwn86Zkvovazz24t
 Ac5Y53ljc8Gj/1lEb/RUtt18qVCMdasWcKvxkmTmgzdFPlk9ggFlvTwE72m2junTru
 5rGDbRhgDYuk2GAKKpsRYBbucFjE2heM5vsAYbaNdp5X05UlllyL5pMYBNICW1gmA1
 ajpliFgRvQocw8CRndLrhFG6w8gMLLU0276AHPR1TGug+0//mGlcCjmu67EM+C9wnt
 bNr1uL28prcNEDg/KFtpePlqL+Cql6cNJielOzUIXv++ifuM0mz+p2AGd9g1DmZz7f
 T5THp49d4y6zg==
Received: from [100.115.1.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 97/F5-30341-65F1DD16;
 Tue, 11 Jan 2022 06:10:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRWlGSWpSXmKPExsViZ8MRohsmfzf
 R4P8JRYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWNvWxNjwQy2in1T37I2MF5m7WLk4hASaGKS
 2LL1MRuEs4dR4tvhXyxdjJwcbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+MYHYwgJ+Eu/OT
 GEDsVkEVCUarx8Esjk4eAU8JF6+rwQJSwgoSEx5+B5sDKeAp0TvqYlg5UICiRLzDzwHG8MrIC
 hxcuYTFojxEhIHX7xghuhVlLjU8Y0Rwq6QmDWrjWkCI/8sJC2zkLQsYGRaxWiVVJSZnlGSm5i
 Zo2toYKBraGiqa6ZrZGigl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGJIp
 xWyXdjDO7fupd4hRkoNJSZS3VvJuohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3hmyQDnBotT01
 Iq0zBxgfMCkJTh4lER4taSB0rzFBYm5xZnpEKlTjLoczZOWb2cWYsnLz0uVEuf9LAhUJABSlF
 GaBzcCFquXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzTpQDmsKTmVcCt+kV0BFMQEckc9w
 GOaIkESEl1cBkeFaXTcB6V56e7osbLu6PnoQ+ql/msulh0i7Zb94fJxQc5P8QdyP0SHKAVky/
 8dMDrtKhq2syun8q5Ntxz2CKMzee8y8j4jfrm1UF31umHhA8q2d1w3z5UwVlhkImmTBG9+Vzd
 k2xnZalxbA/cL35+wbTiVpMVyrd+bIn+fW1/ld4ymV1rPL8EnVD9vWrjv//o6wwq1gtSVXd1P
 SkRmto6Y3qd2m5vL0P/+07o53H+29/5fGcWSkviie3pqZER4a9CDcVdJB5dP1H+uKM2JUu/qt
 8edZdFrZYsCZn05OLPlwzWI/Me5Ji01gSbHHqRpcvo7qhgtoD/k3y4jyaNVLH040sOJuseQVt
 uZ8pK7EUZyQaajEXFScCAIAGgy5QAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-585.messagelabs.com!1641881430!69929!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8323 invoked from network); 11 Jan 2022 06:10:30 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-2.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 06:10:30 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 20B6AMak030057
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:10:30 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 06:10:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 14:10:35 +0800
Message-ID: <1641881435-2351-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/5] runtest.sh: add test_kconfig.sh into ltp c
 test target
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/newlib_tests/runtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index ad213eef6..92fd3860e 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -4,7 +4,7 @@
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
 tst_needs_cmds01 tst_needs_cmds02 tst_needs_cmds03 tst_needs_cmds06
 tst_needs_cmds07 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus
-tst_fuzzy_sync03 test_zero_hugepage.sh}"
+tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
 shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
