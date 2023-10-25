Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F84C07545
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 13:34:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA79A3CF4D5
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 15:34:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF1B03CCB69
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 15:33:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEC2B1400F96
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 15:33:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 731391FF5F
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698240828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fh5F/wwkcHX2mRrobaTE+Dul+39kI6L/IhhIA0alSJI=;
 b=xo+HVMVA9R2f6GHImKJn73x1tqAqRk/yoJMip3I4WZhzaJiw44/AF+QC7NTPFInNugE5yq
 wfQZGxmPhJtpIinX3dxWpx5bVsIktDKWTZUQOIXyfHhKZr2RItBvgleFgGnQcO4pODw7sK
 UFrV5ZnTKyYb6DsOzQF5AfS8dOMU4cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698240828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fh5F/wwkcHX2mRrobaTE+Dul+39kI6L/IhhIA0alSJI=;
 b=H7JzHENcPuE9ClTz/z4H92r4QxHfDljC2AkpJHjhGJ8KiOk4K1nbRaav1UXSe1v9tqoqGT
 661tIrRsZqjpvFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6368213524
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9kY6FzwZOWVRfwAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:33:48 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 13:19:20 +0200
Message-ID: <1881613.tdWV9SEqCh@linux-9lzf>
In-Reply-To: <20231025110533.6516-1-rpalethorpe@suse.com>
References: <20231025110533.6516-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup: Handle trailing new line in
 cgroup.controllers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Mittwoch, 25. Oktober 2023, 13:05:33 CEST schrieb Richard Palethorpe via 
ltp:
> +	switch (ctrl_name[l]) {
> +	case '\n': break;
> +	case '\0': break;
> +	default:
> +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, 
ctrl_name[l]);

I'm wondering whether that's a bit too restrictive. Or is there any official 
documentation says that you really can only have the letters a-z in cgroup 
names (and not even A-Z). Otherwise it might be better to make this just a 
warning or allow any printable characters.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
