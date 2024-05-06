Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED20C10F16
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 11:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B98F03CBB9A
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 13:26:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E52CA3C0343
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:26:20 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 66724102267C
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:26:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF08938258;
 Mon,  6 May 2024 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714994777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOdZyUxkfTWYuEoJg/N8KmKwq3nEkrFxXr+vCqOSgsA=;
 b=xJndXKWvFVD97eyzT6C+612ICxzB7O36RP01F2c+zvsOpy0oUfdRXJxkzR/eXQefOy3ib7
 Sta+7gd3Ti4fKpBS88nBTUZdJGB+l4egjXgALUEwXpbpNfM6t6iJW3j1eVDT7g0iV5dHhz
 ISa25/MsNs1g2ztM1fBWfqgygIZ1MV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714994777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOdZyUxkfTWYuEoJg/N8KmKwq3nEkrFxXr+vCqOSgsA=;
 b=qD7KV50zahMhXkAf5qFvse9LH0xwOY8icvTeA1oMJaKEOCPVMdhPjATXpQGvbbljR1oAkt
 8hvMITDqmk32OxDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714994777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOdZyUxkfTWYuEoJg/N8KmKwq3nEkrFxXr+vCqOSgsA=;
 b=xJndXKWvFVD97eyzT6C+612ICxzB7O36RP01F2c+zvsOpy0oUfdRXJxkzR/eXQefOy3ib7
 Sta+7gd3Ti4fKpBS88nBTUZdJGB+l4egjXgALUEwXpbpNfM6t6iJW3j1eVDT7g0iV5dHhz
 ISa25/MsNs1g2ztM1fBWfqgygIZ1MV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714994777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOdZyUxkfTWYuEoJg/N8KmKwq3nEkrFxXr+vCqOSgsA=;
 b=qD7KV50zahMhXkAf5qFvse9LH0xwOY8icvTeA1oMJaKEOCPVMdhPjATXpQGvbbljR1oAkt
 8hvMITDqmk32OxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C52613A25;
 Mon,  6 May 2024 11:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cSYYJVm+OGYyLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 May 2024 11:26:17 +0000
Date: Mon, 6 May 2024 13:25:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zji-Jh96mBq90dM-@yuki>
References: <20240503093151.29928-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240503093151.29928-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite msgstress testing suite
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
> +static void reader(const int id, const int pos)
> +{
> +	int size;
> +	int iter = num_iterations;
> +	struct sysv_msg msg_recv;
> +	struct sysv_data *buff = &ipc_data[pos];
> +
> +	while (--iter >= 0 && !(*stop)) {
> +		memset(&msg_recv, 0, sizeof(struct sysv_msg));
> +
> +		size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
> +
> +		if (msg_recv.type != buff->msg.type) {
> +			tst_res(TFAIL, "Received the wrong message type");
>  
> -	for (i = 0; i < nprocs; i++) {
> -		fflush(stdout);
> -		if ((pid = FORK_OR_VFORK()) < 0) {
> -			tst_brkm(TFAIL,
> -				 NULL,
> -				 "\tFork failed (may be OK if under stress)");
> +			*stop = 1;
> +			return;
>  		}
> -		/* Child does this */
> -		if (pid == 0) {
> -			procstat = 1;
> -			exit(dotest(keyarray[i], i));
> +
> +		if (msg_recv.data.len != buff->msg.data.len) {
> +			tst_res(TFAIL, "Received the wrong message data length");
> +
> +			*stop = 1;
> +			return;
>  		}
> -		pidarray[i] = pid;
> -	}
>  
> -	count = 0;
> -	while (1) {
> -		if ((wait(&status)) > 0) {
> -			if (status >> 8 != 0) {
> -				tst_brkm(TFAIL, NULL,
> -					 "Child exit status = %d",
> -					 status >> 8);
> -			}
> -			count++;
> -		} else {
> -			if (errno != EINTR) {
> -				break;
> +		for (int i = 0; i < size; i++) {
> +			if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
> +				tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
> +					msg_recv.data.pbytes[i],
> +					buff->msg.data.pbytes[i]);
> +
> +				*stop = 1;
> +				return;
>  			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Signal detected during wait");
> -#endif
>  		}
> -	}
> -	/* Make sure proper number of children exited */
> -	if (count != nprocs) {
> -		tst_brkm(TFAIL,
> -			 NULL,
> -			 "Wrong number of children exited, Saw %d, Expected %d",
> -			 count, nprocs);
> -	}
>  
> -	tst_resm(TPASS, "Test ran successfully!");
> +		tst_res(TDEBUG, "Received correct data");
> +		tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
> +		tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
> +	}
>  
> -	cleanup();
> -	tst_exit();
> +	buff->id = -1;

You can't reset the buff->id to -1 here since that will cause the test
to leak the message queues because the cleanup will not remove anything.


>  }
>  
> -static int dotest(key_t key, int child_process)
> +static void run(void)
>  {
> -	int id, pid;
> -	int ret, status;
> +	int id, pos;
>  
> -	sighold(SIGTERM);
> -	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
> -	if (TEST_RETURN < 0) {
> -		printf("msgget() error in child %d: %s\n",
> -			child_process, strerror(TEST_ERRNO));
> +	reset_messages();

And this is even a bigger problem, with that we forget the IDs on each
iteration with -i so we will leak even more message queues, just check
ipcs output after running this test.


I can push the patch with a following diff, if you agree:

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 5851938dd..5c84957b3 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
+/*\
  * [Description]
  *
  * Stress test for SysV IPC. We send multiple messages at the same time,
@@ -146,8 +146,15 @@ static void reader(const int id, const int pos)
                tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
                tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
        }
+}
 
-       buff->id = -1;
+static void remove_queues(void)
+{
+       for (int pos = 0; pos < num_messages; pos++) {
+               struct sysv_data *buff = &ipc_data[pos];
+               if (buff->id != -1)
+                       SAFE_MSGCTL(buff->id, IPC_RMID, NULL);
+       }
 }
 
 static void run(void)
@@ -175,6 +182,7 @@ static void run(void)
        }
 
        tst_reap_children();
+       remove_queues();
 
        if (!(*stop))
                tst_res(TPASS, "Test passed. All messages have been received");
@@ -232,12 +240,7 @@ static void cleanup(void)
        if (!ipc_data)
                return;
 
-       for (int pos = 0; pos < num_messages; pos++) {
-               struct sysv_data *buff = &ipc_data[pos];
-
-               if (buff->id != -1)
-                       SAFE_MSGCTL(buff->id, IPC_RMID, NULL);
-       }
+       remove_queues();
 
        SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
        SAFE_MUNMAP((void *)stop, sizeof(int));


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
