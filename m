Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B24C0015E
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 08:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAFD33CAE14
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 10:55:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D7F3C9422
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 10:55:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E8A710006D0
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 10:55:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F242A1F38A;
 Fri, 21 Jul 2023 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689929712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weWt2m3B8z0ZSRTjbPNHHOFtCfk6893P50rHQyCSb2g=;
 b=Ejt1vsTMXsrjbDZaQddcVgpR65b3rBg0fDVh8ohj+69LoQvtWeQd/iRX6u4KHJrhZ+1Th+
 +WySo5mtr1Re/Avn7dQ4oC9NtzB+ldKi+BW8qHVUF+/gELxI1dQzm7Wr9xj3aqiiKsP5of
 CwwajHmpdtL7XaV2baCGJh5GbO/NCi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689929712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weWt2m3B8z0ZSRTjbPNHHOFtCfk6893P50rHQyCSb2g=;
 b=ynq1TECL2k8iBiWlU3ODpiKamDMQHwC06Xxjhy0FVe4Gr18uNla8R6Y6truZmnSZt5Ij2d
 IyBIBo1Rs/s6GECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D353E134B0;
 Fri, 21 Jul 2023 08:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /yU7MvBHumQoYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 08:55:12 +0000
Date: Fri, 21 Jul 2023 10:55:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230721085511.GB1348273@pevik>
References: <20230720150206.1338520-1-pvorel@suse.cz>
 <20230720150206.1338520-2-pvorel@suse.cz>
 <86c5849a-50a2-f3b2-fad5-86ecdf73310e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86c5849a-50a2-f3b2-fad5-86ecdf73310e@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] tst_lockdown: Check other lockdown
 configuration
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

Hi Martin,

...
> > +	char flag;
> >   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
> > -		char flag;
> > -
> > +		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
> >   		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
> > -
> > -		/* SecureBoot enabled could mean integrity lockdown */
> >   		if (flag == 'y' && tst_secureboot_enabled() > 0)
> >   			return 1;
> >   		tst_res(TINFO, "Unable to determine system lockdown state");
> >   		return 0;
> > +	} else {

> There should be no "else" branch here. The code above should look like this:

> int flag;
> flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
> flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
> if (flag && tst_secureboot_enabled() > 0)
> 	return 1;

Good point. I don't know why I thought that the other not-yet upstreamed patch
created lockdown file. I'll send v2.

Kind regards,
Petr

> > +		/* SecureBoot forces lockdown (non-mainline version) */
> > +		flag = tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT");
> > +		if (flag == 'y' && tst_secureboot_enabled() > 0)
> > +			return 1;
> >   	}
> >   	file = SAFE_FOPEN(PATH_LOCKDOWN, "r");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
