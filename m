Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB04DC0218F
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 11:58:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ED183C7B16
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 12:58:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EB633C6609
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 12:58:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED5281A027B3
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 12:58:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E35401F38D;
 Fri, 31 Jan 2025 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738324709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8MZ4QFi5oVaD/FqGIUBmljJPZAveMf5fsbgXHLe25U=;
 b=tB/0yS1RxPXvqiZjIKXmjpiu0cOCxpdZ9qqPvbMZaJNGVGlBIem/uRHiqzZYaCkkv9kG3U
 A5mhqS2Gyel4P/gV7Vg+g5FwKqaIRqfAYaofYuR4OwYZxjCRuAtqmtupCho18E0sHYPrIh
 6U30+L2rkuq7svRvgoTluEn/5FL+hg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738324709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8MZ4QFi5oVaD/FqGIUBmljJPZAveMf5fsbgXHLe25U=;
 b=wQpCFZ+QOaojH6mOultI+3JLZqJbkwjEANNwwmKjjmOrlrDiLMpyxKk4p7YPWOMxLW9UEd
 RP9WaUSKicHzf1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738324709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8MZ4QFi5oVaD/FqGIUBmljJPZAveMf5fsbgXHLe25U=;
 b=tB/0yS1RxPXvqiZjIKXmjpiu0cOCxpdZ9qqPvbMZaJNGVGlBIem/uRHiqzZYaCkkv9kG3U
 A5mhqS2Gyel4P/gV7Vg+g5FwKqaIRqfAYaofYuR4OwYZxjCRuAtqmtupCho18E0sHYPrIh
 6U30+L2rkuq7svRvgoTluEn/5FL+hg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738324709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8MZ4QFi5oVaD/FqGIUBmljJPZAveMf5fsbgXHLe25U=;
 b=wQpCFZ+QOaojH6mOultI+3JLZqJbkwjEANNwwmKjjmOrlrDiLMpyxKk4p7YPWOMxLW9UEd
 RP9WaUSKicHzf1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C08A8133A6;
 Fri, 31 Jan 2025 11:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jtaqLeW6nGeDSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 11:58:29 +0000
Date: Fri, 31 Jan 2025 12:58:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250131115828.GB1116925@pevik>
References: <20250131091535.GB1090737@pevik>
 <92cb274a-440a-42e5-95ab-5dd0e1513074@suse.com>
 <20250131103451.GA1097590@pevik>
 <f635d8c0-41ba-47ec-9c85-85d36b756215@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f635d8c0-41ba-47ec-9c85-85d36b756215@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Remove [Description] subtitle from docparse
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

Hi Andrea,

> On 1/31/25 11:34, Petr Vorel wrote:
> > Hi Andrea,

> > > Hi Petr,
> > > I'm currently working on parsing metadata in order to produce a tests list
> > > in the LTP documentation.
> > FYI I planned to work on it (announced in ML [1]), but since you started I stop
> > working on it.
> I'm sorry, I didn't read carefully. The results will come out soon tho, I
> will send the patch-set soon.

Not a big deal, just sometimes it might happen more people are implementing the
same thing.

> > > I just replace "[Description]" with "**Description**". Same for
> > > "[Algorithm]".
> > > I would keep the bold version tho, with the double star **.
> > We talk about a different things. You about the conversion of the subtitles to
> > the final documentation (previously was done in docparse/testinfo.pl, now you
> > will do it in python).

> > But I'm suggesting to entirely remove subtitle "Description". It looks to me
> > useless and some people don't add it thus docs looks inconsistent.
> The thing is that there's not only [Description], but there's also
> [Algorithm]. Maybe we can think about the tests description as a whole RST
> code that will be injected inside the documentation website once it's
> published. In this way, conversion would be much easier.

As I wrote to Cyril:
The reason why suggested to remove it is that I don't see much information value
in "Description" title. "Algorithm" has at least little bit of information value.

Besides these two we have only:
* [Prerequisites] (testcases/kernel/mem/ksm/ksm07.c)
* [Race Description] (testcases/kernel/syscalls/fork/fork13.c)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
