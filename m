Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967B2CA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791822044; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5B1aRttnKxh/iD7SrBCHeSrzpuiqRytRvTZyl/Lm3Zw=;
 b=DIQ6KZEkh6xNtLDKv4wLqNC3rU8Z4Lp0WgtgERw0tlE3RT79mc7nwJ5C7CHSiUPM2++iV
 MhONxfrbPyczOCL+iArvMxj/z9MrGPxf01QgLuf5jN/4d0kbmhFSS6WKlVdqaOEdoIhb4qx
 kzAatR8i0OspIgjLgU7EWNdy3MGQSF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DEF3E5EFC
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 18:20:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4773E5EFC
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:20:25 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EAE1A140044F
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:20:24 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso21774045e9.0
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791822024; x=1792426824; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SLkHQXyX/KuxfKMCc97sQqx/wObCulTjm+yC7PfThz4=;
 b=RE6KkZyhkmnUCSCBodReqzbljV+dutuWhLCv/rjciDYYxakb5PkDRxa+tdwM68QmpR
 DklckMvQKtLiEy4OJUgJUP0kbUiOEQQMfwJc1MeIgh9g8klSudaqW8Qv7YE4H3BGtwl/
 hCEt8zgSrNn11kN7OyImNMo4E2OXMvURS95+uAIbPV0QL7V6fK7vuIRti6mpZmzDCYuY
 eYHpDboMAJE53xuizDcVsqBFqhJOoOPxXqzthvQMZWAbf5ob5QEoxqjmlPowFf5DBEDF
 j6i6GHk9p10sHUYaS1XisnTHoB77BOmM6FPtrjmro/dg7Srdww5ZtQ+BkrtUklHr7Boh
 OuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791822024; x=1792426824;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SLkHQXyX/KuxfKMCc97sQqx/wObCulTjm+yC7PfThz4=;
 b=mPN+pyHOiTv7+zmMjVi+fRlj1n5oBA7+vmKrZ2fJV9C3ocQs2P6Bz+P7qwYog4vRAQ
 mYkIHhg0PqV5+WKnSA6iP1Gr4jjEcCK0wCavyyl9pVQ8xbJ6ilU6SOAEySwJB/lBBtrR
 bWzZxXgfnvuBtIlTPpXdxZY9l0MGGEs7t4aR5s1IHbiAUh2UqGvTNbD+x4dwEl7zxkPM
 gMeWEr8uzr2wx5H8K4bZcnp+DFYYdPTGwfIoXV9TkR/ShqIhiEqMjooYNJsZ3ym47A43
 apmKU6Rdaf3c6FfmbBLB+cnSe1wh5ZZGWVYEd30dszwHOVJA9fnVoGWg0ijC4Xf3TOhJ
 K5iw==
X-Gm-Message-State: AFq9FYJyfqd0Hofyg2Rb1jnTOwv6FqAQlZWQi9K8OQ0qh5OtoOmCdWmd
 4uUzmTtkz4Kw/QTAtuxnf0/eMFtKd1XLzpy6WBdwBIxTZSebCPYCdeQF/MHVrngUt3o=
X-Gm-Gg: AYBFou3ON5Am3nzdVEkwUTihMWq8VNWNpcSHRYv+qUCGgvB89EL72DVzRWLp4MnS+H4
 sMAmpFnbqSOyOPvH1UpLquvy3t3HoBWPe1yL8mqhVMOeJL4X6pGjRzLjZkcnHUtDpe7BjctW1WH
 pvS4C6V+IfPVB+MrgKsEvmQVuxz9z34PcIW4Fgacn7bliBeJjOiBmcc8W2RG3T3u3bKoaKbMIqd
 psvTozExL8HlS5aU/wC3HkFbWzqaPp8TzJVIKlDpY6DqoYpV49T51zZWAYZjLB3HM3NobXDyXLq
 EdxZQ3/xIdFt0D7MBIjt5860JTzpL/M2aaNTSdPbnc81JO5dKLaiPz85VpkodFbtoT19/glxjjG
 egc8/THthtuBlZml6Kvz9li04BmDKfVjr8Q64FJa4BDBMorPlpulbW5nKLpGwgLB9PwSJaq+QuJ
 RaaAKFkbY8A+DEbQTwkKCpfTuv0rE5thFGkp89LsDm8oV9hKl8+Z5hDMAnCz8j8rPLmMf6yqlM0
 gbpLUnrXSECXHRaQczNNAvEKeF/SHoLHn3FBlIQh1msIeWFKtUQM26IBvvxbMfMyZeqznTNdqFB
 ow==
X-Received: by 2002:a05:600c:3b0a:b0:4a1:8963:b865 with SMTP id
 5b1f17b1804b1-4a18e447e9emr199272195e9.1.1791822024143; 
 Mon, 12 Oct 2026 09:20:24 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a195002123sm288130225e9.1.2026.10.12.09.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:20:23 -0700 (PDT)
Message-ID: <FYCFwRRq6TwmRBDes8BoKBQ3CBJXcItvx4Jm@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261005061933.4108985-1-wakel@google.com>
Date: Mon, 12 Oct 2026 16:20:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pathconf01: Allow EINVAL where POSIX leaves
 support unspecified
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> POSIX lists two EINVAL cases for pathconf(). It shall fail with EINVAL
> when the value of name is not valid. It may also fail with EINVAL when
> "the implementation does not support an association of the variable
> name with the specified file".
> 
> The test always calls pathconf() on a directory. For a directory, POSIX
> leaves it unspecified whether _PC_MAX_CANON, _PC_MAX_INPUT and
> _PC_VDISABLE (note 2), _PC_ASYNC_IO, _PC_PRIO_IO and _PC_SYNC_IO
> (note 8) and the _PC_REC_* names (note 10) are supported, so EINVAL is
> allowed for them.
> 
> Bionic before Android 15 returns -1 and sets errno to EINVAL for
> _PC_REC_INCR_XFER_SIZE and _PC_REC_MAX_XFER_SIZE, which makes the test
> fail.
> 
> Report EINVAL as TCONF for these names. EINVAL for the other names is
> still a failure.
> 
> Also print the name and errno on failure, so it is clear which name
> failed.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  .../kernel/syscalls/pathconf/pathconf01.c     | 36 ++++++++++++-------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
> index 5af45e417..635c356bc 100644
> --- a/testcases/kernel/syscalls/pathconf/pathconf01.c
> +++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
> @@ -19,24 +19,26 @@ static char *path;
>  static struct tcase {
>  	int value;
>  	char *name;
> +	/* POSIX leaves support for a directory unspecified */
> +	int einval_ok;

Usually, in these cases, it's better to define an array of errno we might
have when we trigger the syscall in a certain way. And then we use
TST_EXP_ARR_FAIL() on it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
