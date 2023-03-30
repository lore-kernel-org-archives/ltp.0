Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90496C761AF
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 11:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C7CB3CC9BE
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 13:31:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AE8F3C1769
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 13:31:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 841EE1000369
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 13:31:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2727D21B64;
 Thu, 30 Mar 2023 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680175885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx1nNM4TF+2nDqVY2bpgGrQbUDad8FYMolyU9Hj3eoU=;
 b=2PFSxJQf1CW0u/9wVDtvLvai9JiNtL+kG0iPmWaGEGp39iyZU8dPZhvmBzrHZ44qgy0Lum
 H8XCAP91JroPvdPepNGoT3+8fieclCzyGydfHbUCf08d9ZSDWvGefD42yYHllgmi9Gfjqm
 8YADjWoG6rmkVO+F6O5er2htWoW5vLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680175885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx1nNM4TF+2nDqVY2bpgGrQbUDad8FYMolyU9Hj3eoU=;
 b=RuWhGhp8iY8LQvL9XAZZBpzqjVHAdLD+2STjdA4IJRsyRMOljsbb9kQXa89UJqJ/4EtnPo
 a7QYQrk7goXPVCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2463D1348E;
 Thu, 30 Mar 2023 11:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ida+Bw1zJWSKSQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 30 Mar 2023 11:31:25 +0000
Date: Thu, 30 Mar 2023 13:32:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <ZCVzVHPnRDcGDrVt@yuki>
References: <20230323160442.671164-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323160442.671164-1-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ipc/msgstress03: Assume all forks will run
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> It appears that msgstress03 doesn't account for all PIDs that its children
> can use, as it expects the tasks will terminate quickly and not reach
> the PID limit.
> On some systems, this assumption can be invalid and the PID limit
> will be hit.
> Change the limit to account for all possible children at once, knowning
> that each child will fork as well.
> 
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> This patch was already reviewed as part of a larger series[0]. The rest of
> the series needs a large rework to be merged, but I felt this patch was a
> simple and independnt enough to warrant a resend.
> No changes were made.
> 
> CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502197808
> 
> [0]: https://lists.linux.it/pipermail/ltp/2023-February/033007.html
> 
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

The logic behind the change is good, however I wonder if this would
produce a bit confusing message in case that we are over limit and
setting the value to the current maximum. Can we at least multiply the
values printed in the TINFO message by 2 so that we get real limits
instead of halves?

Generally the nprocs is actually the number of message queues, which is
confusing itself, but that is probably left for a bigger cleanup of the
testcase...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
