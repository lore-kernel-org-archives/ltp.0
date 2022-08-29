Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB75ECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:42:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BDF3CA562
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 13:42:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53CC23C0D04
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:42:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 902716000ED
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:42:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFE5321ABE;
 Mon, 29 Aug 2022 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661773344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIOJ6VITqESi71ylt5rK0ydo0n8ut25kkfVKjXjiTa8=;
 b=jRQIIYfaIT5S/A3zz+/mJkm5SPLkyHWRFDwYug7nfyACosWJ5MVRaZz5OdLmxlJ5XMIktp
 wtntOc9rYEMzwJO+hu8ifDGMhb+2hQ+9SEGJJnM6XcPIpQYHCTlgzG0eLyJI4ELXH5w6Bw
 tacLDZzc94eEZQETFuAhVBa86G5GfVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661773344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIOJ6VITqESi71ylt5rK0ydo0n8ut25kkfVKjXjiTa8=;
 b=NX1sPMKtyzJxysKGhaUJZLvh5M1zD+2i1v2Y/EVS87+SSwoUIkC5Jgy2NbrPaIkZ9CS2xE
 9uKADKCiZ8TIk9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C43D1352A;
 Mon, 29 Aug 2022 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rv7oHCCmDGO8IQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:42:24 +0000
Date: Mon, 29 Aug 2022 13:42:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YwymHvpxf/rP1kFT@pevik>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-5-pvorel@suse.cz> <YwydHBRWBX2NlqMR@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwydHBRWBX2NlqMR@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 4/6] tst_device: Use getopts
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > size and filesystems are passed by -s and -f flags.
> > That will help to pass used filesystem.

> This part should be in the next commit description.

> > When it, add also -h.

> "When at it, ..."


> Otherwise it looks good.

Thanks for catching these!
I'll fix them in v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
