Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C0AD1CDA0
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 06:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729577634; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=jG7yfgXsNrxDG8jpHQ3plwem51hGH8wACSlIJit1NHI=;
 b=YRPP1yVJoHGacOFoRt5LDrSzmTLQUHphctj1gv8V1sPPqg/rtLjQ6A8eOVikNLRsTI+0w
 DLY4KyOs6LVoGS8og1bKJEVMRwNKr+8uTC8g5UX966W6bu+WpFOCsnHQ5uzXMdgt28w6Dcg
 gWkHo26I4UQI4sNfU/OaOhgy0VkXJHg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 699343C6F80
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 08:13:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84B3D3C6A20
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 08:13:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FE1B619286
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 08:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1729577611; x=1761113611;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hj7tpSr8E0CmJQBeUo6NCAUeHVUPfy+I6vSwJG3B7AQ=;
 b=fmGxGc1HzLh4mQNeqekTeMD6HGZ2CulOzN+8fzmMHpuTs2B0oPxoo+Aq
 sHupWQKV+r+MqkViBB0cnuLGk3IDKUZ6CWAEra0gXYjt5QRpIy7cJJjJE
 CS4bDv7bjDe8O/5OS0VguReosXVl/vd++uDZGoIPW4UOiYqxlXkYrYQQ/
 QJnVzATVKGraVgXqUmE9aR+527WSlvGlPfZjcL+slM8xf7fKeKLC8yhDp
 h0hhrx3TAp76VUCbaxuJ2OTaovtx6ItjvyBGNgeyzRRVwMYebdRbW1qDp
 gRp93ya7IRg0bIQXsrNEbe05WH9q9DrZRKFH+Drp3MYfDuerKtstXHEHV w==;
X-CSE-ConnectionGUID: YdFpK+42QpGN18oj7h3i5Q==
X-CSE-MsgGUID: 2KTHSbTpST6cpH8IpODIxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="156980380"
X-IronPort-AV: E=Sophos;i="6.11,222,1725289200"; d="scan'208";a="156980380"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 15:13:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EF67D4F57
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:13:25 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 82813CF7CB
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:13:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D8BF220071A23
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:13:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 33A311A000B;
 Tue, 22 Oct 2024 14:13:23 +0800 (CST)
To: ltp@lists.linux.it, chuck.lever@oracle.com, chenhx.fnst@fujitsu.com,
 pvorel@suse.cz
Date: Tue, 22 Oct 2024 14:14:33 +0800
Message-ID: <20241022061434.2610583-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28746.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28746.005
X-TMASE-Result: 10--10.887600-10.000000
X-TMASE-MatchedRID: oLtLGnXlbAEvKBNTYKG+pUrOO5m0+0gETJDl9FKHbrnQEElETurAJS2I
 CLwE7H6Xjx5X3FdI4UAEzNy+qeySxJfPkHar3hvdlXePXNM4FjOBs03RHrzjMyIIO0VwKeOLr9Y
 /9i+8T9Yd99HV0jpzz4UKVJyLQPFLtMT1y9P9VbJB9I5g6XEpi6scWEcqpe5LzBnz0ZuJSWdjGq
 ZxQuvF5sIuTCoy+YItNOJYLkLWx//lRxm3A2wKuhRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7hE4h
 WqTrQd8TqkeuGzRSKzvTU07Ctl6b0640xWoLTEmsBTJSD2iAW0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clnt_create: Determine the return value of
 clnt_create()
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

Determine the return value of clnt_create() to avoid segmentation fault
when executing clnt_destroy() when the return value of create is NULL.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../rpc/rpc_createdestroy_clnt_create/rpc_clnt_create.c    | 7 +++++++
 .../rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c | 6 ++++++
 .../rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy.c  | 7 +++++++
 .../rpc_clnt_destroy_stress.c                              | 5 +++++
 .../rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror.c  | 7 +++++++
 .../rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno.c    | 7 +++++++
 .../rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror.c    | 7 +++++++
 .../rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror.c    | 7 +++++++
 .../rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno.c  | 7 +++++++
 .../rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror.c  | 7 +++++++
 .../rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c    | 7 +++++++
 .../rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c          | 7 +++++++
 .../rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c      | 7 +++++++
 .../rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c    | 7 +++++++
 .../rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c      | 7 +++++++
 .../rpc/rpc_stdcall_clnt_control/rpc_clnt_control.c        | 7 +++++++
 .../rpc_stdcall_clnt_control/rpc_clnt_control_dataint.c    | 7 +++++++
 .../rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr.c          | 7 +++++++
 .../tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c  | 7 +++++++
 .../tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c        | 7 +++++++
 .../tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c        | 7 +++++++
 .../tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c      | 7 +++++++
 .../tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c   | 7 +++++++
 .../tirpc_clnt_create_timed.c                              | 7 +++++++
 24 files changed, 165 insertions(+)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create.c
