Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D82C433F5
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 15:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FBE93CAAAC
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 17:42:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0229C3C8731
 for <ltp@lists.linux.it>; Wed, 18 May 2022 17:42:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4DBF5600F2C
 for <ltp@lists.linux.it>; Wed, 18 May 2022 17:42:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F53D1F8C9;
 Wed, 18 May 2022 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652888562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s91BP+gtYGxC9D4zBqo6Xaid9EbaF9ZudV58f4uJXlI=;
 b=VrJ7i+2im0hMeR7NsoX69q/wy+rmbytxVgi4QbzOWAhUQKycT1yuzblQuB/nHL/ajeO01F
 68mdNHoKokOG+mHLmzWZ6QidhDjgAPGnoi6klHxpT1ZDGOpyWADqAJbH4UxDd694DSyaH3
 83Tutxc2knXW93xd/EJtvMpO8GJXFug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652888562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s91BP+gtYGxC9D4zBqo6Xaid9EbaF9ZudV58f4uJXlI=;
 b=v7gDV4EIVWadaoVhRETlzJR5OQJ6UdPmS3ct+5gYNEMtFqanabyw5gI0Io3002xsC3PJd/
 dioQAz7ss81s1QBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F12D113A6D;
 Wed, 18 May 2022 15:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DxafOPEThWIrUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 18 May 2022 15:42:41 +0000
Date: Wed, 18 May 2022 17:42:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YoUT8GWHB0QCtbcV@pevik>
References: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
 <YoSzazXY+BRhAPmc@pevik> <62850DFF.8030607@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62850DFF.8030607@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional
 test
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

Hi Xu, all,

> > Thus I suggest to have this cleanup code:

> > out1:
> > 	SAFE_CLOSE(otfd);
> > out2:
> > 	if (mount_flag)
> > 		SAFE_UMOUNT(OT_MNTPOINT);

> > 	mount_flag = 0;

> > If Cyril is ok with this I'd merge it before release.
> > (I tested it on various systems, found only this issue.)
> This fix is obviously correct. Since I have reviewed this patch in 
> internal, you can also add my reviewed-by for this patch.

Adding it (I'm lazy thus want patchwork to take this patch.
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

> ps: I think we should also check functionality like mount03 did instead 
> of just check flag.
+1. Although test_rwflag() is a bit complex.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
