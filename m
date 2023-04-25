Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22389C6FD18
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 12:15:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F2E43CE542
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 14:15:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F873CBBE3
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 14:15:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7DE3F200747
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 14:15:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F8CE1FDA3;
 Tue, 25 Apr 2023 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682424927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rq2j+ePw5cw3AWR9zaMvZt3VVS7Ax8SFDhtFkB8+AV8=;
 b=TFlMh0DemX+tLNBa/xw5AB9Z3nnxj1Sd4OgV7vAe6A1XhRiYKocZBt8WnbKPq+ZAPxCoPS
 rmLSLcziXQIA5OrXjonjMb0v6xC1SMjc3xH+wGXUGeeB58ifA2dkI1Y4t7j8WMkMnw6S3r
 tMi7gz6KcN1D4jh/AJlUhf30voubDBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682424927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rq2j+ePw5cw3AWR9zaMvZt3VVS7Ax8SFDhtFkB8+AV8=;
 b=KttBtYH+VVr6kNT6ARkoyNeKsB0wZ4AEXodLmI2k0+uoBt0KCxFGCvUxeQhN7zGSGGHo2o
 Pzf+8juXeHMprMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B888138E3;
 Tue, 25 Apr 2023 12:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z+fOHF/ER2SyZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Apr 2023 12:15:27 +0000
Date: Tue, 25 Apr 2023 14:15:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230425121536.GA2944392@pevik>
References: <20230424175934.2847088-1-pvorel@suse.cz>
 <20230424183936.GA2855209@pevik> <ZEe3gFS3GlVdP7JP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZEe3gFS3GlVdP7JP@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfslock01: Add GPL-2.0-or-later license
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

> Hi!
> > > C sources and headers in nfslock01 directory don't have a license.
> > > Add GPL 2+.

> > Hm, there should probably be copyright added as well.

> As these were added as part of the nfslock01.sh I would just add IBM
> copyright and the same license GPL-2.0-or-later to these as well.

I guess you mean:
Copyright (c) International Business Machines  Corp., 2001

I'll can modify first commit of v2:
https://patchwork.ozlabs.org/project/ltp/patch/20230424184658.2858634-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20230424184658.2858634-1-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
