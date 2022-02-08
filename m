Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC9FC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:29:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AE7D3C9B47
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 19:29:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23A053C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:29:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD83A1A00CA1
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:29:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2ECFF210F0;
 Tue,  8 Feb 2022 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644344941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk/sbucxV0S0Ns165b4u6hf8qlo+33p5khdyeYxUlS4=;
 b=VnFAJu1wdZ+c9IEsBfg+U+rG6tZ+1j+iHm1sQoKdPV2peSByGePBdkxLOtnsLNfzNkusM+
 u0zm/6kNCtQskCm2wG176NKqOgrXMQeoxxVvm2aSUjCu/OSe1Kjs1lnIoNYk+LDdUuxuV+
 Q5+DnjFp7w0IQmOo6hLFLAanL0TsRzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644344941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zk/sbucxV0S0Ns165b4u6hf8qlo+33p5khdyeYxUlS4=;
 b=UuYLdJb6Hc6pel+MAUXefZJ+LYW6Q7mwd9I18+b05YROYkFOerF0Jyt8dX6RJC8BU57SgE
 8tJsY7wxkoMpQ1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C96E13CDC;
 Tue,  8 Feb 2022 18:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e3NwAW22AmJvfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 18:29:01 +0000
Date: Tue, 8 Feb 2022 19:28:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <YgK2a1maq9GGsgnZ@pevik>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-3-pvorel@suse.cz> <YgJ47NfU3vP3XcyE@yuki>
 <YgKxkgXjqRXfHDF1@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgKxkgXjqRXfHDF1@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] tst_test.sh: tst_mkfs(): Add support for
 extra opts
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

Hi Cyril,

> > > +++ b/testcases/lib/tst_test.sh
> > > @@ -343,9 +343,8 @@ tst_mkfs()
> > >  	[ -z "$fs_type" ] && fs_type="$TST_DEFAULT_FS_TYPE"

> > >  	local device=${2:-$TST_DEVICE}
> > > -	[ $# -ge 1 ] && shift
> > > -	[ $# -ge 1 ] && shift
> > > -	local fs_opts="$@"
> > > +	local fs_opts="$3"
> > > +	local extra_opts="$4"

> > Doesn't this actually break the examples described in the
> > doc/shell-test-api.txt?

> > There we do have:

> > tst_mkfs ext4 /dev/device -T largefile

> > Which obviously parses as "-T" in the fs_opts and "largefile" in the
> > extra_opts.
> Good catch, I forget to check examples in docs.

> -T largefile would have to be quoted:
> tst_mkfs ext4 /dev/device "-T largefile"


> > I do not think that the support for extra opts can be added this way
> > without redesigning the tst_mkfs API. Maybe it would make more sense to
> > just pass the parameters in the same way we end up passing them on a
> > command line, i.e. we would only interpret the first parameter passed to
> > tst_mkfs as a filesystem type and pass the rest as $@.

> But then you'd have to always pass a device ($TST_DEVICE).
> And the problem is that I wanted to specify the options before loading
> tst_test.sh (together with TST_FORMAT_DEVICE=1). At this point TST_DEVICE
> is empty string. Therefore I'd prefer to quote fs-options to be passed to
> tst_mkfs as single option.
OK, now I understand you. It's all about tst_mkfs having $1, shift and rest $@.
And we avoid quoting as you suggested :).

But TST_* variables in stay the same. => I'll implement it in v2.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
