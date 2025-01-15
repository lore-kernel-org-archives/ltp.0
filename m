Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C56C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736932518; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Eipsr5nGfq5RgbE+CwLrImg26pGMF4jTipxMLgy2tUg=;
 b=CQKDXGdZhjBhgZAXcsIQIF+NBwUVQtk9jZH/GfBsHFVWRYTcJbvsGNcpli7XAXODw/gif
 dVIeOf7N1bLWANGBpiDeSYhHnIP9Whcj5Suvk/zhCPzj6wx+E93lYs60/SWPNLHzRnjMu+c
 ATSd2mnXRFANmpzLxTy5Sc0DceVCyqY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C9583C7B54
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:15:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9A93C7A78
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:14:56 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 173D760B024
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:14:56 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so45849935e9.2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 01:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736932495; x=1737537295; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g6ZbwJnY5cihlSg4acH+yl1WPp+PPNjoUP9Oks91/tE=;
 b=PkV/QoB4+C/mQxX+tsL/J/bueHYCwMdujswSaXFumf/lz6I/RSJGY0HRlBoqJCs2Us
 tQb+CMNAglZs0m25+oD6FXc8Vt2/bhqKPFHmWAOqQPXFo6haBTE9XzyQuaZifPmeAA3v
 oNl+vErUMm5nG6AY60X7jaqzxxpWba+TXyHn6kN6SZAh3yLCWFKaM5xMLwNaL5eXDfSA
 IJVwOZ2EUfI7OcpGSd9TvBX34KMtFBnVotPihhwL4Brs20yVAJMrPIRX752Zacoz+15v
 +L0JpKiLbrrkwpa1j3Wxu3Vd2ohDmq/2y4V/kMPaPJRlywQDdaNJjQGMuXRXgCCfmpZ1
 0ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736932495; x=1737537295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g6ZbwJnY5cihlSg4acH+yl1WPp+PPNjoUP9Oks91/tE=;
 b=W1lL1OhdKiccpBAX5sr64Ijst4rhwVMOkl7lKF28PRUhSA6a3cSAxZ9yncWLL84eA+
 75jaG/Q68vWak77zi2zJEn3vadLSILUUBI0OzjDwvMf9376XdhgC4iW3DhVUdqXxl782
 WeKX/VX84tsDwzpwXAsX0AZWEQRz3twAA0wKWqlQyU/JWmBxso/mlnf9H499L89Bwjo6
 3UuC2aNC0LuMq56nrgaEqUanHzN6oRPvHmy4696+1q4w4I8lZpsmTEsgCfNPXZldaNw1
 I1gDWvuP7M4wzHHH+eO/eqNQYL0uWpzMi2qaBR2ag/AECM8sBz7i2rwVF5u8ZCeLgjtg
 QWGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEMIwYQ3h5efULgrhlFpACqI7gRK0Sy11So7UYt43nSaWGay3Y2kSXXqz2NnvwTecjxjU=@lists.linux.it
X-Gm-Message-State: AOJu0YyEFhZyBElnSpCis7ZCuNCbeYmMk5KFoY9vwL7B8jwhtOXPBwoE
 FlkoLM0usRSMVJE7y7BOr1ttJG+n3X41oyD8Q6e1HQ4EVvpSK8zS0RccqaRQ89nqngWqGYY4hgq
 7Q+wBgKUa
X-Gm-Gg: ASbGncttootyiUQWukEuGWEzaHOp+gZnNKVEoKzPt7V7OmAugi3Y8bymishHcJ1ah0q
 iZH2TjI8DrPsfRbkaXmEROjX2tsxR2ymBGLVGoeWoNVy19yrosvowtWDzNExbZYq+vgIZ0AfVgN
 ETHnHP1Giup7llCANDR3R+wg4AD1e6h6GWT4ucPNNHnECy10BFcYVqxOa+mjb5SsGpNfF+3mcOg
 1PTS64IQ8ipyBb9e6ZxXI/1C3eKukT/r7I7szBEnP1VhqozGJR8vM//XUovnPzzFV2CMVP3eeX/
 FkOmXEpYlDrysWWkA4Ro8iIgZyvUI1HJ7VFGAcaaj6g158jq8YsL5Pbnqn3107wLuRQ5pErkGkt
 V8Dt5gExHRDHAF0NIsEc=
X-Google-Smtp-Source: AGHT+IHIPpR5OkT69tpActlLXEEpjm1o1C5J/EE2ejEiuPegl0+VLJYJrIF5HrQBWi3xC0Y/WfKKzQ==
X-Received: by 2002:a5d:6d05:0:b0:38b:d9a3:6cff with SMTP id
 ffacd0b85a97d-38bd9a36e6cmr13611256f8f.16.1736932495352; 
 Wed, 15 Jan 2025 01:14:55 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1cf2sm17220684f8f.99.2025.01.15.01.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:14:55 -0800 (PST)
Message-ID: <46ff9a8f-f2d7-4858-80dc-1b39f2ffb393@suse.com>
Date: Wed, 15 Jan 2025 10:14:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20250114155013.7644-1-akumar@suse.de>
Content-Language: en-US
In-Reply-To: <20250114155013.7644-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] flock02: Add test for EWOULDBLOCK errno
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

Hi Avinesh,

On 1/14/25 16:49, Avinesh Kumar wrote:
> Also fix a make check warning.
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> Following up on https://lore.kernel.org/ltp/1934768.7Z3S40VBb9@localhost/
>
>   testcases/kernel/syscalls/flock/flock02.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
> index b8c7eee68..e2fe73a64 100644
> --- a/testcases/kernel/syscalls/flock/flock02.c
> +++ b/testcases/kernel/syscalls/flock/flock02.c
> @@ -13,6 +13,7 @@
>    * - EBADF if the file descriptor is invalid
>    * - EINVAL if the argument operation does not include LOCK_SH,LOCK_EX,LOCK_UN
>    * - EINVAL if an invalid combination of locking modes is used i.e LOCK_SH with LOCK_EX
> + * - EWOULDBLOCK if the file is locked and the LOCK_NB flag was selected
>    */
>   
>   #include <errno.h>
> @@ -31,13 +32,19 @@ static struct tcase {
>   	{&badfd, LOCK_SH, EBADF},
>   	{&fd, LOCK_NB, EINVAL},
>   	{&fd, LOCK_SH | LOCK_EX, EINVAL},
> +	{&fd, LOCK_NB | LOCK_EX, EWOULDBLOCK}
>   };
>   
> -static void verify_flock(unsigned n)
> +static void verify_flock(unsigned int n)
>   {
>   	struct tcase *tc = &tcases[n];
>   
>   	fd = SAFE_OPEN("testfile", O_RDWR);
> +	int fd2 = SAFE_OPEN("testfile", O_RDWR);
We can initialize fd2 at the beginning of verify_flock() with -1, open 
it only when tc->exp_err is EWOULDBLOCK and close it only when it's not 
-1. So we avoid to open one more testfile also for the other testcases.
> +
> +	if (tc->exp_err == EWOULDBLOCK)
> +		flock(fd2, LOCK_EX);
> +
>   	TEST(flock(*tc->fd, tc->operation));
>   	if (TST_RET == 0) {
>   		tst_res(TFAIL | TTERRNO, "flock() succeeded unexpectedly");
> @@ -53,6 +60,7 @@ static void verify_flock(unsigned n)
>   	}
>   
>   	SAFE_CLOSE(fd);
> +	SAFE_CLOSE(fd2);
>   }
>   
>   static void setup(void)
With that small thing:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


Kind regards,
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
