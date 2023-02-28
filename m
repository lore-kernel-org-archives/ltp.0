Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F335C64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 14:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6C8B3CDDD4
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 15:22:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D14CD3CAFCE
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:22:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1735D1A00695
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:22:24 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 666A0219BA;
 Tue, 28 Feb 2023 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677594144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k+x5YES6x8JV7KSaNK9WDTDc5f9858MLBCE/Qhg80ik=;
 b=BLq5IOXyGz3DNut22CpCmZcI/+XhobgQ1yXs3Bhka7LVblCnJ1lpmA21d3HU37K2Q0aFm7
 uCCHUIyeyGinYKz8Yq/1vOOYPo6Lq8C4Yw0d+noGEvxR2DbxuZsDHq21atTMJX5+kpfv4m
 A+ogajETbImEpCApiHHu152cjKmnL/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677594144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k+x5YES6x8JV7KSaNK9WDTDc5f9858MLBCE/Qhg80ik=;
 b=6dOzEhdRrMvK8eBEGQTWplf4Tbiqf3NA3hjCBSQ1li55dt71HUPcaDX7TbOuAoJfiRfagW
 O5NLLAVaN2TPKhBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 37F072C141;
 Tue, 28 Feb 2023 14:22:24 +0000 (UTC)
References: <20230215145440.78482-1-teo.coupriediaz@arm.com>
 <20230215145440.78482-4-teo.coupriediaz@arm.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Date: Tue, 28 Feb 2023 14:21:49 +0000
Organization: Linux Private Site
In-reply-to: <20230215145440.78482-4-teo.coupriediaz@arm.com>
Message-ID: <87bklduaxs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] ipc/msgstress03: Assume all forks will run
 concurently
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Teo Couprie Diaz <teo.coupriediaz@arm.com> writes:

> It appears that msgstress03 doesn't account for all PIDs that its children
> can use, as it expects the tasks will terminate quickly and not reach
> the PID limit.
> On some systems, this assumption can be invalid and the PID limit
> will be hit.
> Change the limit to account for all possible children at once, knowning
> that each child will fork as well.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

>
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> ---
>  testcases/kernel/syscalls/ipc/msgstress/msgstress03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
> index 3cb70ab18..0c46927b8 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
> @@ -109,7 +109,7 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	free_pids = tst_get_free_pids(cleanup);
> +	free_pids = tst_get_free_pids(cleanup) / 2;
>  	if (nprocs >= free_pids) {
>  		tst_resm(TINFO,
>  			 "Requested number of processes higher than limit (%d > %d), "
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
