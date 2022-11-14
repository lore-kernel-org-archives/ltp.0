Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30376C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:00:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53DB3CD23E
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:00:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3179B3C28F3
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 10:59:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 092F66001E9
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 10:59:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 00EA922926;
 Mon, 14 Nov 2022 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668419997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBelfozj1LxbQloTtYjj8BxnB/cuyhuaOaSJQOKm3Ow=;
 b=jRe/W7oYrCamqXwmjGynQ5vB+3f7P3F0YMNpkgh0EBNwB38bw652caEsTy9sJXmzp6n/rF
 5HQ60fLud3GUoQZfnZk81AC23601ugCdfLPHME40ypn/KzCkXvIY1okT2lnEcnYVRaVIGY
 /HTPAm8Z4ExZYh0X6pvnzVWTrTo0AGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668419997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBelfozj1LxbQloTtYjj8BxnB/cuyhuaOaSJQOKm3Ow=;
 b=+NhF0nQuTreLoGuvDbwXv1e8LdJaA/KZlQnpxHdCQ6zFBguOANbrrNjFWfj/kEMrvo+i2d
 740EBu9HPrCp6rCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AD51D2C141;
 Mon, 14 Nov 2022 09:59:56 +0000 (UTC)
References: <20221027215808.4126148-1-edliaw@google.com>
 <20221027215808.4126148-2-edliaw@google.com> <8735atww9l.fsf@suse.de>
 <87y1slvgkm.fsf@suse.de> <Y25+IZDZ9/rvSH+E@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 09:44:56 +0000
Organization: Linux Private Site
In-reply-to: <Y25+IZDZ9/rvSH+E@pevik>
Message-ID: <875yfhvotj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/1] mmapstress01: refactor to tst_test
 framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Edward, Richard, all,
>
>> Hello,
>
>> Richard Palethorpe <rpalethorpe@suse.de> writes:
>
>> > Hello,
>
>> > Edward Liaw via ltp <ltp@lists.linux.it> writes:
>
>> >> Use ltp framework and apply make check corrections.  Reorder functions
>> >> and variables.  Use safe macros.
>> >> Drop leavefile option.
>> >> Build tests with FILE_OFFSET_BITS=64 instead of doing LARGE_FILE checks
>> >> to switch between 32 and 64 bit types and syscalls.
>> >> Define fsize bounds by file offset bits.
>> >> Move sighandler to setup and remove sig blocks.
>> >> Add option to specify pattern.
>> >> Set default nprocs to ncpus with min of 1 and max of 20.
>
>> >> Signed-off-by: Edward Liaw <edliaw@google.com>
>
>> > Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>
>> > Will merge this today if the CI is happy and nobody comments.
>
>> Merged, thanks!
>
> Thanks for your work! FYI 2 tiny problems sneaked in, see below.
>
> runtest/mm contained -t 0.20 option, which caused failure. Fixed in:
> https://github.com/linux-test-project/ltp/commit/36321277a294c0467219f650fd76aa1a8d310c1d
>
>> >> ---
>> >>  testcases/kernel/mem/mmapstress/Makefile      |   2 +
> ...
>> >> +static struct tst_option options[] = {
>> >> +	{"d", &debug, "Enable debug output"},
>> >> +	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
>> >> +	{"m", &do_sync, "Do random msync/fsyncs as well"},
>> >> +	{"o", &do_offset, "Randomize the offset of file to map"},
>> >> +	{"p:", &opt_nprocs,
>> >> +	 "Number of mapping children to create (default 1 < ncpus < 20)"},
>> >> +	{"P:", &opt_pattern,
>> >> +	 "Use a fixed pattern (default random)"},
>> >> +	{"r", &randloops,
>> >> +	 "Randomize number of pages map children check (random % 500), "
>> >> +	 "otherwise each child checks 500 pages"},
>> >> +	{"S:", &opt_sparseoffset,
>> >> +	 "When non-zero, causes the sparse area to be left before the data, "
>> >> +	 "so that the actual initial filesize is sparseoffset + filesize "
>> >> +	 "(default 0)"},
>> >> +	{},
>> >> +};
> Using options as non-inline leads to our docparse documentation
> having the name of the variable (options) i this case instead of listing
> options.  Fixed in
> https://github.com/linux-test-project/ltp/commit/72de038ff54496c5ced6ddc2d76713376aababb1
>
> @Metan: I wonder if this can be fixed in docparser.
> @Richie: If not, it would be nice to have check for it (I'll add issue with
> "check" label).

Yeah, the checker could also produce the metadata. I'm not sure I want
to start down that path though. This is an AST level operation which
Sparse is pretty bad at.

I think both tools have serious issues. Perhaps using tree-sitter or
even Arocc would be far more profitable.

>
> @Edward FYI to build doc:
> cd metadata && make # open ../docparse/metadata.html
>
> Here is stable version:
> http://linux-test-project.github.io/metadata/metadata.stable.html
>
> I plan to write hook to put version for master branch, being updated after each
> commit.
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
