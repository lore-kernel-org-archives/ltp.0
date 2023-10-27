Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777EC25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66D8C3CEBEE
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 13:01:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 452473C83BA
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:01:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99045603495
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:01:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F81D21C66;
 Fri, 27 Oct 2023 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698404478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQH5dXi+x9jAWV2CYBT4kM8hElbCz0KCPMLFNkN2cIs=;
 b=gYMWBcUa2t4JPLe3LmaNj9LuejReXA6qkT/eif9oJ1DqzmuSlIywSC+zK2eto7etlYtsiF
 VognUKBziS2iA7oafeAs2TTIFm/ufSLW+aL2RhcVY0Tms2L54SEUMlNaCoPh1MRqO652ii
 /94Q5Ric0aU9eUf0fAT6kbzs3Oq+jj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698404478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQH5dXi+x9jAWV2CYBT4kM8hElbCz0KCPMLFNkN2cIs=;
 b=qydeF2dMllPDETIxnertLW3LIPGz+8MJSed0RaibUtJQsOuZi4NOmgAesHxM6kNBvo7LxK
 PIbssw4PLEBfypAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C17921358C;
 Fri, 27 Oct 2023 11:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BQBCLH2YO2WCDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 11:01:17 +0000
Date: Fri, 27 Oct 2023 13:01:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20231027110116.GA649751@pevik>
References: <20231027104951.32464-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027104951.32464-1-rpalethorpe@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.90 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.60)[98.23%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: Make mount failure TCONF
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

Hi Richie,

> It appears that if the subsystem is available under V2 then mounting
> the V1 can fail. Probably when the V2 has processes assigned to a
> group it controls.

Sounds likely, but it would be good to check this in the kernel code or with
kernel cgroup developers.

> The test should scan the system and find the existing CGroup
> hierarchies and work with those. This can be done by converting the
> test to tst_cgctl or rewriting it in C. It's not clear what the best
> course of action would be.

> For now, this commit just changes the result to TCONF.

+1 (suppose it's the case of already mounted under v2)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 0cfa0c17e..312654a9d 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -165,7 +165,7 @@ setup()
>  	mount -t cgroup -o cpuset cpuset "$CPUSET" 2> /dev/null
>  	if [ $? -ne 0 ]; then
>  		cleanup
> -		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
> +		tst_brkm TCONF "Could not mount cgroup filesystem with"\
>  					" cpuset on $CPUSET..Exiting test"

nit: I'd cleanup the message.

		tst_brkm TCONF "Could not mount cgroup filesystem with cpuset on $CPUSET"

Kind regards,
Petr

>  	fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
