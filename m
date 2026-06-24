Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C36CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782302705; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hUC2tieTpPC+4wYzSTWmgj85kSwUumAlupm1XrcAZyM=;
 b=T/qJrzXjDQyqysoq7XW/6MCkYVDOhQVikKV8UsY3qWU/efGoM8LC0aczJPwTjzPfCC+ug
 dMIe1Nf82mve3ROh9vG3nTOwQIuNsM5uMGVVV5+07Hy2a1q7V7hJ/sxZuZtFAkgKYRy/959
 zmJZKZrEwNVSyVDcV1Yl3dToWY2O7Z0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453F13E622B
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:05:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D076D3C5BAD
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:04:44 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 68B8B200ACF
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:04:40 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49249072f03so5488115e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782302680; x=1782907480; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NYenrFKghulqr+D1V37IUk/St9No764v8SJ/Weh6PH0=;
 b=SMIC4xna4Er7/z+BNnQaBRihWvwm1GROXkd0wzxwEIEPJ/xhqY2hrEZRUxN4ldr2RN
 dPbIBQuCoSGdfQz1L4WXEEDL3dp8bjGQZOyXCIZzHRGT3GQ2T9v5Q2i9RyF+r3GnQpIl
 MLOad9CtYRIl/+2sMPp9kkNC8GLMVrld0oX/sAb7uOvqQSAZN9IyjS/UzDL91pWVUHES
 g+OZWAzPzfAVko5Ms9v3rOWrNs4smkSn5VSigwKEADE4Fg8ID1kCbD5AMYrctzApKD+I
 Wfa1RpJbGerLNe4zyWWP2/qDDa8mHeNPg6sTEqnsqEr/EF7xJGckyKdQZ0vUkv/QUH6C
 dcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782302680; x=1782907480;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYenrFKghulqr+D1V37IUk/St9No764v8SJ/Weh6PH0=;
 b=Q05JIW6EnKpKKgMoQSnJt+kaW2zg076LUQgsqvwfp1PSquXv+rCDI7/CsqSW362FTF
 ZS7yPjT2XE6MRDSU4tSqJP2iaNjsWHJOa3/l4v5DjQ6192ht38FjJ+Tnwgz5zepwyYI6
 kFUQTXoE1Z3FB3U72r44n0fyVuYjnpu8s+37G0rkA57CISC4bvfpEeA0+BOD4n/Ff+e2
 zCwz4G+roiNCmLOafNYxUUJFntkZX4gZLANUmci2qB4A4BG1wkt5BWGQHpR9bSJgZ89u
 QcQEs0K4zH72n83yg4rHDPt0bT6qfXr+jMIASUCM5kaI/iwve5dUmw6v1n5e2OGsBnUj
 zekA==
X-Gm-Message-State: AOJu0YwW88n1XcnmakRueu7Nex0h3ed97QMy9wn+Lwd/n1Le2dPGcbTV
 MSZ96fL/9zqJM2kK1YgQYlIO3g4GH2QvlVF5Mz77ePtAz7HIIoUeDpSZGceqiBxSBK4=
X-Gm-Gg: AfdE7cl1csZrxwbsnHg0aODiKE707MMKXJ1xO0BwbULwlh/v3Zke5/CK47XLTHoOkyr
 XzR0ESLyJ+C1QrLpBhb9YeiqA24gTMralEQCgXgInMIeiHzVyto2sBLbFZg3FtjF0D6gLbHZ0ri
 /j10OttClVsT1K6jZqOvOMWCzZxLusv48fSL3lvJsAnLhE1jW11zLKEG3NUznRugdElCAH4pjsw
 ZyXuYvlynCIjdoYby23k2agvt7+xaOfkqi1l5KF/LTcAk5hmsRWFBMD5nYDKkwXIELILIxRImC0
 qnGB6p837N6PppnyQ04fbtaG0xnw54gZtvkPjBOir5w4Pv9UjswF0RLRmCPgpVgnJTRqrt9RlJ4
 XUlYzCxD9ETbVIrg1zONQh1vr786DmSq6h42bmodxUXgQCmyxdeis95VZTmcSLOyDGkAbexZQ2I
 OpAgkbPaXuku2q/acRhAE2hRniNnFu8FJq9UTjVed8vYkCyW5Y2VYAJM/VCAQOwSKu/oVMy20+
X-Received: by 2002:a05:600c:4686:b0:490:be14:bfda with SMTP id
 5b1f17b1804b1-492608495e9mr41178595e9.6.1782302679605; 
 Wed, 24 Jun 2026 05:04:39 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496cdsm336467615e9.10.2026.06.24.05.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:04:39 -0700 (PDT)
Message-ID: <6a3bc7d7.49afda34.2c585d.d686@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-7-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 12:04:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] mem/ksm05: Add proper runtime support
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

Hi Cyril,

>  static void sighandler(int sig)
> @@ -91,7 +95,8 @@ static void sighandler(int sig)
>  static struct tst_test test = {
>  	.needs_root = 1,
>  	.forks_child = 1,
> -	.test_all = test_ksm,
> +	.test_all = run,
> +	.min_runtime = 10,

Even if this is technically correct, I'm not 100% sure about it.
Now if we want to manually test the binary, we have to wait 10
seconds by default, while before we had to explicitly use -I.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
