Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13973C5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 10:15:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874613CFE0A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 11:15:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147783C1354
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 11:15:02 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA50F209F38
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 11:15:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED5B20DFB;
 Fri,  8 Mar 2024 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709892899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OORh51fa5fD6quc23evtRc+0VU/dg1wva/jbhA6Vjk0=;
 b=u+gN50QLCq5d+tKbNHRmHDsbxLM24UR74VB3zRJLs+C6odyd8YrwHGiWiVfy6a/WdsQKp2
 43tjJr6gi6lpaLU3Yr6LH90WQD6/KW5aZqvAUhqnKOkQk6aetb1PvoRxNpw75LVaZY7Fmb
 91xVPOips2NltKkdBzzdOxX/klbkG+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709892899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OORh51fa5fD6quc23evtRc+0VU/dg1wva/jbhA6Vjk0=;
 b=Xs64eHqm6fbXtI2QKc/1iFk3HXWEjY02iViD0MDa3AhtR8l7oANq/AWbA9YaANWXGQRuyu
 ownUnijRCHnaNCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709892899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OORh51fa5fD6quc23evtRc+0VU/dg1wva/jbhA6Vjk0=;
 b=u+gN50QLCq5d+tKbNHRmHDsbxLM24UR74VB3zRJLs+C6odyd8YrwHGiWiVfy6a/WdsQKp2
 43tjJr6gi6lpaLU3Yr6LH90WQD6/KW5aZqvAUhqnKOkQk6aetb1PvoRxNpw75LVaZY7Fmb
 91xVPOips2NltKkdBzzdOxX/klbkG+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709892899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OORh51fa5fD6quc23evtRc+0VU/dg1wva/jbhA6Vjk0=;
 b=Xs64eHqm6fbXtI2QKc/1iFk3HXWEjY02iViD0MDa3AhtR8l7oANq/AWbA9YaANWXGQRuyu
 ownUnijRCHnaNCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD3313310;
 Fri,  8 Mar 2024 10:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5JVhDSPl6mVNawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 08 Mar 2024 10:14:59 +0000
Date: Fri, 8 Mar 2024 11:13:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zerk4rdwmClTRgxc@yuki>
References: <20240216122904.11446-1-andrea.cervesato@suse.de>
 <ZemmFwvEl9qgGEAN@yuki>
 <f61464e4-834f-4341-ab85-792765ddb9e5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f61464e4-834f-4341-ab85-792765ddb9e5@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
> > First of all this patch removes all users of the libltpipc library but
> > keeps the library orphaned in libs/ leaving a dead code.
> This was done by purpose. I have track of dependences inside LTP and the 
> idea is to remove it on a second moment. But I can send a following 
> patch removing it already.

Just add a patch that removes it as a second patch after the test
conversion.

> > Secondly if you look at the libmsgctl.c you can actually see that the
> > reader and writer pair sends messages in a loop. This is imporatant
> > because without that the test can be hardly called a stress test. The
> > point is to start as much processes as possible that keep sending
> > messages around so that eventually we saturate the system. The new test
> > just sends a single message, which means that the children finish too
> > quickly and we never run more than a single digit of read/write pairs.
> > Given that we now have a runtime support in the test library we should
> > change this so that the reader/write paris continue to send messages
> > around until we are out of runtime. And the runtime should be at least a
> > minute.
> 
> Actually this is a good idea, but test might send not enough messages if 
> system is not responsive.
> I would keep the loop like we do now in this case, so we ensure a 
> certain amount of stress, no matter the runtime.

As long as the test runs for long enough the pairs should send more or
less equal amount of messages, the scheduller should choose the
processes so that they do equal amount of work on average.

So I wouldn't be concerned with a minimal amount of loops for a given
pair, unless we want to make this into a scheduller test.

