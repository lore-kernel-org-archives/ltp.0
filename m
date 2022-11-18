Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E771C433FE
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 13:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E622B3CCECA
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 14:30:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C5243CCE37
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:30:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B5B21C827E4
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:30:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7043522505;
 Fri, 18 Nov 2022 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668778209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rfjHtAvrcJFEoM7+TVLFcTfbbCSnTKzlfWV12vu2Ajw=;
 b=vCWKTin2aE9dzHpc28sxeyAW2dy3iqpXb65QjwIhPkvybZDisc+uSIB9nCeiIoELq2UVW/
 dc2OTKX4n1AsCzQ2XrCKTBaeChZiY+ENbgGti5L81TFoKdc9FAW8mzj/0iOemlpLYhawAq
 wQCTV9/hXUVClSgil0FTN4l76+KQ5hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668778209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rfjHtAvrcJFEoM7+TVLFcTfbbCSnTKzlfWV12vu2Ajw=;
 b=ZaELaVDf2H7bO/Ayn3elM027aRN+w7tgV4Hwisw9OOBzGxvaMXnC3iYCa9aczZaCAL3NeP
 yZEQVG04Zv5TmXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B09213A66;
 Fri, 18 Nov 2022 13:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id //xjE+GId2OrKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Nov 2022 13:30:09 +0000
Date: Fri, 18 Nov 2022 14:31:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y3eJNAi81ucutljP@yuki>
References: <20221116160715.10082-1-mdoucha@suse.cz>
 <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
 flags
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)
> > +#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)
> > +#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)
> >
> 
> I'd suggest using "_TSKIP" to replace "_SKIP' to be consistent.
> Then the whole format will look quite perfect and easy to memorize:).

I think that it makse sense to keep it as _SKIP because that is the
option that does not map directly to the test result flags. If we named
it TSKIP people will be confused that there is no TSKIP in the test
result flags at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
