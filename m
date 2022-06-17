Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14438C43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 10:07:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F5863C871D
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 12:07:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5F6B3C215A
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 12:07:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6B6220034B
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 12:07:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 000EA21E20;
 Fri, 17 Jun 2022 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655460420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPdaDwQzjMV4/3ncyyn7tYNcmpxrw4PQSE33RZqf/LY=;
 b=pa0x2QWNAGUwOBeDRrLDJ3Cu/sbw3MKqHeF4e0+F3AEz/pA+3EeIdRYtinKKnU1ZeJUZGk
 /Zh+jZlAV8ah+zS7RTztodJgk2nVNnwDxrAaCmpXzGAK/MLQqX1UJTej9eT5cp5FlYSMI4
 LqzqT2o7XnaK+zS7T8YtFDXVptmEFRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655460420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPdaDwQzjMV4/3ncyyn7tYNcmpxrw4PQSE33RZqf/LY=;
 b=ayNhLPS3liFP6zJ7cQBXZi7XdKRyQjZW0TrxwFssj7gecBP6dJga6EAe+bfXT2NDDUnPU2
 4gwt5Hqv1NUkWnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E099A1348E;
 Fri, 17 Jun 2022 10:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DMXoNUNSrGIjQQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 10:06:59 +0000
Date: Fri, 17 Jun 2022 12:09:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YqxSxUh4F1vajB2i@yuki>
References: <20220617055600.455225-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220617055600.455225-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapping01: set .max_runtime to 90 seconds
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
>   # time ./swapping01
>   tst_kconfig.c:82: TINFO: Parsing kernel config '/boot/config-4.18.0-309.el8.x86_64+debug'
>   tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s
>   swapping01.c:110: TINFO: available physical memory: 1545 MB
>   swapping01.c:113: TINFO: try to allocate: 2008 MB
>   swapping01.c:152: TPASS: no heavy swapping detected, 218 MB swapped.
>   ...
> 
>   real    0m34.241s
>   user    0m0.386s
>   sys     0m16.040s

I did play with the test for a bit and it's even more unpredictable for
me, it tooks a minute or two on my workstation but there were outliners
that took nearly four minutes as well.

Hence I would propose to go even further and default to 10 minutes for
max_runtime. At the same time I would limit the loop that waits for the
swap usage to settle to run for a reminder of max_runtime/2 instead of
the hardcoded 30 seconds. Something as:

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index f6133cc0d..40395b1d3 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -58,6 +58,7 @@ static long swap_free_init;
 static long mem_over;
 static long mem_over_max;
 static pid_t pid;
+static unsigned int start_runtime;
 
 static void test_swapping(void)
 {
@@ -67,6 +68,8 @@ static void test_swapping(void)
 	FILE *file;
 	char line[PATH_MAX];
 
+	start_runtime = tst_remaining_runtime();
+
 	file = SAFE_FOPEN("/proc/swaps", "r");
 	while (fgets(line, sizeof(line), file)) {
 		if (strstr(line, "/dev/zram")) {
@@ -122,7 +125,7 @@ static void do_alloc(int allow_raise)
 
 static void check_swapping(void)
 {
-	int status, i;
+	int status;
 	long swap_free_now, swapped;
 
 	/* wait child stop */
@@ -131,14 +134,13 @@ static void check_swapping(void)
 		tst_brk(TBROK, "child was not stopped.");
 
 	/* Still occupying memory, loop for a while */
-	i = 0;
-	while (i < 30) {
+	while (tst_remaining_runtime() > start_runtime/2) {
 		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
-		if (labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 10)
+		long diff = labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:"));
+		if (diff < 10)
 			break;
-
-		i++;
+		tst_res(TINFO, "SwapFree difference %li", diff);
 	}
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
@@ -159,6 +161,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
+	.max_runtime = 600,
 	.test_all = test_swapping,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",

After this patch the test works for me as:

$ time ./swapping01
tst_kconfig.c:82: TINFO: Parsing kernel config '/usr/src/linux/.config'
tst_test.c:1526: TINFO: Timeout per run is 0h 10m 30s
swapping01.c:112: TINFO: available physical memory: 15389 MB
swapping01.c:116: TINFO: try to allocate: 20006 MB
swapping01.c:143: TINFO: SwapFree difference 1280
swapping01.c:143: TINFO: SwapFree difference 512
swapping01.c:143: TINFO: SwapFree difference 256
swapping01.c:143: TINFO: SwapFree difference 256
swapping01.c:143: TINFO: SwapFree difference 256
swapping01.c:153: TPASS: no heavy swapping detected, 4612 MB swapped.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

real    1m46.942s
user    0m1.860s
sys     0m20.429s

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
