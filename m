Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E19EB8FD7
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1723CC848
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 13:47:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 165DC3CB576
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:47:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B4CB1400C44
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:47:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 532E121869;
 Thu,  7 Sep 2023 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694087254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPVs0lkYI0STMIGbNOVwA6VGpjHumnvyaz5JZpMd48E=;
 b=0SYrEI1IynqmW8iL98mQGgfHwNWDvTmuJqnO1wKPnmQLKr/gna4Cl6H0ozHIL7gOanvT2i
 2kjZmu/3TZIRBSnjwqjXMHGGUaaeOWXjGHob86PvV+lPIB/2osrkw8L8vDxL8BxY5mklhN
 LX7HkvOzG/eKDjuOwXi6dUY8HP5AgOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694087254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPVs0lkYI0STMIGbNOVwA6VGpjHumnvyaz5JZpMd48E=;
 b=Scofh7F7TJ6LztoQVl7FcfvgacKVD5rDBNptIZbf0jTOfisw3arppEv8QvpviE/HDIpqXA
 K1190m5XuZL6eFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40C5F138F9;
 Thu,  7 Sep 2023 11:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GVT0Dla4+WSmBAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 07 Sep 2023 11:47:34 +0000
Message-ID: <2d1f406a-9f4a-2a5a-b29c-49f47a700efc@suse.cz>
Date: Thu, 7 Sep 2023 13:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230905093019.13881-1-mkittler@suse.de>
 <20230905093019.13881-3-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230905093019.13881-3-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Detangle test cases for termio and termios
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
a two notes below.

On 05. 09. 23 11:30, Marius Kittler wrote:
> As suggested in the review it is clearer to separate the test
> cases for termio and termios into separate entries in the
> `tcases` array.
> ---
>   testcases/kernel/syscalls/ioctl/ioctl01.c | 25 +++++++++++------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 983208925..d552746f8 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -36,35 +36,34 @@ static struct termios termios;
>   
>   static struct tcase {
>   	int *fd;
> -	int request_tio;
> -	int request_tios;
> -	struct termio *s_tio;
> -	struct termios *s_tios;
> +	int request;
> +	void *s_tio;
>   	int error;
>   } tcases[] = {
>   	/* file descriptor is invalid */
> -	{&bfd, TCGETA, TCGETS, &termio, &termios, EBADF},
> +	{&bfd, TCGETA, &termio, EBADF},
> +	{&bfd, TCGETS, &termios, EBADF},
>   	/* termio address is invalid */
> -	{&fd, TCGETA, TCGETS, (struct termio *)-1, (struct termios *)-1, EFAULT},
> +	{&fd, TCGETA, (struct termio *)-1, EFAULT},
> +	{&fd, TCGETS, (struct termios *)-1, EFAULT},
>   	// /* command is invalid */
>   	/* This errno value was changed from EINVAL to ENOTTY
>   	 * by kernel commit 07d106d0 and bbb63c51
>   	 */
> -	{&fd, INVAL_IOCTL, INVAL_IOCTL, &termio, &termios, ENOTTY},
> +	{&fd, INVAL_IOCTL, &termio, ENOTTY},
> +	{&fd, INVAL_IOCTL, &termios, ENOTTY},

The INVAL_IOCTL, &termios testcase is probably redundant.

>   	/* file descriptor is for a regular file */
> -	{&fd_file, TCGETA, TCGETS, &termio, &termios, ENOTTY},
> +	{&fd_file, TCGETA, &termio, ENOTTY},
> +	{&fd_file, TCGETS, &termios, ENOTTY},
>   	/* termio is NULL */
> -	{&fd, TCGETA, TCGETS, NULL, NULL, EFAULT}
> +	{&fd, TCGETA, NULL, EFAULT}

No TCGETS testcase here?

>   };
>   
>   static char *device;
>   
>   static void verify_ioctl(unsigned int i)
>   {
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tio, tcases[i].s_tio),
> -		     tcases[i].error);
> -
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tios, tcases[i].s_tios),
> +	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
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
