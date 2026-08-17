Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF0C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 04:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B6353C5887
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 06:52:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF24A3C23B2
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 06:51:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 57A471A006A6
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 06:51:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64E0E83E16;
 Mon, 17 Aug 2026 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786942299;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xswj+TrOWwcaEY1Mx8gaGKigGOBLH+6AqOxYa7c64us=;
 b=iTYwKhMAYN0oLcZ+ZqCtEG/er+wwcVWy/wWMRkyDodRdU3PmCk/dQcyQcJuWhrAF5H84aB
 Wt5pMzJstVCKzH4HmghuyvjNpiT+/Knnl725NTNxYMrS3nEnUJneGsGCBHpV992NK/amu2
 lqUiHtshjrbRTLMzPfKAR2VhLP7cd/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786942299;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xswj+TrOWwcaEY1Mx8gaGKigGOBLH+6AqOxYa7c64us=;
 b=3iHCiCh5/Ygj8FZGZJ6eZlzann+asBWKwyCdjerUJT7zQ8GxMui4n5M3HnVv9XKQ0rOOlF
 jjwutG8B5GIzwHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786942295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xswj+TrOWwcaEY1Mx8gaGKigGOBLH+6AqOxYa7c64us=;
 b=Xn71FWDINsUrOatXZuQLheerJ54TXhOr+uwcOcn6pcvwZ0TY98Wc4ZzgzihJkmSwwvlySV
 XFpUfL0euo4+zq7e8sN/I9ZF7bb1BSDcW3MG6l6jovYGkj1qo+ED/rkkdaXO2BtYcjQ+3o
 aK6lRJRCaGlj8EdyhJwTm+SjC+lVWhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786942295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xswj+TrOWwcaEY1Mx8gaGKigGOBLH+6AqOxYa7c64us=;
 b=Ki3DZb86qWvlZzHZ4NAvjitmodIFscjg9tBHk5yF5rTh0/GYu0li9/QcipwQ07/rq78DEO
 X1gir/PYZ22OpdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D113792AA;
 Mon, 17 Aug 2026 04:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KZoUCVeTgmr5NQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Aug 2026 04:51:35 +0000
Date: Mon, 17 Aug 2026 06:51:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20260817045129.GA1954854@pevik>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-2-anonymemeow@gmail.com>
 <qvztwkwtesalldjybep577roegy77c6snq7xh6xkykc2cgctus@bdigqlb4buit>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <qvztwkwtesalldjybep577roegy77c6snq7xh6xkykc2cgctus@bdigqlb4buit>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz,suse.com,suse.de];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] fanotify20: Skip FAN_REPORT_PIDFD |
 FAN_REPORT_TID test on v7.2+
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
Cc: amir73il@gmail.com, AnonymeMeow <anonymemeow@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Wed 17-06-26 05:04:44, AnonymeMeow wrote:
> > fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> > FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> > reporting pidfds for thread IDs, so this combination is expected to
> > succeed.

> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

> Looks good. Feel free to add:

> Reviewed-by: Jan Kara <jack@suse.cz>

In the end, after some iterations trying to add .max_kver, this simple version
was merged.

Thanks to all for their time.

Kind regards,
Petr

> 								Honza

> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify20.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > index b32ecf6aa..f395d77ee 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > @@ -8,13 +8,15 @@

> >  /*\
> >   * This source file contains a test case which ensures that the
> > - * :manpage:`fanotify(7)` API returns an expected error code when provided an
> > - * invalid initialization flag alongside FAN_REPORT_PIDFD. Additionally, it
> > - * checks that the operability with existing FAN_REPORT_* flags is maintained
> > - * and functioning as intended.
> > + * :manpage:`fanotify(7)` API returns an expected error code when provided
> > + * unsupported initialization flags, e.g. FAN_REPORT_PIDFD combined with
> > + * FAN_REPORT_TID. Additionally, it checks that the operability with
> > + * supported FAN_REPORT_* flags is maintained and functioning as intended.
> >   *
> >   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
> >   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> > + * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1
> > + * in 17171128513b ("fanotify: report thread pidfds for FAN_REPORT_TID").
> >   */

> >  #define _GNU_SOURCE
> > @@ -45,6 +47,10 @@ static struct test_case_t {

> >  static void do_setup(void)
> >  {
> > +	if (tst_kvercmp(7, 2, 0) >= 0)
> > +		tst_brk(TCONF, "FAN_REPORT_PIDFD | FAN_REPORT_TID is supported "
> > +			       "since v7.2, skipping test");
> > +
> >  	/*
> >  	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
> >  	 * test initialization as it's a prerequisite for all test cases.
> > -- 
> > 2.54.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
