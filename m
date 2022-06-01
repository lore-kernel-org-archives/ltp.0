Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0207C433FE
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 08:42:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D91F3C6A29
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 10:42:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D701A3C1C22
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 10:41:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6024E600F3B
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 10:41:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 818091F8CE;
 Wed,  1 Jun 2022 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654072917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4VYcEifM7SoT+NDLimNU0dISdc3B4dmv3sSvbSROjk=;
 b=mCmPbSnbSw7xo3IiuE13M8pl0bDD8nx1sEzM2qRyOp4n56Q56YG/ahFwNw4k0WM6AVmbNM
 8bOBUiLcSXrdgfYjB/H9Mpcd56zKFTG5T6qfT3CHFSF/XIhilruEtL4tNFG/Eg+s74q86C
 F7GBIVFSCToxx1+eS8f4nJi1ELoh7Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654072917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4VYcEifM7SoT+NDLimNU0dISdc3B4dmv3sSvbSROjk=;
 b=11k0L7ORoO3A7EoAWzipdsDEQLKPxzxqkPIjAyjDWNUZLECpi+o9IVT177Z5PkOzp2pfG2
 X02OQO1RU35ig+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A4601330F;
 Wed,  1 Jun 2022 08:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iP59DFUml2KnWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jun 2022 08:41:57 +0000
Date: Wed, 1 Jun 2022 10:41:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YpcmU75XxaHCh9dZ@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-7-pvorel@suse.cz> <YpYJI7khXNJOjU4/@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpYJI7khXNJOjU4/@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/8] tst_test.sh: Add $TST_ALL_FILESYSTEMS
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +	[ "$TST_ALL_FILESYSTEMS" = 1 ] && TST_MOUNT_DEVICE=1
> >  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
> >  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
> >  	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1

> > +	if [ "$TST_NEEDS_DEVICE" = 1 -a -z "$TST_MOUNT_FLAG" ]; then

> I do not get the TST_MOUNT_FLAG, what do we need it for? The tst_run()
> should be called exactly once in the test and at this point the
> TST_MOUNT_FLAG cannot be set.

Correct, $TST_MOUNT_FLAG should be removed here.
Thanks,
Petr

> > +		TST_DEVICE=$(tst_device acquire)
> > +
> > +		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
> > +			unset TST_DEVICE
> > +			tst_brk TBROK "Failed to acquire device"
> > +		fi
> > +		TST_DEVICE_FLAG=1
> > +	fi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
