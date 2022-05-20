Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7C9C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:51:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580193CAB0D
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:51:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B91523C021D
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:51:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 977EA200BC5
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:50:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E18BC1FA42;
 Fri, 20 May 2022 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653047458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Elave8608Lp9y9MqFmqOED3+xiV8mUeUOEDwXT6L7Ks=;
 b=wQWoBxa8+2+EsTgJ8d4K8+0ZD1TGUxPG8wWQb6NzySJYR2A9v0r6gnJ0SkhcaUBTSvf2Xb
 8rwaGLcAbzFLwI6s1NGjY8YUnDaXjYW6Xu58tf6gF9DIOuNYEp8BhweXzKp3mtlAFcnL22
 COb6NWKUm8nKe1KG77UXBnsHP/52/Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653047458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Elave8608Lp9y9MqFmqOED3+xiV8mUeUOEDwXT6L7Ks=;
 b=B0b5HA5G8XBCj6DIxZ1g8gLzcZn938irffn/jhDTOCS3kWh8LejPW1mMK4tX0Dw9/qt4f2
 3jd89rLK/v6YI7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF9C613AF4;
 Fri, 20 May 2022 11:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YiJSLaKAh2IkNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 11:50:58 +0000
Date: Fri, 20 May 2022 13:50:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YoeAoLQ0Wfp7SOJb@pevik>
References: <20220519121056.1181-1-mdoucha@suse.cz> <Yodes44v5tnei8p9@yuki>
 <e5fd3db9-d113-c3b0-82a6-58d45bb4a246@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5fd3db9-d113-c3b0-82a6-58d45bb4a246@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pty07: Resize console to the same size as
 before
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

> On 20. 05. 22 11:26, Cyril Hrubis wrote:
> > I guess that the actual size we pass to VT_RESIZEX does not matter when
> > we attempt to trigger the race.

> I've tested this on SLE-15SP1 GM kernel which is older than the fix and
> this version still triggers the crash. Technically we could even pass
> all zeroes which would simply leave all console parameters unchanged and
> it'd still work because the ioctl implementation sets a flag in the
> freed memory anyway. But that behavior might change in the future so
> I've decided to just set the rows and cols to the values queried from
> kernel.

+1. Merged this one, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
