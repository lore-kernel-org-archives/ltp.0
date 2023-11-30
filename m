Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E18EC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:41:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7188E3CDB09
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 11:41:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1AD23CC201
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:41:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D82B6207CE4
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:41:30 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 901321FCEA;
 Thu, 30 Nov 2023 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701340889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tb9i77tG2u3+prOWhmx8qLxJRNu2HBXMPIYXMSGDKvs=;
 b=hwcav0boUCpccrCbYLLNH29d+GN+WSaK/BNWwXHVfxbm8tuqtRYSY/vuYLxV6Q0ZEX1fyc
 Y73+fTt87a4tK+pZ22fwx7azdop11vjW6NKgnlfpclFA2G0qT2nyxKsRvR1vn7hO59cZp5
 T2tgXeDJ1lHiBL9bVCHz/JtU5wbKbrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701340889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tb9i77tG2u3+prOWhmx8qLxJRNu2HBXMPIYXMSGDKvs=;
 b=x21mN3WpT6ennEsFNvmWCkAfUTinUe8kgfc9tEF4kLtqSSkKYYS/xrW/IjhaO4VEQ+b/gK
 YWEotsJu6L/cq7Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B11138E5;
 Thu, 30 Nov 2023 10:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id OFSwF9lmaGUmOAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 30 Nov 2023 10:41:29 +0000
Date: Thu, 30 Nov 2023 11:41:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mengchi Cheng <mengcc@amazon.com>
Message-ID: <20231130104127.GA3099694@pevik>
References: <20231130004010.488496-1-mengcc@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231130004010.488496-1-mengcc@amazon.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.46 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.16)[69.21%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] rwtest: Confirm df is a symlink to busybox
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

Hi Mengchi,

> /bin/df can be a symlink to coreutils. It returns correct info with dir
> arguments.
> Just checking if df is a symlink will include such cases. Need to make
> sure it is linking to busybox before ignoring options.

> Signed-off-by: Mengchi Cheng <mengcc@amazon.com>
> ---
>  testcases/kernel/fs/doio/rwtest | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
> index 6725e1426..26659e9d3 100644
> --- a/testcases/kernel/fs/doio/rwtest
> +++ b/testcases/kernel/fs/doio/rwtest
> @@ -329,10 +329,10 @@ do
>  		else
>  			# If df is a symlink (to busybox) then do not pass the $dir and $dfOpts
>  			# parameters because they don't work as expected
> -                        if test -h $(which df)
> -                           then
> -                               dir=""; dfOpts="";
> -                        fi
> +			if [[ "$(readlink -f "$(which df)")" == *"busybox"* ]]
Could you please test if this works?

			if [ "$(readlink -f "$(which df)")" = "busybox" ]

Although this script uses bash, we generally don't want to use it. Thus it'd be
better to not introduce any bash specific code.

BTW this is very old and very ugly script, we should cleanup it or delete:
https://github.com/linux-test-project/ltp/issues/1110

Kind regards,
Petr

> +			then
> +				dir=""; dfOpts="";
> +			fi

>  			blks=$(df $dfOpts $dir |
>  			(while read fs blks used avail cap mountpoint

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
