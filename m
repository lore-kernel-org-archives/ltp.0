Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04332C41513
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717422570; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=vvNYDA3pTydQ4B42D1Qvp8OmCUAzbVl9vdFfwGUd1VY=;
 b=Hb0032QxxG/SxcAUvH70ShUbll+J5P4HE/s088Nx5hPAD2cIfuVMVQ4y706reb1FXeYyA
 /5Np+VBaDUGcglcqbmieD19QROlNhRKgpBes2m9Ldp4SwJepCgA5BVlWa/+GcfsiA3wLKuX
 nKs1G1VaJmzEoWMlI28PtcDivcifi44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0BFD3D08F6
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 15:49:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C15B3D08A7
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 15:49:08 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18CD6140112E
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 15:49:08 +0200 (CEST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e724bc46c4so49874551fa.2
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717422547; x=1718027347; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jf0pANbywJXzv+3QfaL3mpN3TnjJYwkdu9Mssiv+pXU=;
 b=RCoZXeeIkO0AJ+YGs8n+KlgSN47A4Gys+oPsqO50VwODOK8dciHm/Y2x5ockSuo+ty
 tb9es1EpsbJjfWdeEHXFH4s2vhPK0nQPAUeZOgxbgPKlCMsUlP2nk5BuEkMNpAb8vnJw
 7ah4cf8eTJvkhS8l1CgAAVb0JwdL1k04eseu4G69c+9eF75HwjBAfjfWPVnWiGU1a8cY
 fcND+5OfhCmrKixyUBlJrW5TC5hRwccNqbje5v24cPBNkwLFOyML61Wp8/8ICvdosWZY
 rXxSq3dXG5EhZWBOHAsqkrXfcUN6nhWCHcoKQxLXO/5gMF+E/Dmvp9LAzKZ8VuCMFiQe
 pnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717422547; x=1718027347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jf0pANbywJXzv+3QfaL3mpN3TnjJYwkdu9Mssiv+pXU=;
 b=wUnEMTk86SZMa0C6iXXELlWwfrU9Zhpd1XVDSBEGI29lmr8QO9n6K4dESeZAsQZe4r
 xAigrojnYQBnq46UJjqaK3q3it+3TVWRhHZgxfIywynbTTLF6UgBl8O/GchpZS20Km8I
 BSTF6rb+oh9cFDtwWooRugxQr4A8Ztb1xGfKSBaGKpz0iRousfFIG6XKEGp7ujDuI8iE
 3IkE0EE0OrpwgeEtCU6K+B+ztpr08n1L8HxFP8/VFH0EMX4yZwTAsq5HEL9Cj/RcyeFN
 b71XfViXmgmpiJJDlCbacv9TmPI2DZTnpSfz+ecH93TZ+aFIfCGSXKnmhbfKsTUxi5Dw
 ha0w==
X-Gm-Message-State: AOJu0Ywz0yHjjKC9Pkw12FwU2YyZAgbwRdkgybvVbYqoraUtCc7IcdQM
 0K4KVUQDggJGTqQL7U+BogV02v7QG1SLk78m94tVx/Y5a3MaRxv5YmrDVKq5WpNiM5DSKsfO+yb
 m
X-Google-Smtp-Source: AGHT+IEtrlq0SFsPV1bNIqGHqdzKJdutIVLAxhGZzGXkL3aTIBvstXucOpNljQM+j/6mLbnSd9OkcQ==
X-Received: by 2002:a2e:980d:0:b0:2d8:67a0:61b2 with SMTP id
 38308e7fff4ca-2ea9512c01dmr51595851fa.20.1717422547016; 
 Mon, 03 Jun 2024 06:49:07 -0700 (PDT)
Received: from [10.232.133.118] ([88.128.88.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7027e4a7d5dsm204031b3a.49.2024.06.03.06.49.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 06:49:06 -0700 (PDT)
Message-ID: <1c82db37-4c4b-4679-9c18-618c57ec6a0a@suse.com>
Date: Mon, 3 Jun 2024 15:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <CAJCsO8fTwOsVwhCdBksStaPVjXHBi8m3g+_b-ZAnKByUR3cqyA@mail.gmail.com>
 <20240603124653.31967-1-akumar@suse.de>
Content-Language: en-US
In-Reply-To: <20240603124653.31967-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink09: Fix open syscall flags
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

thanks for fixing the commit message and the test. According with the 
open() documentation an access flag
is a must and that's one thing that makes this test wrong.

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 6/3/24 14:46, Avinesh Kumar wrote:
> In the SAFE_OPEN() calls, we missed to include any of the mandatory
> flags for open syscall:  O_RDONLY,  O_WRONLY,  or  O_RDWR
>
> Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>   testcases/kernel/syscalls/unlink/unlink09.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
> index cc4b4a07e..405deb05f 100644
> --- a/testcases/kernel/syscalls/unlink/unlink09.c
> +++ b/testcases/kernel/syscalls/unlink/unlink09.c
> @@ -43,12 +43,12 @@ static void setup(void)
>   {
>   	int attr;
>   
> -	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
> +	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_RDWR | O_CREAT, 0600);
>   	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
>   	attr |= FS_IMMUTABLE_FL;
>   	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
>   
> -	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
> +	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_RDWR | O_CREAT, 0600);
>   	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>   	attr |= FS_APPEND_FL;
>   	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> @@ -79,7 +79,7 @@ static void verify_unlink(unsigned int i)
>   	/* If unlink() succeeded unexpectedly, test file should be restored. */
>   	if (!TST_RET) {
>   		if (tc->fd) {
> -			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
> +			*(tc->fd) = SAFE_OPEN(tc->filename, O_RDWR | O_CREAT, 0600);
>   			if (tc->flag) {
>   				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
>   				attr |= tc->flag;

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
