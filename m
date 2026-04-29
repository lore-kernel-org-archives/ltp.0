Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15E1FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777448719; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=9YNnZ1VHcC+haXEYOj6CphoeExrgB0b/kicFBy+hyio=;
 b=oPUyJ3dYrA2XPC+C+bP/6A45xq2c4+x0KTOlSq9+UYATw58SX5U109DIqhs9OY7/BJjbV
 eH8CNkRruKgRv1h6VOvdTB7vbfOi1K+H1ei0tbGyHg0E8ChmZ9r2awN7ZrQfdrrae544StQ
 2eP9DubbBJniX7hoABxPsewvalhOp1M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A883E289C
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:45:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D64A3CA104
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:44:56 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87188140055B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:44:55 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so9239539f8f.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777448695; x=1778053495; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Eyv5Z6Bb6RP2EID16d88fCI5uFLfigCi1cEhU5ZFKLg=;
 b=CocVTBhJHVuvBX/+ZWhwiCrXJUqHwLT+AJmiC/RJ4fM6VTfzkSrBW1CXvdfbP8/2P9
 njcw04CXJKTb8oPxdz8nI+c0N4TB5VbkbVoY37bNL15hFEVzT9QDgsaLiiAPxSAWVvLk
 EUXrhOMRv2lYrYPVtwsjO0YoOpiZwmNbkKsr9UiBy+5+A/IY6Fv+I7mex40QavpeDx/N
 EVPGrR8zIz7u/y56iQAviFcsAZ/LCh/oTQpqNoKliJ6UCbwfLPrqxaHOCtwOASZzwWYQ
 JaKzTKfmT47V4CltTkvC0YOgBAd1VOqohND35Y5S+mgp7duSQdZbyoKDHvOSBX461VEZ
 Didg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777448695; x=1778053495;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eyv5Z6Bb6RP2EID16d88fCI5uFLfigCi1cEhU5ZFKLg=;
 b=AaSG8y65j7jLljbyOZlMVXPTofxbyukGIvPiijqlK5j8ssxXM6yIAuEqxQpClopoS8
 adbViIzZjhUf0xz+H8psFiv84cUvQsdQaaO27evDYocJYJ9EW3BCFR+183NQWPAqIjsW
 /0SB5JE+GHHqm1AaQTmYTpb8Ym/hVxUFtZV9sNVEc/O7NO/4nFWzTGoi+hZSySP6H6QD
 +gONERw7eLbjLCX9MG00vK8JAhaAc9HI9PE8dNgPgmOzjF0Vry9S+4qbyVIDM2nrH/Zg
 2MzIns1LwhTbSmBwruDgWCuSr5foMkxwaHvfUI0wpQlg1O2FJLTPhnx/H9LWV20T4kdC
 0jjg==
X-Gm-Message-State: AOJu0YwWAJ9nwdpV8Q0DkKZAeHgAcQeckcVNmOK/nzGELo5ojpZp8B1d
 Vt7mnt18GrmQf8jVuRxy0mFbaG8juYxwQfWu1NYwVfpeQaM6RaAol4mfDHMQPYRR/GNTroLmqcl
 b75BOmaHC1A==
X-Gm-Gg: AeBDiesIE7IPSdBhFd8Gfs+Ty4DKFMhjJltc4w3CnBY6kkgTyRsRcnXidpnJohr0ngL
 yyqq/83My12ot7UCs5v0lLXvNhbcnxpc2KOMNtee5NUerg0iU1jHakMkFKbhkK8iI5RB/RdLCG0
 FaSbtJnVmw5twqP2Ir1qoXkC6sx6VW73badE8woeLFpghIQTB97r2ZVMNR2CffhtoekYvdHos/s
 F1IiFrF/DV6zL2AVVEhXbF88LRN+ancYEB+3GnuFD/3IxMjskyWPGjwx+HMo66hnK1/C1vhr6+p
 ULk5xot7t2b4uWV+/M7dYpvbJtQv7zry8Vt1N0van83qVaJpJvPbz4Thuy1etdho1cVwTMejK+7
 uJqB2AjAmoD3P5eSvwSTcVKCtyeOlULbdvOpk4JaCELSENKfnBJNM9NpD2NxFJ7kCAiJkZ4zqvr
 ucZI7z1V6I226pvJr9efhsq/MAy4Uoviwr8D5Y+ggUwsaZ5KNDtodK9rYZgRtk2B7yTIqQVFJba
 vfPdyUCj78iEEoTqpSNf3VQHP8mnci+uV/eTUVjjqDScQuvg5/U+V9Xz8F8j3+4jNdFmFLRDTlO
 Ks1pHn8naaOQ
X-Received: by 2002:a5d:5c89:0:b0:43d:762e:76ba with SMTP id
 ffacd0b85a97d-4478ea8a239mr4440336f8f.17.1777448694780; 
 Wed, 29 Apr 2026 00:44:54 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca5fe6sm4215621f8f.32.2026.04.29.00.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:44:54 -0700 (PDT)
Message-ID: <69f1b6f6.df0a0220.217141.acee@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260323113940.188663-2-piotr.kubaj@intel.com>
Date: Wed, 29 Apr 2026 07:44:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

this patch looks much better.

> +		char path[PATH_MAX];

Please move this out of the loop, `snprintf()` already
terminate the string with `\0` so we don't need to reset the buffer
before using it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
