Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F602C48BF6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 12:53:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81B293D0023
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 13:53:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88223CE9A3
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 13:52:48 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABC726008E5
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 13:52:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F5BA5D072;
 Thu,  7 Mar 2024 11:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709811285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/yznh8Yjvjfjg097QDnsz7hnI6vTVfqJeQcQZJ9UTw=;
 b=AqocsGd8sib9H3VESRWlQVBGHVTsW0QMgPVai/iwMQ3ampzWxNGM3HUCcxuCyMpRFtAZxo
 IdVt8/n1tSfkAN/GahWLPKfg7407xcGpHo6uUa7SnfHsWpUOu+w6u8x/J+K/eN6FzPVVmt
 zTOiIo13tM9M1hXE5g6iAyMNKqB+rQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709811285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/yznh8Yjvjfjg097QDnsz7hnI6vTVfqJeQcQZJ9UTw=;
 b=WwCJu01TizaW5v57dgRhsMRPyA6AUxOPctAZAJejxB7HzAAu6TPqWHh0JJd94fG47w0gKA
 ZSgDMp5ljQF0xyDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709811285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/yznh8Yjvjfjg097QDnsz7hnI6vTVfqJeQcQZJ9UTw=;
 b=AqocsGd8sib9H3VESRWlQVBGHVTsW0QMgPVai/iwMQ3ampzWxNGM3HUCcxuCyMpRFtAZxo
 IdVt8/n1tSfkAN/GahWLPKfg7407xcGpHo6uUa7SnfHsWpUOu+w6u8x/J+K/eN6FzPVVmt
 zTOiIo13tM9M1hXE5g6iAyMNKqB+rQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709811285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/yznh8Yjvjfjg097QDnsz7hnI6vTVfqJeQcQZJ9UTw=;
 b=WwCJu01TizaW5v57dgRhsMRPyA6AUxOPctAZAJejxB7HzAAu6TPqWHh0JJd94fG47w0gKA
 ZSgDMp5ljQF0xyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5B5112FC5;
 Thu,  7 Mar 2024 11:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oDrJN1Sm6WWUOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 Mar 2024 11:34:44 +0000
Date: Thu, 7 Mar 2024 12:33:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZemmFwvEl9qgGEAN@yuki>
References: <20240216122904.11446-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240216122904.11446-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; URIBL_BLOCKED(0.00)[suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite msgstress testing suite
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
First of all this patch removes all users of the libltpipc library but
keeps the library orphaned in libs/ leaving a dead code.

Secondly if you look at the libmsgctl.c you can actually see that the
reader and writer pair sends messages in a loop. This is imporatant
because without that the test can be hardly called a stress test. The
point is to start as much processes as possible that keep sending
messages around so that eventually we saturate the system. The new test
just sends a single message, which means that the children finish too
quickly and we never run more than a single digit of read/write pairs.
Given that we now have a runtime support in the test library we should
change this so that the reader/write paris continue to send messages
around until we are out of runtime. And the runtime should be at least a
minute.

> +static void reader(const int id)
> +{
> +	int size;
> +	struct sysv_msg msg_recv;
> +	struct sysv_data *buff = NULL;
>  
> -	/* Fork a number of processes, each of which will
> -	 * create a message queue with one reader/writer
> -	 * pair which will read and write a number (iterations)
> -	 * of random length messages with specific values.
> -	 */
> +	memset(&msg_recv, 0, sizeof(struct sysv_msg));
>  
> -	for (i = 0; i < nprocs; i++) {
> -		fflush(stdout);
> -		if ((pid = FORK_OR_VFORK()) < 0) {
> -			tst_brkm(TFAIL,
> -				 NULL,
> -				 "\tFork failed (may be OK if under stress)");
> -		}
> -		/* Child does this */
> -		if (pid == 0) {
> -			procstat = 1;
> -			exit(dotest(keyarray[i], i));
> +	size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
> +
> +	for (int i = 0; i < ipc_data_len; i++) {
> +		if (ipc_data[i].id == id) {
> +			buff = ipc_data + i;
> +			break;
>  		}
> -		pidarray[i] = pid;
>  	}
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
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Signal detected during wait");
> -#endif
> -		}
> +	if (!buff) {
> +		tst_brk(TBROK, "Can't find original message. This is a test issue!");
> +		return;
>  	}
> -	/* Make sure proper number of children exited */
> -	if (count != nprocs) {
> -		tst_brkm(TFAIL,
> -			 NULL,
> -			 "Wrong number of children exited, Saw %d, Expected %d",
> -			 count, nprocs);
> +
> +	TST_EXP_EQ_LI(msg_recv.type, buff->msg.type);
> +	TST_EXP_EQ_LI(msg_recv.data.len, buff->msg.data.len);
> +
> +	for (int i = 0; i < size; i++) {
> +		if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
> +			tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
> +				msg_recv.data.pbytes[i],
> +				buff->msg.data.pbytes[i]);
> +
> +			goto exit;
> +		}
>  	}
>  
> -	tst_resm(TPASS, "Test ran successfully!");
> +	tst_res(TPASS, "Received correct data");

This spams the test output with a few hundreds of lines of output, which
is known to choke test runners. For this case we should probably output
one single TPASS at the end of the test.

Also this seems to be a common pattern, so we may as well add a function
into the test library that would produce TPASS unless we have seen a
FAIL/BROK/WARN. Or maybe just a function that would return sum of the
result counters so that we can do:

	if (tst_get_res(TFAIL|TBROK|TWARN))
		tst_res(TPASS, "All data were received correctly");


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
