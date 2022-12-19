Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D840EC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 07:38:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3CA73CBAEA
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 08:38:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D2063C1351
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 08:38:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CBC436005E3
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 08:38:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DFDC234C2A;
 Mon, 19 Dec 2022 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671435509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLF06FWg5L6jUrpSq4c/GIrNT1AS/uj+flnD43Zu+GA=;
 b=TC+7MRBaaT3KycpY61SvHEeE9ocP4hCDMN178TtyjGUAJ3P4n8kKVmSJUBDph2fu/5dA37
 GAsQNsOAOBQCqFb3UuI68h4OYzhayNaCMOCpXWhsE1Mw2qRfCGdFaAs390RzLDT4C295W/
 twVUxpzzSUzoFI0vhqJlbCicoCBTWEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671435509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLF06FWg5L6jUrpSq4c/GIrNT1AS/uj+flnD43Zu+GA=;
 b=nBiA5wFVwQ/cc6zSBUFvtvHZlvyFHlVJwkCnhM/WC7/9BbGnkcYHxHOdg1pSfqvUhgd2Ll
 /Gxx6KCNqrXulbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFF6913910;
 Mon, 19 Dec 2022 07:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LAdvLfUUoGOcdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Dec 2022 07:38:29 +0000
Date: Mon, 19 Dec 2022 08:38:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Y6AU9FuBviwlzd5Q@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5xEoHhXDn5EN0gA@pevik>
 <0ec8a1bd-1fa3-0114-3b90-2527ad2a0492@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ec8a1bd-1fa3-0114-3b90-2527ad2a0492@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] doc/c-test-api.txt
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> I merged this patchset except this patch. Also I will update 
> tst_kvercmp2 usage but in shell script. I will send a patchset for add 
> RHEL9 fallback for this change[1]

Thank you!

> > Also, I'd wait with this patchset to what brings the discussion of minimal
> > level.

> I guess we can mention that old test kernel version raise to 3.10 in 
> next release if nobody has objection or no reponse during this period.
Agree, new release will be sometime in January (quite soon, given Christmas and
Chinese New Year).

Kind regards,
Petr

> [1]https://github.com/linux-test-project/ltp/commit/2aaff45db7960ce8e46e39fad8ae95a3f5db6cba

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
