Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7C9EB64DC
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 11:51:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D9BF3CC553
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 13:51:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B0083CBD93
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 13:51:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48C2B600069
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 13:51:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07CF41F8D9;
 Thu, 29 Jun 2023 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688039499;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJYIGr2Xvnl3S/UMtsEqpqMjdtYgZM5qhX4CV5EDCmo=;
 b=ojFjAsLvn+YtDwWDiQVgJBeR7ZkSDT88X+1rZWvruR1H4F0fpfWKSPBK6a87y9t4dxAbgt
 FfVk/NSZttgRh9oxWVfxS72yba7JJp8Yu4hn3WEzREuGLx6LrsyY58N/FdZqIQLRfYGM6m
 tfhn3aW86+Ir361FN3YNg2hyr1eXzjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688039499;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJYIGr2Xvnl3S/UMtsEqpqMjdtYgZM5qhX4CV5EDCmo=;
 b=UM8scngrSisiT0m2YA1632hzVpQlTZLKvGVOiq5ScCFf+yQrntd9dUdqew12zvXk5lwbkO
 YWPdKUhBdaoEHQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D118913905;
 Thu, 29 Jun 2023 11:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cY3DMUpwnWRFRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jun 2023 11:51:38 +0000
Date: Thu, 29 Jun 2023 13:51:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230629115137.GA207849@pevik>
References: <20230628130742.155724-1-pvorel@suse.cz>
 <20230628130742.155724-3-pvorel@suse.cz> <ZJw3Or-7pEXOnAjC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJw3Or-7pEXOnAjC@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] fsstress/global.h: Use _GNU_SOURCE
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > -/* xfs-specific includes */

> Just a very minor nit, such cleanups should be in a separate patch.
I'm sorry, I sometimes try to blance between separating changes and too many commits.
I can put this to separate commit.

> Otherwise the rest of the changes looks good:
Is that that this is just this patch. Please let me know if you're meant whole
patchset (it'd make sense, it's pretty simple).

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
