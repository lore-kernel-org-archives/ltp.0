Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FFBC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69903CA0DF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:16:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AF0B3C9DE5
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:16:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A42C42013C3
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:16:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C66B51F37D;
 Fri, 18 Feb 2022 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645179360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzU5kZzqGbcDpxYvvrIslOSIVb3VMDk604Jjz1xGxYU=;
 b=qrIRWCq4DsXFDG7Zb5CmyoUGGZhaUoh2oSPVHugGvkGXN2B+nVMiga0WAxjJWD9OGM/oST
 wycAxQ68k50OEylTkCi0429cV04yF1y/NiSaGtQ9X+cO7hQ9jKKoCXyiTBoT4uAoBDrRUv
 jD5ehekHr3asuSkPW87mxLDoSU64qt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645179360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzU5kZzqGbcDpxYvvrIslOSIVb3VMDk604Jjz1xGxYU=;
 b=kwzYHONqVWgvyX3jTcPO4TgScAITZCIJM7gEHuWU7CApKBN7bC2kDyKlGwVd8Mv17GuNvV
 KeIAQa81KIr0TTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A53E313C5B;
 Fri, 18 Feb 2022 10:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jA91JuBxD2IEBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 10:16:00 +0000
Date: Fri, 18 Feb 2022 11:15:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg9x397xUislLTm9@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik> <620F118E.3070306@fujitsu.com>
 <Yg9fg4L26MRmbpny@pevik> <620F6D91.1070903@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F6D91.1070903@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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

Hi Xu,

...
> >> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
> >> if (TST_RET==-1) {
> >> 	tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
> >> 	goto free;
> >> } else {
> >> 	if (TST_RET<  0 || TST_RET>  3)
> > +1 (very nit: instead of if/else I'd use 2x if and (TST_RET<  -1 || TST_RET>  3)
> > - readability).
> Good catch. I add the last "if" otherwise 1,2,3 are ignored.

> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>          if (TST_RET == -1) {
>                  tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
>                  goto free;
>          }
>          if (TST_RET < 0 || TST_RET > 3) {
>                  tst_res(TFAIL, "kcmp invalid returns value(%d)", 
> (int)TST_RET);
>                  goto free;
>          }
>          if (TST_RET != 0) {
>                  tst_res(TFAIL, "kcmp returns unexpected value(%d) 
> instead of 0",
>                                  (int)TST_RET);
>                  goto free;
>          }

>          tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);

FYI Unless we want to have explanations why it failed, we could use TST_EXP_VAL() or
TST_EXP_VAL_SILENT().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
