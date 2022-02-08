Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40FDC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 13:26:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66AB33C9B5D
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:26:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2641A3C9B28
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:25:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46F7160015C
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:25:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38FD7210E8;
 Tue,  8 Feb 2022 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644326751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VriNBvKmqU+/+po9JYBfOrEVzD+Hga4aBOkAVHm1HJ8=;
 b=q8xQetLkjbnOl3a0ov6yF+SjQrTIIdJFVdi+LCenLgMwYlz4l8L/5K2nj3sLhTjCX75tnD
 PtsRD7p/Y5Ch28282iynLdb7c7gPwMuHAlO8tY6T1MFvNQT0bswrQnrB294B5zyZavEKrV
 SxqeCsFg2cfB0NE2ekjzWoaDZf0iBe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644326751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VriNBvKmqU+/+po9JYBfOrEVzD+Hga4aBOkAVHm1HJ8=;
 b=5ted5pZENM3R6FboBugtt2WHN9EKfFLINK9C7cUfvkHH8t1aYeV8QnY9HmmLup0yaAGaOG
 bzZVDJGJbtA3kYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D75313C99;
 Tue,  8 Feb 2022 13:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /p+FBV9vAmI2YAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 13:25:51 +0000
Date: Tue, 8 Feb 2022 14:27:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgJv2+y6v/+Tpb1N@yuki>
References: <20220126145141.13825-1-pvorel@suse.cz>
 <20220126145141.13825-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126145141.13825-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Print environment variables in
 help
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
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 30614974c3..a7fd7b19c6 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -448,12 +448,30 @@ tst_usage()
>  	if [ -n "$TST_USAGE" ]; then
>  		$TST_USAGE
>  	else
> -		echo "usage: $0"
> -		echo "OPTIONS"
> +		cat << EOF
> +usage: $0
> +
> +Options
> +-------
> +EOF

I think that the cat EOF syntax inside of else branch is a bit
confusing, especially sice it prints just three lines of text...


But other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
