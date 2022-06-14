Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9382EC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:34:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AAEB3C94AA
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 15:34:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D766A3C06E0
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:34:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 544EA600842
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:34:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83E371F90F;
 Tue, 14 Jun 2022 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655213669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2gPJx/i9efLgtBeuVBSS1jGbSFrsgtzweU6RFT9t0QY=;
 b=Ll8TD9D7s7NtM853zT0ag9A6ZE5VNhU8lbcWjhdYutZGpnqof6rBllpuDJfW5fGYgLbTli
 aZmOaAXmtYYeV3T8SmY76DZraYDHAtuVlPVUN+fCvgwb/k9/Fp0qC4VMnKNmI5tNo4e6rm
 U7ugGLgaXxdVdBjAdI2TAh3zvtUqO2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655213669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2gPJx/i9efLgtBeuVBSS1jGbSFrsgtzweU6RFT9t0QY=;
 b=hBWQM6cuqV6unRIY+mbn9Yq5MgVl6CC0v7EsOX7B5FIv8LrYRqPQoVjpG0zRibRAGk8MaI
 M51wdmKJ4ZOl1DDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6145D139EC;
 Tue, 14 Jun 2022 13:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eIV6FmWOqGIALAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jun 2022 13:34:29 +0000
Date: Tue, 14 Jun 2022 15:34:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YqiOY2obFxbj//We@pevik>
References: <20220613125153.20423-1-chrubis@suse.cz> <YqdKVngCCGUfFDCZ@pevik>
 <YqiHVJhvhf16s2kL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqiHVJhvhf16s2kL@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve06: Add test for argv[0] = NULL
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

> > I wonder why this does not work:
> > 	.needs_cmds = (const char *[]) {
> > 		"execve06_child",
> > 		NULL
> > 	},

> > tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> > execve06.c:33: TFAIL: Failed to execute execl01_child: ENOENT (2)
> > tst_test.c:395: TBROK: Invalid child (23451) exit value 1

> The difference is because the test library adds current directory and
> test start directory into $PATH before a test is executed, see
> add_paths() in the tst_test.c.

> The .needs_cmds is for binaries installed on the system in /usr/bin/
> etc. so it does not make much sense to call the add_paths() before we
> process the array.
Thx!

...
> > Testing matches the description from kernel commit.
> > Maybe also test for argv[0] being empty string (to make sure behavior does not
> > change, although unlikely it'd change)?

> It should be safe either way but I decided to be less specific and only
> check that something have been added there.
Sure.

> > I tested it on various kernels, works as expected.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>

> I will push it with the added runtest entries and fixed copyright then.
Thx!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
