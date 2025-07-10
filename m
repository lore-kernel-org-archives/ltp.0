Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17D7C83F0F
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752111194; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z3XGAz2upvrVoTlJgQ2VZQmTkjDEPeN8XMcsrgUOtd0=;
 b=jVh7ZXFkwea85vCb5Kpo7QRCNKwDea8Vso59Ect/ZwKg/NYsvVzPYU/p4CrQRw7YlzUP4
 53/9A+X8MnIcsJdAK0k/IW7+JltUJd/+wbO9A11+OyRffEnyyz4zE2dAMKRLer7NIJrzZ1f
 CbaxpTWCYhurhdWFbW0kCIr2FUjhTjk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E1433CAEA3
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 03:33:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 595AA3C6277
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:32:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A1EB60046A
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 03:32:52 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so340394f8f.0
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752111172; x=1752715972; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+w8vbPorJHg+gG6Zf5Gac/xVA7+ulBBg/3p5bArZOsY=;
 b=EAVov7hP8200oROiAiLOJRvy5sU+/FR1n3KFFM7ch9+oX0uhxrkv1gHz52OphzXZ2i
 w5+uUIl4glUbMvdIKgPGA5DgiSzT2ZnAxC/wmi4KYKgUTnO0HZgO/Kdj97I0L6uYrDtS
 f6ZiNwvWuwdhC0IxH/Q7X2eu+2pR2GEpZgxLU3ibxuJHvNUEuj6R3O4czF7d9Ixu8iAS
 hsxh3KbVdfvz5BJsY3Fds9dhdQJqOHcGVRKWC4ATuOvHuIEceygn7t+phq6TMQmNMY+S
 4nlnAMUqMObIxKuhD+BKk54mkGxUWSm46ZZzjbx6s+djT0rQ2FLK2mD+ljSNM8yLzcOs
 aJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752111172; x=1752715972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w8vbPorJHg+gG6Zf5Gac/xVA7+ulBBg/3p5bArZOsY=;
 b=OEGjbtgbfQMm2TpSz9nX/cpK6pXRfGVrK2QWb1ovROJCNU62kn9tjYeZG8IGIm5t3T
 QclunTJ4Soac7NJTUvETg2QmvvipjPozO506Udocz9XdVNelLz7+M8UYmWs4276e9dVC
 PJUa3BukvX00qI46it2Q7g1dsJj6Unt1e3JpUTt8fKXLYsSdMX1ZD6TKzf0ScleZWHUD
 9uo6zVmr4Tr3tvbtxWPQMdie2zzK/1GnHC60mFXkjD8SweyDGsy2xLoEwVcu9PmZKDG+
 C3lPGyjKm9mtYI6vFWPxt9IBuddr1ThakUAmRopbXD0yROlsyNYMNqhtOoEJSY5VICyi
 9X4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeSjwKiO/+5bJbM3o2oe8LMPwCMaZc9iy9rWO326DRAKRzIpSJ5MH5Lvec6NSYse/QQFg=@lists.linux.it
X-Gm-Message-State: AOJu0YyWWFMAGxfA8fVieZFgOSBnNw8HGzzyDqkWcIHzoLO5qkEgAwt3
 0lN37N0CbTG42yTWMvChwQxrbCMpRh+OMTTZi6ABXL3zxLt7fCgdpLOWqgxPxG+AK0Zo3iqFHqk
 k50s=
X-Gm-Gg: ASbGncvScWatZ0KjKyLkXH2c+jNuAQLqHbAfGf4QLtsPlNGxKFTGn6NL3xDgD8lBM9y
 Lz4NDV+kLytrQGUpTxPMWmocPC5CMwxVh6Cu8GM+o6H9R7VxE4DShwnPlU9pgapS/EsvRkaZRGE
 cA5tbnSdDQDKMuqYoVJH+T/KANiVyXUPhfKtG7jFSkahUYOX8Vge8+oprHpB40s/5iInAAC7Wfp
 2n1briS/SD74ge9Sv2ALIlAlIbzTJNfHP47+8e06iH6BMECJTOjqXMYdGQCEbN5LYFka1AOs9S8
 grCujZmnSWLI62wG5AGujBN632E8qgKv4jgrn1ZrW1lyhAHu4hhnjGKvEz84Mg==
X-Google-Smtp-Source: AGHT+IFZA/2Y0FCRgSje6F87ztH1AuNCyMqqw1MlkRzTIO/bd8MqWrnBhjmu0jyQa+16IevdOeu54g==
X-Received: by 2002:a05:6000:4a12:b0:3a5:2f23:3783 with SMTP id
 ffacd0b85a97d-3b5e44ea414mr4346262f8f.24.1752111171682; 
 Wed, 09 Jul 2025 18:32:51 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1b360sm388128b3a.78.2025.07.09.18.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 18:32:51 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:32:12 -0400
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aG_A3DvZ0yRAdWbJ@MiWiFi-CR6608-srv>
References: <20250709163022.69985-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250709163022.69985-1-japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/1] splice07.c: Skip invalid splice()
 tests involving memfd secret
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 09, 2025 at 06:30:22PM +0200, Jan Polensky wrote:
> Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
> secretmem LSM bypass") prevents any access to secret memory pages from other
> kernel subsystems.
> 
> Splice operations involving memfd secret are no longer valid and return EACCES.
> These test cases are skipped accordingly.
> 
> This avoids false negatives in splice07 test:
> 
>     [skip]
>     splice07.c:54: TFAIL: splice() on pipe read end -> memfd secret expected EBADF, EINVAL: EACCES (13)
>     [skip]
>     splice07.c:54: TFAIL: splice() on memfd secret -> pipe write end expected EBADF, EINVAL: EACCES (13)
>     [skip]
> 
> Reference: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/splice/splice07.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> index 2228e2f269de..c750a14bf439 100644
> --- a/testcases/kernel/syscalls/splice/splice07.c
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -27,6 +27,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
>  		case TST_FD_UNIX_SOCK:
>  		case TST_FD_INET_SOCK:
>  		case TST_FD_MEMFD:
> +		case TST_FD_MEMFD_SECRET:
>  			return;
>  		default:
>  		break;
> @@ -40,6 +41,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
>  		case TST_FD_FILE:
>  		case TST_FD_PROC_MAPS:
>  		case TST_FD_MEMFD:
> +		case TST_FD_MEMFD_SECRET:
>  			return;
>  		/* And this complains about socket not being connected */
>  		case TST_FD_INET_SOCK:

Another option maybe we can add this error into exp_errnos, i guess can
fix your issue?

for example:
        const int exp_errnos[] = {EBADF, EINVAL};
+       const int exp_errnos[] = {EBADF, EINVAL, EACCES};

> -- 
> 2.50.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
