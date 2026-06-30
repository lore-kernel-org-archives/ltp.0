Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48398C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 15:31:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA3CE3E4B09
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 17:31:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E2843C746A
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 17:31:03 +0200 (CEST)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 285E91A001D9
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 17:31:03 +0200 (CEST)
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-6a116bd18ebso2730096eaf.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782833462; x=1783438262; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFbxZ+1ilrOLdaEKExmaiHgZh8pNWio+7l1BjIK6PnE=;
 b=AxNKP0+0J3wfRC4EvKtgQ0E5Weq7cdiO9DkncvVx/BQyh1o/xcJs7+6sez1+BNRcl3
 FoegvdzJIswqBMpcg+QUsDJLv1UeDP7W/0dypJjje+sGP3ahE4h/rPNek9dhgbpIcbOF
 CKAeiAvYilgLRcLjdf5hiphztvEUIyK13MrMagB1lj6ktn1lyjoEU8CrcFbVljyO4ArQ
 xHz+an8Yklig2WonIO+6Y5SwbuxGjHunicDftTcxTVwcfQeJuYVptVVo9GcXVBI/kDKj
 Spg9jRhSRlIVtYmhqH8gasgLR39GpjHjNQklhTxXHEEBsM2vDTUvG7l9dP96LnTB+UtR
 aP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833462; x=1783438262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CFbxZ+1ilrOLdaEKExmaiHgZh8pNWio+7l1BjIK6PnE=;
 b=mCFBWGK4NdnNLH6SH9rh/0E4p7oks+l5LEUr02ids5AkmGl/xXafuW+hFcm+W1VtYr
 OpLldbIs4F2JCDGcvHPf/cuYojfs2TWCAK9hyyuEwZVYoLnWpSn4ArWOvwCKMo8iDSS6
 D5+2Sito/3vPTrKks//J8TyXbRolJm4S0UgeSYb4CURK0vFepxfzIqqqzdwnO137Avam
 FqVLK8kj94JnEVSf60rv9EvKtafqIlTmBIlijgNdE4bdsjRHaBYA0thcqB9ZkyOvUYEj
 ErRFgSBF4QR73codgh7QUTzN5LtDLcPyR3yZ6L6BeLZMru+G1zFY07NIh+1J1J+sn/1a
 Y49g==
X-Gm-Message-State: AOJu0YwHG7Mj1tm6NTMZO+cRhMkJUblpY4FgJVLFgYMErL8QUwB8ZbQx
 kvw59LWUGTeV76YD45xZWGiN9fOQir52G/v9xesSqB3VstyDVC9Zllo7
X-Gm-Gg: AfdE7clWBgWlLfKIg/jDvNfrNQFp8Q6eyG4qsTcsVdxhX+8wPRR8imASdFEelVsYjds
 KEkL6oH1AseYcKhDjrZ1mOEbbtO8e+AiqKRZSqFCsRoyxBhsOIPqfdFR2WmVbgZDl3d9uhAOCoC
 PWTkWf++8Coq+UiCBQthes07tRtUU+IzZ34/Ywib0cUgVUpEg41bOZZ8EQr8EpgZvGnh6y9zT1v
 +i5qUCr71avQtYs5WpIw7r4dw/zDiWIQKUwz/pwkdktWxntgNa+UbCL+Q6lJGd/m7/MlYStievS
 v3GTwGHdrtw75v4PcqR+DLgGmhjzxCvIfjCwkRpPCpGrdPonkZqvvhKvb8khrUaMPUsidBv4Un2
 69vp72aiHpysiVkQQVKj40P6DD6jrD20vOXdlIjKdgkKPfBdKWaCCMSXFYvjAPjpd8MlQQP5Y3r
 Fy1xY53GVUEEy5eBIGnIJR6qlN2DeQVC2hf+KQ/S+wlIP95sGjkBnt52dCzKu2CDbnBY14B3mkT
 swti5/mOlgAyTx2+dMng076s9xxG/0=
X-Received: by 2002:a05:6820:818a:b0:6a1:1c19:48b6 with SMTP id
 006d021491bc7-6a1890f4cc0mr3581747eaf.6.1782833461460; 
 Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
Received: from
 runnervmmklqx.qtqeh0lh4sgepnqtebzm4mqhhe.cx.internal.cloudapp.net
 ([145.132.101.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e6237ea0bsm263214585a.43.2026.06.30.08.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 30 Jun 2026 15:31:00 +0000
Message-ID: <20260630153100.3982-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630-landlock_udp-v1-1-21a740209f70@suse.com>
References: <20260630-landlock_udp-v1-1-21a740209f70@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock08: add UDP bind/connect test variants
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, 30 Jun 2026 16:16:08 +0200, Andrea Cervesato wrote:
> landlock08: add UDP bind/connect test variants

> static void setup(void)
> {
> 	landlock_abi = verify_landlock_is_enabled();
> 	if (landlock_abi < 4)
> 		tst_brk(TCONF, "Landlock network is not supported");
>
> 	addr_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);

TST_GET_UNUSED_PORT is called with SOCK_STREAM, but addr_port is
also used for the UDP variants (tst_variant 2 and 3) where the
socket type is SOCK_DGRAM.

A port verified free for TCP is not guaranteed to be free for UDP.
Should the port acquisition be moved into run() and use the
variant's socket type instead?

> /*\
>  * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
>  * protocols, using both TCP and UDP. In particular, check that bind() is
>  ...
>  * [Algorithm]
>  *
>  * Repeat the following procedure for {TCP, UDP} x {IPV4, IPV6}:
>  *
>  ...
>  * - create a server listening on PORT1

The algorithm says "create a server listening on PORT1", but for
UDP variants the server only binds -- there is no listen() call.
The code handles this correctly (the SAFE_LISTEN is guarded by
SOCK_STREAM), but the description should probably say something
like "create a server bound on PORT1" or split the TCP/UDP steps.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
