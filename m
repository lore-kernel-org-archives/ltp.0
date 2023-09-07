Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6716EB8FCB
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:44:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A02FE3CE9C3
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 13:44:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 235EB3CB589
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:44:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41A421000D1C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:44:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 892041F8A4;
 Thu,  7 Sep 2023 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694087061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHBw/BpNvaEQ6MDFY7GnpkkLNEcHX0Ix3FOmEqlcddU=;
 b=ssLQ9rvlFIaem4Hpu3SV6pMFx+ylU5foYgczUsYpmf5OkHaLYDrjrfR/0N0yRTWF5OTtAa
 jVoaBWEg8yGaZsiyNhc2ZlEUZs9x5bWOX49WqIXu/nGMsjUTrA7//+WN2M/ZJLKgw7U3AT
 iB9H/i1UUyQg0o7iysnJxv9b8MAlxng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694087061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHBw/BpNvaEQ6MDFY7GnpkkLNEcHX0Ix3FOmEqlcddU=;
 b=NUN+fPqDKAqshh7/IpbIFUZHVYnQSneOjLznE/MFfm/a8pQSqziqGOZKX2mlHG7yw+3ooz
 0t53uaB6Koi6w3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7833F138F9;
 Thu,  7 Sep 2023 11:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g+1cHJW3+WSxAgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 07 Sep 2023 11:44:21 +0000
Message-ID: <9c56c759-5a61-ab0b-12c4-39ab8feb692e@suse.cz>
Date: Thu, 7 Sep 2023 13:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230905093019.13881-1-mkittler@suse.de>
 <20230905093019.13881-2-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230905093019.13881-2-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Use correct ioctl request for termios
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
this patch will be effectively reverted by the second one. Merge them 
into a single patch.

On 05. 09. 23 11:30, Marius Kittler wrote:
> With the termios struct one is supposed to use TCGETS instead of TCGETA,
> see `man ioctl_tty`.
> 
> Related issue: https://github.com/linux-test-project/ltp/issues/637#issuecomment-1705334874
> ---
>   testcases/kernel/syscalls/ioctl/ioctl01.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 1be38e79d..983208925 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -36,34 +36,35 @@ static struct termios termios;
>   
>   static struct tcase {
>   	int *fd;
> -	int request;
> +	int request_tio;
> +	int request_tios;
>   	struct termio *s_tio;
>   	struct termios *s_tios;
>   	int error;
>   } tcases[] = {
>   	/* file descriptor is invalid */
> -	{&bfd, TCGETA, &termio, &termios, EBADF},
> +	{&bfd, TCGETA, TCGETS, &termio, &termios, EBADF},
>   	/* termio address is invalid */
> -	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
> -	/* command is invalid */
> +	{&fd, TCGETA, TCGETS, (struct termio *)-1, (struct termios *)-1, EFAULT},
> +	// /* command is invalid */
>   	/* This errno value was changed from EINVAL to ENOTTY
>   	 * by kernel commit 07d106d0 and bbb63c51
>   	 */
> -	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
> +	{&fd, INVAL_IOCTL, INVAL_IOCTL, &termio, &termios, ENOTTY},
>   	/* file descriptor is for a regular file */
> -	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
> +	{&fd_file, TCGETA, TCGETS, &termio, &termios, ENOTTY},
>   	/* termio is NULL */
> -	{&fd, TCGETA, NULL, NULL, EFAULT}
> +	{&fd, TCGETA, TCGETS, NULL, NULL, EFAULT}
>   };
>   
>   static char *device;
>   
>   static void verify_ioctl(unsigned int i)
>   {
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
> +	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tio, tcases[i].s_tio),
>   		     tcases[i].error);
>   
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
> +	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tios, tcases[i].s_tios),
>   		     tcases[i].error);
>   }
>   

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
