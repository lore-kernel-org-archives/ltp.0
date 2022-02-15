Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0CCC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 15:16:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 518893CA05F
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 16:16:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AAF23C9EEA
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 16:16:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7AF5C60162D
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 16:16:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2CFB1F382;
 Tue, 15 Feb 2022 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644938199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3o0wo9FCPJX3gTpX8vvZO9qoV7VChtt/PUL2pVlLBM4=;
 b=I3y0SFW02wFUkX/haphlNq2P+tn94sqwWUvJBN9te3Qvay8jbpyWVC0LjKWsQrg0BNdSPP
 e1IWZjZadNr38Oor6Z4Iij3F8Dy+nXi/empz54eR/hWdNMQGMk3H7P5CEVhW/EeCKFPmh1
 L+mWW6KkyxiljQ7EFbGs5eaHgtbqYkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644938199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3o0wo9FCPJX3gTpX8vvZO9qoV7VChtt/PUL2pVlLBM4=;
 b=Y6Q42ZfP98dMe4fXFFMPOnuzCv/CV0JPd7RKxnXvI5XnM1rxKfCPwp18ie+qZynnST6Uzc
 TtAaKuEiuQLcNcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C1DD13C9F;
 Tue, 15 Feb 2022 15:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GnnGJNfDC2JCPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 15 Feb 2022 15:16:39 +0000
Date: Tue, 15 Feb 2022 16:16:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgvDzjjXLt5I4sk1@rei>
References: <20220211143901.31087-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220211143901.31087-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite process_vm_readv03.c test with new LTP
 API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor changes, thanks.

The most important change was that fix for a memory leak in the run()
function that would cause problems with large enough -i parameter.

I also hardcoded the maximal number of iovecs instead of using whatever
is the system limit.

Full diff:

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index d6945fb7d..4caafe867 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -13,7 +13,7 @@
  * the remote iovecs initialized to the original process memory
  * locations and the local iovecs initialized to randomly sized and
  * allocated local memory locations. The second child then verifies
- * that the data copied is correct.
+ * that the data is copied correctly.
  */
 
 #include <stdio.h>
@@ -23,6 +23,8 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
+#define MAX_IOVECS 1024
+
 static struct tcase {
 	int bufsize;
 	int remote_iovecs;
@@ -48,18 +50,16 @@ static struct tcase {
 };
 
 static char **data_ptr;
-static long max_iovec;
 
 static void create_data_size(int *arr, int arr_sz, int buffsize)
 {
-	long bufsz_left, bufsz_single;
+	long bufsz_left;
 	int i;
 
 	bufsz_left = buffsize;
 	for (i = 0; i < arr_sz - 1; i++) {
-		bufsz_single = rand() % ((bufsz_left / 2) + 1);
-		arr[i] = bufsz_single;
-		bufsz_left -= bufsz_single;
+		arr[i] = rand() % ((bufsz_left / 2) + 1);
+		bufsz_left -= arr[i];
 	}
 
 	arr[arr_sz - 1] = bufsz_left;
@@ -80,12 +80,12 @@ static void child_alloc(const int *sizes, int nr_iovecs)
 		}
 	}
 
-	tst_res(TINFO, "child 0: memory allocated and initialized");
+	tst_res(TINFO, "child_alloc: memory allocated and initialized");
 
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 }
 
