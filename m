Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEFCFA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 21:43:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEFFB3CABC5
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 22:43:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A80793CA6A7
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:43:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C82D41A003F2
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:43:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F267D336AA;
 Mon, 31 Oct 2022 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667252607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4CZXO+LBpjbLRXXdcIRrOE36B2nyJMY4a97WQTAUb8=;
 b=eCDz6hmoaBoAC0kYt+hObTYXZByOoAlPyHQysFM6xD7ZAhXC/EklyjHEblmC5/oz2uNRj+
 xYCQk2+7smgBQknKJPmafD0/UDIbLDzWwdnb1yC2j3NAfPw6sDjqGtwNBAJ+Rf+wd+P8Ha
 NemNNt/GTv7rh7M4CXAdh5VWsYQJH3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667252607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4CZXO+LBpjbLRXXdcIRrOE36B2nyJMY4a97WQTAUb8=;
 b=N7Jw24W7y25gZM5bDdiciiWhEqCGzIJLcjSmrnorzfmfXfP2xlpqLCQGMxeXiWKVfPiTE1
 zMHd/lERenv4OIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1CF813451;
 Mon, 31 Oct 2022 21:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NdDvJX9BYGN/QQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 21:43:27 +0000
Date: Mon, 31 Oct 2022 22:43:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: You Zhou <you.zhou@intel.com>, ltp@lists.linux.it
Message-ID: <Y2BBfeSYiwmLU0GA@pevik>
References: <20221028032103.2050696-1-you.zhou@intel.com>
 <Y1+qkXXu9uqsJaVG@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1+qkXXu9uqsJaVG@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi You,

FYI fixed in 5398d6c41 ("setfsuid02: using -1 as invalid fsuid for setfsuid()").

BTW this test failed on other archs (at least on aarch64, ppc64le, I suspect
it's not arch specific), therefore your solution would not work.

Kind regards,
Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
