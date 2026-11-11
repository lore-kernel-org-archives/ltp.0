Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5091606A321
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Kn6YDKLg;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EHIlgo3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794389580; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ys2BoJmyj71Vo3O9govSMF2AY1OL0cRIWLqJEek3wlY=;
 b=Kn6YDKLgtEvnVFsQQaPQqGdxblxFiu5LRMJELrlDtXsDmlMY56siKTlSBgfgigBPMxIR8
 NdEvDbWiHV7hqTzeQ/CfBHRgssJBlfbALxLcPHWNcv+18KnonGm5IxGwzFGlI/s3gFMjhuu
 jLe/Hze85e9UC/ij0AKS6MAMTKE1K6M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734283E9503
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBC5B3E94FD
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:31:59 +0100 (CET)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C8B02001C0
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:31:59 +0100 (CET)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so1974287a12.1
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794389517; x=1794994317; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ur7qTbpOkQ8cAftUQ+Rsb5LLO6VvmUdr+ZLuayU9/qI=;
 b=EHIlgo3vcsJ3osKq9oODPb7LITXb0sr8uvnvpHt1RwtHsDaNvhp/+mypjvgulfNxME
 qMecZulwZr376+Vsi3/Ayhv06R0XvpbLr8s24l9extnZMBUVGMhPR0u/6rOGavZ0mfmV
 H0qKgmyE/18XclLktwbqzG7NHeqahdKGHykSjRhSLK3Jl6hahn8saBFRb+tfqJYLeEKK
 LuU1sPsqC+z7oPRUcdS9qz4rpBOzuweWrpzjw79uFoH3eEqhPO6l9y5699u4gKD3/Wg4
 WmDRlcdGx8o2FgwwlrCX31+teC8aMH2OwnsnyhPNNOJBG74ya92MTziZuuKpNEW1tbP3
 0opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389518; x=1794994318;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ur7qTbpOkQ8cAftUQ+Rsb5LLO6VvmUdr+ZLuayU9/qI=;
 b=g+pS8xif2jMVmT32i7GSUTUQMg01sqDlxG4gMY8wEDNAliFduJnWgml4nbe3F7xn4q
 2BqMW+zW3zVeJoCHd5tHQNdus56SVU3WZ2lT41wJ7WvvpnmIRN4agbpBcyNjqMwefoB0
 mrXHewNmPZAi3O/TajkSvzxiuYWSINbSLB4NyuLiff8SYCzOZaZVcfT9VViSV8aADacg
 w4k0/Gz69jHn/w0GckeivNTGxInJmL3GdCdIXtil73UxG35godeRsLFUSDiYAfvJt3R7
 a/EPnZGKWbIK+IUyRrWhvuc7xvo/1qrOtH4PcvdWZa3PiO94awiMRnFfM0uy56EHuEca
 mO1w==
X-Gm-Message-State: APuU4Z8qd7sjsZSc6dFHlIWfMVYQZLilZXisRZYwk5mh26I0afqnHEL+
 SIsQje4EY7ulV816oYiP6Ewh4gvcC4JaliyLS+I7Vavg7ye9WocN5qU+QZmTN9g8ov4p/X6phtJ
 YynPp2l6xAPqMzXOTZIpe2RPlLc8bW33MJqsHmn9qjqzp0hgykd+DT4DKsBO8xKaM2I+Ij+woCQ
 4FLuvks1KKur+Kc7lb6nE73gsAQg==
X-Received: from pgaa12-n2.prod.google.com
 ([2002:a05:6a02:648c:20b0:cda:e9be:9294])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:914e:b0:3e2:4a46:7ea1
 with SMTP id adf61e73a8af0-3f3000bbe2dmr1945844637.66.1794389517273; Wed, 11
 Nov 2026 01:31:57 -0800 (PST)
Date: Wed, 11 Nov 2026 09:31:48 +0000
In-Reply-To: <20261111093151.374731-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111093151.374731-2-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH 1/4] epoll_wait06,
 fcntl35: Don't assume a pipe buffer is getpagesize()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A pipe consists of pipe buffers of one kernel page each, but both tests
assume that a pipe buffer is getpagesize() bytes.

epoll_wait06 sets the pipe capacity to getpagesize() and expects the
pipe to consist of a single buffer, so that reading half of the data
does not release a buffer and raise EPOLLOUT. fcntl35 expects the
default capacity of a pipe created by a privileged user, which is 16
pipe buffers (PIPE_DEF_BUFFERS), to be 16 * getpagesize().

Neither holds when the kernel reports a larger page size to userspace
than it uses internally, as with the 16K page size emulation that
Android uses on x86_64. There the pipe of epoll_wait06 consists of four
4K buffers, reading half of the data releases two of them, and the
test fails with:

  TFAIL: SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0) (1) != 0 (0)

fcntl35 gets a default capacity of 65536 bytes instead of the expected
262144.

Get the size of a pipe buffer from the kernel instead, by shrinking a
pipe to its minimum capacity with F_SETPIPE_SZ. The unprivileged case
of fcntl35 needs no change, as setting pipe-max-size to getpagesize()
still caps the capacity at getpagesize() bytes. Nothing changes on
kernels where both page sizes are equal.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 15 +++++++++-----
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 20 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
index 622830d55..ce4e2d5bc 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -32,13 +32,18 @@ static int epfd;
 
 static void setup(void)
 {
-	write_size = getpagesize();
-	read_size = write_size / 2;
-
 	SAFE_PIPE2(fds, O_NONBLOCK);
 
-	/* EPOLLOUT will be raised when buffer became empty after becoming full */
-	SAFE_FCNTL(fds[1], F_SETPIPE_SZ, write_size);
+	/*
+	 * EPOLLOUT will be raised when buffer became empty after becoming full.
+	 *
+	 * Shrink the pipe to its minimum capacity, which is a single pipe
+	 * buffer, so that reading only half of the data doesn't release any
+	 * buffer. Use the capacity reported by the kernel rather than
+	 * assuming it matches getpagesize().
+	 */
+	write_size = SAFE_FCNTL(fds[1], F_SETPIPE_SZ, 1);
+	read_size = write_size / 2;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index d17812fd0..a240500d4 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -44,10 +44,28 @@ static struct tcase {
 	{&test_max_priv, 0, "a privileged user"}
 };
 
+/*
+ * The pipe capacity is a multiple of the size of a pipe buffer, which is one
+ * page of the kernel. Get it by shrinking a pipe to its minimum capacity,
+ * rather than assuming it matches getpagesize().
+ */
+static int get_pipe_buf_size(void)
+{
+	int fds[2], size;
+
+	SAFE_PIPE(fds);
+	size = SAFE_FCNTL(fds[1], F_SETPIPE_SZ, 1);
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
+
+	return size;
+}
+
 static void setup(void)
 {
 	test_max_unpriv = getpagesize();
-	test_max_priv = test_max_unpriv * 16;
+	/* The default capacity is 16 pipe buffers (PIPE_DEF_BUFFERS) */
+	test_max_priv = get_pipe_buf_size() * 16;
 
 	if (!access(PATH_FS_PIPE_MAX_SIZE, F_OK)) {
 		SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_SIZE, "%d", &pipe_max_unpriv);
-- 
2.56.0.567.gdb80ae8cd5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
