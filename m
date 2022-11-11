Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE51C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 16:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B45BE3C7621
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 17:54:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8424A3C7621
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 17:53:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1597600F7B
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 17:53:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 06FC02021E;
 Fri, 11 Nov 2022 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668185636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8u/z8V07GfsbzEl1Wm910evNicVui6ApCqwZpScfRmM=;
 b=RhfF1ErDKBRYvHoIgzxWQwtb6+NhwYiPiHWvWvkky1SituSaie1adbJHbhBQ2JJzf9oXNO
 uxfVatvhUiWv5zw+kTQ5qifn35gfbAjBDxyRTdCGVp9Uqr0/ANRwTGYQ3m5OuEMRnVHEPz
 ZwOA2t5CaTT/WQ+2KCrJvUUdTWo2xug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668185636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8u/z8V07GfsbzEl1Wm910evNicVui6ApCqwZpScfRmM=;
 b=/55YNfvuHrsQJkeDejOENSuIv29EQiOFvV4IEXjAQtD7vn3GqOsFVXAZaqdNRpDvOMQgyR
 obhZWErPTV+Yb9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C85BE13357;
 Fri, 11 Nov 2022 16:53:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a1B/LyN+bmPtYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 16:53:55 +0000
Date: Fri, 11 Nov 2022 17:53:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y25+IZDZ9/rvSH+E@pevik>
References: <20221027215808.4126148-1-edliaw@google.com>
 <20221027215808.4126148-2-edliaw@google.com>
 <8735atww9l.fsf@suse.de> <87y1slvgkm.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1slvgkm.fsf@suse.de>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, Richard, all,

> Hello,

> Richard Palethorpe <rpalethorpe@suse.de> writes:

> > Hello,

> > Edward Liaw via ltp <ltp@lists.linux.it> writes:

> >> Use ltp framework and apply make check corrections.  Reorder functions
> >> and variables.  Use safe macros.
> >> Drop leavefile option.
> >> Build tests with FILE_OFFSET_BITS=64 instead of doing LARGE_FILE checks
> >> to switch between 32 and 64 bit types and syscalls.
> >> Define fsize bounds by file offset bits.
> >> Move sighandler to setup and remove sig blocks.
> >> Add option to specify pattern.
> >> Set default nprocs to ncpus with min of 1 and max of 20.

> >> Signed-off-by: Edward Liaw <edliaw@google.com>

> > Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> > Will merge this today if the CI is happy and nobody comments.

> Merged, thanks!

Thanks for your work! FYI 2 tiny problems sneaked in, see below.

runtest/mm contained -t 0.20 option, which caused failure. Fixed in:
https://github.com/linux-test-project/ltp/commit/36321277a294c0467219f650fd76aa1a8d310c1d

> >> ---
> >>  testcases/kernel/mem/mmapstress/Makefile      |   2 +
...
> >> +static struct tst_option options[] = {
> >> +	{"d", &debug, "Enable debug output"},
> >> +	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
> >> +	{"m", &do_sync, "Do random msync/fsyncs as well"},
> >> +	{"o", &do_offset, "Randomize the offset of file to map"},
> >> +	{"p:", &opt_nprocs,
> >> +	 "Number of mapping children to create (default 1 < ncpus < 20)"},
> >> +	{"P:", &opt_pattern,
> >> +	 "Use a fixed pattern (default random)"},
> >> +	{"r", &randloops,
> >> +	 "Randomize number of pages map children check (random % 500), "
> >> +	 "otherwise each child checks 500 pages"},
> >> +	{"S:", &opt_sparseoffset,
> >> +	 "When non-zero, causes the sparse area to be left before the data, "
> >> +	 "so that the actual initial filesize is sparseoffset + filesize "
> >> +	 "(default 0)"},
> >> +	{},
> >> +};
Using options as non-inline leads to our docparse documentation
having the name of the variable (options) i this case instead of listing
options.  Fixed in
https://github.com/linux-test-project/ltp/commit/72de038ff54496c5ced6ddc2d76713376aababb1

@Metan: I wonder if this can be fixed in docparser.
@Richie: If not, it would be nice to have check for it (I'll add issue with
"check" label).

@Edward FYI to build doc:
cd metadata && make # open ../docparse/metadata.html

Here is stable version:
http://linux-test-project.github.io/metadata/metadata.stable.html

I plan to write hook to put version for master branch, being updated after each
commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
