Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF486C433F5
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 14:30:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167D961056
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 14:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 167D961056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 363DE3C7EBF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 16:30:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 064E73C65BE
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 16:30:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7FC52100136F
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 16:30:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A90CC22491;
 Wed,  6 Oct 2021 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633530639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDUb6Hl1X7WDTNKV6C/cJpLLPwrM1rgCGfji15lFvxU=;
 b=juz4cgrYS/QErashhtJ/SChgGnB3/p2MlAvsCijTnTEDV8vL35ahiliBrzOURI0VZqv35p
 QI5QdorlJJzkd5TKW7dabqHSE7DaNQRDeykwYu1qwy53x30CJ4wOHEhcJxYwmHKkm/WoQW
 HtzlJHs9P1VQdNh9tDgQYtysB+VohK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633530639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDUb6Hl1X7WDTNKV6C/cJpLLPwrM1rgCGfji15lFvxU=;
 b=F1DgSK6PHFmyiXHlnaQvsSZMjoypFQdwi9IeQOeKX2Yjbh3fdqDR3ihTnZ7RS4ZPeWRMPA
 h12IKBeN8hugZAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9663B13E4F;
 Wed,  6 Oct 2021 14:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UcvSIg+zXWF/AwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 06 Oct 2021 14:30:39 +0000
Date: Wed, 6 Oct 2021 16:31:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YV2zMeb3ILLRPNsL@yuki>
References: <281d8fbf1a7df4d85aea6bbd3ff74982923309c5.1633527038.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <281d8fbf1a7df4d85aea6bbd3ff74982923309c5.1633527038.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: remove pthread_kill/6-1
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
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> index 2289b9bfbb2e..fa74c312bebb 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> @@ -16,10 +16,6 @@
>    <assertion id="5" tag="ref:XSH6:33594:33595 pt:THR">
>      No signal shall be sent if the pthread_kill() function fails.
>    </assertion>
> -  <assertion id="6" tag="ref:XSH6:33598:33599 pt:THR">
> -    [ESRCH] No thread could be found corresponding to that specified by
> -    the given thread ID.
> -  </assertion>
>    <assertion id="7" tag="ref:XSH6:33600:33600 pt:THR">
>      [EINVAL] The value of the sig argument is an invalid or unsupported
>      signal number.
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> index 03dc3d5a718a..8cfa3d8b6ba3 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> @@ -6,6 +6,5 @@ Assertion	Status
>  3		YES
>  4		IMPLICITLY tested by assertions 6 and 7.
>  5		IMPLICITLY tested by assertions 6 and 7.
> -6		YES
>  7		YES
>  8		WON'T test. No way to interrupt the pthread_kill() call.


Shouldn't we just flip the YES to WON'T test in the coverage?

I'm not sure how to maintain the assertions or coverage files to be
honest.

Otherwise it looks good. The ESRCH return was always a recommendation
and not an requirement.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
