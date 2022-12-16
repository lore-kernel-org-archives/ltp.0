Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F1C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 08:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C307D3CBC22
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:55:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 810523CBC18
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 09:55:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9299D1A00E5F
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 09:55:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 771C533D79;
 Fri, 16 Dec 2022 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671180912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqroESyYsncCMU5P1fa086szq9+5RXnsj50WkUBpd3s=;
 b=TmLVt9fhPdH82U4oG74qBzxPnb3lnBLzajXEAYjgQ/ETEIiyE0Pp/KCYJsUT8ofQL87qCR
 r44Y+Entf9iVHwC1HiQMQHz5yYEm9V1ospkLH96KLcKbV1oOGZLHfVKl9R1ghqef69zWq2
 FbgeoMq3RQ/0XI+0YAE71vNf+45sFPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671180912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqroESyYsncCMU5P1fa086szq9+5RXnsj50WkUBpd3s=;
 b=2htEYZxuI39POMM2y14AzO8viLk7GUVUL5x6Zv2v4+3IG8EhPMxWJYDFbdgPVh9LNGIk/R
 im0VYw8WMNVmXHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B63138FD;
 Fri, 16 Dec 2022 08:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d+NwE3AynGPLOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 08:55:12 +0000
Date: Fri, 16 Dec 2022 09:55:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5wyboyGmmZySY9D@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671166923-2173-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] shell: Remove old kernel version check
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

...
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -15,21 +15,15 @@ cleanup() {
>  	fi
>  }

> -check_kervel_arch() {
> -	# Checking required kernel version and architecture
> -	if tst_kvcmp -lt "2.6.21"; then
> -		tst_brkm TCONF "Kernel version not supported; not " \
> -			"running testcases"
> -	else
> -		case "$(uname -m)" in
> -		i[4-6]86|x86_64)
> -			;;
> -		*)
> -			tst_brkm TCONF "Arch not supported; not running " \
> -				"testcases"
> -			;;
> -		esac
> -	fi
> +check_arch() {
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running " \
> +			"testcases"
Could you please put this on single line?
		tst_brkm TCONF "Arch not supported; not running testcases"

Can be done before merge.

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
