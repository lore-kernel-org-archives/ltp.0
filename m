Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833C2C4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 16:05:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09C633C9C76
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 17:05:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D84D63C9787
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 17:05:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 540771000F6F
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 17:05:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25ACC1F38E;
 Wed,  9 Feb 2022 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644422706;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvbdAQ93TjjTwyHtKDv2N2HEE45IkFzRImT0hqBv4q8=;
 b=nyFKhwrHH8jtiADRAuAAfXHJmYFEU0X/fr2F9JEUKYhRX5ULZg3pcmzgd5IctQnIILE5dY
 yWB3fUpGktPLybAeU/h6oUSJ9GhLQgEZraTIiZBmqVuXps7Fm/ed8DwNE2AXzsJRBDOpbJ
 vIvPOhuqMAqf16jsTlz54PYEYjSgD4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644422706;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvbdAQ93TjjTwyHtKDv2N2HEE45IkFzRImT0hqBv4q8=;
 b=Xphb/YmhrvO5GRJG0Rqngj0e2cK266kk7tEb7q8VqdkhWft4i/if+AeDCRAZC/wuxH/u8+
 rM+qnHNQ+O6v0nAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B40113D58;
 Wed,  9 Feb 2022 16:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q5ftDDLmA2J5IQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Feb 2022 16:05:06 +0000
Date: Wed, 9 Feb 2022 17:05:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <YgPmMP21/M5PiK8b@pevik>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-3-pvorel@suse.cz> <YgJ47NfU3vP3XcyE@yuki>
 <YgKxkgXjqRXfHDF1@pevik> <YgK2a1maq9GGsgnZ@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgK2a1maq9GGsgnZ@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

> Hi Cyril,

> > > > +++ b/testcases/lib/tst_test.sh
> > > > @@ -343,9 +343,8 @@ tst_mkfs()
> > > >  	[ -z "$fs_type" ] && fs_type="$TST_DEFAULT_FS_TYPE"

> > > >  	local device=${2:-$TST_DEVICE}
> > > > -	[ $# -ge 1 ] && shift
> > > > -	[ $# -ge 1 ] && shift
> > > > -	local fs_opts="$@"
> > > > +	local fs_opts="$3"
> > > > +	local extra_opts="$4"

> > > Doesn't this actually break the examples described in the
> > > doc/shell-test-api.txt?

> > > There we do have:

> > > tst_mkfs ext4 /dev/device -T largefile

> > > Which obviously parses as "-T" in the fs_opts and "largefile" in the
> > > extra_opts.
> > Good catch, I forget to check examples in docs.

> > -T largefile would have to be quoted:
> > tst_mkfs ext4 /dev/device "-T largefile"


> > > I do not think that the support for extra opts can be added this way
> > > without redesigning the tst_mkfs API. Maybe it would make more sense to
> > > just pass the parameters in the same way we end up passing them on a
> > > command line, i.e. we would only interpret the first parameter passed to
> > > tst_mkfs as a filesystem type and pass the rest as $@.

> > But then you'd have to always pass a device ($TST_DEVICE).
> > And the problem is that I wanted to specify the options before loading
> > tst_test.sh (together with TST_FORMAT_DEVICE=1). At this point TST_DEVICE
> > is empty string. Therefore I'd prefer to quote fs-options to be passed to
> > tst_mkfs as single option.
> OK, now I understand you. It's all about tst_mkfs having $1, shift and rest $@.
> And we avoid quoting as you suggested :).

> But TST_* variables in stay the same. => I'll implement it in v2.

Cyril, we forget on think: when passing everything as $@, we just don't know
what is the device.

Thus I'll change
tst_res TINFO "Formatting $device with $fs_type opts='$fs_opts' extra opts='$extra_opts'"
with
tst_res TINFO "Formatting $fs_type with opts='$opts'"

It's just a minor logging problem.
We also loose check for missing device, that's not ideal as it's mandatory, thus
I'll add some check when using the default $TST_DEVICE.

Kind regards,
Petr

> Thanks!

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
