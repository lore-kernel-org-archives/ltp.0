Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449BAC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970273CE94A
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:46:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 825A33C31BB
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:46:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D316B1B61043
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:46:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA00B211E1;
 Fri,  3 Nov 2023 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699026387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHIMI4QYODkJm2c11GX6qoyFR1dLfvDnIsjxPgaCYh8=;
 b=BbwICBXFzV0ESVQeUiRpEmr4EicPnYF50nk0YUEiGKHHzwOAaQHq/6npsSt4A18RvvBicl
 W4Ap7zkAHQJCHnFv7530kvZSW6rjwhxDNR+Y1+WE5N1y+8EVZgPF0l8aZrPvAPkfmC6gd/
 amJzVmlWiN4kKKACa7cDLAj9zY/puUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699026387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHIMI4QYODkJm2c11GX6qoyFR1dLfvDnIsjxPgaCYh8=;
 b=bDJ8JgQBdAmTbG9vGX/jumWP5CkRqAd8UOx/UjuABz1qFqPmmggdgyty08Ae0UiNRMzkpU
 wqmhmKnVM1RRiXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6A6B1348C;
 Fri,  3 Nov 2023 15:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TfkDM9MVRWWqNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Nov 2023 15:46:27 +0000
Date: Fri, 3 Nov 2023 16:47:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZUUV9MiVadNA75WY@yuki>
References: <20231103105339.21435-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103105339.21435-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Extend ioctl02 to test termio and termios
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#define CMP_ATTR(term_exp, term, attr) \
> +	(flag += cmp_attr((term_exp).attr, (term).attr, #attr))
>  
> -	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
> -		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
> -		tst_res(TFAIL, "iflag has incorrect value. %o",
> -			 termio.c_iflag);
> -		flag++;
> -	}
> +#define CMP_C_CC(term_exp, term) \
> +	(flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc)))

The last thing that I do not like about this is that we modify the flag
variable without it being passed to the macro, this is something you get
frowned upon for in proper C circles.

The rest looks really good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
