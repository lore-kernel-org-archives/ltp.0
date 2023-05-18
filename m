Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF5C77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 07:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21BA93CB2A9
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:40:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C78713CB288
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:40:40 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7770B10009F4
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:40:38 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="96567858"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; d="scan'208";a="96567858"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 16:40:37 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B1B33C68E1
 for <ltp@lists.linux.it>; Thu, 18 May 2023 16:40:34 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com
 [192.51.206.12])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F30A5D39C8
 for <ltp@lists.linux.it>; Thu, 18 May 2023 16:40:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 180CB23406B6;
 Thu, 18 May 2023 16:40:33 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 18 May 2023 15:40:23 +0800
Message-Id: <1684395623-14792-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27632.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27632.005
X-TMASE-Result: 10--3.098800-10.000000
X-TMASE-MatchedRID: J8Qxq5eo31Evt8akOOKRVjZoNXJMbH+ngbNN0R684zPK9r4CKuozRdAY
 WUo4HSIkIvrftAIhWmLy9zcRSkKatX68Epk3cm6cLCOlrnWhfGtfT3wDt+vdV5a5+gecZQ1+4xu
 5XN3JhhrvPBXLPdbeHE0mkURNjpeQXgPkZYDh/MyfrLSY2RbRpJfau+Sc1iUTHBIhAp4p0DejxY
 yRBa/qJcFwgTvxipFajoczmuoPCq105XuGd1t4JvauVRek2Cbth3+fIf/FE+2DET2QiJiAmnHII
 OL1YRyuzohpeNI1+U31VS1Of9MdCQEPkCjVMVy8GTBvFGdYCModJuEZuYbKVcUkrvIudlEZl07d
 DrsiYvyCLhFTP3QRDAbYwClu/qh3
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc/shell-test-api.txt: Don't include tst_test.sh
 twice
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Usually, we include tst_test.sh on the end of a case and on the
top of tst_run. Some the beginning tst_test.sh is useless and remove.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index e5c918660..dde170644 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -26,7 +26,6 @@ WARNING: All identifiers starting with 'TST_' or 'tst_' are reserved for the
 # This is a basic test for true shell builtin
 
 TST_TESTFUNC=do_test
-. tst_test.sh
 
 do_test()
 {
@@ -79,7 +78,6 @@ not trigger calling it.
 
 TST_TESTFUNC=test
 TST_CNT=2
-. tst_test.sh
 
 test1()
 {
@@ -110,7 +108,6 @@ found they are executed one by one. The test number is passed to it in the '$1'.
 
 TST_TESTFUNC=do_test
 TST_CNT=2
-. tst_test.sh
 
 do_test()
 {
@@ -141,7 +138,6 @@ to it in the '$1'.
 TST_TESTFUNC=do_test
 TST_TEST_DATA="foo:bar:d dd"
 TST_TEST_DATA_IFS=":"
-. tst_test.sh
 
 do_test()
 {
@@ -168,7 +164,6 @@ It's possible to pass data for function with '$TST_TEST_DATA'. Optional
 TST_TESTFUNC=do_test
 TST_CNT=2
 TST_TEST_DATA="foo bar"
-. tst_test.sh
 
 do_test()
 {
@@ -285,7 +280,6 @@ as it doesn't exit (it issues 'tst_res TCONF'). Expected usage is:
 #!/bin/sh
 
 TST_TESTFUNC=do_test
-. tst_test.sh
 
 do_test()
 {
@@ -325,8 +319,6 @@ TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
 TST_TESTFUNC=do_test
 
-. tst_test.sh
-
 ALTERNATIVE=0
 MODE="foo"
 
@@ -378,8 +370,6 @@ TST_POS_ARGS=3
 TST_USAGE=usage
 TST_TESTFUNC=do_test
 
-. tst_test.sh
-
 usage()
 {
 	cat << EOF
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
