Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CCEC433FE
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 21:11:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9A553C8137
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 22:11:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DCB73C7205
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:11:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D8D81400B89
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:11:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C817210EB;
 Thu,  9 Dec 2021 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639084267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRq3yPtOzwvJNQ+HrLgEybcl+aLdN1vAKd6uu809uKM=;
 b=Pa685/9LDgEr5aBQt+FBCFtdC1402nZTi7OPjY0QX8nV3cDDfeBxmb+IFDiQNZ/rR2/jTK
 BtvTYp2GVixT7g3IFsl39J5Xkjtp81MevIp3EOchVeyrBCAdT6BrVTwbM7bO0PJXbtjWbp
 sZGQNeRWgDdduPgJoUaXDNABB8TL/dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639084267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRq3yPtOzwvJNQ+HrLgEybcl+aLdN1vAKd6uu809uKM=;
 b=afYjz7/xalZFF+u+gQq5ZlQbTiip9tBwo/qJP3251pfoID0JFwGAYj4nO1uAIghM+z/TDn
 t4SQbzNOMY6H3BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BC6013D7C;
 Thu,  9 Dec 2021 21:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HLkfButwsmFDTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Dec 2021 21:11:07 +0000
Date: Thu, 9 Dec 2021 22:11:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YbJw6IfUFhVDgQLS@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbIeFLfVb36DaVq8@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Xu, Cyril,

> Hi!
> >  	tst_set_timeout $((dev_num*450))

> > +	rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
This is wrong:

$ lsmod | grep zram
# rmmod zram; echo $?
rmmod: ERROR: Module zram is not currently loaded
1

Why not detect with lsmod? i.e.:

	if lsmod | grep zram; then
		rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
	fi

Although I'm not sure if we should attempt to rmmod, maybe quit when lsmod
detects zram would be better.

Also it wouldn't harm to add at least rmmod into TST_NEEDS_CMDS (in the
zram_lib.sh + take into account TST_NEEDS_CMDS from tests), but that's another
story.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
