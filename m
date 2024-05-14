Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C76C04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 12:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B4493CF2E0
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 14:30:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0743CF1D8
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:29:45 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D52391001129
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:29:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D700C60B79;
 Tue, 14 May 2024 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715689784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W03zAXaz6asrWBkfoN4uuXKX9RxsNdd7+XvKbWRPAxc=;
 b=BZ8ElWtaqlQpN/mtSnH2LTZQ74wmTZgZZs3fcIppwHHCdCT92evuB4eZvy9iCoCqvCWZZP
 yj/1vkUp/5hiJwD8OTDxn2WX8p9zI/qMKx/zY/QRUarY+s/nfNvXfsDeahYk0v0tNHDpF6
 +eR2ob7XciNpk3xtbonDfcDFYDcn1oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715689784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W03zAXaz6asrWBkfoN4uuXKX9RxsNdd7+XvKbWRPAxc=;
 b=G/IPoc2N+FPt/6WWDC2grRlBIT6hzV2QbWRnvg/7ZBugBm4ENEpSQUcy9DwBzVOFhK6HO3
 OsHHFkUhDbfBkiBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715689783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W03zAXaz6asrWBkfoN4uuXKX9RxsNdd7+XvKbWRPAxc=;
 b=1arqds+gbcfhkuUfw5CFnGuGLRysgQzKfxvygWFG7WIaxu3p5RWepqFupDuAg0bFaWfdSu
 C1MqCbwNdg090p8F8feaJJaGzmpYCXPCRPdhIe83czjXasTkQ0iS1l8DGeFIpti4wj2yIF
 XhQBMMpKiUbqi6ZYr444XKJtcPmJ9D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715689783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W03zAXaz6asrWBkfoN4uuXKX9RxsNdd7+XvKbWRPAxc=;
 b=jNalH1fIU9ZU71mmS2wmfNy+yyQ72WzVmHYXVF5m6ei9V0IH8K5NGCyDeBr611K/RFltNc
 dC5Re/J3tYNaLcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C29D01372E;
 Tue, 14 May 2024 12:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EgpCLzdZQ2aeGAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 14 May 2024 12:29:43 +0000
Message-ID: <962e26d8-6333-477a-9b03-dc2308779a57@suse.cz>
Date: Tue, 14 May 2024 14:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20240505061746.77510-1-xuyang2018.jy@fujitsu.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240505061746.77510-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] bind: Add negative tests for bind
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
small nit below, otherwise looks good to me.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 05. 05. 24 8:17, Yang Xu via ltp wrote:
> Add negative cases for bind(), when errno is EBADF or ENOTDIR.
> Also fix some format check warning for existed code.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/bind/bind01.c | 36 ++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
> index c008819a8..6d8338a22 100644
> --- a/testcases/kernel/syscalls/bind/bind01.c
> +++ b/testcases/kernel/syscalls/bind/bind01.c
> @@ -17,11 +17,16 @@
>   
>   #include "tst_test.h"
>   
> -int inet_socket;
> -int dev_null;
> +#define DIR_ENOTDIR "dir_enotdir"
> +#define TEST_ENOTDIR "test_enotdir"
>   
> -struct sockaddr_in sin1, sin2, sin3;
> -struct sockaddr_un sun;
> +static int inet_socket;
> +static int dev_null;
> +static int fd_ebadf;
> +static int fd_enotdir;
> +
> +static struct sockaddr_in sin1, sin2, sin3;
> +static struct sockaddr_un sun, sock_enotdir;
>   
>   static struct test_case {
>   	int *socket_fd;
> @@ -41,24 +46,28 @@ static struct test_case {
>   	  EAFNOSUPPORT, "UNIX-domain of current directory" },
>   	{ &inet_socket, (struct sockaddr *)&sin3, sizeof(sin3), -1,
>   	  EADDRNOTAVAIL, "non-local address" },
> +	{ &fd_ebadf, (struct sockaddr *)&sin1, sizeof(sin1), -1,
> +	  EBADF, "sockfd is not a valid file descriptor" },
> +	{ &fd_enotdir, (struct sockaddr *)&sock_enotdir, sizeof(sock_enotdir), -1,
> +	  ENOTDIR, "a component of addr prefix is not a directory"},
>   };
>   
> -void verify_bind(unsigned int nr)
> +static void verify_bind(unsigned int nr)
>   {
>   	struct test_case *tcase = &tcases[nr];
>   
>   	if (tcase->experrno) {
>   		TST_EXP_FAIL(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
> -		             tcase->experrno, "%s", tcase->desc);
> +				tcase->experrno, "%s", tcase->desc);
>   	} else {
>   		TST_EXP_PASS(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
> -		             "%s", tcase->desc);
> +				"%s", tcase->desc);
>   		SAFE_CLOSE(inet_socket);
>   		inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
>   	}
>   }
>   
> -void test_setup(void)
> +static void test_setup(void)
>   {
>   	/* initialize sockaddr's */
>   	sin1.sin_family = AF_INET;
> @@ -78,14 +87,22 @@ void test_setup(void)
>   	sun.sun_family = AF_UNIX;
>   	strncpy(sun.sun_path, ".", sizeof(sun.sun_path));
>   
> +	SAFE_TOUCH(DIR_ENOTDIR, 0777, NULL);
> +	sock_enotdir.sun_family = AF_UNIX;
> +	strncpy(sock_enotdir.sun_path, DIR_ENOTDIR "/" TEST_ENOTDIR,
> +		sizeof(sock_enotdir.sun_path));
> +
>   	inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
>   	dev_null = SAFE_OPEN("/dev/null", O_WRONLY);
> +	fd_ebadf = -1;

Nit: fd_ebadf could be initialized when it's declared above. But that 
can be fixed during merge.

> +	fd_enotdir = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
>   }
>   
> -void test_cleanup(void)
> +static void test_cleanup(void)
>   {
>   	SAFE_CLOSE(inet_socket);
>   	SAFE_CLOSE(dev_null);
> +	SAFE_CLOSE(fd_enotdir);
>   }
>   
>   static struct tst_test test = {
> @@ -93,4 +110,5 @@ static struct tst_test test = {
>   	.setup = test_setup,
>   	.cleanup = test_cleanup,
>   	.test = verify_bind,
> +	.needs_tmpdir = 1,
>   };

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
