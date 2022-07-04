Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ADFC43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 12:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4CB3CA00A
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 14:08:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3FE73C6AD5
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 14:08:13 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 6FCA01400180
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 14:08:10 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCeEh2MJiQJAIAA--.26177S2; 
 Mon, 04 Jul 2022 20:08:06 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>,
 Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  4 Jul 2022 20:08:00 +0800
Message-Id: <1656936480-34980-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9AxCeEh2MJiQJAIAA--.26177S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17tFW8KFyDXFWDCrWrGrg_yoW8ury3pF
 4S9FWUCrWvgr15Ar4UArZ5Wr4YyF93Xr1j9rWrAwn7ur9FkryrXa10vFWvq3WYkrW7GryU
 Zr45Gan5u3WDAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rpc01: fix variable not initialized
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
Cc: ltp@lists.linux.it, Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

when error occurred in function callrpc/clnt_call, return_buffer may
be leaved not initialized.So initialize return_buffer to NULL,and
retrieve the return_buffer->data when return_buffer is really assigned.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/network/rpc/basic_tests/rpc01/rpc1.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
index bc9f35b..5691c06 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -24,7 +24,7 @@ void usage_error(char *program_name);
 int main(int argc, char *argv[])
 {
 	struct hostent *hp;
-	struct data buffer, *return_buffer;
+	struct data buffer, *return_buffer = NULL;
 	int i, n, rc;
 	FILE *fp;
 	struct stat stat_buffer;
@@ -128,7 +128,8 @@ int main(int argc, char *argv[])
 	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
 			(char *)&buffer, (xdrproc_t)xdr_receive_data,
 			(char *)&return_buffer);
-	do_compare(rc, "callrpc", &buffer, return_buffer->data);
+	do_compare(rc, "callrpc", &buffer,
+				return_buffer ? return_buffer->data : NULL);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
@@ -145,7 +146,8 @@ int main(int argc, char *argv[])
 				(char *)&buffer, (xdrproc_t)xdr_receive_data,
 				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "udp transport", &buffer, return_buffer->data);
+	do_compare(rc, "udp transport", &buffer,
+				return_buffer ? return_buffer->data : NULL);
 
 	server_sin.sin_port = 0;
 	sock = RPC_ANYSOCK;
@@ -160,7 +162,8 @@ int main(int argc, char *argv[])
 				(char *)&buffer, (xdrproc_t)xdr_receive_data,
 				(char *)&return_buffer, timeout);
 	clnt_destroy(clnt);
-	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
+	do_compare(rc, "tcp transport", &buffer,
+				return_buffer ? return_buffer->data : NULL);
 
 	exit(0);
 }
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
