Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DCEC43334
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 05:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECD013CA15B
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 07:26:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A9023C7C07
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 07:25:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E33BF1A0070B
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 07:25:55 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5E8751FE3E
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 05:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1656998755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RBKimGFFxkwL+FQrj05MrBpcYas/XfY/olH64MFtWr0=;
 b=hwURmSAYwDEGb1n85rkWMFprvMPqfdeo+ehEe4U73SlUczU4QIv7ue+5nU0Fl2aBfLjoQT
 vyeYCjCztcXaqTu7P8Z03wVuw30gWXI9i8VJaxSCIBvt3GcuKQyJ3ZpkCZIdRpkv2zcPDU
 tZU7EyVWdS40w4PUAVL/lm6mBCOoCBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1656998755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RBKimGFFxkwL+FQrj05MrBpcYas/XfY/olH64MFtWr0=;
 b=rduAihSEHLCm3B6F6tozJyaR2/RyViO+6p47VjPOezqPgUNFsxuzKE6j2NqKRHvnUQvn9Y
 8HEvrIxrQNla39Cg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 25ABA2C141;
 Tue,  5 Jul 2022 05:25:55 +0000 (UTC)
References: <20220620092146.7604-1-chrubis@suse.cz>
 <20220620092146.7604-7-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 05 Jul 2022 06:25:51 +0100
In-reply-to: <20220620092146.7604-7-chrubis@suse.cz>
Message-ID: <87pmikruzh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] openposix: mq_timedreceive: Silence warning
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


Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Cyril Hrubis <chrubis@suse.cz> writes:

> We do not use the exit value from the child at all, but that's not a
> reason to produce warnings.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../conformance/interfaces/mq_timedreceive/5-3.c                 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
> index a843c13ee..d79d9720d 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
> @@ -110,5 +110,6 @@ int main(void)
>  		sleep(1);	/* give time to parent to set up handler */
>  		/* send signal to parent */
>  		kill(getppid(), SIGABRT);
> +		return 0;
>  	}
>  }
> -- 
> 2.35.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
