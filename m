Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFEFC43334
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 05:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0C6D3CA0FD
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 07:20:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A49B13C87EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 07:20:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D705200779
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 07:20:24 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6FBBC222EB
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1656998424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAtg1xOEKJ2xlC5NJ2aLy+sj9eaes8Q8/QqPr38E2JE=;
 b=rNQIeKzkWcwK3l2+2m7CVtb7iy0lOynl2d3ieBJridIzZF8gr8EmefHXpwhvMVRWMDOR0d
 WmhGH2LvU59hGCWwiToPnxFJzZpOeC1fvlBhXaK/IiFMqJCA8BtpF5RNartpRrhVCMw3Wz
 cgLCaTU+FTm00fbbiEqiNuanS1cMg6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1656998424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAtg1xOEKJ2xlC5NJ2aLy+sj9eaes8Q8/QqPr38E2JE=;
 b=RmgOo0+Tu3y1lC1grFALX9JJxv1/bJ1AyODNewa9+aswf8yE67CBQGrnt5xPVcSRyt7pAO
 +bHuslxt+DZGlOBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 30B5B2C141;
 Tue,  5 Jul 2022 05:20:24 +0000 (UTC)
References: <20220620092146.7604-1-chrubis@suse.cz>
 <20220620092146.7604-3-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 05 Jul 2022 06:20:17 +0100
In-reply-to: <20220620092146.7604-3-chrubis@suse.cz>
Message-ID: <8735fgt9t4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] openposix: pthread_spin_init/{2-1,2-2}: Fix
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


Hello,

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Cyril Hrubis <chrubis@suse.cz> writes:

> Propagate a failure in child to the parent properly.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../interfaces/pthread_spin_init/2-1.c        | 20 +++++++++++++++++--
>  .../interfaces/pthread_spin_init/2-2.c        | 20 +++++++++++++++++--
>  2 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
> index b7dd9e05e..f20822c50 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
> @@ -100,7 +100,11 @@ int main(void)
>  	if (pid == -1) {
>  		perror("Error at fork()");
>  		return PTS_UNRESOLVED;
> -	} else if (pid > 0) {
> +	}
> +
> +	if (pid > 0) {
> +		int status;
> +
>  		/* Parent */
>  		/* wait until child writes to spinlock data */
>  		while (spinlock_data->data != 1)
> @@ -116,13 +120,23 @@ int main(void)
>  		spinlock_data->data = 2;
>  
>  		/* Wait until child ends */
> -		wait(NULL);
> +		wait(&status);
>  
>  		if ((shm_unlink(shm_name)) != 0) {
>  			perror("Error at shm_unlink()");
>  			return PTS_UNRESOLVED;
>  		}
>  
> +		if (!WIFEXITED(status)) {
> +			printf("Parent: did not exit properly!\n");
> +			return PTS_FAIL;
> +		}
> +
> +		if (WEXITSTATUS(status)) {
> +			printf("Parent: failure in child\n");
> +			return WEXITSTATUS(status);
> +		}
> +
>  		printf("Test PASSED\n");
>  		return PTS_PASS;
>  	} else {
> @@ -170,5 +184,7 @@ int main(void)
>  			printf("Child: error at pthread_spin_destroy()\n");
>  			return PTS_UNRESOLVED;
>  		}
> +
> +		return PTS_PASS;
>  	}
>  }
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
> index f3cb9b2a3..df0d4df87 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
> @@ -106,7 +106,11 @@ int main(void)
>  	if (pid == -1) {
>  		perror("Error at fork()");
>  		return PTS_UNRESOLVED;
> -	} else if (pid > 0) {
> +	}
> +
> +	if (pid > 0) {
> +		int status;
> +
>  		/* Parent */
>  		/* wait until child writes to spinlock data */
>  		while (spinlock_data->data != 1)
> @@ -122,13 +126,23 @@ int main(void)
>  		spinlock_data->data = 2;
>  
>  		/* Wait until child ends */
> -		wait(NULL);
> +		wait(&status);
>  
>  		if ((shm_unlink(shm_name)) != 0) {
>  			perror("Error at shm_unlink()");
>  			return PTS_UNRESOLVED;
>  		}
>  
> +		if (!WIFEXITED(status)) {
> +			printf("Parent: did not exit properly!\n");
> +			return PTS_FAIL;
> +		}
> +
> +		if (WEXITSTATUS(status)) {
> +			printf("Parent: failure in child\n");
> +			return WEXITSTATUS(status);
> +		}
> +
>  		printf("Test PASSED\n");
>  		return PTS_PASS;
>  	} else {
> @@ -175,5 +189,7 @@ int main(void)
>  			printf("Child: error at pthread_spin_destroy()\n");
>  			return PTS_UNRESOLVED;
>  		}
> +
> +		return PTS_PASS;
>  	}
>  }
> -- 
> 2.35.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