index 98793c640..8578d943c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create.c
@@ -52,6 +52,13 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode == 1) {
 		printf("CLIENT : %p\n", clnt);
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c
index 58f55d71e..c5780d629 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress.c
@@ -59,6 +59,12 @@ int main(int argn, char *argc[])
 
 		if (clnt != NULL)
 			nbOk++;
+		else {
+			clnt_pcreateerror("err");
+			printf("%d\n", rpc_createerr.cf_stat);
+
+			return 1;
+		}
 	}
 
 	if (run_mode == 1) {
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy.c
index f10f15d9b..85c0d5fe6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy.c
@@ -48,6 +48,13 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call destroy macro
 	clnt_destroy(clnt);
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy_stress.c
index 9fef30f6b..ba5324c18 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy_stress.c
@@ -56,6 +56,11 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	for (i = 0; i < nbCall; i++) {
 		clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
+		if (clnt == NULL) {
+			clnt_pcreateerror("err");
+			printf("%d\n", rpc_createerr.cf_stat);
+			return 1;
+		}
 		clnt_destroy(clnt);
 		nbOk++;
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror.c
index 0aaa50c27..03756cf7e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror.c
@@ -49,6 +49,13 @@ int main(int argn, char *argc[])
 
 	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	clnt_pcreateerror("#SUCCESS");
 
 	//If we are here, test has passed
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno.c
index 489c6c8b6..a881a4a09 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno.c
@@ -65,6 +65,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror.c
index 74c6201d3..ddf2ec441 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror.c
@@ -65,6 +65,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_void, NULL,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror.c
index 65e68dae6..a85e87787 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror.c
@@ -50,6 +50,13 @@ int main(int argn, char *argc[])
 
 	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	rslt = clnt_spcreateerror("#SUCCESS");
 
 	//If we are here, test has passed
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno.c
index 1e74c39a3..728f35a97 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno.c
@@ -66,6 +66,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror.c
index fc10f9e04..de4734579 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror.c
@@ -66,6 +66,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_void, NULL,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
index 50232a91a..34b1b2bf9 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth.c
@@ -62,6 +62,13 @@ int main(int argn, char *argc[])
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call AuthErr RP */
 
+	if (client == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	cs = clnt_call(client, PROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&var_snd,
 		       (xdrproc_t) xdr_int, (char *)&var_snd, tv);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
index 3f9ea9142..4483fb6ab 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc.c
@@ -65,6 +65,13 @@ int main(int argn, char *argc[])
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (client == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	cs = clnt_call((CLIENT *) client, PROCNUM, (xdrproc_t) xdr_int, (char *)&var_snd,	// xdr_in
 		       (xdrproc_t) xdr_int, (char *)&var_snd,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
index 8fa54d9f0..9dfc65431 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers.c
@@ -62,6 +62,13 @@ int main(int argn, char *argc[])
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call wrong version RP */
 
+	if (client == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	cs = clnt_call(client, PROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&var_snd,
 		       (xdrproc_t) xdr_int, (char *)&var_snd, tv);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
index 2a45f5055..17546fe0a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr.c
@@ -62,6 +62,13 @@ int main(int argn, char *argc[])
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call SysErr RP */
 
+	if (client == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	cs = clnt_call(client, PROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&var_snd,
 		       (xdrproc_t) xdr_int, (char *)&var_snd, tv);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
index 563b11a36..a9dd71b5d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth.c
@@ -62,6 +62,13 @@ int main(int argn, char *argc[])
 
 	client = clnt_create(argc[1], progNum, VERSNUM, nettype);	/* Call WeakAuthErr RP */
 
+	if (client == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	cs = clnt_call(client, PROCNUM,
 		       (xdrproc_t) xdr_int, (char *)&var_snd,
 		       (xdrproc_t) xdr_int, (char *)&var_snd, tv);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control.c
index 0b37585ec..91d087141 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control.c
@@ -53,6 +53,13 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode == 1) {
 		printf("CLIENT : %p\n", clnt);
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control_dataint.c
index 3616d652c..10de96e10 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control_dataint.c
@@ -54,6 +54,13 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode) {
 		printf("CLIENT : %p\n", clnt);
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr.c
index 9bbce26af..d0505e623 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr.c
@@ -53,6 +53,13 @@ int main(int argn, char *argc[])
 	//First of all, create a client
 	clnt = clnt_create(argc[1], progNum, VERSNUM, proto);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode == 1) {
 		printf("CLIENT : %p\n", clnt);
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
index 029d158ff..81bf37e36 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror.c
@@ -50,6 +50,13 @@ int main(int argn, char *argc[])
 
 	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	clnt_pcreateerror("#SUCCESS");
 
 	//If we are here, test has passed
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
index a1b16416a..c3ec08887 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno.c
@@ -65,6 +65,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_void, NULL,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
index 445ecfd32..8a8cdf238 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror.c
@@ -65,6 +65,13 @@ int main(int argn, char *argc[])
 	    //First of all, create client using top level API
 	    clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Then call remote procedure
 	rslt = clnt_call((CLIENT *) clnt, PROCNUM, (xdrproc_t) xdr_void, NULL,	// xdr_in
 			 (xdrproc_t) xdr_int, (char *)&recVar,	// xdr_out
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
index e363e00b9..a97bbfa17 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex.c
@@ -64,6 +64,13 @@ int main(int argn, char *argc[])
 	total_timeout.tv_usec = 1;
 	/**/ clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	//Multiple test case
 	rslt = rpc_call(argc[1], progNum, VERSNUM, PROCNUM,
 			(xdrproc_t) xdr_int, (char *)&sndVar,
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
index eaca14747..6a9aae6c0 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create.c
@@ -57,6 +57,13 @@ int main(int argn, char *argc[])
 	}
 	clnt = clnt_create(argc[1], progNum, VERSNUM, nettype);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode == 1) {
 		printf("Client after creation : %p\n", clnt);
 	}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
index 43df4d95f..8723ca8c8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed.c
@@ -62,6 +62,13 @@ int main(int argn, char *argc[])
 
 	clnt = clnt_create_timed(argc[1], progNum, VERSNUM, nettype, &tv);
 
+	if (clnt == NULL) {
+		clnt_pcreateerror("err");
+		printf("%d\n", rpc_createerr.cf_stat);
+
+		return 1;
+	}
+
 	if (run_mode == 1) {
 		printf("Client after creation : %p\n", clnt);
 	}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
