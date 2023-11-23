Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA797C5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 15:55:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4F133D017E
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 16:55:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4B93CEFCB
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:55:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D8A3600F99
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:55:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 363AC21C01;
 Thu, 23 Nov 2023 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700754905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgoD2/ZDv83aXeqPOsziJCg77I2BcB1qEh3ufVJo9Kk=;
 b=YrxSxw/t+V3Rpd6yqsfuWlza/C+DRQjzzkIu5QRh5wmo2yjvj8VdyQtSJW1pxZPHBjtnGa
 4bDLTAnnN1vuxi02PtUSvTTFBbLeHisQUJ7ZkdEYaF1ycUJTJug9s5m7L0XOzN7t75RScX
 O3IiYtMdQ15KBpHW6lzpJu+z/M/SarI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700754905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgoD2/ZDv83aXeqPOsziJCg77I2BcB1qEh3ufVJo9Kk=;
 b=Bg79czDhc2W/hZ2u+ML+Ii+XoFxf1lU0fJdkREVaJo5LKHuAwJBYO8axjLXRG49QyFAYcS
 Wka4qTAGQRg0ABDQ==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A1C062D193;
 Thu, 23 Nov 2023 11:10:31 +0000 (UTC)
References: <20230922155507.604020-1-pvorel@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Nov 2023 10:59:45 +0000
Organization: Linux Private Site
In-reply-to: <20230922155507.604020-1-pvorel@suse.cz>
Message-ID: <878r6o913t.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [17.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 VIOLATED_DIRECT_SPF(3.50)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-0.00)[38.65%]
X-Rspamd-Queue-Id: 363AC21C01
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ipneigh01.sh: Add workaround for ARP
 timeout
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
Cc: ltp@lists.linux.it, Xu Senmiao <xusenmiao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello

Petr Vorel <pvorel@suse.cz> writes:

> From: Xu Senmiao <xusenmiao@huawei.com>
>
> When the ARP status of the rhost is stale,
> lhost ping rhost and the lhost deletes the ARP record,
> the record in the rhost changes from stale to delay.
>
> Then, the probe request is sent to the lhost, and the lhost ARP
> information is updated.
>
>    rhost(10.0.0.1)      lhost(10.0.0.2)
> t1 10.0.0.2 STALE       ping 10.0.0.1
>                         10.0.0.1 REACHABLE
>                         arp -d 10.0.0.1
> t2 10.0.0.2 DELAY
> t3 probe 10.0.0.2
> t4                      10.0.0.1 REACHABLE
>
> Clear the ARP entries of rhost before each round of test.
> This fixes an issue where ipneigh01_arp fail due to ARP timeout.
>
> Signed-off-by: Xu Senmiao <xusenmiao@huawei.com>
> [ pvorel: use $DEL_CMD ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * Using DEL_CMD to fix working on system without arp installed.
>
> Xu, can you confirm that it fixes your problem?
> Also, do you have this problem also on IPv6?
> Could you test both arp and ip?
> Also, do you have any idea why rhost get stale?

We need an answer to why the rhost is stale before merging this. It's
not clear that there is a test bug.

I will set this to changes requested in patchwork.

>
> Kind regards,
> Petr
>
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index e67ff5cc8..f37241d49 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -19,14 +19,14 @@ do_setup()
>  	case $CMD in
>  	ip)
>  		SHOW_CMD="ip neigh show"
> -		DEL_CMD="ROD ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
> +		DEL_CMD="ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
>  		;;
>  	arp)
>  		if [ -n "$TST_IPV6" ]; then
>  			tst_brk TCONF "'arp' doesn't support IPv6"
>  		fi
>  		SHOW_CMD="arp -an"
> -		DEL_CMD="ROD arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
> +		DEL_CMD="arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
>  		;;
>  	*)
>  		tst_brk TBROK "unknown or missing command, use -c [ arp | ip ]"
> @@ -56,6 +56,7 @@ do_test()
>  	tst_res TINFO "stress auto-creation $entry_name cache entry deleted with '$CMD' $NUMLOOPS times"
>  
>  	for i in $(seq 1 $NUMLOOPS); do
> +		$DEL_CMD
>  
>  		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null || \
>  			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
> @@ -74,7 +75,7 @@ do_test()
>  		[ "$ret" -ne 0 ] && \
>  			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
>  
> -		$DEL_CMD
> +		ROD $DEL_CMD
>  
>  		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
>  			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
> -- 
> 2.40.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
