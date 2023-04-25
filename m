Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD7C6FD18
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 09:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC9ED3CBBE9
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 11:12:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8E3D3CBBB7
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 11:12:25 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA9BB2001B1
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 11:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1682413942; i=@fujitsu.com;
 bh=sbx1pX5PV9R47z3QLem1lUi27ficEfyvqBXnVqoOq5k=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=hLaeOjbmEHdvnOcMXZlqQjDhFBAHGtQB3DANfg0Rw2zc1AGAq+wuhJGGBQWrjD5yW
 czI1XNKIXCC4W7iwC+ngFo0DdfolztD/G8OUzlA8p6b2qJ+yu8D7VrJXpQ6IIcU1ld
 FV63Uu7iGWgBefHV/BblOETE3XrXM+pArIqllmzC7TibsEEaqGICSdasTbz+ObyhZm
 xQWy7rJDax6PUdsPY+jcitPbDCQLlid/ZBdsZPhgh8R9G/qs1qRqXBhaOfbu6FO3tM
 dzviB+1tSxdTCTK1naEKgTXPGgHGsD0Sz+rOCfbiSsjBCSuwyd1Njrn2laqrg9n7dR
 S1aA0pzSUr/Og==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRWlGSWpSXmKPExsViZ8OxWbd0pnu
 Kwfq30hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aDGVeYCm7bVsz794+lgXGCSRcjF4eQwClG
 ibZj+9ghnL1MEq2vpgE5nEDOPkaJy08TQGw2AU2JZ50LmEFsEQEJiY6Gt2A1zALqEssn/WICs
 YUFIiRWbDwJVMPBwSKgKjF9jx1ImFfAU+LHq+1g5RICChJTHr5nhogLSpyc+YQFYoyExMEXL5
 ghapQk2lqvsELYlRKtH36xQNhqElfPbWKewMg/C0n7LCTtCxiZVjGaFqcWlaUW6ZroJRVlpme
 U5CZm5uglVukm6qWW6panFpfoGuollhfrpRYX6xVX5ibnpOjlpZZsYgQGYkoxQ+QOxvs7/+od
 YpTkYFIS5eUKc0sR4kvKT6nMSCzOiC8qzUktPsQow8GhJMHrOs09RUiwKDU9tSItMwcYFTBpC
 Q4eJRHekFagNG9xQWJucWY6ROoUoy7Hpn1dB5iFWPLy81KlxHkTpgMVCYAUZZTmwY2AReglRl
 kpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK882YATeHJzCuB2/QK6AgmoCN2cbuAHFGSiJCSamA
 SOfdcmc94NseabQe/6jnqLIl46LIvZM12a66lbdLLMoRSWdIU2xttPgpf1/f9+2/Jw9bNnxSV
 DOZffvxIvEa+vCjYa0H6tpcKadEXNsyW+3tzl9+OyNP/Wc4dkp5168DyyHc6gdPTDvL981LlM
 P73LXuD+Zo5W3a/5O+4Fb8xJeqhxlXu+3Z31D6fefLL49DcnP8cm5OrTuXqBjOH23++2fKBN+
 9w4LntemeV0vqv6zPdfWL0ccle5t99OYqulaKBhR5PxUN/Wyvc2fXnFssG859at779zc26wbR
 EQ3GfmtKXnAj7NJ7vzXeOr5k8a9sndddDHAGzJhWzyJ3+s+QD64OMCXeDbu7bbDkvanFekRJL
 cUaioRZzUXEiAIS8zeFLAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-587.messagelabs.com!1682413941!117297!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20951 invoked from network); 25 Apr 2023 09:12:21 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-20.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Apr 2023 09:12:21 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 139C1156
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 10:12:21 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 071837B
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 10:12:21 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 10:12:19 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 25 Apr 2023 17:12:09 +0800
Message-ID: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] rpc/rpc-tirpc: Fix compile error on clang when
 using clnt_broadcast
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

When clang upgrade to 16.0.0-2.fc38, these case will report
incompatible-function-pointer-types  error as below:

rpc_clnt_broadcast_complex.c:81:46: error: incompatible function pointer types passing
'bool_t (char *, struct sockaddr_in *)' (aka 'int (char *, struct sockaddr_in *)') to
parameter of type 'resultproc_t' (aka 'int (*)(char *, ...)') [-Wincompatible-function-pointer-types]
(xdrproc_t) xdr_int, (char *)&varRec, eachResult);

the clnt_broadcase declare as below:
extern enum clnt_stat   clnt_broadcast(u_long, u_long, u_long,
                                         xdrproc_t, void *,
                                         xdrproc_t, void *,
                                         resultproc_t);

so we should add resultproc_t cast like tirpc_simple_rpc_broadcast[1] does.

[1]https://github.com/linux-test-project/ltp/blob/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c#L84

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../rpc_clnt_broadcast.c                          |  3 ++-
 .../rpc_clnt_broadcast_complex.c                  |  3 ++-
 .../rpc_clnt_broadcast_dataint.c                  | 15 ++++++++++-----
 .../rpc_clnt_broadcast_performance.c              |  2 +-
 .../rpc_clnt_broadcast_scalability.c              |  2 +-
 .../rpc_clnt_broadcast_stress.c                   |  2 +-
 6 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
