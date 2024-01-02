Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE29C46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 17:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B5FB3D050E
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 18:08:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D58233C2877
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 18:08:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8AC006009D1
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 18:08:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C49941F37E;
 Tue,  2 Jan 2024 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704215287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ujZXBUv+LwSgcYI5Rfmk/SzmZQ9d1vyeACFxa6/loM=;
 b=f7jhRIyzyafurGsQ/tCg/pVNxY1cPbrL/AKoyTEGdZChrshqGQ/8Eg7psBmNldx7r6PgPx
 gEaWabWrwrHY7tGDYMXdkUOpMGgL7Y19pueJtull3VGcUIY0ib2OTufOmHDTfC+eb/vtBx
 VdiqC/kP/SXLSVdQ9S27PCJiD1DZHOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704215287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ujZXBUv+LwSgcYI5Rfmk/SzmZQ9d1vyeACFxa6/loM=;
 b=xcJkj/vYiGYq3/uPnuSXeB3ZH5dyp83nQzOSdJpGsfNjAlzSAaekdROLSoz8k1o6TI5hB9
 95blFJ0BsXUTHiAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704215286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ujZXBUv+LwSgcYI5Rfmk/SzmZQ9d1vyeACFxa6/loM=;
 b=i0w27oGI/jY/YMqEcN5WxMA5vtCzi6Ss30R+OVoYEgok4uV4E/S8gI/2ObyceQICQNrh7V
 XWt4MbJhMTbs2r4X8MUOsHRtO1ZWMZ3EZwlOAAvG85bskxa0SjSJ23h9NkkhMHQhgUgn8d
 IY1ufeydJxWrDpnNYFVN525lnMj0BIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704215286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ujZXBUv+LwSgcYI5Rfmk/SzmZQ9d1vyeACFxa6/loM=;
 b=h4ttYnGXDAdyTIifP9P7rYoWsMayULVVscEJBMa1+LrSrlqUK1ejI+t7SR6x1FKUBoBPZs
 /+cRJFajgA5pH/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98B4C1340C;
 Tue,  2 Jan 2024 17:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X8yFI/ZClGW0CgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 02 Jan 2024 17:08:06 +0000
Message-ID: <69ae372c-c089-4201-957f-2e07b592afcc@suse.cz>
Date: Tue, 2 Jan 2024 18:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20231219123709.339435-1-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20231219123709.339435-1-pvorel@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i0w27oGI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h4ttYnGX
X-Rspamd-Queue-Id: C49941F37E
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] net: tst_netload_compare(): Ignore
 performance failures
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 19. 12. 23 13:37, Petr Vorel wrote:
> Performance failures in tests which use tst_netload_compare() (tests in
> runtest/net.features) can hide a real error (e.g. test fails due missing
> required kernel module). Best solution would be to have feature tests
> (likely written in C API) and performance tests (the current ones).
> 
> But until it happens, just disable performance failure by default,
> print TINFO message instead unless TST_NET_FEATURES_TEST_PERFORMANCE=1
> environment variable is set.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/lib/tst_net.sh    | 12 +++++++++---
>   testcases/lib/tst_test.sh   |  5 +++--
>   testcases/network/README.md |  4 ++++
>   3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index e47ee9676..46d49c266 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -869,16 +869,22 @@ tst_netload_compare()
>   	local new_time=$2
>   	local threshold_low=$3
>   	local threshold_hi=$4
> +	local ttype='TFAIL'
> +	local msg res
>   
>   	if [ -z "$base_time" -o -z "$new_time" -o -z "$threshold_low" ]; then
>   		tst_brk_ TBROK "tst_netload_compare: invalid argument(s)"
>   	fi
>   
> -	local res=$(((base_time - new_time) * 100 / base_time))
> -	local msg="performance result is ${res}%"
> +	res=$(((base_time - new_time) * 100 / base_time))
> +	msg="performance result is ${res}%"
>   
>   	if [ "$res" -lt "$threshold_low" ]; then
> -		tst_res_ TFAIL "$msg < threshold ${threshold_low}%"
> +		if [ -z "$TST_NET_FEATURES_TEST_PERFORMANCE" ]; then
> +			ttype='TINFO';
> +			tst_res_ TINFO "WARNING: slow performance is not treated as error, change it with TST_NET_FEATURES_TEST_PERFORMANCE=1"

This TINFO message should probably be moved to tst_net_setup(). 
Otherwise some tests will print it multiple times.

I'd also slightly prefer to keep the default as is and use a variable to 
disable perf checks instead.

> +		fi
> +		tst_res_ $ttype "$msg < threshold ${threshold_low}%"
>   		return
>   	fi
>   
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 5f178a1be..06ee6005a 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -1,6 +1,6 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2014-2022
> +# Copyright (c) Linux Test Project, 2014-2023
>   # Author: Cyril Hrubis <chrubis@suse.cz>
>   #
>   # LTP test library for shell.
> @@ -681,7 +681,8 @@ tst_run()
>   			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
>   			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
>   			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
> -			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
> +			NETLOAD_CLN_NUMBER|NET_DATAROOT|NET_FEATURES_TEST_PERFORMANCE);;
> +			NET_MAX_PKT|NET_RHOST_RUN_DEBUG);;
>   			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
>   			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
>   			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
> diff --git a/testcases/network/README.md b/testcases/network/README.md
> index a0a1d3d95..0547c3f9f 100644
> --- a/testcases/network/README.md
> +++ b/testcases/network/README.md
> @@ -84,6 +84,10 @@ Where
>   Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
>   Network stress parameters are documented in `testcases/network/stress/README`.
>   
> +Tests which use `tst_netload_compare()` test just basic functionality,
> +performance failure is just printed with 'TINFO'. To enable also performance
> +testing, set `TST_NET_FEATURES_TEST_PERFORMANCE=1` environment variable.
> +
>   ## Debugging
>   Both single and two host configurations support debugging via
>   `TST_NET_RHOST_RUN_DEBUG=1` environment variable.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
