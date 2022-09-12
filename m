Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1574C6FA83
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 20:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BDFE3CAADF
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 22:43:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A085A3C0475
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:43:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10608600847
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:43:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4171C20C36;
 Mon, 12 Sep 2022 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663015392;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4zDy2IPgtyURDU/Jgx6iyaccdfpM9uJpp9VwTWwPD8=;
 b=RFawNE3Q1rAjywOXaSRT4rw2HxEPjjZnV+hjQqH4uxhDylfbX4r1PHuvzVkFlmeYQYe21o
 DdWpZ/7JARSEmwrsYFDXH8PfaPibbtOvoiE5El6DfNQ0JqM9fKeJbZkY2BF6+7MZAEi4h2
 FTHR0hrkL7BuVUCJyJkuSe1PxPvQF2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663015392;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4zDy2IPgtyURDU/Jgx6iyaccdfpM9uJpp9VwTWwPD8=;
 b=+TCeH8Q6k7+iWmAncG4Yf1SXuPwzOYCl29c1eahYwVzn25ACSA9ixsxeL9Ah85w7EWpRjU
 n4q9TPkdm3M305Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE149139E0;
 Mon, 12 Sep 2022 20:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zGsUON+ZH2OrRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 20:43:11 +0000
Date: Mon, 12 Sep 2022 22:43:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx+Z3sHxj0h5vGgO@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-7-pvorel@suse.cz> <Yx9L3SfGpS9LlcEi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx9L3SfGpS9LlcEi@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 06/10] shell: Add $TST_SKIP_FILESYSTEMS + tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > +++ b/testcases/lib/tst_test.sh
> > @@ -626,6 +626,7 @@ tst_run()
> >  	local _tst_max
> >  	local _tst_name
> >  	local _tst_pattern='[='\''"} \t\/:`$\;].*'
> > +	local ret

> >  	if [ -n "$TST_TEST_PATH" ]; then
> >  		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
> > @@ -644,6 +645,7 @@ tst_run()
> >  			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
> >  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
> >  			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
> > +			SKIP_FILESYSTEMS);;
> >  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
> >  			esac
> >  		done
> > @@ -675,6 +677,10 @@ tst_run()
> >  			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
> >  	fi

> > +	tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
> > +	ret=$?
> > +	[ $ret -ne 0 ] && return $ret

> So we actually depend here on the tst_supported_fs return value. So at
> least we have to do return TCONF in the helper binary even if ve move
> the messages into the library.

Yes. This is the equivalent of code in do_test_setup() (i.e. handling skipped
filesystems when testing single filesystem - *not* doing all filesystems loop).

Again, have C API function for looping filesystems and for single
filesystem would help avoiding duplicity, but not sure how to keep things simple
and readable. I'll try to think about it, but hints are welcome :).

Kind regards,
Petr

> >  	_tst_setup_timer

> >  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
> > -- 
> > 2.37.3

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
