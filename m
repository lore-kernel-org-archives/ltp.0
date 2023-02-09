Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C59C636D6
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:18:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09E573CC0E8
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 16:18:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECF43C4D54
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 16:18:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68C461400211
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 16:18:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3954C375E6;
 Thu,  9 Feb 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675955902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ayuHgFdUB6dD3htf/9QZYc/pTRT7VkJrjNa1CHp8ODU=;
 b=SFAnp3Qlup2iZXMneZVeNyOn/05lUq2rif7NmWkJXuV7wF42hAcWd8WIRnOUWABYZegjCL
 MiwARcci2pF5poOeS37wrUMms63eKVp9UBzzsHhnpmkrJu0VFh0c02Rdu7zqzp9szOMg9U
 WfKJ+K+N+27MyfOYwy0NK5HdhGzQjhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675955902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ayuHgFdUB6dD3htf/9QZYc/pTRT7VkJrjNa1CHp8ODU=;
 b=nrveiyNb6rIVn4RxzKmCs2MekIwAoKciRoUUHjPSxNH0vOKukk4yiHyiorBPOFo6kdc9Ah
 SfH5+8zspzLlfYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D692B1339E;
 Thu,  9 Feb 2023 15:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gk+AMr0O5WNuMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 15:18:21 +0000
Date: Thu, 9 Feb 2023 16:18:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+UOvCdfhRg/mqFj@pevik>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
 <Y+UEqNtUTNaGVwXT@pevik> <Y+UItbp4v2WKZedL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UItbp4v2WKZedL@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > I guess something like this should be used:

> > 	for (unsigned int i = 0; i < 5000; i++) {
> > 		TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > 							EINVAL);

> It doesn't fail on older kernels, or did I misinterpret something? There
> are three stable kernel trees based on kernels that are supposedly
> affected, we do want to run this test for them too.

IT fails on new (fixed) kernels (tested on 6.2.0-rc6), it's about test does not
crash anything).

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
