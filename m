Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FD7C433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 09:56:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BDAD3C93D9
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 10:56:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10153C07B5
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:56:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CDBA1A00CCE
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:56:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 443521F37F;
 Wed, 23 Mar 2022 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648029375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MbOCuMDRxuiRqL/qG4td2GKREUhkkzJpY8FZM/CIZo=;
 b=iRozMm+swDf9cDcApYtkOQAWv4lbDOm3C1FR7IPrQLzV3Qf8fkxQGtwkm4NbxIFL/PTzIp
 9K78mQ/imi6YO3EBGCvMx/0wI55s1xC/m+OkoijBYgihbf2jWGAaL5i3McEJG1Ok96FexC
 VSAGdgFxGx04qacdbVK3Or6P02uiCAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648029375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MbOCuMDRxuiRqL/qG4td2GKREUhkkzJpY8FZM/CIZo=;
 b=RtHQpCrhjRO2/06TnxYP6lbtyQ9MhCY0DibZQWWF5w5GAqkYRCAkBfcbu5SYNe2dLQocnP
 180NPlQprha/eFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31F86132BA;
 Wed, 23 Mar 2022 09:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RZg7C7/uOmIsNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Mar 2022 09:56:15 +0000
Date: Wed, 23 Mar 2022 10:58:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YjrvSVaU2jkLgwPt@yuki>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de>
 <YjrqO8Er3NqOG8uc@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjrqO8Er3NqOG8uc@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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
> ./userns08 -i50
> tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
> 
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:36: TBROK: clone3 failed: ENOSPC (28)
> 
> Something needs to be closed after each run.

ENOSPC means that we created too many user namespaces. The problem is
likely that we are creating the namespaces faster than they are being
asynchronously cleaned up in the kernel. Adding sleep(1) to the
clone_newuser() function gives kernel enough time to clean the
namespaces and the test works with any -i. Also note that we get the
exact same failure if we execute the test a few times in a row, i.e.

for i in `seq 10`; do
	./userns08
done

The original test fails in the same way, so while it should be fixed,
it's not really reason to block this patchset.

And the only correct fix would be retrying the clone() on ENOSPC in the
SAFE_CLONE().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
