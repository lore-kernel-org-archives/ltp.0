Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE3C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663FE3C9575
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:35:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E594B3C4DF4
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:34:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43BCB60070E
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:34:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16D0E2019A;
 Mon,  8 Aug 2022 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659962093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NS/wuIx/GBQE2PEQmNSdFQQApD2iODS1bGeC7QioEUo=;
 b=xYfjSqVVw1iiKB1Nu61whfEcg3Xo5hV59koMbnULVd1rOK+scclC/KjyzKpyY41Lg51Jd0
 JxeCMIaCfof4zpxcfdpASz0Tn92GtIrF57N3qcVQQvX9d2Qqti8bbfzsNh9NGXqyR/Voe4
 RsiJtOxznrh2vD2Y+9Sxx8W9151cUgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659962093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NS/wuIx/GBQE2PEQmNSdFQQApD2iODS1bGeC7QioEUo=;
 b=OcORtohA8mi1WfY/JaGANc295YTiKPFXLjc0IzPJ6JI2Z5igpKwSGDeij1TI5ZAi3iDN/Y
 QrJDh6nDkN3gmeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E592313A7C;
 Mon,  8 Aug 2022 12:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Tog8NuwC8WJgSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 12:34:52 +0000
Date: Mon, 8 Aug 2022 14:34:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YvEC6gpWO7qnV7sd@pevik>
References: <20220708170634.842-1-akumar@suse.de> <YsxHHDw0H1lZTFMN@pevik>
 <118407732.DU46jWBZyT@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <118407732.DU46jWBZyT@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fstat02.c: simplify using TST_EXP_*() macros
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

> On Monday, July 11, 2022 9:21:56 PM IST Petr Vorel wrote:
> > Hi Avinesh,


> > LGTM, thanks!
> > Minor comments below.
> Hi Petr, Thank you! I agree with your comments here.
> Do I need to send v2 or you will merge with these changes?

I'm sorry, I overlooked your question (vacation).
Going to merge v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
