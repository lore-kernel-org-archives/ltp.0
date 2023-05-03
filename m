Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0C0C77B7F
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 09:33:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 675383CD8FD
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 11:33:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CD8B3CB794
 for <ltp@lists.linux.it>; Wed,  3 May 2023 11:33:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B811E600258
 for <ltp@lists.linux.it>; Wed,  3 May 2023 11:33:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E43D4201B3;
 Wed,  3 May 2023 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683106385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OKDQe6eNfuV1RjzYMf+Ofaz17xlFFdjPumqKu3hnqbU=;
 b=pqw4V/UXGlE4gFG1khniQ5b7rQXfNxsCd46npKiBb6ZTJF9sGCQ0p6dZZSGMzoGijViFXN
 z5EDcWpAPgTNifXT11VWniQCt+15z7K4IzT+daLQUC91SzaQop6CNt2segs1bOg9pG5kfY
 N79ZeD7XczOtNBhjVzVBr5EYPQ5p7G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683106385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OKDQe6eNfuV1RjzYMf+Ofaz17xlFFdjPumqKu3hnqbU=;
 b=19fY8e0RD7edK5ouZNW/wRBPi4qKZLXQCea7uimMcxzjn14pUzZNtNPUae4NyLCj37gO4k
 DxFMkkPUoqSYpeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1D301331F;
 Wed,  3 May 2023 09:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tY00MlEqUmRwFwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 May 2023 09:33:05 +0000
Date: Wed, 3 May 2023 11:31:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFIp4Sulcy20GWkc@rei>
References: <ZEjsKC6ESB1+mM0H@rei>
 <20230502143711.GA3665733@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230502143711.GA3665733@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> * IMHO Martin's KVM patchset should be merged
> https://patchwork.ozlabs.org/project/ltp/list/?series=351921&state=*

Feel free to merge with my ack as long as it passes basic testsing.

> * nfslock01.sh: Don't test on NFS v3 on TCP
> https://patchwork.ozlabs.org/project/ltp/patch/20230502075921.3614794-1-pvorel@suse.cz/
> => IMHO should go in to increase NFS tests stability

The discussion around it sounds like this is a kernel problem after all.

> * NFS: test on all filesystems
> https://patchwork.ozlabs.org/project/ltp/list/?series=352840&state=*

This is rather big change, is this important enough to get it in just
before the git freeze?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
