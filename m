Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F2FC433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 14:43:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12645610FB
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 14:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12645610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3533C8B73
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 15:43:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26D203C7B03
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 15:43:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4655C1A0148C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 15:43:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 582731FD3C;
 Fri, 19 Nov 2021 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637333014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMUdHn4CKPy0FPDsFZgxkQOyb0i9UD0BG15EPxFcj+U=;
 b=S0NI11549dYsXl0MoY9U10gDMH/ZZVSnbYRzHQeuPPv/Bz08i2mH0xK8JBZJiEz2e/fGlG
 UEOSSWufSB+Mk1CpG/W+2L4iKOgNw5hE9S3oaOFCW+5gVEAaLvT7YpgPq+wGToBvPD2GiH
 Q60nCPJEuLEtRpzs0RChMkPNYaGWxuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637333014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMUdHn4CKPy0FPDsFZgxkQOyb0i9UD0BG15EPxFcj+U=;
 b=5hIFKnh1SXN3/rEiUkkjS+zw1ptdnugmepwst1MfRhlws05xG0YduB2x+h0w3U2ODT5yQp
 VNHjqg2jfcsThnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42AB713B32;
 Fri, 19 Nov 2021 14:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /V74Dha4l2HoCQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 14:43:34 +0000
Date: Fri, 19 Nov 2021 15:44:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZe4V8mbn7Dk8x3U@yuki>
References: <20211119074602.857595-1-lkml@jv-coder.de>
 <20211119074602.857595-3-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211119074602.857595-3-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/12] posix/mq_(timed)send/5-1: Fix error
 reporting
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Applied, thanks.

> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
> @@ -58,7 +58,6 @@ int main(void)
>  	char msgrcd[BUFFER];
>  	const char *msgptr = MSGSTR;
>  	struct mq_attr attr;
> -	int unresolved = 0;
>  	unsigned pri;
>  
>  	sprintf(gqname, "/mq_timedsend_5-1_%d", getpid());
> @@ -119,7 +118,10 @@ int main(void)
>  		/* receive message and allow blocked send to complete */
>  		if (mq_receive(gqueue, msgrcd, BUFFER, &pri) == -1) {
>  			perror("mq_receive() did not return success");
> -			unresolved = 1;
> +			kill(pid, SIGKILL);	//kill child
> +			mq_close(gqueue);
> +			mq_unlink(gqname);
> +			return PTS_UNRESOLVED;
>  		}

There is another place where it does not clean up the queue in the code
under the if (j == MAXMSG+1) condition, that should be fixed as well.

Also I guess the cleanest way how to write this test would be a kernel
style goto cleanup. E.g.:

	int rval = PTS_UNRESOLVED;


	if (foo) {
		rval = PTS_FAIL;
		goto ret;
	}

	if (bar)
		goto ret;

	...

	pid = 0;
ret:
	if (pid)
		kill(pid, SIGKILL);
	mq_close(queue);
	mq_unlink(queue);
	return rval;
-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
