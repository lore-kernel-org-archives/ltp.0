Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300F9C77B61
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 09:12:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D25B23CBBF7
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 11:12:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C2E3CBBB7
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 11:12:27 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7FDA60029B
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 11:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1682413945; i=@fujitsu.com;
 bh=Ey8S9ScajM7+YtnSGDZ7t/W2P8bi+naNgLO2loKezpE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=d9/8BZKquARVIwQ5N8TSriPIt/8kdh8dTX42b9rhQe7NxCX6WDTtvuKdXZkVoqWS/
 VTmv0fGKQ2rMal6W7s0r2MgdEfI1IFoSFdMsXeM5CaoJYEPmt8181OT0xIJIorW0vn
 wXW7WEFDs+O6t/cJDIuHfmsfs7CruMqL4/DM1KK+6R0UPADevrOUv1zTycHzOABdWU
 h+tm7mm/LvbtRes1u24IYsDshkLx9v6CTony08lwSOpi4Zx/+CrUkIG4CttA28S9Pg
 E47NC76iEQXALss6CWVwpvdwWx6mcT6IyYoCmyBRy57WOag24oAJzhOhc2i+VyBEeO
 ds7f5kn21hL/Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORpFsx0z3
 FoHeNmcWK7zsYHRg99v1exxrAGMWamZeUX5HAmnH30x/Wgj6eirNrtzA3MF7j6mLk4hASOMUo
 sfZ4KxuEs5dJ4vGZCVDOPkaJW0svsnYxcnKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC4RKPGw9BRZnEVCV+HF0LZDNwcEr4CnR88oPJCwhoCAx5eF7sDGcAl4Sb7bvBhsvBFTy59
 o+RhCbV0BQ4uTMJywQ4yUkDr54wQzRqyTR1nqFFcKulGj98IsFwlaTuHpuE/MERsFZSNpnIWl
 fwMi0itG8OLWoLLVI19BUL6koMz2jJDcxM0cvsUo3US+1VDcvv6gkQ9dQL7G8WC+1uFivuDI3
 OSdFLy+1ZBMjMHxTipODdzCu3vVX7xCjJAeTkigvV5hbihBfUn5KZUZicUZ8UWlOavEhRhkOD
 iUJXtdp7ilCgkWp6akVaZk5wFiCSUtw8CiJ8Ia0AqV5iwsSc4sz0yFSpxh1OT6+nHqQWYglLz
 8vVUqcN2E6UJEASFFGaR7cCFhcX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzDtvBtAUnsy
 8ErhNr4COYAI6Yhe3C8gRJYkIKakGpuPnfER/p85+cl3s2KbjUx73JTd9KfZ9oslgevS3mtYS
 Tr3v+QvWck2XvrOtbJUJ57V18ZfXujhyLpm+bbVOXPSruyEped96WF/qNuRpCd9d2PMiyfSOB
 6fwT6EQfoFXR13+rdRfvVgtO9JGSS8myf7iynt8GerB4uE/LTW+arjYM2VvXSjZxvlBdcaVwO
 xzT35Zu33ov+Nz4JLpydBdARJJu7WyU/fXht7Uqe1Jyr7Cd3uHtl1cl8mm2SJe+wqvHt67enq
 lYcfXQ2ItmyTDYqet0lq05Kl4bL/BoyNLNQqNC+eFP+LdYHgw2CPP1+5XVccqVV2PnWu+xr06
 vYhvW7rOr1P3ugq5c453zAlJUGIpzkg01GIuKk4EACbvAm5mAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-732.messagelabs.com!1682413944!47204!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6576 invoked from network); 25 Apr 2023 09:12:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-13.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Apr 2023 09:12:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 5001A1C1
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 10:12:24 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 4414A7B
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 10:12:24 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 10:12:22 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 25 Apr 2023 17:12:10 +0800
Message-ID: <1682413930-19764-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] rpc/rpc-tirpc: Fix compile error on clang when
 using registerrpc
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

rpc_registerrpc.c:72:4: error: incompatible function pointer types passing
'bool_t (XDR *, int *)' (aka 'int (struct __rpc_xdr *, int *)') to parameter
of type 'xdrproc_t' (aka 'int (*)(struct __rpc_xdr *, ...)') [-Wincompatible-function-pointer-types]
xdr_int);

the registerrpc declare as below:

int registerrpc(int, int, int, char *(*)(char [UDPMSGSIZE]),
    xdrproc_t, xdrproc_t);

so we should add xdrproc_t cast to avoid this.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
ps: has verified it on my ltp fork.
 .../rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
index 3becf4600..c6f76839c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
@@ -68,8 +68,8 @@ int main(int argn, char *argc[])
 
 	//call routine
 	rslt =
-	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing, xdr_int,
-			xdr_int);
+	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing,
+			(xdrproc_t) xdr_int, (xdrproc_t) xdr_int);
 
 	if (run_mode) {
 		printf("SVC : %p\n", svcr);
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
