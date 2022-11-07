Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91292C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:13:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 368723CDA42
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:13:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C5053CD9C9
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 16:13:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8DA9F1000763
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 16:13:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D93061F891;
 Mon,  7 Nov 2022 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667833984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAfDaftSSFalcxpbLiPjB3Q4xr381/MR0BmsmwT/4Mk=;
 b=wNiVQkvTZ4aTM23HHt2MgIMNgd2Jz07P8us7gTydKrRN1bh/vBx8OkCC8RWL7+F6KGXj+x
 jAcSHu47goYITjrXYt+DsAyCrsJ/uR1Kl6NiYu2d5Tf1mgonTcd0jLII+alUeVVrVmHTfO
 M8VnPbqjHSw4Y8eDozZmjeN2LaILymw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667833984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAfDaftSSFalcxpbLiPjB3Q4xr381/MR0BmsmwT/4Mk=;
 b=Ki7ckOZKu7FVYT14Ovgx7BMz2dnQ1hgCtAB9ov3PFIAEYTCS/yNEyRSpN/6nfwy7DWn0JW
 eCgYM0mPsQ46BFDQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 59FA82C141;
 Mon,  7 Nov 2022 15:13:04 +0000 (UTC)
References: <20221103164431.365731-1-teo.coupriediaz@arm.com>
 <20221103164431.365731-2-teo.coupriediaz@arm.com> <Y2ke0FphPNuXb+kD@yuki>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Nov 2022 15:12:42 +0000
Organization: Linux Private Site
In-reply-to: <Y2ke0FphPNuXb+kD@yuki>
Message-ID: <87bkpix0g5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] regen.sh: Use intptr_t for tst_syscall return
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged! thanks.

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Reviwed-by: Cyril Hrubis <chrubis@suse.cz>
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
