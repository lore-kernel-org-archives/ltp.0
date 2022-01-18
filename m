Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64542C433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 15:11:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E08F3C9690
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 16:11:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB93A3C8AD5
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:11:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CFA3C200756
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:11:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0866F218E0;
 Tue, 18 Jan 2022 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642518664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SbeuwcJiDQI+V5I7CKX+8Q2xQ3a0aBRDeOBRTrUdITQ=;
 b=xOc5NqXDWLrqKoKYF1S6sjwPxr3vPeIjLjNeIQmlM8jDKidJm6gIU3r3cNi6e8fTzu6h1J
 LX73ea9Cswmhbmw2jlW6/LIgnNTbe4jpRpXo6DrMdkA9nCwmip1teUNeQsJEy9uJHsXG96
 9rSINLNbOmQHSsFHJHAgK22B+CpbSQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642518664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SbeuwcJiDQI+V5I7CKX+8Q2xQ3a0aBRDeOBRTrUdITQ=;
 b=OZhNx+AOnX/awp6r/J5K245wbahTCLTXeS52x1efSCNJQs0T77DzTtq3HPRI3zfbNacP1E
 GaeHFoCHPDU47/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E354E13AC3;
 Tue, 18 Jan 2022 15:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id by64NofY5mHlVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jan 2022 15:11:03 +0000
Date: Tue, 18 Jan 2022 16:12:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YebY7ut/d0sT80HQ@yuki>
References: <20220114125513.895-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220114125513.895-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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
> Previously with --disable-metadata output didn't mention that metadata
> are disabled and printed config which was not used. Now:
> 
> $ ./configure --disable-metadata
> ...
> METADATA
> metadata disabled
> 
> $ ./configure
> ...
> METADATA
> metadata generator: asciidoctor
> HTML metadata: yes
> PDF metadata: no
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 3c56d19224..5b9e3c1781 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -404,7 +404,14 @@ libtirpc: ${have_libtirpc:-no}
>  glibc SUN-RPC: ${have_rpc_glibc:-no}
>  
>  METADATA
> +EOF
> +
> +if test "x$enable_metadata" = xyes; then
> +cat << EOF
>  metadata generator: $with_metadata_generator
>  HTML metadata: $with_metadata_html
>  PDF metadata: $with_metadata_pdf

Don't we stil have the same problem with "$enable_metadata_html" and
"$enable_metadata_pdf" ?

Also looking at m4/ltp-docparse.m4 shouldn't we just skip the
autodetection if metadata are disabled and exit with all three wariables
set to no?

I think that we should rethink what the flags really do, I guess that
for instance it would make sense for the $enable_metadata=no to just set
both $enable_metadata_html and $enable_metadata_pdf to no and the rest
of the m4/ltp-docparse.m4 should just check the later two.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
