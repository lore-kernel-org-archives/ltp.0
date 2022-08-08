Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FCAC25B07
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:12:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 273123C945E
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:12:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18AB33C712D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:12:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB61F1A006E0
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:12:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDC9D378FB;
 Mon,  8 Aug 2022 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659957140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lX4TOhlw7h8AwpxFC7SjavCzix9p1oAwtGr2NZfh360=;
 b=v7u3Otr7h9lHtSlr4eVUw0zC6dVTW55sANITqosp7EezcJ1aVKLpS8Sff7vj0lWhQUNsUM
 3rIbEgVw2sX4+SfxOfTeBGXXqbg7THtoSmifp9LIvoKSH46gHD7/egzl3nh1PRjjoSz6VT
 a1atbIUrLKf8tCRAxHKwh8Ecm2kd1f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659957140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lX4TOhlw7h8AwpxFC7SjavCzix9p1oAwtGr2NZfh360=;
 b=Bs8qGxIDzfJaNrl+DKO6cTLDEESvO7/+jugsBgv732Ffv9wjlBK+sCMhCXtl3iAsGZCjhl
 S8PdgDGvL1RbqeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A139613AB3;
 Mon,  8 Aug 2022 11:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jsbBJJTv8GJoIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 11:12:20 +0000
Date: Mon, 8 Aug 2022 13:12:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YvDvjVU66LrHpZ2M@pevik>
References: <20220808101019.29892-1-pvorel@suse.cz>
 <20220808101019.29892-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808101019.29892-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] tst_ansi_color.sh: Allow to run with set -e
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
> code, harden tst_res TINFO to be able to be used on scripts with it.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_ansi_color.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
> index 703df1eb8..4b2255448 100644
> --- a/testcases/lib/tst_ansi_color.sh
> +++ b/testcases/lib/tst_ansi_color.sh
> @@ -32,8 +32,9 @@ tst_color_enabled()

>  tst_print_colored()
>  {
> -	tst_color_enabled
> -	local color=$?
> +	local color=0
> +
> +	tst_color_enabled || color=$?
OK, this is not working for LTP_COLORIZE_OUTPUT=n => v4 will come shortly.

Kind regards,
Petr

>  	[ "$color" = "1" ] && tst_flag2color "$1"
>  	printf "$2"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
