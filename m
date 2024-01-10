Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB6C3DA6E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 10:57:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92F853CE4BA
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 11:57:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F06F3C2674
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 11:57:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBC0F600565
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 11:57:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D5C01F84E;
 Wed, 10 Jan 2024 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704884259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=58wy1WK0k0YBnwlLvhrbneDzOq8aMfi0bdxJ/P6Zh5g=;
 b=wibMRDVCQyDYRWNmz4jOhrHZmcLXT/5KzbP2ihuhNHXH02OeDtf3gN9nzS3gGvziSHhlAS
 qSyAXkSrkzt7XR+cx5VN21m7WgOHYXSs9Yry51ma3ZV0lKlTYif4YIISSLfRAWRkDzVUiz
 pSRix9bdA9JldKMJVAhcfNUYlmhUK9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704884259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=58wy1WK0k0YBnwlLvhrbneDzOq8aMfi0bdxJ/P6Zh5g=;
 b=/qeSV1kjfZw/MV0idRTVYh1EBywQyZWpFBzBUzS7/ip2ADxEuIzQOoFZXNNw0nDPeXYUxC
 AiHdAjj5Y0QX1OCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704884259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=58wy1WK0k0YBnwlLvhrbneDzOq8aMfi0bdxJ/P6Zh5g=;
 b=wibMRDVCQyDYRWNmz4jOhrHZmcLXT/5KzbP2ihuhNHXH02OeDtf3gN9nzS3gGvziSHhlAS
 qSyAXkSrkzt7XR+cx5VN21m7WgOHYXSs9Yry51ma3ZV0lKlTYif4YIISSLfRAWRkDzVUiz
 pSRix9bdA9JldKMJVAhcfNUYlmhUK9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704884259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=58wy1WK0k0YBnwlLvhrbneDzOq8aMfi0bdxJ/P6Zh5g=;
 b=/qeSV1kjfZw/MV0idRTVYh1EBywQyZWpFBzBUzS7/ip2ADxEuIzQOoFZXNNw0nDPeXYUxC
 AiHdAjj5Y0QX1OCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C6713786;
 Wed, 10 Jan 2024 10:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a0Z3HyN4nmV5JgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 10 Jan 2024 10:57:39 +0000
Message-ID: <a3bf8618-4335-4784-8298-f2f2c522fac4@suse.cz>
Date: Wed, 10 Jan 2024 11:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240104121001.1155491-1-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240104121001.1155491-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] net: tst_netload_compare(): Ignore
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 04. 01. 24 13:10, Petr Vorel wrote:
> Performance failures in tests which use tst_netload_compare() (tests in
> runtest/net.features) can hide a real error (e.g. test fails due missing
> required kernel module). Best solution would be to have feature tests
> (likely written in C API) and performance tests (the current ones).
> 
> But until it happens, allow to ignore performance failure with
> environment variable LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * Ignoring performance requires setting LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
> (previously it was ignored by default, Martin), therefore rename the variable.
> * Variable uses LTP_ prefix (user defined), thus no need to whitelist it
> in tst_net.sh.
> 
> Martin also pointed out that message can be printed multiple times, but I
> don't think this is a problem (it's better that tester sees it).
> 
>   testcases/lib/tst_net.sh    | 19 +++++++++++++++----
>   testcases/network/README.md |  4 ++++
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 2ed0e787f..6cf7f2fcb 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2016-2023 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2016-2024 Petr Vorel <pvorel@suse.cz>
>   # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>   
>   [ -n "$TST_LIB_NET_LOADED" ] && return 0
> @@ -863,22 +863,33 @@ tst_netload()
>   # TIME: time that is compared to the base one
>   # THRESHOD_LOW: lower limit for TFAIL
>   # THRESHOD_HIGH: upper limit for TWARN
> +#
> +# Slow performance can be ignored with setting environment variable
> +# LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
>   tst_netload_compare()
>   {
>   	local base_time=$1
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
> +		if [ "$LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE" = 1 ]; then
> +			ttype='TINFO';
> +			tst_res_ TINFO "WARNING: slow performance is not treated as error due LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1"
> +		else
> +			tst_res_ TINFO "Following slow performance can be ignored with LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1"
> +		fi
> +		tst_res_ $ttype "$msg < threshold ${threshold_low}%"
>   		return
>   	fi
>   
> diff --git a/testcases/network/README.md b/testcases/network/README.md
> index a0a1d3d95..e1b1296d6 100644
> --- a/testcases/network/README.md
> +++ b/testcases/network/README.md
> @@ -84,6 +84,10 @@ Where
>   Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
>   Network stress parameters are documented in `testcases/network/stress/README`.
>   
> +Tests which use `tst_netload_compare()` test also performance. They can fail on
> +overloaded SUT.  To ignore performance failure and test only the network functionality,
> +set `LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1` environment variable.
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
