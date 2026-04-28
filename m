Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84429FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777365999; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IBovLX5Tnbl3Yl12H4SuZ2NLV1yivJri2seWenC5nJk=;
 b=G/VLAEItsN2e+7hIl7FaibSC7LtaXNGG4k5SOuvElkbE0nydJmfSsIbr9LElklQ+b9lDs
 x++B2YPtejIk/vT1ucebwKy16fPsZPQxXlnBgYwgaSGxa4gSOq4KN123WflS36AWv3QEQBV
 WcX9Sgs19NWw3Qdk6HyCVZZpEsRQfNw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174023E2682
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:46:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCBF93E2542
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:46:15 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41B8B100078C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:46:15 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso95715515e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777365975; x=1777970775; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=p+4+NeItnGOLnqLlBKW3aoEZuE0O9JqJPgwv+3B5wDg=;
 b=Ooj3LrD2Luc+LholXfSb3164h66JZBibmR8GAhoQtjS7LC4eAoQMRItgep5ZIWSMWT
 piaLhNuqIugmMcdt1ikWEk5KFtYE3+jk2eH8YEAw6rO/5yQd+hg5whNbyzjE7+1REaFh
 98XgOmps0CbHh8tp2Y8hIRYL/tIpBnhxob+hZad9WmliZad61zY+EdN1QZGYTy24IEFx
 e6frqR7/cMBTqEqbgpmH4Td0E0vggnWDmubG3zkC9coeyEAEWY6tWh3DbOkhDGZnQhS6
 dAfNiVCityZIo3c/TGay+/Uz4Aqoa8ao6s24VHCXf4PDcbXLwdVxUiUw2eRZfJnaZrDo
 3IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777365975; x=1777970775;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+4+NeItnGOLnqLlBKW3aoEZuE0O9JqJPgwv+3B5wDg=;
 b=aDbnj+FSreAVtYLA6GDnmQUrvYOc1ByzsCb2d75GGoPdaX4jTjQWjWtbrDv/zlJTbx
 I1v29SA16Y2sdNlSxd2txdtBTXv32eBxfD+qwbhcyfSzFtp/7RpSYrJX/OZQefY3X0Ew
 ZbCP/qFmKNv6fzQ0mT606P4wG3mNMlCWUctHtqmZ5oO8p6Rw2fa/NpI7p5eymOGyNU0s
 Afltzym/yN0UEEbM22Q2kbT8NvSv43JTKwyrep5xBQBpeTh8khb+EBB+ye14xC5ujOZW
 LIsmq+RpiMqju/bgenUE9G6g1hf95LW/fm3d83iXDOHtNmxX6R/LD89KEv7F5E56qTgM
 o2fg==
X-Gm-Message-State: AOJu0YwGwbiW0eHlVXxv8X1mZWLk/fWXzmymJMW3IfVzaNcce3XmJ4mP
 swQcYTDSisJ7BAMygVAhVh/5OfkmoSaeXDvQPjGgAx0xMElzg/PqIXgrTMqFzKJM3ZhaFQk7ojV
 sPqRNFGY=
X-Gm-Gg: AeBDietbOmE/taRhdlICneoQ0G94vi5v91gqZQkIKSB66ih1hfKZdNgoCjk4uOlfy9j
 Q4oVaUu4Ft9RCw0XVBYDptEz4e23n6uHKdWQkhtFXTXsEsKmyfGqToXr96fZ7hamyYCeS3i3HV/
 SJ89Ohrh08VZR40qMwrEyDj6mtOLvZoXBpnXZyh4DdS0WPQMtqrtLvElr3u1tg8LH7aVh0Twsof
 JPqIWvMw/7yplwHB2Os/r+roe0XTJ/eoPJXqLYtXIO+aHqR5UbY4m/iYosRM+qoyZWveIMDLVbr
 1W4sPJJTZKdyvaF0naLklhbp3DggKHt8VIjbar6q726ydpWg4NpsZ+3X9b5ovD0M1xoPSHMW1X5
 3TWrPPEgSke3TM559L2uWRqcFIX8eeMZMAs8wmbluD6pNQHNlf9xOoFgeYLfHfmsrLGyWPEb6eo
 MKc7hb5UczdUvqjmofgt8nENIs/UVwsbKDN+CTlNSeC1rMWz/75nCO
X-Received: by 2002:a05:600c:4593:b0:48a:53ea:13e6 with SMTP id
 5b1f17b1804b1-48a77b1dab6mr33362935e9.25.1777365974480; 
 Tue, 28 Apr 2026 01:46:14 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77608ce2sm13748545e9.34.2026.04.28.01.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:46:13 -0700 (PDT)
Message-ID: <69f073d5.050a0220.2ecf74.a4c0@mx.google.com>
To: lepillai@linux.ibm.com
In-Reply-To: <20260421050251.3662828-1-lepillai@linux.ibm.com>
Date: Tue, 28 Apr 2026 08:46:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added new_behavior flag to detect kernel version
 Kernel >= 6.11: Tests that creat() succeeds (write to executed file
 allowed)
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> From: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>
> 
> ---
>  testcases/kernel/syscalls/creat/creat07.c | 38 ++++++++++++++++-------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index c7b85ee69..762022301 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -19,6 +19,8 @@
>  
>  #define TEST_APP "creat07_child"
>  
> +static int new_behavior;
> +
>  static void verify_creat(void)
>  {
>  	pid_t pid;
> @@ -33,16 +35,26 @@ static void verify_creat(void)
>  
>  	TEST(creat(TEST_APP, O_WRONLY));
>  
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "creat() succeeded unexpectedly");
> -		return;
> +	if (new_behavior) {
> +		/* Kernel >= 6.11: write to executed file is allowed */
> +		if (TST_RET != -1) {
> +			SAFE_CLOSE(TST_RET);
> +			tst_res(TPASS, "creat() succeeded as expected (new behavior)");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> +		}
> +	} else {
> +		/* Kernel < 6.11: write to executed file returns ETXTBSY */
> +		if (TST_RET != -1) {
> +			tst_res(TFAIL, "creat() succeeded unexpectedly");
> +			SAFE_CLOSE(TST_RET);
> +		} else if (TST_ERR == ETXTBSY) {
> +			tst_res(TPASS, "creat() received ETXTBSY");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> +		}
>  	}
>  
> -	if (TST_ERR == ETXTBSY)
> -		tst_res(TPASS, "creat() received EXTBSY");
> -	else
> -		tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> -
>  	SAFE_KILL(pid, SIGKILL);
>  	SAFE_WAITPID(pid, NULL, 0);
>  }
> @@ -50,9 +62,13 @@ static void verify_creat(void)
>  static void setup(void)
>  {
>  	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> -		tst_brk(TCONF, "Skipping test, write to executed file is "
> -			"allowed since 6.11-rc1.\n"
> -			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +		new_behavior = 1;
> +		tst_res(TINFO, "Testing new behavior: write to executed file is "
> +			"allowed since 6.11-rc1 (2a010c412853)");
> +	} else {
> +		new_behavior = 0;
> +		tst_res(TINFO, "Testing old behavior: write to executed file "
> +			"returns ETXTBSY");
>  	}
>  }
>  
> -- 
> 2.39.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

There's too much going on in these nested statements. The `new_behavior`
is not needed, we only need to save the error code (-1 or ETXTBSY) inside
a static variable.

If it's not -1, TST_EXP_ERR() can be used. Otherwise we print a TPASS.

The kernel version is printed before every test execution, so there's no
need to show any information about it.

Also test it with `-i` parameter. The test is likely broken with this patch.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
