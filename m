Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F061AC3DA49
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 08:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DCAB3D1D81
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 10:57:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC683CE640
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:57:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B59B91401267
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:57:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E82381F7F6;
 Tue, 30 Jul 2024 08:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4aUZTRalI0m4ujRLVWtluZkogU/TQA/qVhz+NBKgM=;
 b=UFAbImNpvzbM/LzW4wC7FYTSLvT2moMWv9fzu1obkzP+Zzmk+lqXP36IpGriAm/Lhw81Fu
 n+6mH3O2vfTKoIhbGSP/rAgyRrGprRYVthr82eyudkTi1AckBudVcWyE40H3c+RhozZeNG
 R9BnvZ+22MQoD9a1dBGoU3H3EXlTh70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4aUZTRalI0m4ujRLVWtluZkogU/TQA/qVhz+NBKgM=;
 b=NQbj1fK6W9Kya+ZbX5RLgREHvE4IjInTk2+wiX1VCE+BloyYMoCQZrmXuqTVtEERnWb6zA
 rnspBpfvu9pMJABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4aUZTRalI0m4ujRLVWtluZkogU/TQA/qVhz+NBKgM=;
 b=UFAbImNpvzbM/LzW4wC7FYTSLvT2moMWv9fzu1obkzP+Zzmk+lqXP36IpGriAm/Lhw81Fu
 n+6mH3O2vfTKoIhbGSP/rAgyRrGprRYVthr82eyudkTi1AckBudVcWyE40H3c+RhozZeNG
 R9BnvZ+22MQoD9a1dBGoU3H3EXlTh70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4aUZTRalI0m4ujRLVWtluZkogU/TQA/qVhz+NBKgM=;
 b=NQbj1fK6W9Kya+ZbX5RLgREHvE4IjInTk2+wiX1VCE+BloyYMoCQZrmXuqTVtEERnWb6zA
 rnspBpfvu9pMJABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC93113983;
 Tue, 30 Jul 2024 08:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HQMMOOqqGajCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 08:57:07 +0000
Date: Tue, 30 Jul 2024 10:57:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240730085707.GA1336335@pevik>
References: <20240729223431.1307306-1-pvorel@suse.cz> <ZqibBUXHVfSjN-_4@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqibBUXHVfSjN-_4@yuki>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] cachestat01: Reduce required space on 64kb
 page size
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

Hi Cyril,

...
> > First I thought we should use tst_fs_has_free() in each
> > test_cached_pages() run, but test uses .all_filesystems, thus it's
> > always 300 MB. Should we, just in case, use .dev_min_size = 300,
> > to make sure it runs correctly even we change the DEV_SIZE_MB value?

> > Or, should we really calculate required space with tst_fs_has_free(),
> > based on page size num_pages and * 1.1 (reserved space for metadata)?

> Hmm, I guess that we should calculate how many pages are going to fit
> into the filesystem and cap it on a sane number as well, so that the
> test runs for a reasonable time if user passed a real and big block
> device, so something as:

> num_pages = MIN(tst_device->size/(2*page_size), 15);

Thanks! Sounds reasonable, I'll retest.

> >  testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
> > index f7f6275cbd..edb6335d9e 100644
> > --- a/testcases/kernel/syscalls/cachestat/cachestat01.c
> > +++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
> > @@ -67,7 +67,7 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)

> >  static void run(unsigned int use_sync)
> >  {
> > -	for (int i = 0; i < 15; i++)
> > +	for (int i = 0; i < page_size > 4096 ? 13 : 15; i++)

> Uff, this is starting to look like perl...

OK, using variable makes things readable.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
