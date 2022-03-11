Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290E1C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 05:46:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CFAE3C8AAF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 06:46:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55F263C0CEA
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67F7B200FC6
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646977571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d37O9e5Td7eN4xtO0PEOKH3+Cig5HCgeAtgEKsBuw9M=;
 b=Q4o8Wp7NgKb7xGzHO4BuwN7VyIzaNKBVktRNCkqsOEErzieE+wVze0JyyZDSm5BhpfodmG
 84RGCkd3XkZx94E/cdqIuiqCcdpZImZsRfORrA2ODyevLapmcKzU7SdeG2Wdk5CIRPxKP7
 ggE3Iwa+5fLm88FfqIaAZqoIhWb9MFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-1FVaX3blN6-k6ZZ1U3U0gg-1; Fri, 11 Mar 2022 00:46:10 -0500
X-MC-Unique: 1FVaX3blN6-k6ZZ1U3U0gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D0051E0
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:09 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 480E6108D4
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:07 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 13:46:01 +0800
Message-Id: <20220311054603.57328-2-liwang@redhat.com>
In-Reply-To: <20220311054603.57328-1-liwang@redhat.com>
References: <20220311054603.57328-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] include: replace min/max macro by the new
 definition
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/ipcmsg.h                                      | 2 --
 include/libnewipc.h                                   | 1 -
 testcases/kernel/mem/mmapstress/mmapstress01.c        | 3 +--
 testcases/kernel/mem/mmapstress/mmapstress09.c        | 1 -
 testcases/kernel/mem/mmapstress/mmapstress10.c        | 3 +--
 testcases/kernel/security/cap_bound/cap_bounds_r.c    | 3 +--
 testcases/kernel/security/cap_bound/cap_bounds_rw.c   | 7 +++----
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress02.c | 2 +-
 9 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/ipcmsg.h b/include/ipcmsg.h
index d89894b72..3b3fa32c0 100644
--- a/include/ipcmsg.h
+++ b/include/ipcmsg.h
@@ -43,8 +43,6 @@ void setup(void);
 
 #define NR_MSGQUEUES	16	/* MSGMNI as defined in linux/msg.h */
 
-#define min(a, b)	(((a) < (b)) ? (a) : (b))
-
 typedef struct mbuf {		/* a generic message structure */
 	long mtype;
 	char mtext[MSGSIZE + 1];  /* add 1 here so the message can be 1024   */
diff --git a/include/libnewipc.h b/include/libnewipc.h
index 9eec31763..1e126ca1c 100644
--- a/include/libnewipc.h
+++ b/include/libnewipc.h
@@ -31,7 +31,6 @@
 #define MSGSIZE	1024
 #define MSGTYPE	1
 #define NR_MSGQUEUES	16
-#define min(a, b)	(((a) < (b)) ? (a) : (b))
 
 #define SEM_RD	0400
 #define SEM_ALT	0200
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 3b4b1ac24..c16b50a6d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -95,7 +95,6 @@ void ok_exit();
 #undef roundup
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
-#define min(x, y)	(((x) < (y)) ? (x) : (y))
 
 extern time_t time(time_t *);
 extern char *ctime(const time_t *);
@@ -311,7 +310,7 @@ int main(int argc, char *argv[])
 		anyfail();
 	}
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = min(pagesize, bytes_left);
+		write_cnt = MIN(pagesize, bytes_left);
 		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
 			if (c == -1) {
 				perror("write error");
diff --git a/testcases/kernel/mem/mmapstress/mmapstress09.c b/testcases/kernel/mem/mmapstress/mmapstress09.c
index 2c710df1e..0a8da0006 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress09.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress09.c
@@ -78,7 +78,6 @@ void ok_exit();
 #undef roundup
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
-#define min(x, y)	(((x) < (y)) ? (x) : (y))
 
 extern time_t time(time_t *);
 extern char *ctime(const time_t *);
diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
index 26ea98bc1..28b4f1e91 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -106,7 +106,6 @@ void ok_exit();
 #undef roundup
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
-#define min(x, y)	(((x) < (y)) ? (x) : (y))
 
 #define SIZE_MAX UINT_MAX
 
@@ -361,7 +360,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = min(pagesize, bytes_left);
+		write_cnt = MIN(pagesize, bytes_left);
 		if ((c = write(fd, (char *)buf, write_cnt)) != write_cnt) {
 			if (c == -1) {
 				perror("write error");
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
index d7c2bf0ae..28f320fd9 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -85,9 +85,8 @@ int main(void)
 	 * We could test using kernel API, but that's what we're
 	 * testing...  So let's take an insanely high value */
 #define INSANE 63
-#define max(x,y) (x > y ? x : y)
 #if HAVE_DECL_PR_CAPBSET_READ
-	ret = prctl(PR_CAPBSET_READ, max(INSANE, CAP_LAST_CAP + 1));
+	ret = prctl(PR_CAPBSET_READ, MAX(INSANE, CAP_LAST_CAP + 1));
 #else
 	errno = ENOSYS;
 	ret = -1;
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index 503853c5b..a0d2111d6 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -115,18 +115,17 @@ int main(void)
 	 * We could test using kernel API, but that's what we're
 	 * testing...  So let's take an insanely high value */
 #define INSANE 63
-#define max(x,y) (x > y ? x : y)
 #if HAVE_DECL_PR_CAPBSET_DROP
-	ret = prctl(PR_CAPBSET_DROP, max(INSANE, CAP_LAST_CAP + 1));
+	ret = prctl(PR_CAPBSET_DROP, MAX(INSANE, CAP_LAST_CAP + 1));
 #else
 	errno = ENOSYS;
 	ret = -1;
 #endif
 	if (ret != -1) {
 		tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, %d) returned %d",
-			 max(INSANE, CAP_LAST_CAP + 1), ret);
+			 MAX(INSANE, CAP_LAST_CAP + 1), ret);
 		tst_resm(TINFO, " %d is should not exist",
-			 max(INSANE, CAP_LAST_CAP + 1));
+			 MAX(INSANE, CAP_LAST_CAP + 1));
 		tst_exit();
 	}
 	for (i = 0; i <= cap_last_cap; i++) {
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 0a660c042..84e338437 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -280,7 +280,7 @@ void setup(void)
 	 * that are not necessary for this test.
 	 * That's why we define NR_MSGQUEUES as a high boundary for it.
 	 */
-	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
+	MSGMNI = MIN(nr_msgqs, NR_MSGQUEUES);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index e15131043..a0f894b05 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -385,7 +385,7 @@ void setup(void)
 	 * that are not necessary for this test.
 	 * That's why we define NR_MSGQUEUES as a high boundary for it.
 	 */
-	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
+	MSGMNI = MIN(nr_msgqs, NR_MSGQUEUES);
 }
 
 void cleanup(void)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
