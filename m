Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D09C4167D
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 09:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 092C13CC8B8
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 10:24:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00043CC822
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:24:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E6791000EC6
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:24:42 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3E6132193C
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698917081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFTVmTCDno5TPzHq2bBX7keER5wiBEYomJqOrOdaWX8=;
 b=iyivKS5xdss3bpHKwFu1fpwg+4/yOAvqnhZw3byJIC10iKqxxbS5FsX3h5ypsjwg90JwJD
 F466nNqFmqTg0sRhKrqFySlCWU2ct1oTavSkZN4lMccjE0V3KUg45S7qZferkMMzKYKy+N
 w3l6TNDLX+2HGGKS4QvNwU+172o62zY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698917081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFTVmTCDno5TPzHq2bBX7keER5wiBEYomJqOrOdaWX8=;
 b=oLduXxhyaTlDWqvfaJt2dJMideBVzOYdOmQs25e9/RScxWpgM+UgY0F1QPlIwP0gtk6LN/
 N46C0Tgy111Fh4Cg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C44542C15C;
 Thu,  2 Nov 2023 09:24:40 +0000 (UTC)
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-5-pvorel@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 02 Nov 2023 09:22:07 +0000
Organization: Linux Private Site
In-reply-to: <20231013074748.702214-5-pvorel@suse.cz>
Message-ID: <87il6kse1z.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] can_bcm01: Move vcan to .modprobe
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

Petr Vorel <pvorel@suse.cz> writes:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/can/cve/can_bcm01.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
> index d9a835b03..ec98db133 100644
> --- a/testcases/network/can/cve/can_bcm01.c
> +++ b/testcases/network/can/cve/can_bcm01.c
> @@ -41,14 +41,6 @@ static void setup(void)
>  {
>  	struct sockaddr_can addr = { .can_family = AF_CAN };
>  
> -	/*
> -	 * Older kernels require explicit modprobe of vcan. Newer kernels
> -	 * will load the modules automatically and support CAN in network
> -	 * namespace which would eliminate the need for running the test
> -	 * with root privileges.
> -	 */
> -	tst_cmd((const char*[]){"modprobe", "vcan", NULL}, NULL, NULL, 0);
> -
>  	NETDEV_ADD_DEVICE(LTP_DEVICE, "vcan");
>  	NETDEV_SET_STATE(LTP_DEVICE, 1);
>  	addr.can_ifindex = NETDEV_INDEX_BY_NAME(LTP_DEVICE);
> @@ -143,10 +135,19 @@ static struct tst_test test = {
>  	.skip_in_compat = 1,
>  	.max_runtime = 30,
>  	.needs_drivers = (const char *const[]) {
> -		"vcan",
>  		"can-bcm",
>  		NULL
>  	},
> +	/*
> +	 * Older kernels require explicit modprobe of vcan. Newer kernels
> +	 * will load the modules automatically and support CAN in network
> +	 * namespace which would eliminate the need for running the test
> +	 * with root privileges.
> +	 */

This comment is wrong and can be removed. It also (or only?) depends on
kernel config whether modules are loaded automatically. It is a security
feature to remove automatic modprobe. IDK if older kernels lacked auto
module loading.

> +	.modprobe = (const char *const[]) {
> +		"vcan",
> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "d5f9023fa61e"},
>  		{"CVE", "2021-3609"},
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
