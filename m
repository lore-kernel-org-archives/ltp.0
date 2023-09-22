Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB8CD4F35
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:11:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 697D83CE379
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 11:11:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9895E3C8946
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:11:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE5771002889
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:11:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF2C1F45A;
 Fri, 22 Sep 2023 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695373861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/jho8KKZ0H8szA6Vm6sMFjwVPB+b0A02JZe/Ei5DSU=;
 b=YoAVqiRh1/inIvoukf17w/SeHIUx/uwfsHi16Bm0Xa5isptxEP06jLNfAuOrJWzCfC2Xv+
 jPgJsVQcIT1hPCOfPWv85PPQIAGkb4SVuveik4S0DUF0O6ecXRTQ/EY3HLHFjWDbkOzqK3
 wAqowojfgb+L70X87tYcNxvl94E7MIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695373861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/jho8KKZ0H8szA6Vm6sMFjwVPB+b0A02JZe/Ei5DSU=;
 b=gmVhrlBuZpoGa8YT+s4xXO6SiHUUuALPtVKhZTl59d1cMBhYAPkOoMgLIjFhWsdgxiBjnr
 JP+eSK4dQIPgqUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B9F813478;
 Fri, 22 Sep 2023 09:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EYd6DiVaDWVjUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Sep 2023 09:11:01 +0000
Date: Fri, 22 Sep 2023 11:10:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Xu Senmiao <xusenmiao@huawei.com>
Message-ID: <20230922091059.GB483490@pevik>
References: <20230815085706.1077725-1-xusenmiao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230815085706.1077725-1-xusenmiao@huawei.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ipneigh01.sh: Fix an issue where ipneigh01_arp
 test case fail due to ARP timeout
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

Hi Xu,

> When the ARP status of the rhost is stale,
> lhost ping rhost and the lhost deletes the ARP record,
> the record in the rhost changes from stale to delay.
> Then, the probe request is sent to the lhost, and the lhost ARP information is updated.

>    rhost(10.0.0.1)      lhost(10.0.0.2)
> t1 10.0.0.2 STALE       ping 10.0.0.1
>                         10.0.0.1 REACHABLE
>                         arp -d 10.0.0.1
> t2 10.0.0.2 DELAY
> t3 probe 10.0.0.2
> t4                      10.0.0.1 REACHABLE

> Clear the ARP entries of rhost before each round of test.

Do you have idea why ARP status of the rhost is stale?
I've never encountered problem like this.

> Signed-off-by: Xu Senmiao <xusenmiao@huawei.com>
> ---
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index e67ff5cc8..4db675f8f 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -56,6 +56,7 @@ do_test()
>  	tst_res TINFO "stress auto-creation $entry_name cache entry deleted with '$CMD' $NUMLOOPS times"

>  	for i in $(seq 1 $NUMLOOPS); do
> +		tst_rhost_run -c "arp -d $(tst_ipaddr lhost)"
IMHO we use $DEL_CMD as we use later in the test function, because some systems
does not have arp installed.  i.e. use the tool which is used for testing.
Otherwise we endup with: sh: arp: command not found

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
