Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49738C54798
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 00:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 154E23D1C19
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 01:47:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BE73CB8D1
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 01:47:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17E5461DF1E
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 01:47:11 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED2066F78;
 Thu,  7 Mar 2024 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709849280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9V4zJiMggYiEfa2nWhVo0CmQMW/H4b78jxELRcmdf8=;
 b=UbNaDETuVfGLfExPKxPYD2UI/bzGA6bAw13+PtzRpD8Zo6kr/sN1w9qr93J7c576JrgxgJ
 ZemhPWMVwFRvToZozCO0tUvsujPvmMrp1XxeD6X3OhSOc+J1QNPpC/i13FY7npaBejunbl
 zTp94pgYb6HoJetP1I5zvpyMyRyIOzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709849280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9V4zJiMggYiEfa2nWhVo0CmQMW/H4b78jxELRcmdf8=;
 b=U+De2LyI6lhMQ4akD0YODOEBnOCFUvV31i9tFcAIJixukt0ahn3zi5ipU5buOrBq/urHK/
 5feWK+6ADB3AEHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709849280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9V4zJiMggYiEfa2nWhVo0CmQMW/H4b78jxELRcmdf8=;
 b=UbNaDETuVfGLfExPKxPYD2UI/bzGA6bAw13+PtzRpD8Zo6kr/sN1w9qr93J7c576JrgxgJ
 ZemhPWMVwFRvToZozCO0tUvsujPvmMrp1XxeD6X3OhSOc+J1QNPpC/i13FY7npaBejunbl
 zTp94pgYb6HoJetP1I5zvpyMyRyIOzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709849280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9V4zJiMggYiEfa2nWhVo0CmQMW/H4b78jxELRcmdf8=;
 b=U+De2LyI6lhMQ4akD0YODOEBnOCFUvV31i9tFcAIJixukt0ahn3zi5ipU5buOrBq/urHK/
 5feWK+6ADB3AEHAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A150E132A4;
 Thu,  7 Mar 2024 22:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ablVI7866mWlOwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 22:07:59 +0000
Date: Thu, 7 Mar 2024 23:07:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240307220757.GB211890@pevik>
References: <20240216122904.11446-1-andrea.cervesato@suse.de>
 <ZemmFwvEl9qgGEAN@yuki>
 <f61464e4-834f-4341-ab85-792765ddb9e5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f61464e4-834f-4341-ab85-792765ddb9e5@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> On 3/7/24 12:33, Cyril Hrubis wrote:
> > Hi!
> > First of all this patch removes all users of the libltpipc library but
> > keeps the library orphaned in libs/ leaving a dead code.
> This was done by purpose. I have track of dependences inside LTP and the
> idea is to remove it on a second moment. But I can send a following patch
> removing it already.

Actually, if it was done on purpose it is a bad approach. Splitting a cleanup
from a rewrite is asking to leave a dead code.

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

> Actually this is a good idea, but test might send not enough messages if
> system is not responsive.
> I would keep the loop like we do now in this case, so we ensure a certain
> amount of stress, no matter the runtime.

I would agree with Cyril this is not much stressing (rewrite should not drop the
main purpose of the test).


...
> > > -	tst_resm(TPASS, "Test ran successfully!");
> > > +	tst_res(TPASS, "Received correct data");
> > This spams the test output with a few hundreds of lines of output, which
> > is known to choke test runners. For this case we should probably output
> > one single TPASS at the end of the test.

Can't we exit child non-zero on failure, store that via WIFEXITED() and print
TPASS only when none of the child runs failed?

> > Also this seems to be a common pattern, so we may as well add a function
> > into the test library that would produce TPASS unless we have seen a
> > FAIL/BROK/WARN. Or maybe just a function that would return sum of the
> > result counters so that we can do:

> > 	if (tst_get_res(TFAIL|TBROK|TWARN))
> > 		tst_res(TPASS, "All data were received correctly");

This looks to me better approach than expect that the default is to TPASS.

> Isn't it like this already?

No, it TBROK if you don't produce any of TPASS/TFAIL/TBROK/TCONF (TBROK can be
only in tst_brk()):

tst_test.c:1472: TBROK: Test 0 haven't reported results!

Kind regards,
Petr

> Regards,
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