-static void child_invoke(const int *sizes, int local_iovecs, int remote_iovecs,
+static void child_read(const int *sizes, int local_iovecs, int remote_iovecs,
 			 pid_t pid_alloc, int buffsize)
 {
 	struct iovec local[local_iovecs];
@@ -93,7 +93,7 @@ static void child_invoke(const int *sizes, int local_iovecs, int remote_iovecs,
 	int i, j;
 	int count;
 	int nr_error;
-	int *local_sizes;
+	int local_sizes[local_iovecs];
 	unsigned char expect, actual;
 
 	for (i = 0; i < remote_iovecs; i++) {
@@ -101,17 +101,17 @@ static void child_invoke(const int *sizes, int local_iovecs, int remote_iovecs,
 		remote[i].iov_len = sizes[i];
 	}
 
-	local_sizes = SAFE_MALLOC(local_iovecs * sizeof(int));
 	create_data_size(local_sizes, local_iovecs, buffsize);
 	for (i = 0; i < local_iovecs; i++) {
 		local[i].iov_base = SAFE_MALLOC(local_sizes[i]);
 		local[i].iov_len = local_sizes[i];
 	}
 
-	tst_res(TINFO, "child 1: reading string from same memory location");
+	tst_res(TINFO, "child_read: reading string from same memory location");
 
 	TST_EXP_POSITIVE(tst_syscall(__NR_process_vm_readv, pid_alloc, local,
-				     local_iovecs, remote, remote_iovecs, 0UL));
+				     local_iovecs, remote, remote_iovecs, 0UL),
+			 "process_vm_read()");
 
 	if (TST_RET != buffsize) {
 		tst_brk(TBROK, "process_vm_readv: expected %d bytes but got %ld",
@@ -132,24 +132,23 @@ static void child_invoke(const int *sizes, int local_iovecs, int remote_iovecs,
 	}
 
 	if (nr_error)
-		tst_brk(TFAIL, "child 1: %d incorrect bytes received", nr_error);
+		tst_brk(TFAIL, "child_read: %d incorrect bytes received", nr_error);
 	else
-		tst_res(TPASS, "child 1: all bytes are correctly received");
+		tst_res(TPASS, "child_read: all bytes are correctly received");
 }
 
 static void setup(void)
 {
 	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
-	max_iovec = sysconf(_SC_IOV_MAX);
-	data_ptr = SAFE_MMAP(NULL, sizeof(void *) * max_iovec, PROT_READ | PROT_WRITE,
+	data_ptr = SAFE_MMAP(NULL, sizeof(void *) * MAX_IOVECS, PROT_READ | PROT_WRITE,
 			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
 static void cleanup(void)
 {
 	if (data_ptr)
-		SAFE_MUNMAP(data_ptr, sizeof(void *) * max_iovec);
+		SAFE_MUNMAP(data_ptr, sizeof(void *) * MAX_IOVECS);
 }
 
 static void run(unsigned int i)
@@ -158,14 +157,13 @@ static void run(unsigned int i)
 	int remote_iovecs = testcases[i].remote_iovecs;
 	int local_iovecs = testcases[i].local_iovecs;
 	pid_t pid_alloc;
-	pid_t pid_invoke;
+	pid_t pid_read;
 	int status;
-	int *sizes;
+	int sizes[remote_iovecs];
 
 	tst_res(TINFO, "bufsize=%d, remote_iovecs=%d, local_iovecs=%d", bufsize,
 		remote_iovecs, local_iovecs);
 
-	sizes = SAFE_MALLOC(remote_iovecs * sizeof(int));
 	create_data_size(sizes, remote_iovecs, bufsize);
 
 	pid_alloc = SAFE_FORK();
@@ -176,19 +174,17 @@ static void run(unsigned int i)
 
 	TST_CHECKPOINT_WAIT(0);
 
-	pid_invoke = SAFE_FORK();
-	if (!pid_invoke) {
-		child_invoke(sizes, local_iovecs, remote_iovecs, pid_alloc, bufsize);
+	pid_read = SAFE_FORK();
+	if (!pid_read) {
+		child_read(sizes, local_iovecs, remote_iovecs, pid_alloc, bufsize);
 		return;
 	}
 
-	SAFE_WAITPID(pid_invoke, &status, 0);
+	SAFE_WAITPID(pid_read, &status, 0);
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-		tst_res(TFAIL, "child 1: returns %s", tst_strstatus(status));
+		tst_res(TFAIL, "child_read: %s", tst_strstatus(status));
 
 	TST_CHECKPOINT_WAKE(0);
-
-	SAFE_WAITPID(pid_alloc, &status, 0);
 }
 
 static struct tst_test test = {
@@ -198,5 +194,4 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.tcnt = ARRAY_SIZE(testcases),
-	.min_kver = "2.0",
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
