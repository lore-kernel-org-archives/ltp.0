Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7DC433EF
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 21:20:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C9B61B9F
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 21:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2C9B61B9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2A363C814D
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 22:20:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A8583C708C
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 22:20:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB3141000A7B
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 22:20:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB1421FD6C;
 Mon, 15 Nov 2021 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637011220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJXj8ivl1Ap4K27SIgrvjVQoC+VPU4TYqELnqJXYkLM=;
 b=sKNRT0j7H8CSoJQ55wpM3PElaSsjXMWqOjvWC4t1q8BGBtKbPAwoBjsYUII5Ez4a82GPeg
 709DkZcnW/gia9YH6nUemBV4O1xTlY9u28iBL+gjJfy3Hqzj9MqS9Tkwd0/ameQ+bTw9sj
 FL82xcVtMU2jExRlI87wcqFkDRucwrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637011220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJXj8ivl1Ap4K27SIgrvjVQoC+VPU4TYqELnqJXYkLM=;
 b=kb3mfeFrp3BU5zSpeMegQkxXr9jpIYeNZ4ULiV1m7E6gfN9Dbbz89rD3jlzxzv11VDSUPa
 9UqmM0SihwN3YnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9651913AE9;
 Mon, 15 Nov 2021 21:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ckU2IhTPkmE4IQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Nov 2021 21:20:20 +0000
Date: Mon, 15 Nov 2021 22:20:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>, Amir Goldstein <amir73il@gmail.com>
Message-ID: <YZLPEjJkII1evtEc@pevik>
References: <cover.1636451496.git.repnop@google.com>
 <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
 <CAOQ4uxiFsnvA-8y1mJ7uHccd4bqZUYJkK5Y2R1+KtgDK_OH4Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiFsnvA-8y1mJ7uHccd4bqZUYJkK5Y2R1+KtgDK_OH4Sw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls/fanotify: Add a helper macro
 which checks for the presence of specific fanotify initialization flag(s)
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Matthew, Amir,

Tested on two distro kernels with support (Tumbleweed and Debian unstable)
+ on various old kernels without support.

Merged with very minor fixes, see diff below.

NOTE: we now support basic static analysis + checkpatch formatting check - run
make check in fanotify directory or make check-fanotify20.

Thanks a lot!

Kind regards,
Petr

diff --git runtest/syscalls runtest/syscalls
index 1e6d46744..d57c73e39 100644
--- runtest/syscalls
+++ runtest/syscalls
@@ -605,6 +605,8 @@ fanotify16 fanotify16
 fanotify17 fanotify17
 fanotify18 fanotify18
 fanotify19 fanotify19
+fanotify20 fanotify20
+fanotify21 fanotify21
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git testcases/kernel/syscalls/fanotify/fanotify20.c testcases/kernel/syscalls/fanotify/fanotify20.c
index 9960d85eb..de0fdb782 100644
--- testcases/kernel/syscalls/fanotify/fanotify20.c
+++ testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -12,6 +12,9 @@
  * returns an expected error code when provided an invalid initialization flag
  * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
  * existing FAN_REPORT_* flags is maintained and functioning as intended.
+ *
+ * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in af579beb666a
+ * ("fanotify: add pidfd support to the fanotify API").
  */
 
 #define _GNU_SOURCE
@@ -39,7 +42,7 @@ static struct test_case_t {
 	},
 	{
 		"pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
-		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME ,
+		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME,
 		0,
 		0,
 	},
diff --git testcases/kernel/syscalls/fanotify/fanotify21.c testcases/kernel/syscalls/fanotify/fanotify21.c
index e842dad17..6ae70c57e 100644
--- testcases/kernel/syscalls/fanotify/fanotify21.c
+++ testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -11,6 +11,9 @@
  * A test which verifies whether the returned struct
  * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
  * expected set of information.
+ *
+ * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in af579beb666a
+ * ("fanotify: add pidfd support to the fanotify API").
  */
 
 #define _GNU_SOURCE
@@ -56,7 +59,7 @@ struct test_case_t {
 
 static int fanotify_fd;
 static char event_buf[BUF_SZ];
-static struct pidfd_fdinfo_t *self_pidfd_fdinfo = NULL;
+static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
 
 static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 {
@@ -158,7 +161,7 @@ static void do_test(unsigned int num)
 	 * buffer.
 	 */
 	len = SAFE_READ(0, fanotify_fd, event_buf, sizeof(event_buf));
-	while(i < len) {
+	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
 		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
@@ -197,7 +200,7 @@ static void do_test(unsigned int num)
 			tst_res(TFAIL,
 				"pidfd creation failed for pid: %u with pidfd error value "
 				"set to: %d",
-				(unsigned)event->pid,
+				(unsigned int)event->pid,
 				info->pidfd);
 			goto next_event;
 		} else if (tc->want_pidfd_err &&
@@ -205,14 +208,14 @@ static void do_test(unsigned int num)
 			tst_res(TFAIL,
 				"pidfd set to an unexpected error: %d for pid: %u",
 				info->pidfd,
-				(unsigned)event->pid);
+				(unsigned int)event->pid);
 			goto next_event;
 		} else if (tc->want_pidfd_err &&
 			   info->pidfd == tc->want_pidfd_err) {
 			tst_res(TPASS,
 				"pid: %u terminated before pidfd was created, "
 				"pidfd set to the value of: %d, as expected",
-				(unsigned)event->pid,
+				(unsigned int)event->pid,
 				FAN_NOPIDFD);
 			goto next_event;
 		}
@@ -227,15 +230,15 @@ static void do_test(unsigned int num)
 				"reading fdinfo for pidfd: %d "
 				"describing pid: %u failed",
 				info->pidfd,
-				(unsigned)event->pid);
+				(unsigned int)event->pid);
 			goto next_event;
 		} else if (event_pidfd_fdinfo->pid != event->pid) {
 			tst_res(TFAIL,
 				"pidfd provided for incorrect pid "
 				"(expected pidfd for pid: %u, got pidfd for "
 				"pid: %u)",
-				(unsigned)event->pid,
-				(unsigned)event_pidfd_fdinfo->pid);
+				(unsigned int)event->pid,
+				(unsigned int)event_pidfd_fdinfo->pid);
 			goto next_event;
 		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
 				  sizeof(struct pidfd_fdinfo_t))) {
@@ -261,7 +264,7 @@ static void do_test(unsigned int num)
 				"mask: %lld, pid: %u, fd: %d, "
 				"pidfd: %d, info_type: %d, info_len: %d",
 				(unsigned long long)event->mask,
-				(unsigned)event->pid,
+				(unsigned int)event->pid,
 				event->fd,
 				info->pidfd,
 				info->hdr.info_type,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
