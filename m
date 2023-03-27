Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9342DC761A6
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:21:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06CE53CCB49
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 12:21:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91AAF3CCCF9
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:21:24 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 780CD1A00886
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679912482; i=@fujitsu.com;
 bh=AfUaO4lr332p++cK68g7B44I0fMgrHSw9orV3ZmdifA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=WE4e1Ak2H2coXeFKuet8cgSJtvnGMz3qs86MwDolmqfHyKO3N/z4f4ouSNYY9z3HK
 y2nFc1kip3DpSBr2TD1UVhkQOk/UJwz2SUZTForF774RdnhB39neepT+7phiTCmFfx
 SQMy7iqK5Bor23Z8g3QsOnBepKeagk6tUxLW+6x2cTkDW46SSpp713zeTtn5410GkC
 5NbEPFMuOBjN9Of2at2Sgnp4Cruu778cFO4e6O0y/il6zJrHnZObqZkR1Uxxk7jtX9
 hpAWrZHx2rZyPnPK0Ed1OZ/KilRtAiLinJA3fveAJQiXt5qW3bM4VpyAu/5KVVywOM
 RgLULg/hFwiag==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8OxWVcxTzH
 F4M9sK4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP93AdMBR+EK6b9TG1gfCbYxcjFISRwilFi
 zdoGRghnD5PE4YP/2CGcvYwSu7qeMnUxcnKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/oFV
 iMsYCAx5/8PoDgHB4uAqkTHvmSQMK+Ah8TlZdvBWiUEFCSmPHzPDBEXlDg58wkLxBgJiYMvXk
 DVKEm0tV5hhbArJBqnH2KCsNUkrp7bxDyBkX8WkvZZSNoXMDKtYjQvTi0qSy3SNTTQSyrKTM8
 oyU3MzNFLrNJN1Est1c3LLyrJ0DXUSywv1kstLtYrrsxNzknRy0st2cQIDMaU4sT5Oxgv9/3V
 O8QoycGkJMrbz6mYIsSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCVzIHKCdYlJqeWpGWmQOMDJi0B
 AePkghvaRpQmre4IDG3ODMdInWKUZdjYf/VvcxCLHn5ealS4rx3QWYIgBRllObBjYBF6SVGWS
 lhXkYGBgYhnoLUotzMElT5V4ziHIxKwry5mUBTeDLzSuA2vQI6ggnoiG8FCiBHlCQipKQamPS
 vhdxSe1ay+ImYyXJr27QsX5EfzzmeRqXpxuacPFmj5mvRUJ3PNVPyskL9oTq3JZrzcr5Jnt9R
 vUhOKTDUK3mCQHToTMmmhb1hj14qrJNql0hh4HXmWj3DsK5yddHP67afN3r2f/rxaJe5v/elZ
 /ohtSKsQvPZ4n9wGBY0Tdxx8/03nVOnbs5QkfM0fRGx4/IXuedRl0L11Jcw/nzJdDnDJuie5L
 oV+xXvOf748UcymmmmQv08m2OZIdvkc+9VT2yfyWe16fV/lqq5S1TPLp7l9HB7xnc/na/S1yJ
 OLo+bej24ryf84aYDzDpv1T+ueRDrwS1lPz3FVLlgSv7l6DxOq2P8DntmsrLdb566V4mlOCPR
 UIu5qDgRAJ75NrxNAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-728.messagelabs.com!1679912481!478306!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28827 invoked from network); 27 Mar 2023 10:21:21 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-12.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Mar 2023 10:21:21 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 57EC9152
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:21:21 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 4B68E7B
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:21:21 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 27 Mar 2023 11:21:19 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 27 Mar 2023 18:21:08 +0800
Message-ID: <1679912468-4539-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] runtest/cve: sort by cve number
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
 runtest/cve | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index cdbb5bc5f..5447284c9 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -5,9 +5,9 @@ cve-2011-2496 vma03
 cve-2012-0957 uname04
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
+cve-2015-3290 cve-2015-3290
 cve-2015-7550 keyctl02
 cve-2016-4470 keyctl01.sh
-cve-2015-3290 cve-2015-3290
 cve-2016-4997 setsockopt03
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
@@ -19,6 +19,7 @@ cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2636 pty05
 cve-2017-2671 cve-2017-2671
+cve-2017-5754 meltdown
 cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
@@ -31,19 +32,18 @@ cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
 cve-2017-15649 fanout01
 cve-2017-15951 request_key03 -b cve-2017-15951
+cve-2017-16939 cve-2017-16939
+cve-2017-16995 bpf_prog03
+cve-2017-17052 cve-2017-17052
+cve-2017-17053 cve-2017-17053
 cve-2017-17712 sendmsg03
 cve-2017-17805 af_alg02
 cve-2017-17806 af_alg01
 cve-2017-17807 request_key04
-cve-2017-1000364 stack_clash
-cve-2017-5754 meltdown
-cve-2017-17052 cve-2017-17052
-cve-2017-16939 cve-2017-16939
-cve-2017-16995 bpf_prog03
-cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2017-1000111 setsockopt07
 cve-2017-1000112 setsockopt05
+cve-2017-1000364 stack_clash
 cve-2017-1000380 snd_timer01
 cve-2017-1000405 thp04
 cve-2018-5803 sctp_big_chunk
@@ -51,15 +51,15 @@ cve-2018-7566 snd_seq01
 cve-2018-8897 ptrace09
 cve-2018-9568 connect02
 cve-2018-10124 kill13
-cve-2018-1000001 realpath01
-cve-2018-1000199 ptrace08
-cve-2018-1000204 ioctl_sg01
 cve-2018-12896 timer_settime03
 cve-2018-13405 creat09
 cve-2018-18445 bpf_prog04
 cve-2018-18559 bind06
 cve-2018-18955 userns08
 cve-2018-19854 crypto_user01
+cve-2018-1000001 realpath01
+cve-2018-1000199 ptrace08
+cve-2018-1000204 ioctl_sg01
 cve-2019-8912 af_alg07
 cve-2020-11494 pty04
 cve-2020-14386 sendto03
@@ -72,10 +72,10 @@ cve-2021-4034 execve06
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
+cve-2021-38604 mq_notify03
 cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
-cve-2021-38604 mq_notify03
 # Tests below may cause kernel memory leak
-cve-2020-25704 perf_event_open03
-cve-2022-4378 cve-2022-4378
 cve-2022-0185 fsconfig03
+cve-2022-4378 cve-2022-4378
+cve-2020-25704 perf_event_open03
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
