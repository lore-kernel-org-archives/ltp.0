Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87554C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 11:14:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EE7A3CAE7C
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 13:14:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018153C02B3
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 13:13:47 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B95621A00890
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 13:13:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B088321179;
 Mon,  7 Apr 2025 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744024425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JogImFfGN0gUkbziXL1oMAJIzJMYwJD91I3lrX2GiXA=;
 b=Kt6vYuXIBnz5B6mGJ07mhbqqrepkNrfb/gjtKL0G3L9fkWRq79gBrmWhshoFCjClRcLDpl
 jno0ZE0YWmoz2AY7nxQ7VZQF6SdujNkxfB9Xb1tZ2/soHFBKXZMdAgBGkp9AOyLPUx171z
 etY7D56NIGhjLP5ThCnx6fkEGqWhQBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744024425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JogImFfGN0gUkbziXL1oMAJIzJMYwJD91I3lrX2GiXA=;
 b=kUoKS3pn8O0DDEIbMhxj/zM5h4a5hm8Rt2wAbobbmd14tpxKkzwuIewQ/Ptx0hRhO7bEOd
 z+ajzxiRf/V3OyAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744024425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JogImFfGN0gUkbziXL1oMAJIzJMYwJD91I3lrX2GiXA=;
 b=Kt6vYuXIBnz5B6mGJ07mhbqqrepkNrfb/gjtKL0G3L9fkWRq79gBrmWhshoFCjClRcLDpl
 jno0ZE0YWmoz2AY7nxQ7VZQF6SdujNkxfB9Xb1tZ2/soHFBKXZMdAgBGkp9AOyLPUx171z
 etY7D56NIGhjLP5ThCnx6fkEGqWhQBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744024425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JogImFfGN0gUkbziXL1oMAJIzJMYwJD91I3lrX2GiXA=;
 b=kUoKS3pn8O0DDEIbMhxj/zM5h4a5hm8Rt2wAbobbmd14tpxKkzwuIewQ/Ptx0hRhO7bEOd
 z+ajzxiRf/V3OyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5380E13A4B;
 Mon,  7 Apr 2025 11:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mevNEWmz82dTZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 11:13:45 +0000
Date: Mon, 7 Apr 2025 13:13:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Siddhesh Poyarekar <siddhesh@gotplt.org>
Message-ID: <20250407111343.GA83774@pevik>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
 <20250407102448.2605506-3-siddhesh@gotplt.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250407102448.2605506-3-siddhesh@gotplt.org>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add centos10 to test matrix
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

Hi Siddhesh,

> gcc on CentOS 10 is configured to build with AVX on by default
> (specifically, -march=x86-64-v3), unlike other compilers, so it should
> be a useful addition to the test matrix.

> cve-2015-3290 for example fails to build on this without `-mno-avx` in
> the build flags.

I don't want to add yet another CI job just to test previous commit.
We already have quite a lot of distros (running is quite long).

@Li I suppose you want to keep centos 9 than to have centos 10.
I guess for new distros we have Fedora.

Therefore I suggest to not accept this change.

Kind regards,
Petr

> Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
> ---
>  .github/workflows/ci-docker-build.yml | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
> index 44dcca055..310d8c3a3 100644
> --- a/.github/workflows/ci-docker-build.yml
> +++ b/.github/workflows/ci-docker-build.yml
> @@ -67,6 +67,11 @@ jobs:
>                CC: gcc
>                TREE: out

> +          - container: "quay.io/centos/centos:stream10"
> +            env:
> +              CC: gcc
> +              TREE: out
> +
>            - container: "debian:testing"
>              env:
>                CC: gcc

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
