Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA325C636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 14:13:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0CA3CC1AC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 15:13:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1126C3CC139
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:13:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 764391A00E0F
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:13:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D8E134254;
 Wed,  8 Feb 2023 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675865591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1umj43KTKQUdFGbkFIesi3d21xKvSwdK2sAbwxUQG4=;
 b=ZqGDPfuo8VUhRuMHqztGO9bNWybW/offinDbibuq4tACIdszzN3/pnUNOUSi22jULy6AJm
 y3FTJubyKmFLAXpyKEgOsuZDrj31+6CpA7GC0ZvtDDSG4vUCpdpSzy96MYs3JDUvUZjobD
 98i0xffG02Qu7KD2OzftLlrwbCDRgCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675865591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1umj43KTKQUdFGbkFIesi3d21xKvSwdK2sAbwxUQG4=;
 b=hG8ItSyllGDiC8JsbinlSRXB4DCrLry/IBPm+XYUlvXJxcDhX5u5ZtMoAvhpUAWl5oqUOm
 IIJcXwPUevhiicAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5718C1358A;
 Wed,  8 Feb 2023 14:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HtM4FPet42OyHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Feb 2023 14:13:11 +0000
Date: Wed, 8 Feb 2023 15:13:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230208141309.GC31469@pevik>
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230208135404.GB31469@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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

> Hi Li,

> > > +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"

> > Hidden the device path parameter is a good idea.

> > But maybe can we add a function to find available char devices instead
> > of using the tty0 as default? In that function, we do the S_ISCHR() check
> > and return the valid path of it. Then the rest test (e.g. ioctl02) can make
> > use of it but not set the specified device as well. WDYT?

> FYI I'm using S_ISCHR() in other patches, which check if device can be used.
> Implementing search looks like a good idea. Are useful files any /dev/tty*
> (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> or include other paths?

I also wonder if we still want to keep -D parameter (i.e. allow tester to pass a
file).

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
