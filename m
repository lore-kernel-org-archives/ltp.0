Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98377C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:48:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E3803CF351
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 14:48:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39F423C887D
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:48:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E3D71400C6A
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:48:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3999C222E1;
 Mon, 18 Dec 2023 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702907281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4s4zQlzLv8LvPKEiaO79gClZG/S9TfsDR/FqvrlhddU=;
 b=ZQen4obzI4w9T9n9xYzuHy5sHaM65EHx8DJzEzWy+yi4iwesLWIvkKYIMI/4Thu69UXYYM
 mRuqVPJg0i7slaqD7IP1BycJMFsVDZs5FtNCGu5tCzm2B91HLVQCUjvhh6P+KV/QkMxFFF
 dMVjjdbTRQTzatDbzEBXO6YYdS3i268=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702907281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4s4zQlzLv8LvPKEiaO79gClZG/S9TfsDR/FqvrlhddU=;
 b=p4O18TNuzco4pKTxY1A6ZAP3zaem0AE9PRA3H/zOhMA70oDvQHViX7z5KQ7GDJ2E7JA+A1
 nq0C9+NkLhi0cUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702907281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4s4zQlzLv8LvPKEiaO79gClZG/S9TfsDR/FqvrlhddU=;
 b=ZQen4obzI4w9T9n9xYzuHy5sHaM65EHx8DJzEzWy+yi4iwesLWIvkKYIMI/4Thu69UXYYM
 mRuqVPJg0i7slaqD7IP1BycJMFsVDZs5FtNCGu5tCzm2B91HLVQCUjvhh6P+KV/QkMxFFF
 dMVjjdbTRQTzatDbzEBXO6YYdS3i268=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702907281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4s4zQlzLv8LvPKEiaO79gClZG/S9TfsDR/FqvrlhddU=;
 b=p4O18TNuzco4pKTxY1A6ZAP3zaem0AE9PRA3H/zOhMA70oDvQHViX7z5KQ7GDJ2E7JA+A1
 nq0C9+NkLhi0cUCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F64713BC8;
 Mon, 18 Dec 2023 13:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id hygSBpFNgGXWYQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 13:48:01 +0000
Date: Mon, 18 Dec 2023 14:47:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20231218134755.GA209176@pevik>
References: <20231214071321.9863-1-wegao@suse.com>
 <20231218122236.24917-1-wegao@suse.com>
 <20231218122236.24917-3-wegao@suse.com>
 <20231218133404.GB199735@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218133404.GB199735@pevik>
X-Spamd-Result: default: False [-1.57 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.27)[96.55%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] swapping01.c: Reporting /proc/meminfo
 during test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Wei,

> > Get clear overview memory status during test is good for debug, such as
> > get report before the test and also at the moment of the failure.

> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/mem/swapping/swapping01.c | 4 ++++
> >  1 file changed, 4 insertions(+)

> > diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> > index fc225e4a6..025f44363 100644
> > --- a/testcases/kernel/mem/swapping/swapping01.c
> > +++ b/testcases/kernel/mem/swapping/swapping01.c
> > @@ -83,7 +83,9 @@ static void test_swapping(void)

> >  	switch (pid = SAFE_FORK()) {
> >  	case 0:
> > +		TST_PRINT_MEMINFO();
> >  		do_alloc(0);
> > +		TST_PRINT_MEMINFO();
> Developer asked you to print /proc/meminfo "before the test starts and at the
> moment of the failure" Wouldn't be just this second TST_PRINT_MEMINFO() enough?

OK, I merged this. Thank you.

Kind regards,
Petr

> Kind regards,
> Petr

> >  		do_alloc(1);
> >  		exit(0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
