Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5826F41986
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776251835; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5FwovR+FdPavbUYlxscp3tBnbJNQqAklNJJVTyhkRZM=;
 b=VF9ykSWGFn5nFMUWR09oFvV9b7B5j4gka6nU0A2CR7VidAjJYXuWCbacVBuywgkKU5XuM
 Ku4vDo8ulhiOaxXcU7aM8OV39GVhg0b+x5PJ/ecUtzP8/Nm1kXIu3wak88B7/6qY6kM6y1+
 4mKDuqZSGW2Em0up6e/4DzLxfASPLM8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12E193E5BA8
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:17:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967EE3E59CA
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:16:50 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE73C60094B
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:16:49 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso65473835e9.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776251809; x=1776856609; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VgrWo8Hyv/GvKmUrSkdlrL9+toRigXUuiHyjuqIjSpM=;
 b=WpevlcxiOFphpPi95B88nEcRXZXJnq6n25dIJdKRAizxKl5FS4SGp8MUD4/QF8oQFq
 5RQiR4W6HXj8Gu817bfgcXjPrOvHc0t0MS9CQs0HJyNj7g/UrSoT4CsKHg98yxLfnhbq
 DYPg3BEzNQGe1PgB3lb8ZiZQdzXiEUmkWtlUIP9DY9zOcEm574p83D5acSO1Jd2XVKd2
 4SiU62dmAP2kWTDrU3YWUIulSmtc92kyM6p25/iCo+XT1SiKXOe8zXuz5fO+tMF27x6v
 DJLdGRfXffP9hgh07lIyiKMOlnMCGBenSyYYBZ98emGHP7NFpvQWK+E3/MhROq+plxOb
 qi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776251809; x=1776856609;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgrWo8Hyv/GvKmUrSkdlrL9+toRigXUuiHyjuqIjSpM=;
 b=rqWShw7cQOcQoFuMLtxkOcFaSCGc+TG+D6Z+SXDBSTLss+h6zyN6vRzbPZJFLvOwys
 Q+KTFTTl/KtL8W9t0HhwSbC2bqxU8gAvIKpyFgJZe4aTBCKMpyFs1mBIpW8paaHV/QQC
 3JH0PwZR0aEfxOTdMW5Cd5QVZBtJ3cDujMpHKS3afrtXIKgkKnlmpirUBHSOfwvY5j+f
 quzhexsJ0RELtQ3VPRLdCQlasPqQjzRdxtwoAYGAwmlQ7IvkniGHuSOETdZP3tsnPAK8
 a8PUdy6WmDYostCSy6cFrMbTqYx3BNU1Z4u6MbL2PhS79dkD8V+d0nRV926cSfIIYgge
 4+9g==
X-Gm-Message-State: AOJu0YwyEr97mDqeLyOHgflxoPl+nQ5WUIJQyA8Ddb8+aMkEe9jo5gup
 CfwOxPkkwL1ChizrxL0vMJC9cuAa7G5A75q/i+19pSZqFu5IGcpAq6FMDzgckV1smVsRoOuKXeA
 armcNKwg=
X-Gm-Gg: AeBDiesljDwqdaE5Z4RKMrtKpMWX99jrdUiTjTKz1mnP2t+R2YhZj6cqG2KR6mB6xcy
 YlDrBAQxiO6jadUyF7iIKKrX4D3DRaW8zvNbjBJSouLBV7Bu8yuRGVd9kHFogqIuNJUV+Ji4ef8
 AzAuDLEMBNpA5EJ7XjSenM9Uyb36iD7MlgvdfAc3eXoZqWNeHbsJibuUFRHjUCGIwVWSls40CM5
 O3Ut45ie4k39TiSA2z1TsnlY/lnBzmcHXKl385z1zpTuBceVmPmqDm5mvnFkJIXAPTblVk0ccFO
 35ZIs3Gxr7Fb0mxPP4vF0QsVu7dc24vTWaiWleqq4pGZvYfFqX+dswKMPOpzJHH1OTRA/QTzjXo
 N4N4lwEgGxqOeQ7MMiEZ2hXmqe2sa6lxj+/0Ar5aGpyTzQclZH4vC55TXsl8vBdO7kY7nFgVBNj
 wknBDnUBEnv6ETCNNUl+dIK2z5aIUfbxI1SdtYchQ=
X-Received: by 2002:a05:600d:d:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488d67eb7a7mr225031485e9.1.1776251809207; 
 Wed, 15 Apr 2026 04:16:49 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0ad1e4fsm33403545e9.1.2026.04.15.04.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:16:48 -0700 (PDT)
Message-ID: <69df73a0.050a0220.11c737.98a8@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260321153734.5590-1-always.starving0@gmail.com>
Date: Wed, 15 Apr 2026 11:16:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read: verify read size and data correctness
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

Hi Jinseok,

the name of the commit is related to read01, so it should be:

	read01: verify read size and data correctness

> The test only checked that read(2) did not fail, which allows
> partial reads or unexpected data to pass unnoticed.
> 
> Verify that read(2) returns the expected number of bytes and
> that the read data matches the written buffer.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/read/read01.c | 27 ++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
> index 68d6346c5..f205979b9 100644
> --- a/testcases/kernel/syscalls/read/read01.c
> +++ b/testcases/kernel/syscalls/read/read01.c
> @@ -10,25 +10,38 @@
>  #define SIZE 512
> 
>  static int fd;
> -static char buf[SIZE];
> +static char write_buf[SIZE];
> +static char read_buf[SIZE];
> 
>  static void verify_read(void)
>  {
>  	SAFE_LSEEK(fd, 0, SEEK_SET);
> 
> -	TEST(read(fd, buf, SIZE));
> +	TEST(read(fd, read_buf, SIZE));

We have TST_EXP_PASS().

> 
> -	if (TST_RET == -1)
> +	if (TST_RET == -1) {
>  		tst_res(TFAIL | TTERRNO, "read(2) failed");
> -	else
> -		tst_res(TPASS, "read(2) returned %ld", TST_RET);
> +		return;
> +	}

So this won't be needed.

> +
> +	if (TST_RET != SIZE) {
> +		tst_res(TFAIL, "read(2) returned %ld, expected %d", TST_RET, SIZE);
> +		return;
> +	}

TST_EXP_EQ_LI(TST_RET, SIZE);

> +
> +	if (memcmp(write_buf, read_buf, SIZE)) {
> +		tst_res(TFAIL, "read(2) returned unexpected data");
> +		return;
> +	}

TST_EXP_EQ_STRN(write_buf, read_buf, SIZE);

> +
> +	tst_res(TPASS, "read(2) returned expected data %ld", TST_RET);

So this is not needed anymore.

>  }
> 
>  static void setup(void)
>  {
> -	memset(buf, '*', SIZE);
> +	memset(write_buf, '*', SIZE);
>  	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
> -	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, SIZE);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf, SIZE);
>  }
> 
>  static void cleanup(void)
> --
> 2.43.0
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
