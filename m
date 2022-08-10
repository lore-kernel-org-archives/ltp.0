Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D51C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 06:45:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 125E83C953D
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 08:45:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A903C1BEA
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 08:45:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69E4B6001EA
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 08:45:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07CC71FE85;
 Wed, 10 Aug 2022 06:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660113939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtvosssXpwSMYtCg3tmhUC5/Q9DVvvBPLndpuXVGYP0=;
 b=zzcqe/odauQjmads5FrLHRMTeM0uEOaSENFhMuKlvF7Wmi1uVj1sYm3S/iln3r0wqdVJ0E
 zwz1bD4K/Whc3/790pQdH91KnhwQcM9aMb3iHEfK5h8oDiB13MM1JBeJ+uN7eFxWKWpRyM
 TfGSrcrD5tp9LJ7XtAtSBTC/LgXiQKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660113939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtvosssXpwSMYtCg3tmhUC5/Q9DVvvBPLndpuXVGYP0=;
 b=WY/pfH4wEZozVLUUBzQp8XGQAqPIjiQ2G3vLDejzOI9MxXUGOP3GD4nfxidNhDgOAMDAES
 mhEo2jubDF48HQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC3D813A7E;
 Wed, 10 Aug 2022 06:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Je8eNBJU82KIQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 Aug 2022 06:45:38 +0000
Date: Wed, 10 Aug 2022 08:45:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YvNUEYSydc8RW13y@pevik>
References: <20220810051437.13037-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220810051437.13037-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setuid01: use TST_EXP_PASS() macro,
 docparse comment and reword
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

Hi Avinesh,

> -/* DESCRIPTION
> - *	This test will verify that setuid(2) syscall basic functionality.
> - *	setuid(2) returns a value of 0 and uid has been set successfully
> - *	as a normal or super user.
> +/*
This is wrong, it must be '/*\'. I guess we need to add support for this into
make check.

I fixed it, updated copyright and merged.

Thanks!

Kind regards,
Petr

> + * [Description]
> + *
> + * Verify that setuid(2) returns 0 and effective uid has
> + * been set successfully as a normal or super user.
>   */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