> >> +static void reader(const int id)
> >> +{
> >> +	int size;
> >> +	struct sysv_msg msg_recv;
> >> +	struct sysv_data *buff = NULL;
> >>   
> >> -	/* Fork a number of processes, each of which will
> >> -	 * create a message queue with one reader/writer
> >> -	 * pair which will read and write a number (iterations)
> >> -	 * of random length messages with specific values.
> >> -	 */
> >> +	memset(&msg_recv, 0, sizeof(struct sysv_msg));
> >>   
> >> -	for (i = 0; i < nprocs; i++) {
> >> -		fflush(stdout);
> >> -		if ((pid = FORK_OR_VFORK()) < 0) {
> >> -			tst_brkm(TFAIL,
> >> -				 NULL,
> >> -				 "\tFork failed (may be OK if under stress)");
> >> -		}
> >> -		/* Child does this */
> >> -		if (pid == 0) {
> >> -			procstat = 1;
> >> -			exit(dotest(keyarray[i], i));
> >> +	size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
> >> +
> >> +	for (int i = 0; i < ipc_data_len; i++) {
> >> +		if (ipc_data[i].id == id) {
> >> +			buff = ipc_data + i;
> >> +			break;
> >>   		}
> >> -		pidarray[i] = pid;
> >>   	}
> >>   
> >> -	count = 0;
> >> -	while (1) {
> >> -		if ((wait(&status)) > 0) {
> >> -			if (status >> 8 != 0) {
> >> -				tst_brkm(TFAIL, NULL,
> >> -					 "Child exit status = %d",
> >> -					 status >> 8);
> >> -			}
> >> -			count++;
> >> -		} else {
> >> -			if (errno != EINTR) {
> >> -				break;
> >> -			}
> >> -#ifdef DEBUG
> >> -			tst_resm(TINFO, "Signal detected during wait");
> >> -#endif
> >> -		}
> >> +	if (!buff) {
> >> +		tst_brk(TBROK, "Can't find original message. This is a test issue!");
> >> +		return;
> >>   	}
> >> -	/* Make sure proper number of children exited */
> >> -	if (count != nprocs) {
> >> -		tst_brkm(TFAIL,
> >> -			 NULL,
> >> -			 "Wrong number of children exited, Saw %d, Expected %d",
> >> -			 count, nprocs);
> >> +
> >> +	TST_EXP_EQ_LI(msg_recv.type, buff->msg.type);
> >> +	TST_EXP_EQ_LI(msg_recv.data.len, buff->msg.data.len);
> >> +
> >> +	for (int i = 0; i < size; i++) {
> >> +		if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
> >> +			tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
> >> +				msg_recv.data.pbytes[i],
> >> +				buff->msg.data.pbytes[i]);
> >> +
> >> +			goto exit;
> >> +		}
> >>   	}
> >>   
> >> -	tst_resm(TPASS, "Test ran successfully!");
> >> +	tst_res(TPASS, "Received correct data");
> > This spams the test output with a few hundreds of lines of output, which
> > is known to choke test runners. For this case we should probably output
> > one single TPASS at the end of the test.
> >
> > Also this seems to be a common pattern, so we may as well add a function
> > into the test library that would produce TPASS unless we have seen a
> > FAIL/BROK/WARN. Or maybe just a function that would return sum of the
> > result counters so that we can do:
> >
> > 	if (tst_get_res(TFAIL|TBROK|TWARN))
> > 		tst_res(TPASS, "All data were received correctly");
> >
> >
> Isn't it like this already?

Not at all, test that does not report any results is supposed to be
broken and reports TBROK. The reasoning is that test results have to be
reported explicitly.

And currently we do not have any API that would allow the test to get
the value of the result reporting counters, so testcases that want to
report PASS/FAIL at the end of the test have to keep the track
themselves, usually by having a page of shared memory with a coutner. So
perhaps it would make sense to add a function that would return the
value of the result counters so that we can use them to report TPASS if
no errors were found during the test iteration.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
