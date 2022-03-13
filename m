Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E207C433F5
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 21:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146C13C91B6
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 22:48:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17A473C0CEA
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:48:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8316F60004C
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:48:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76E67210FE;
 Sun, 13 Mar 2022 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647208085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Sfvtb44OjFVob5KA3wQpNa3ntNZCJNbpdJhyYlxO98=;
 b=WgEv2UEVtEpG8MkQxImZnWXpS8YoIm3VSkbSMX6hpyfJjYgcvd692iWBCxWcV8V9hQE7K3
 3nITkY3bNiCydpIbKeINNMv0XNYM5vTbcQCSJ3wNL74HyCHHoByWI/wGQzk7uYlx00fam4
 XNDtH3xu2NktYbBJvpWFyrzIq8W+WaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647208085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Sfvtb44OjFVob5KA3wQpNa3ntNZCJNbpdJhyYlxO98=;
 b=p1hYH7mdUnKpXrAs2QjE7iOD0TtRfBnJv8B74c9kqkGJETGvnhhWym5Xz14MSgMU0zRFrI
 KcHblxgJuO/QbmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3596813B18;
 Sun, 13 Mar 2022 21:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q8sdC5VmLmKoMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 13 Mar 2022 21:48:05 +0000
Date: Sun, 13 Mar 2022 22:48:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yi5mk+4tTDa6AmQ6@pevik>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-4-pvorel@suse.cz> <Yitcifh+HxHMce/T@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yitcifh+HxHMce/T@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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

> > +| 'TST_FORMAT_DEVICE'      | Format a block device with a filesystem, see
> > +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]

> Hm, I guess that we already have a few absolute links in the docs to a
> github.com wiki, but I do not like it that much. I guess that realtive
> links does not work, right?

AFAIK it does not in AsciiDoc format (not sure about other, but we don't want to
switch anyway). I guess I can keep it as we don't have any better solution,
right?

> > +|                          | See also 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
> > +|                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
> > +| 'TST_FS_TYPE'            | Override the default filesystem to be used.
> >  | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
> >  |                          | Alternatively the 'tst_require_root' command can be used.
> >  | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
> > @@ -495,7 +504,25 @@ tst_random 0 1000
> >  Formatting device with a filesystem
> >  +++++++++++++++++++++++++++++++++++

> > -The 'tst_mkfs' helper will format device with the filesystem.
> > +'TST_FORMAT_DEVICE=1' can be used to format device before running the test.
> > +Uses '$TST_FS_TYPE' (used filesystem, by default ext2), '$TST_DEVICE' (used
>                               ^
> 			      I would removed this part and keep only
> 			      the (by default ext2)
> > +block device, usually prepared by 'TST_NEEDS_DEVICE=1'), '$TST_DEV_FS_OPTS'

> and rewrote this part no to be in the parentheses as:

> '$TST_DEVICE' a block device to be formatted, usually prepared by the
> library (TST_NEEDS_DEVICE=1 must be set).

> > +('mkfs' options _before_ the device name) and '$TST_DEV_EXTRA_OPTS'
> > +(extra 'mkfs' options _after_ the device name).

> And remove the parentheses here as:

> '$TST_DEV_FS_OPTS' a 'mkfs' options _before_ the device path and
> '$TST_DEV_EXTRA_OPTS' extra 'mkfs'' options _after_ the device path.

Agree with all of this.


> Other than that and the test1() pointed out by Yang Xu:
I suppose this is what you mean: s/test1/test/, right?

+++ doc/shell-test-api.txt
@@ -517,7 +517,7 @@ TST_DEV_FS_OPTS="-b 1024 -O quota"
 TST_DEV_EXTRA_OPTS="5m"
 TST_TESTFUNC=test

-test1()
+test()
 {
        tst_res TPASS "device formatted"
 }


> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
