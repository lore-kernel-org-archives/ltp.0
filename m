Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1728AC433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 08:00:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE8123CA5D8
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 09:59:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADFB33CA2C5
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 09:59:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB21E1A0027A
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 09:59:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 03E111F749;
 Thu, 14 Apr 2022 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649923187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1IWDWwK99edFdF24wHjMBCpq+1I7oOm1pcjOkLnBKNI=;
 b=h+BQvPidojTAiP33ipvic+aEeiLC0GtLKb5iTlE9ztPwCxcGZ6DTyspW9KEGjmtZ3D06Pp
 hCEJxrJG+JCiyL5uf+2luG5lG2hwmJhXIF+notfl6ySm9Z+CjTnubYK+EuQYnVu/nMXsHe
 aZxWAxdhN5acNPCGdMXjPZcmR4YxcA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649923187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1IWDWwK99edFdF24wHjMBCpq+1I7oOm1pcjOkLnBKNI=;
 b=8tX6pvveOTd3GKZ2acSip3xEYkDEz70T/pmwKOg5F2CTfGDCsytuHp44onXU10/gt2LNrn
 PpQ0pUgyqmKiVuAw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 86E99A3B93;
 Thu, 14 Apr 2022 07:59:46 +0000 (UTC)
References: <20220216073716.19598-1-tangmeng@uniontech.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: tangmeng <tangmeng@uniontech.com>
Date: Thu, 14 Apr 2022 08:59:04 +0100
In-reply-to: <20220216073716.19598-1-tangmeng@uniontech.com>
Message-ID: <878rs8yu19.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fchmod_06: Fix code formatting issues
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

tangmeng <tangmeng@uniontech.com> writes:

> When running make check, the following error is reported:
> fchmod06.c:53: error: code indentation should use tabs whenever possible.
> This commit fixes it
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/syscalls/fchmod/fchmod06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
> index 446865b1b..4a8aee6ca 100644
> --- a/testcases/kernel/syscalls/fchmod/fchmod06.c
> +++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
> @@ -50,7 +50,7 @@ static void verify_fchmod(unsigned int i)
>  	}
>  
>  	tst_res(TFAIL | TTERRNO,
> -	        "fchmod() failed unexpectedly, expected %i - %s",
> +		"fchmod() failed unexpectedly, expected %i - %s",
>  		TST_ERR, tst_strerrno(TST_ERR));
>  }
>  
> -- 
> 2.20.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
