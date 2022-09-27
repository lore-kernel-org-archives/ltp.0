Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE3CC07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 08:10:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE2433CAE02
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 10:10:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D573C1BAD
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 10:10:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 750B31A00E1E
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 10:10:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B57E1F8A4;
 Tue, 27 Sep 2022 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664266239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0e1hsKfdTwHC1wAy9vY6DK4okkwyZeD6RUGXvC1EcgA=;
 b=DVMUNPXVawNTS1iMslr800uKYMsfu3LRYiJjKqyyFlAXbuFbCeQ0hBmQKxBfBHHcr7QsSx
 3XYVBjMs1lAVsdFrpoM7XMXw83+j8rEMXPhn/VxPTEikEQWMqi+yQZ3FV8T3jDO7BvULu8
 DWxChTudU+mBL4tfGo1TqH9uf9JHlsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664266239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0e1hsKfdTwHC1wAy9vY6DK4okkwyZeD6RUGXvC1EcgA=;
 b=d2LdoVUeXZvkX1ZZxVuJ8c41r8qlXsDVGThI9edX+IGbIkQ2DXgBlzk976xPbBs2GQ+RxH
 DIpgCx+CSEKxSkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C96C1139B3;
 Tue, 27 Sep 2022 08:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l0OkL/6vMmP3DwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Sep 2022 08:10:38 +0000
Date: Tue, 27 Sep 2022 10:10:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YzKv/ClILufSy3up@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
 <YzF3wLk9cMTdU1z7@yuki>
 <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
 <CAEemH2e6Dzm1ydZt1VZvoxZN4xXyrSZua5jmfxeci8SyXNc2tw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e6Dzm1ydZt1VZvoxZN4xXyrSZua5jmfxeci8SyXNc2tw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

...
> 2. df01 got strange failures on XFS (I was unable to reproduce it manually)

>     71 df01 37 TINFO: === Testing on xfs ===
>     72 df01 37 TINFO: Formatting xfs with opts='/dev/loop0'
>     73 df01 37 TINFO: Mounting device: mount -t xfs /dev/loop0
> /mnt/testarea/ltp-pgxzTJRwdG/LTP_df01.IFAhWHNrYb/mntpoint
>     74 df01 37 TINFO: timeout per run is 0h 10m 0s
>     75 df01 37 TPASS: 'df -P' passed.
>     76 total: 301728, used: 17736
>     77 df saved output:
>    ...
>    135 df01 38 TFAIL: 'df -a -P' failed, not expected.
>    136 df01 39 TPASS: 'df -i -P' passed.
>    ...
>    160 df01 40 TFAIL: 'df -k -P' failed, not expected.
>    161 df01 41 TPASS: 'df -t xfs -P' passed.
>    ...
>    185 df01 42 TFAIL: 'df -T -P' failed, not expected.
>    186 df01 43 TPASS: 'df -v /dev/loop0 -P' passed.
>    187 df01 44 TPASS: 'df -h' passed.
>    188 df01 45 TPASS: 'df -H' passed.
>    189 df01 46 TPASS: 'df -m' passed.
>    190 df01 47 TPASS: 'df --version' passed.
>    191 df01 48 TPASS: 'df -x xfs -P' passed.
This is known:
https://lore.kernel.org/linux-xfs/YvZTpQFinpkB06p9@pevik/

I've mention that yesterday, that I'll fix it after the release
https://lore.kernel.org/ltp/YzGDdC76DLmrJyys@pevik/
I'll try to send a patch soon and we can decide whether we merge it before
release or not.

And zram01.sh fails due XFS minimal size. I also try to send a patch soon.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
