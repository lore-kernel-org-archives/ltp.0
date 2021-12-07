Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC01C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 18:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4DA3C5AEA
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 19:55:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAB213C0480
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 19:55:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F107D200DD2
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 19:55:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FBD42190C;
 Tue,  7 Dec 2021 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638903311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrsKUy9reltSMh48vcAokjeq8w/gZPjr0ym417DhAc=;
 b=y75MCSZ1sGApDJBk+ayVphZoZEi7KLtdDm6g/mzJxtrq4wsjIUgkwu8bC4y+VTQ802x7ft
 A7DHCVz4vXZIWxvMLABHdALD+qPmXiLTfTK1xMETof2NIUe8QKKpELrrSBRTivqPv4SOs5
 wblO7Irv1gIoC9JKJeex8go1tUdz2HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638903311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrsKUy9reltSMh48vcAokjeq8w/gZPjr0ym417DhAc=;
 b=WA3ptlWPucDlqULH0BSF075QtBtaVr+p4tdLvyIko/qeJI3j0SGHutf4sGYplSiMKaOwbl
 8v7P3QGUuVtnQNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB3813ABA;
 Tue,  7 Dec 2021 18:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WNGCBQ+ur2H6YwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 18:55:11 +0000
Date: Tue, 7 Dec 2021 19:56:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya+uW7R+djvFWsX/@yuki>
References: <20211207133515.24053-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211207133515.24053-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add documentation for tst_parse_* helpers
 functions
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/c-test-api.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 64d0630ce..b03124ed3 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -457,15 +457,17 @@ NOTE: The test parameters must not collide with common test parameters defined
>  [source,c]
>  -------------------------------------------------------------------------------
>  int tst_parse_int(const char *str, int *val, int min, int max);
> +int tst_parse_long(const char *str, long *val, long min, long max);
>  int tst_parse_float(const char *str, float *val, float min, float max);
> +int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
>  -------------------------------------------------------------------------------
>  
>  Helpers for parsing the strings returned in the 'struct tst_option'.
>  
> -Both return zero on success and 'errno', mostly 'EINVAL' or 'ERANGE', on
> +Helpers return zero on success and 'errno', mostly 'EINVAL' or 'ERANGE', on
>  failure.
>  
> -Both functions are no-op if 'str' is 'NULL'.
> +Helpers functions are no-op if 'str' is 'NULL'.
>  
>  The valid range for result includes both 'min' and 'max'.

Maybe we should list what are the valid units for the tst_parse_filesize
here as well, otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
