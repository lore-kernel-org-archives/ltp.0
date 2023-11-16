Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1909C197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 14:11:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74CB3CE3B3
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 15:11:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609713CD0DE
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 15:11:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 48359601334
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 15:11:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CC9D322944;
 Thu, 16 Nov 2023 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700143896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RZx9+NOTIu8HjyL8SEDQ+F/PLfx7OKX8UcmuxTBSm0=;
 b=pHZivUacbDcJxWNdUqBLstfsvhlBvbcXm88tXRShpMbeJrxvCVK8Hd587jehv+4Kat+wTP
 verPp16m5jG1StMxbtUeqUj/u68gjFLHLfI09G255LOzL6XBmoz6t0Y62M9iGVhDdT4jL3
 VvLiQ2RUbvL783gNyMeHRNGYQu284Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700143896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RZx9+NOTIu8HjyL8SEDQ+F/PLfx7OKX8UcmuxTBSm0=;
 b=qiwGgua1OwkBZRtCFMmefaMGw1gV4JGCjn59Z5P5EDbF70YOZ9slA0cw5eeymn8NSRQxpI
 UrXykdV6DHVbqBAg==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6C6EA2C48E;
 Thu, 16 Nov 2023 14:11:36 +0000 (UTC)
References: <20230908102315.8163-1-andrea.cervesato@suse.de>
 <20230908102315.8163-3-andrea.cervesato@suse.de> <878r82yhyh.fsf@suse.de>
 <ZUJJmPJYqumtFZxh@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Nov 2023 13:24:36 +0000
Organization: Linux Private Site
In-reply-to: <ZUJJmPJYqumtFZxh@yuki>
Message-ID: <87msvdaiug.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.09 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 HAS_ORG_HEADER(0.00)[]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+];
 FORGED_RECIPIENTS(2.00)[m:chrubis@suse.cz,m:andrea.cervesato@suse.de,s:andrea.cervesato@suse.com];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-0.00)[14.91%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.de];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: CC9D322944
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Refactor exit_group01 using new API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> This could fail due to PID reuse or maybe because state == 'Z'.
>> 
>> Perhaps instead we could check the threads are put into the Z state?
>> 
>> I guess that the child threads are reparented to init and it reaps
>> them. So you will have to prevent that by setting PR_SET_CHILD_SUBREAPER
>> on the main test process with prctl.
>> 
>> The man pages are not clear on this though. I guess this is how it works
>> from reading the kernel code.
>
> What about we:
>
> 1) allocate a piece of shared memory
> 2) each thread would run a loop that would increment a counter in that
>    memory
> 3) the test process will wait() the main child
> 4) then monitor the shared memory to make sure that counters are not
>    incremented anymore

+1

>
> Also child threads shouldn't be reparented to init, as long as at least
> one of the threads runs the child process is technically alive and I
> guess that wait() will not return until last thread in the group is
> dead.

OK, I looked again and it appears that indeed the thread group leader is
not reaped if there are threads in the group that are still alive
(wait_consider_task). Also it is only the thread group leader that can
enter a zombie state (exit_notify).

So this just leaves PID recycling as a potential issue IIRC.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
