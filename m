Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E014C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 06:44:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC16A3C759A
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 08:44:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9C53C2917
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 08:44:03 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 271721400BDF
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 08:43:59 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axr+InGM1i9rgYAA--.55838S2; 
 Tue, 12 Jul 2022 14:43:54 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jul 2022 14:43:49 +0800
Message-Id: <1657608229-6189-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ysu+mbkO8eUP4A2+@pevik>
References: <Ysu+mbkO8eUP4A2+@pevik>
X-CM-TRANSID: AQAAf9Axr+InGM1i9rgYAA--.55838S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Ar4DArW8trW3Xr1rCrg_yoW5GFyxpF
 ya9ayjkFZ7Wr1UAr47Ars5Gr1rCF97XF1jkr4rAr4xur9Fk3s8Xa1jvF10vF1UKr47GryU
 Ar4rC3Z5W3WDAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] rpc01: fix variable not initialized
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
Cc: libtirpc-devel@lists.sourceforge.net, ltp@lists.linux.it,
 Steve Dickson <steved@redhat.com>, Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

when error occurred in function callrpc/clnt_call, return_buffer may
be leaved not initialized.
As Petr said, we should check the return value before retrieve the
return_buffer->data. Change do_compare's parameter from char * to
struct data * to fix it.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/network/rpc/basic_tests/rpc01/rpc1.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
index bc9f35b..6b8619d 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -18,7 +18,8 @@ char *file_name = NULL;
 char host_name[100];
 long host_address;
 
-void do_compare(int, char *, struct data *, char *);
+void do_compare(int rpc_rc, char *msg, struct data *buffer,
+			struct data *ret_buffer)
 void usage_error(char *program_name);
 
 int main(int argc, char *argv[])
@@ -128,7 +129,7 @@ int main(int argc, char *argv[])
 	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
 			(char *)&buffer, (xdrproc_t)xdr_receive_data,
 			(char *)&return_buffer);
-	do_compare(rc, "callrpc", &buffer, return_buffer->data);
+	do_compare(rc, "callrpc", &buffer, return_buffer);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
@@ -145,7 +146,7 @@ int main(int argc, char *argv[])
 				(char *)&buffer, (xdrproc_t)xdr_receive_data,
 				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "udp transport", &buffer, return_buffer->data);
+	do_compare(rc, "udp transport", &buffer, return_buffer);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
@@ -160,12 +161,13 @@ int main(int argc, char *argv[])
 				(char *)&buffer, (xdrproc_t)xdr_receive_data,
 				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
+	do_compare(rc, "tcp transport", &buffer, return_buffer);
 
 	exit(0);
 }
 
-void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
+void do_compare(int rpc_rc, char *msg, struct data *buffer,
+			struct data *ret_buffer)
 {
 	int rc;
 
@@ -175,7 +177,7 @@ void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
 		printf("\n");
 		exit(1);
 	}
-	rc = memcmp(buffer->data, ret_data, buffer->data_length);
+	rc = memcmp(buffer->data, ret_buffer->data, buffer->data_length);
 	if (rc) {
 		printf("Data compare for %s returned %d\n", msg, rc);
 		exit(1);
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
