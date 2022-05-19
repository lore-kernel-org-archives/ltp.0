Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5ABC433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 09:03:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82D043CAAD6
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:03:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD0823C0894
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:03:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28B421000A4E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:03:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08F6A1F7AB;
 Thu, 19 May 2022 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652950994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5JLCev+wUCWrre7cyIkudApw7Or4QNf/XkBZOgEeQQ=;
 b=Yg0eTSTzoHv9zM5+lyTmnpp30Wop3nQj6HKmDQN5aaJVAqwq+U4eEvkycVYZ1Xra7XdAXd
 /1tsOnyIDjOl1HCEwdo2sMeHwAjmDxhYlmbuZaR36ZsVFO34cF7jva07rmUAk9QOG1vim8
 Ui7vupaHQpkod4aDXNuztJzlBB9f2ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652950994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5JLCev+wUCWrre7cyIkudApw7Or4QNf/XkBZOgEeQQ=;
 b=pqaFnIOt5wnKglksdd4JwsEhp0mHhTWdyyzZB2PEddfXmfcX0VQ2FuQw5iOX+rW2RSMS+f
 1ScIcbrp4a15/ZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E946A13AF8;
 Thu, 19 May 2022 09:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IdmrN9EHhmL+IQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 May 2022 09:03:13 +0000
Date: Thu, 19 May 2022 11:05:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YoYIVaJJDzryYNeg@yuki>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de>
 <YoN/W4wbow2fyOut@yuki>
 <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
 <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Okay, my perspective is shortsighted as well.
> 
> This solution is correct in the direction but overlooks the significant
> global value 'tst_start_time'. If that value reflush within tcnt loop we
> don't need to reset max_runtime again, actually the real work in my
> previous patch is to invoke heartbeat() which touches tst_start_time.
> 
> So I would suggest using heartbeat() instead of only sending SIGUSR1
> to lib_pid. Or, do simply revision like:

Ah, right, I guess that we should just call heartbeat() before each
iteration of the test then.

So basically:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index dad8aad92..f3090217b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1317,6 +1317,24 @@ static void do_cleanup(void)
 	cleanup_ipc();
 }
 
+static void heartbeat(void)
+{
+	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+
+	if (getppid() == 1) {
+		tst_res(TFAIL, "Main test process might have exit!");
+		/*
+		 * We need kill the task group immediately since the
+		 * main process has exit.
+		 */
+		kill(0, SIGKILL);
+		exit(TBROK);
+	}
+
+	kill(getppid(), SIGUSR1);
+}
+
 static void run_tests(void)
 {
 	unsigned int i;
@@ -1324,6 +1342,7 @@ static void run_tests(void)
 
 	if (!tst_test->test) {
 		saved_results = *results;
+		heartbeat();
 		tst_test->test_all();
 
 		if (getpid() != main_pid) {
@@ -1339,6 +1358,7 @@ static void run_tests(void)
 
 	for (i = 0; i < tst_test->tcnt; i++) {
 		saved_results = *results;
+		heartbeat();
 		tst_test->test(i);
 
 		if (getpid() != main_pid) {
@@ -1349,6 +1369,8 @@ static void run_tests(void)
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test %i haven't reported results!", i);
+
+		kill(getppid(), SIGUSR1);
 	}
 }
 
@@ -1379,24 +1401,6 @@ static void add_paths(void)
 	free(new_path);
 }
 
-static void heartbeat(void)
-{
-	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
-		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
-
-	if (getppid() == 1) {
-		tst_res(TFAIL, "Main test process might have exit!");
-		/*
-		 * We need kill the task group immediately since the
-		 * main process has exit.
-		 */
-		kill(0, SIGKILL);
-		exit(TBROK);
-	}
-
-	kill(getppid(), SIGUSR1);
-}
-
 static void testrun(void)
 {
 	unsigned int i = 0;
@@ -1425,7 +1429,6 @@ static void testrun(void)
 			break;
 
 		run_tests();
-		heartbeat();
 	}
 
 	do_test_cleanup();


I guess that this should go in a separate patch on the top of the
"Introduce concept of max runtime".

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
