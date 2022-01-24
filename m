Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79475C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 14:19:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9193C909A
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:19:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79ED43C7E58
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:19:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A67D96003CC
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:19:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B881C21993;
 Mon, 24 Jan 2022 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643033946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fPr+iZCBIUsxkONSxPFenhfpJvWyCPFfJ/Annpe/Lo=;
 b=B/WwMoWluLy2u/hxP5mP03wC3ff6/HS0mGRcndXlba/A3358Ib5wNb6XaczH2R0h6BMhyY
 5K0G2rkZXJ/b8cs7nyckkpCa9yASoPe3cEnXtxAO26wLkcI8a9nWemoG7tpGxv+3hdAyit
 QVuZyem+JAhgYwbh4VSk9nA2takH3F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643033946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fPr+iZCBIUsxkONSxPFenhfpJvWyCPFfJ/Annpe/Lo=;
 b=drzZTjMTBWF3DhT8x318xNeZIhFyzJ8M/65hYHunpRvgEMbo6jgkTygVki3uEzLn7/wEzB
 Kp8aVoELJ9RcbmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A173D13BF6;
 Mon, 24 Jan 2022 14:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sIpvJlq17mENcQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 24 Jan 2022 14:19:06 +0000
Message-ID: <3611b369-89b8-c9bc-92b7-ea69f91fea13@suse.cz>
Date: Mon, 24 Jan 2022 15:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220119195519.3117-1-pvorel@suse.cz>
 <20220119195519.3117-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220119195519.3117-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] tst_net.sh: Fix for disabled IPv6
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 19. 01. 22 20:55, Petr Vorel wrote:
> Tests failed in tst_init_iface even IPv4 only test was run.
> Allow to init interfaces at least for IPv4.
> 
> Tests which use TST_IPV6=6 needs to be fixed (unless they use
> just tst_ipaddr_un()).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 66 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 4dc0fca926..df16e12a26 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -24,7 +24,9 @@ TST_IPV6_FLAG=${TST_IPV6_FLAG:-}
>  tst_net_parse_args()
>  {
>  	case $1 in
> -	6) TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6";;
> +	6)  tst_net_require_ipv6
> +		TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6"
> +		;;
>  	*) [ "$TST_PARSE_ARGS_CALLER" ] && $TST_PARSE_ARGS_CALLER "$1" "$2";;
>  	esac
>  }
> @@ -100,6 +102,30 @@ tst_brk_()
>  	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
>  }
>  
> +tst_net_detect_ipv6()
> +{
> +	local type="${1:-lhost}"
> +	local cmd='[ -f /proc/net/if_inet6 ]'
> +
> +	if [ "$type" = "lhost" ]; then
> +		$cmd
> +		return $?
> +	fi
> +
> +	tst_rhost_run -c "$cmd"
> +	return $?
> +}

tst_net_detect_ipv6() should probably run each check only once and cache
the result. The function is called multiple times and tst_rhost_run()
could be quite slow if the remote side is on a different physical machine.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
