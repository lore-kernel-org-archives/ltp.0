Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD64FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:01:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 499643E49C5
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:01:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2803E12DF
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:00:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BD83E1400C73
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:00:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E7EF6A867;
 Wed, 29 Apr 2026 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777464033;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
 b=S4bxcTXkTgAqqcQffMVUAX3MYKoAVvZfjvMOTMGQ+i/ljppJcvcpUX74X0jqYyPMsnymbA
 JozxN3SD7B2WQZ5IIlrkVrOMH1fE88BaD7uJ2SN5oEYuXU56NobfPq34hcYNBmi3nNfJPq
 AChX+rkMPTRhyx13k3uXXZiE1xdpkpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777464033;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
 b=pntH6DiL1Mkaw+Qxa4D7DUpArIFmxz8THH60znML88ku7ZhQ+OMwa+7PgFCv0Wmn5Hoxxi
 R0wgKHxrL8A/JgDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777464032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
 b=hs9bTTM+pWfhR9P5C2FJ31keLCe+MRPoSkYEuzFTFGSInwm8tJ/xN7DzvoFWMn6OLwDmCd
 ANKtq1krbw26d/A1oxkxUC1NLL2IUg+uTlovqMdPO/6P3j/zwqFAXwquTVbeNDRu2z2l0/
 wPfnilFFWpNj88gfJxsVLw9lrUpMWC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777464032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
 b=ofV+AeoslEjK1UBWhzW/t0/m/X3y+UsjP/j80WebTSk1KlhrQqDEvbL7j/8mIuUBH/1esW
 E7XNGKWBVn7gQSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60697593B0;
 Wed, 29 Apr 2026 12:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /B3bFODy8WlcTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 12:00:32 +0000
Date: Wed, 29 Apr 2026 14:00:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260429120030.GA993265@pevik>
References: <20260428161034.947614-1-pvorel@suse.cz>
 <20260428161034.947614-2-pvorel@suse.cz>
 <209b0327-64b4-4a58-9ee1-19ec693c8105@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <209b0327-64b4-4a58-9ee1-19ec693c8105@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_violations.sh: ima_mmap.c: Replace sleep
 with checkpoints
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, all,

> Hi,
> for both patches:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for review, patchset merged.

Kind regards,
Petr

> On 4/28/26 18:10, Petr Vorel wrote:
> > Using checkpoints is a proper way in LTP new API [1] to avoid races and
> > waste of time.  It reduces 3 sec sleep in ima_mmap.c and 1 sec sleep in
> > ima_violations.sh with just checkpoints.

> > NOTE: tst_reinit() is really needed instead of .needs_checkpoints = 1
> > as documented in Shell-Test-API.asciidoc.

> > [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

> > Fixes: 0e4cbf753f ("security/ima: Rewrite tests into new API + fixes")
> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/kernel/security/integrity/ima/src/ima_mmap.c     | 7 ++++---
> >   .../kernel/security/integrity/ima/tests/ima_violations.sh  | 6 +++++-
> >   2 files changed, 9 insertions(+), 4 deletions(-)

> > diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > index 8596809ef4..09b22fd4f4 100644
> > --- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > +++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > @@ -9,7 +9,6 @@
> >   #include "tst_test.h"
> > -#define SLEEP_AFTER_CLOSE 3
> >   #define MMAPSIZE 1024
> >   static char *filename;
> > @@ -35,8 +34,10 @@ static void run(void)
> >   	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> >   	SAFE_CLOSE(fd);
> > -	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
> > -	sleep(SLEEP_AFTER_CLOSE);
> > +	tst_reinit();
> > +	TST_CHECKPOINT_WAIT(0);
> > +	/* keep running until ima_violations.sh open and close file */
> > +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> >   	tst_res(TPASS, "test completed");
> >   }
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 0c03c30786..d7dcd077b4 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -8,6 +8,7 @@
> >   # test[4-6] test 6.15 commit 5b3cd801155f ("ima: limit the number of open-writers integrity violations")
> >   # test[7-8] test 6.15 commit a414016218ca ("ima: limit the number of ToMToU integrity violations")
> > +TST_NEEDS_CHECKPOINTS=1
> >   TST_SETUP="setup"
> >   TST_CLEANUP="cleanup"
> >   TST_CNT=8
> > @@ -171,12 +172,15 @@ test3()
> >   	ima_mmap -f $FILE &
> >   	pid=$!
> > +
> >   	# wait for violations appear in logs
> > -	tst_sleep 1s
> > +	TST_CHECKPOINT_WAKE_AND_WAIT 0
> >   	open_file_read
> >   	close_file_read
> > +	TST_CHECKPOINT_WAKE 0
> > +
> >   	validate $num_violations $count $search
> >   	# wait for ima_mmap to exit, so we can umount

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
