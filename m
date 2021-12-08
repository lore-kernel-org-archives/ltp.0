Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E723AC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 16:41:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA3B3C562F
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 17:41:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32FCE3C31DA
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:41:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2DCA200FD3
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:41:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE982212CC;
 Wed,  8 Dec 2021 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638981697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqnKLf3BToC4qe2kUPHMi2sHI2LKvw71AkR3Bmq2Z50=;
 b=0AogYyz1IdTOR1Z2Ka201s8StWw0VNOhv13YFvAgX5oLsXOhPoV9+czi4cslAfAJd5FpeY
 CS9IRl7j7Guood0s0qnAyzC27/2KUwV2RHDe7W1v3o1wrD0WUliswDGZq4XPrwd2rIPyJt
 YRHi2XNwrvEklUXMgnsnhbo1e3wGBAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638981697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqnKLf3BToC4qe2kUPHMi2sHI2LKvw71AkR3Bmq2Z50=;
 b=CZx1u69lT4hp/bntZSz/vivTsUEVYD0Nkt+sG55i0oaMkUvGcdW73VwvhL3P/5ww1sRYOl
 Hp98s2KZlGEySqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D01139C2;
 Wed,  8 Dec 2021 16:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id esY4J0HgsGEGdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Dec 2021 16:41:37 +0000
Date: Wed, 8 Dec 2021 17:41:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YbDgP7TwyOje2ax/@pevik>
References: <20211208150034.16358-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208150034.16358-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs05: Reduce the default number of dirs and files
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

Hi Martin,

[ Cc Alexey ]

> The nfs05 test currently creates 1000 .c files per thread and then compiles

> them using recursive Makefiles. It needs 6 minutes to finish on my machine
> which is longer than the default test timeout. Running it on a local filesystem
> (without NFS) still takes 2 minutes to finish so NFS performance is reasonable.
> Reduce the default number of test files to 10x30 per thread to avoid timeouts.

Good catch, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs05.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
> index 2742a54e6..7ddf8239e 100755
> --- a/testcases/network/nfs/nfs_stress/nfs05.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs05.sh
> @@ -8,8 +8,8 @@

>  # Created by: Robbie Williamson (robbiew@us.ibm.com)

> -DIR_NUM=${DIR_NUM:-"20"}
> -FILE_NUM=${FILE_NUM:-"50"}
> +DIR_NUM=${DIR_NUM:-"10"}
> +FILE_NUM=${FILE_NUM:-"30"}
>  THREAD_NUM=${THREAD_NUM:-"8"}
>  TST_NEEDS_CMDS="make gcc"
>  TST_TESTFUNC="do_test"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
