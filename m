Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A744E7C4FD
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 09:00:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0506B3CDA9C
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 11:00:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4B243CB02B
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 11:00:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC39F14052EE
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 11:00:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED07321865;
 Thu,  5 Oct 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696496435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdNGLzXvqKNkNwiCbqjmtDAG8EiMKdAoGcKAqj4sq4M=;
 b=Zz5mUassrl+/CYnCoBspT085DSuQLpphI1tnxH8XofLpPZROF1WwESEk9zoyyTH5VR3uWl
 YA521WCLynIeq14eWeJ3fOzw2bv8Cd7n/+4gg2pv/R2V3Vry3+uSQgr2hscIKTLkozBSvB
 9XCtJ5a15sio6IaicjILJvxXYEzX2Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696496435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdNGLzXvqKNkNwiCbqjmtDAG8EiMKdAoGcKAqj4sq4M=;
 b=SwIl8NgEtdKWQXH6fa+xmIDD3QAAXoKs3NraCir32vMfgtsCTk4Otds+kWMxh59SUMNv+T
 cb4aMejlOA1WIACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA063139C2;
 Thu,  5 Oct 2023 09:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pb/JLzN7HmVZbwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 05 Oct 2023 09:00:35 +0000
Date: Thu, 5 Oct 2023 11:00:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20231005090034.GA102472@pevik>
References: <20231004121149.30849-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231004121149.30849-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg: Account for pages in the per-cpu cache
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

Hi Richie,

[ Cc Li ]

> PAGESIZES is one greater than the batch size for charging pages from
> the per CPU cache. So with MEM_TO_ALLOC=2*PAGESIZES we have two pages
> that are below the threshold for being charged.

> Sometimes something triggers a flush and the pages get charged to the
> global counter anyway and the test passes. We have seen cases where
> the test times out waiting for this to happen.

> So this patch sets a lower bound to allow those cases to pass. It'll
> probably speed the test up as well.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  .../controllers/memcg/functional/memcg_subgroup_charge.sh    | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> index 9bcc01258..3b7311422 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> @@ -33,8 +33,8 @@ test_subgroup()
>  	fi

>  	echo $MEMCG_PROCESS_PID > tasks
> -	signal_memcg_process $MEM_TO_ALLOC
> -	check_mem_stat "rss" $MEM_TO_ALLOC
> +	signal_memcg_process $MIN_CHARGED
> +	check_mem_stat "rss" $MIN_CHARGED $MEM_TO_ALLOC

>  	cd subgroup
>  	echo $MEMCG_PROCESS_PID > tasks
> @@ -66,5 +66,6 @@ test3()

>  # Allocate memory bigger than per-cpu kernel memory
>  MEM_TO_ALLOC=$((PAGESIZES * 2))
> +MIN_CHARGED=$((2 * (PAGESIZES - 1)))

>  tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
