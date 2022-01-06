Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF1BC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6435A3C719A
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 11:41:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C563C12D0
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 11:41:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0A5B200C04
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 11:40:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF6081F37D;
 Thu,  6 Jan 2022 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641465658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sc95Ypj/WoHw4tTxcXsBss7+0nYNWy9x9pgNXLIU2p4=;
 b=K3PsMQd5VecBjN97zWq/lBc2uORTm0kV1cVfoXpK5QveLFnrlwaNR7hy5/PW3lVPLxO9Ye
 u80P0X2mTgIPSLZ8cPbrjPIR4g0LUYc4tqwtdUr1/m4YL+GZjzbx+KSILB/2QX6sSNEajm
 HCLEfQFeEmn51Cze+jFSfm4CJJkQZuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641465658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sc95Ypj/WoHw4tTxcXsBss7+0nYNWy9x9pgNXLIU2p4=;
 b=8nITrag7pbYwPNi8MAH65OkQcCKNsr4R99qcOndmT3TmAOqPdR838tDBT9W5LFEGjCrafW
 7lwHNYXqSy8fyPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DF3613C24;
 Thu,  6 Jan 2022 10:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YWhZJDrH1mErCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Jan 2022 10:40:58 +0000
Date: Thu, 6 Jan 2022 11:40:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdbHODSAdEnILJ6K@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

> +tst_require_kconfigs()
> +{
> +	[ $# -eq 0 ] && return 0
> +
> +	local kconfigs
> +	local kconfig_i
> +	local kconfig_max
> +
> +	kconfigs=$@

> +	[ -z "$kconfigs" ] && return 0
> +
> +	tst_check_cmds cut tr wc
> +	kconfig_max=$(( $(echo "$kconfigs" | tr -cd "$TST_NEEDS_KCONFIGS_IFS" | wc -c) +1))
> +	if [ $kconfig_max -gt 10 ]; then
> +		tst_brk TCONF "The max number of kconfig is 10!"
> +	fi
> +
> +	for kconfig_i in $(seq $kconfig_max); do
> +		eval "local kconfig$kconfig_i"
> +		eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIGS_IFS" -f$kconfig_i)'"
Well, we use 2x eval and cut in order to have easy C code. How about move
splitting string to C (using e.g. strtok_r()? Although using this code is
probably safe for any shell (we use similar cut like delimiter in tst_test.sh),
I've had enough of fixing obscure shell bugs. And C code with strtok_r() is more
portable across libc than any shell code.

> +	done
> +
> +	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
> +			$kconfig7 $kconfig8 $kconfig9 $kconfig10
Now I see the need for the need to limit. First, you need to quote parameters:

	tst_check_kconfigs "$kconfig1" "$kconfig2" "$kconfig3" "$kconfig4" "$kconfig5" "$kconfig6" \
			"$kconfig7" "$kconfig8" "$kconfig9" "$kconfig10"

Because there might be config value with space. I found only one which is not
going to be used:
CONFIG_CC_VERSION_TEXT="gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b]"
but we cannot rely on that.

Kind regards,
Petr

> +	if [ $? -ne 0 ]; then
> +		tst_brk TCONF "Aborting due to unsuitable kernel config, see above!"
> +	fi
> +
> +	return 0
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
