Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31E8C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 09:57:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2EE73C9486
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 11:57:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DB343C1FED
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 11:57:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 53AA91A00612
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 11:57:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F71121E4E;
 Thu, 23 Jun 2022 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655978252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwMIwqaRahrOLk2LNpQJ6tq2S40QE8vCToNgcp7mwe8=;
 b=IyKgcrnT74+IFf2mKzM9/OUtgwBdlvGPbfAkNEHXl0VZf0eHnuwYj21YZDWzRNX1BmZXI8
 Ob3FAD2wbfbUsZA3OmuOaFfUgT9YwSvpA/w4Sb5VbxKquQfonZAf747kNiMXTxLe38RlY2
 +N83lTQuM806bI2mQOnyHyRZ09Op8VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655978252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwMIwqaRahrOLk2LNpQJ6tq2S40QE8vCToNgcp7mwe8=;
 b=OHCtr/HbDNiswuugtn6KnCv3KZJdNtYOqR2DSutlEarBkEYBEyxzM6J0+YGvrbDOgNEXP0
 pxumMICWarRcUYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D181133A6;
 Thu, 23 Jun 2022 09:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qbivFQw5tGLcNQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 23 Jun 2022 09:57:32 +0000
Message-ID: <91377e86-da37-2987-72a2-3e5cf44bdec6@suse.cz>
Date: Thu, 23 Jun 2022 11:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20220620092146.7604-1-chrubis@suse.cz>
 <20220620092146.7604-5-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220620092146.7604-5-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] openposix: sem_timedwait/11-1: Fix
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
small suggestion below, otherwise it looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 20. 06. 22 11:21, Cyril Hrubis wrote:
> Actually run both of the cases (valid timeout and invalid timeout).
> 
> The timeout is not actually invalid, but rather in the past, which is
> important to test as the system has to try to lock the semaphore first
> and only if that fails it should check the timeout.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../conformance/interfaces/sem_timedwait/11-1.c          | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/11-1.c
> index f87afaa43..663edd836 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/11-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/11-1.c
> @@ -24,7 +24,7 @@
>  #include "posixtest.h"
>  
>  #define TIMEOUT 2
> -#define INVALIDTIMEOUT -2
> +#define NEGATIVETIMEOUT -2
>  #define TEST "11-1"
>  #define FUNCTION "sem_timedwait"
>  #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
> @@ -45,7 +45,7 @@ int main(void)
>  			ts[i].tv_sec = time(NULL) + TIMEOUT;
>  			ts[i].tv_nsec = 0;
>  		} else if (i == 1) {
> -			ts[i].tv_sec = time(NULL) + INVALIDTIMEOUT;
> +			ts[i].tv_sec = time(NULL) + NEGATIVETIMEOUT;
>  			ts[i].tv_nsec = 0;
>  		}
>  		/* Lock Semaphore */
> @@ -63,13 +63,14 @@ int main(void)
>  
>  		/* Checking if the value of the Semaphore decremented by one */
>  		if ((val[i] == 0) && (sts[i] == 0)) {
> -			puts("TEST PASSED");
>  			sem_destroy(&mysemp[i]);

It'd be better to move sem_destroy() above the condition. See code
example at the end.

> -			return PTS_PASS;
>  		} else {
>  			puts("TEST FAILED");
>  			sem_destroy(&mysemp[i]);
>  			return PTS_FAIL;
>  		}
>  	}
> +
> +	puts("TEST PASSED");
> +	return PTS_PASS;
>  }

...

	sem_destroy(&mysemp[i]);

	/* Checking if the value of the Semaphore decremented by one */
	if ((val[i] != 0) || (sts[i] != 0)) {
		puts("TEST FAILED");
		return PTS_FAIL;
	}

	puts("TEST PASSED");
	return PTS_PASS;
}

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
