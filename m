Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F16C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:21:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E9D60C3E
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0E9D60C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01AE63C951E
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 14:21:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E303C25B5
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 14:21:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41281600D10
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 14:21:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A910D22112;
 Mon,  6 Sep 2021 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1630930901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNRm92gQBVxMi2YSnxzQJHlXqs8RZah2kqQQJxiGnJ8=;
 b=xxOoErepzC5TdmUPibkCJTF2gCSPSs6Cosl6IrAmJmhEmXo6PaLU+AlXctbAz4jw4cmHRZ
 Q5iOdKdDeS26RMhx/b462VfIjWDH8Gy86d5k4rHE9wVV5MDPqgqLN3uInZZRYyEIKPRagU
 vvvCVN+Mh39E9oTbxIYWc5/MsF1LgUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1630930901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNRm92gQBVxMi2YSnxzQJHlXqs8RZah2kqQQJxiGnJ8=;
 b=ZD6KIhoQ70Ps9GnlaFkNy2ZJkR15iSwFbSDUkmuB+8OmaVmc2yOKLHzRuibSEMY6jOKs09
 QjEHf1vCsjmIbmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8294E13C1B;
 Mon,  6 Sep 2021 12:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1a+0HtUHNmEFOQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Sep 2021 12:21:41 +0000
Date: Mon, 6 Sep 2021 14:21:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YTYH4DdeUqsYeglK@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210903154848.18705-4-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] Add user/group ID lookup helper functions
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
Message-ID: <20210906122152.N1CGlpaA21UuNNdqLGs3GcT_Ch9e4BnnPdkf249acYM@z>

Hi!
> diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> index dd719d312..915a5bc34 100644
> --- a/lib/tst_uid.c
> +++ b/lib/tst_uid.c
> @@ -3,8 +3,10 @@
>   * Copyright (c) 2021 Linux Test Project
>   */
>  
> +#define _XOPEN_SOURCE 500
>  #include <sys/types.h>
>  #include <grp.h>
> +#include <pwd.h>
>  #include <errno.h>
>  
>  #define TST_NO_DEFAULT_MAIN
> @@ -36,3 +38,101 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
>  	tst_brk_(file, lineno, TBROK, "No free group ID found");
>  	return (gid_t)-1;
>  }
> +
> +struct passwd *safe_getpwent(const char *file, const int lineno)
> +{
> +	struct passwd *ret;
> +
> +	errno = 0;
> +	ret = getpwent();
> +
> +	if (!ret) {
> +		if (errno) {
> +			tst_brk_(file, lineno, TBROK | TERRNO,
> +				"getpwent() failed");
> +		} else {
> +			tst_brk_(file, lineno, TBROK,
> +				"getpwent() failed: end of file");
> +		}

I'm not sure if "no more users in the /etc/passwd" should be reported as
an error.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
