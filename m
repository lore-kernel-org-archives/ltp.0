Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D601EC8738
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 16:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4E3B3CCCFF
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 18:07:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651E33CB660
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 18:07:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B96F8200BC9
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 18:07:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1381621878;
 Thu,  7 Sep 2023 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694102847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMaF21+gvxTJKys4H4GH7R7gc1fwtJ7LgekfTISivGk=;
 b=Y3WHAa7mSSM5+66rkdSSzSg8V3tfPT/tlYwaSPptwc2UrjS3Iwt9l23YvZGlBCLdDEcf8b
 HlGgJFx+55IhkRSBNAKAyD/qx4IbF0pRDKNS9K0hUTOmcQP0xWYgGouANAPf+wtaWctEZE
 Piw7Hst8IC9DoQbgf6LPmRY0C5NkVU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694102847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMaF21+gvxTJKys4H4GH7R7gc1fwtJ7LgekfTISivGk=;
 b=iSTFkwDNC+tpRptv40rHQPcEUjsyRADAoA2Pw7E4szfcaE+d1SgBzD8YYJ1uhQ3dlheoYp
 xR1Jb5EpYmrnsNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0134B138F9;
 Thu,  7 Sep 2023 16:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id isMhOz71+WQ3EwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 07 Sep 2023 16:07:26 +0000
Message-ID: <52f8a0df-d605-5e22-21c3-009e57eb3a5a@suse.cz>
Date: Thu, 7 Sep 2023 18:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230907142141.15388-1-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230907142141.15388-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Use correct ioctl request for termios
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 07. 09. 23 16:21, Marius Kittler wrote:
> With the termios struct one is supposed to use TCGETS instead of TCGETA,
> see `man ioctl_tty`.
> 
> Related issue: https://github.com/linux-test-project/ltp/issues/637#issuecomment-1705334874
> 
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl01.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 1be38e79d..3ca8a9a3b 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -37,23 +37,26 @@ static struct termios termios;
>   static struct tcase {
>   	int *fd;
>   	int request;
> -	struct termio *s_tio;
> -	struct termios *s_tios;
> +	void *s_tio;
>   	int error;
>   } tcases[] = {
>   	/* file descriptor is invalid */
> -	{&bfd, TCGETA, &termio, &termios, EBADF},
> +	{&bfd, TCGETA, &termio, EBADF},
> +	{&bfd, TCGETS, &termios, EBADF},
>   	/* termio address is invalid */
> -	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
> -	/* command is invalid */
> +	{&fd, TCGETA, (struct termio *)-1, EFAULT},
> +	{&fd, TCGETS, (struct termios *)-1, EFAULT},
> +	// /* command is invalid */
>   	/* This errno value was changed from EINVAL to ENOTTY
>   	 * by kernel commit 07d106d0 and bbb63c51
>   	 */
> -	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
> +	{&fd, INVAL_IOCTL, &termio, ENOTTY},
>   	/* file descriptor is for a regular file */
> -	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
> +	{&fd_file, TCGETA, &termio, ENOTTY},
> +	{&fd_file, TCGETS, &termios, ENOTTY},
>   	/* termio is NULL */
> -	{&fd, TCGETA, NULL, NULL, EFAULT}
> +	{&fd, TCGETA, NULL, EFAULT},
> +	{&fd, TCGETS, NULL, EFAULT}
>   };
>   
>   static char *device;
> @@ -62,9 +65,6 @@ static void verify_ioctl(unsigned int i)
>   {
>   	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
>   		     tcases[i].error);
> -
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
> -		     tcases[i].error);
>   }
>   
>   static void setup(void)

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