index 5f024f113..80d5f045a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast.c
@@ -59,7 +59,8 @@ int main(int argn, char *argc[])
 	//Call broadcast routine
 	cs = clnt_broadcast(progNum, VERSNUM, PROCNUM,
 			    (xdrproc_t) xdr_int, (char *)&varSnd,
-			    (xdrproc_t) xdr_int, (char *)&varRec, eachResult);
+			    (xdrproc_t) xdr_int, (char *)&varRec,
+			    (resultproc_t) eachResult);
 
 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
index c6e55cd81..e1bb8fcc5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex.c
@@ -78,7 +78,8 @@ int main(int argn, char *argc[])
 	//Call broadcast routine
 	cs = clnt_broadcast(progNum, VERSNUM, PROCNUM,
 			    (xdrproc_t) xdr_int, (char *)&varSnd,
-			    (xdrproc_t) xdr_int, (char *)&varRec, eachResult);
+			    (xdrproc_t) xdr_int, (char *)&varRec,
+			    (resultproc_t) eachResult);
 
 	if (currentAnswer == maxAnswer)
 		test_status = 0;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
index fdf1e31a2..e1f7bcb6a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
@@ -72,7 +72,8 @@ int main(int argn, char *argc[])
 
 	clnt_broadcast(progNum, VERSNUM, INTPROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&intSnd,
-		       (xdrproc_t) xdr_int, (char *)&intRec, eachResult);
+		       (xdrproc_t) xdr_int, (char *)&intRec,
+		       (resultproc_t) eachResult);
 
 	if (intSnd != intRec)
 		test_status = 1;
@@ -84,7 +85,8 @@ int main(int argn, char *argc[])
 
 	clnt_broadcast(progNum, VERSNUM, INTPROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&intSnd,
-		       (xdrproc_t) xdr_int, (char *)&intRec, eachResult);
+		       (xdrproc_t) xdr_int, (char *)&intRec,
+		       (resultproc_t) eachResult);
 
 	if (intSnd != intRec)
 		test_status = 1;
@@ -96,7 +98,8 @@ int main(int argn, char *argc[])
 
 	clnt_broadcast(progNum, VERSNUM, LNGPROCNUM,
 		       (xdrproc_t) xdr_long, (char *)&lngSnd,
-		       (xdrproc_t) xdr_long, (char *)&lngRec, eachResult);
+		       (xdrproc_t) xdr_long, (char *)&lngRec,
+		       (resultproc_t) eachResult);
 
 	if (lngSnd != lngRec)
 		test_status = 1;
@@ -108,7 +111,8 @@ int main(int argn, char *argc[])
 
 	clnt_broadcast(progNum, VERSNUM, LNGPROCNUM,
 		       (xdrproc_t) xdr_double, (char *)&dblSnd,
-		       (xdrproc_t) xdr_double, (char *)&dblRec, eachResult);
+		       (xdrproc_t) xdr_double, (char *)&dblRec,
+		       (resultproc_t) eachResult);
 
 	if (dblSnd != dblRec)
 		test_status = 1;
@@ -121,7 +125,8 @@ int main(int argn, char *argc[])
 
 	clnt_broadcast(progNum, VERSNUM, LNGPROCNUM,
 		       (xdrproc_t) xdr_wrapstring, (char *)&strSnd,
-		       (xdrproc_t) xdr_wrapstring, (char *)&strRec, eachResult);
+		       (xdrproc_t) xdr_wrapstring, (char *)&strRec,
+		       (resultproc_t) eachResult);
 
 	if (strcmp(strSnd, strRec))
 		test_status = 1;
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
index 11ba64fab..d733e72ef 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance.c
@@ -114,7 +114,7 @@ int main(int argn, char *argc[])
 		cs = clnt_broadcast(progNum, VERSNUM, PROCNUM,
 				    (xdrproc_t) xdr_int, (char *)&varSnd,
 				    (xdrproc_t) xdr_int, (char *)&varRec,
-				    eachResult);
+				    (resultproc_t) eachResult);
 
 		if (cs != RPC_SUCCESS)
 			clnt_perrno(cs);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
index 57ea25349..4455c1173 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability.c
@@ -114,7 +114,7 @@ int main(int argn, char *argc[])
 		cs = clnt_broadcast(progNum, VERSNUM, PROCNUM,
 				    (xdrproc_t) xdr_int, (char *)&varSnd,
 				    (xdrproc_t) xdr_int, (char *)&varRec,
-				    eachResult);
+				    (resultproc_t) eachResult);
 
 		if (cs != RPC_SUCCESS)
 			clnt_perrno(cs);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
index d5d7d85d1..933305482 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress.c
@@ -65,7 +65,7 @@ int main(int argn, char *argc[])
 		cs = clnt_broadcast(progNum, VERSNUM, PROCNUM,
 				    (xdrproc_t) xdr_int, (char *)&varSnd,
 				    (xdrproc_t) xdr_int, (char *)&varRec,
-				    eachResult);
+				    (resultproc_t) eachResult);
 		if (cs == RPC_SUCCESS)
 			nbOk++;
 	}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
