Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07D7C25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 08:25:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29C2E3CA24F
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:25:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456E83C8A8C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:25:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41FDE140018A
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:25:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA4D5CADE;
 Fri, 19 Aug 2022 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660897525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+ZHDyjUgOxzLS9oW3Rv41WnTL5GROZGYMnoTOiSYWo=;
 b=EkG9OaZkkst3yQENTnR7LPwXRE0ODsc9rcqGX0LPG87KNN3i99SWxzoC4fzpccsxaRM+ka
 4vEQxmiq5iwW7frZZpNXocGmMftkqQTYZYAJn9CxYxZWWGK8p+v99kecnCzwjjyBFJdO1H
 ADX9vqm6BsyORRpvx2pYvLfPwI+LEsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660897525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+ZHDyjUgOxzLS9oW3Rv41WnTL5GROZGYMnoTOiSYWo=;
 b=3gDz1rR5ZhGmsh/h+Lj1ww9Q3GgeIUB61PcoOeb+Hi0OnU0ksZLgnW0bbPmVXz9GqYSSwb
 +EmlhgN2xENqbTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EBAD13AE9;
 Fri, 19 Aug 2022 08:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6VGeBvVI/2L8ZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Aug 2022 08:25:25 +0000
Date: Fri, 19 Aug 2022 10:27:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv9Jafy8AzSCH437@yuki>
References: <20220818171724.9182-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220818171724.9182-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
> +++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
> @@ -209,6 +209,11 @@ static struct tst_test test = {
>  		{&msg, .size = sizeof(MSG)},
>  		{}
>  	},
> +	.needs_root = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"?/proc/sys/kernel/unprivileged_bpf_disabled", "0"},
> +		{}
> +	},

If we set needs_root the test would run under root and there is no need
to fiddle with the unprivileged_bpf_disabled at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
