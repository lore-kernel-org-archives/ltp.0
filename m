Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E372FC00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 15:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A02EF3C953D
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 17:04:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B082E3C0646
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:04:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3DF11A0089D
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:03:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3B7B5C154;
 Wed, 10 Aug 2022 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660143839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lD9UgTGuy4XPYI7oEBokKulsWPLY57nPcHZ40eNmU8=;
 b=BdNTNyVWxDd0RTqWvkw44NslrgoiKOVnM2355MGZU+1NhyBcy5ByU3wg4qJ0kI6wep7rzo
 ykRRBmiGi5YGXiQhwAVJSor+d98M98CzZqj04uVCBUIhOBf8aoJJ5TSx7VcSCs+wjySPxk
 Bgvd/Pz4hOpo6pf6+0H1kcfGDn0MkBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660143839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lD9UgTGuy4XPYI7oEBokKulsWPLY57nPcHZ40eNmU8=;
 b=+SnpQ/TcBW87O2UKYLKW4WjgoJ5sSlL65IdHQE8tn76pOFpTsBpAtHzpq+mflZZkHmvbhn
 a7ZOuqP2I/1b3FDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D76E813A7E;
 Wed, 10 Aug 2022 15:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JVmRM97I82KHRgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 10 Aug 2022 15:03:58 +0000
Message-ID: <3173fba0-778a-69db-2a35-585cc9625a4e@suse.cz>
Date: Wed, 10 Aug 2022 17:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220808113756.11582-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] tst_test.sh: runtest.sh: Remove unused code
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
looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 08. 08. 22 13:37, Petr Vorel wrote:
> This code is in tst_print_colored() (probably forgotten to remove code
> from tst_test.sh in a7f613372 when moved to tst_print_colored during
> development; later copy wrong code in d132084bc into runtest.sh).
> 
> Fixes: a7f613372 ("Colorize test type in the output")
> Fixes: d132084bc ("lib: Add script for running tests")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/runtest.sh | 3 ---
>  testcases/lib/tst_test.sh   | 3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
> index f136bcb88..e78b556c5 100755
> --- a/lib/newlib_tests/runtest.sh
> +++ b/lib/newlib_tests/runtest.sh
> @@ -48,9 +48,6 @@ runtest_res()
>  	local res="$1"
>  	shift
>  
> -	tst_color_enabled
> -	local color=$?
> -
>  	printf "runtest " >&2
>  	tst_print_colored $res "$res: " >&2
>  	echo "$@" >&2
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index a35fa2e7b..356af0106 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -112,9 +112,6 @@ tst_res()
>  	local res=$1
>  	shift
>  
> -	tst_color_enabled
> -	local color=$?
> -
>  	_tst_inc_res "$res"
>  
>  	printf "$TST_ID $TST_COUNT " >&2


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
