Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C497C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784185263; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=nK9j9iMJ9U8k50nfzU8SKaSzdHE+4ETpn0GjgGCUV5c=;
 b=R5ACEBHN1Q7jL8jnMUoxlMEHZNsV8xMNILb858ayWtdiEo4U9RTcjG5OCNTjNrP6rJGBn
 QJLR43jML26M8b4ZeNHJ2DdMpfW78JFekRZ9aif6dDKC7JOwISid/asnEtvB7v6NLVaDSSv
 HIy0faLhU1lgYEY0Cxen/Qnyn1oA+2g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4C973E2505
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 09:01:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76B413E10BE
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 09:00:41 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF4401400979
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 09:00:40 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso1704235e9.0
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784185240; x=1784790040; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y7ILY+PUFPaZbejksLrFxbXuFBy+Qx4HyOJhFqDYeLY=;
 b=b6XI5DKdnZ4FCrlzqmvVcZ7JWAeWm8HYKw7uPbuju8sf6MmvpDT+2CxJ3H6t5zmXsI
 7/V3QUsHOA61uxTo59NC8nbxEtf6Xoce3z3geS1qRGZ7Nl+Mnpy3kZUyRM7ZXm8/Uw/e
 4iPDit+Jjv/KM674B4EnAk6osNZXgWqJ9A9GI6Pwan91rp7NGTRdgAkfqYexMYHofj7L
 LOmdaW4qkcb/iicFf8A3QdFFMjCj7ADcLaOvPuLIuOchc9Ye1NrflWgoaiEt765q/3ph
 Xg/d1knhOLEWAVIlBZaIkiSBLpRXy5Rqk6QJjR3jjPS6bgS2Pyi1xp3Fsp4c9GgBOAWw
 VVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784185240; x=1784790040;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y7ILY+PUFPaZbejksLrFxbXuFBy+Qx4HyOJhFqDYeLY=;
 b=PEPVS3a2tbfYcC8ayO8KEAhX7vv084xKYWy+jwqjlHFTPqnmJ/CIoWOAKPoSkFWjIQ
 0ckUA2AdkW0igTCSk6/lzFUMrPUG3owTNKGWpyt6AjcyuLiRen8HdgmVDcpyz2cFoCQW
 bAlXXPGpxnE+gYAy8KRPYkJpnx5b5pV1xx9xWak+2+EZqUaRYJB9c8/PJcCNkpI0fdwl
 HnVZGLKrXyKielAuTDLw8qkOnmvqhaOOkSskKDdcg8ExqmdjXt+UUqsExStZv3m7pDIQ
 VMNr8QG5kNOjmnR+HT4J1WDMYJapkom7ofUQv+4LPKOLo0jaKfMiq8u+slS4KUk3FXYr
 DZzg==
X-Gm-Message-State: AOJu0YwUK1lr4QS98XUTKICLQ1g3E1H5yt8o3dCfhuFFxQ2gjcJoDZz0
 iP+AC/6uldI3hL+MmDDz0+G+DO9USDGBR+SdDWlV/ZrkVAM/4Z1G2z9aw5MwXYkhUU6XGAEMZ3Q
 l63/Wk4c=
X-Gm-Gg: AfdE7ckNLb/A7ttrsh3mi44RMboIR3Xk0ZKzkAHmWPWk0/lmYgBCufMfNFYckr23Y0U
 sKsvhP0hIQRcvpwTarQidAfgvKBpxbh9H9JGTYn5R6wlshn0D4ms5S1pyDrCV7TXwo1FI4BT5JM
 zzDizC+wrqczzscyif5uR3DEk8SVXjTKhodfE+QwMI6ZY0Ha3+hhxSU9yHtMGDFYtLlq9iTb/pj
 h6ZBn+StbJzL4N2d51qJkOdXz3w0tNIFGfSXpxBxosrIlfpfyizdq1m+HfaOydEIifI413/ns1I
 ehX5eIrT4HP5CrFyH61KFl6zoDvjkN7Wtrp4U50wTkXRmAmEIcmX8z7lSvR2JRy8difrWfgMiT5
 QlRoZl9L4Nb7JphlAzu9Tc0LsZUdplAfI7YQbQihAzoefcbwJSm5z+etn9HNtBQmr+fjLBUFhin
 Aho85OGM8z8iaAO0Hgw9q3Px60Mg==
X-Received: by 2002:a05:600c:5292:b0:493:ee34:d875 with SMTP id
 5b1f17b1804b1-495428801dbmr10187755e9.10.1784185239448; 
 Thu, 16 Jul 2026 00:00:39 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541ebe625sm34668515e9.15.2026.07.16.00.00.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 00:00:39 -0700 (PDT)
Message-ID: <6a588197.e81417be.2c0b1a.4742@mx.google.com>
To: "Tomas Dzik via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <cover.1784183478.git.tdzik@redhat.com>
Date: Thu, 16 Jul 2026 07:00:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Fix to float_trigo core dump and related
 enhancements
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tomas,

please send the patches with the related version in the subject tag,
otherwise we can't track the history of the patch.

I will reject all patches for now, waiting for the correct version.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
