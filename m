Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14F9ECAAD5
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 16:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D88D3CA5D8
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 18:14:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BF423C8813
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:14:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28DAB600158
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:14:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA658229D7;
 Mon, 29 Aug 2022 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661789661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJNi49m3aoK7ZxSdO38U6MBi7YL988pHZltt045fT0U=;
 b=coCBFDCP5RlN/CTGep9hrZtm74VtYyA/a3KIiI43Gy0/6d9T7v1mbadVBPNrWuqs6WMzZT
 WMHl2wt5vU0M4eusAQplgbp1ihKNXDkrfcPHgEV4t6G+wInmEyuVaRnKUgCog7/OYYoY0b
 YEU/5vTiOnG5bdaj3f3MC+izFct5Y5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661789661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJNi49m3aoK7ZxSdO38U6MBi7YL988pHZltt045fT0U=;
 b=9pcWjNlgiuZyVZ3Xr2qZPl5lSK4yDmI34lPm90aNBNoJ9RvTBKiYAevnGaC3WVSdQAGslK
 Bwn0fft2Qy+SG6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DFCA1352A;
 Mon, 29 Aug 2022 16:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qmjjEt3lDGODGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 16:14:21 +0000
Date: Mon, 29 Aug 2022 18:14:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <Ywzl266wQ89KonEW@pevik>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
 <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] tst_fs_type: Add nsfs, vfat,
 squashfs to tst_fs_type_name()
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tim,

> Minor nit, but the subject line has nsfs when I think it means ntfs.
>  -- Tim
Thanks, will be fixed in v2.

How about XFS using 300 MB vs 16 MB but using different code paths?
How big deal it'd be if we require 300 MB in case testing on kernel with XFS
enabled and xfsprogs installed?

https://lore.kernel.org/ltp/YwyYUzvlxfIGpTwo@yuki/
https://lore.kernel.org/ltp/YwyljsgYIK3AvUr+@pevik/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
