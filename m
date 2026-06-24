Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BA0CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782297776; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xRVWAeOhxTNt0/YaynGfMrO89hRUp6QOc48738RKgjA=;
 b=JjjfVLhUpb8kWU39aRcjVba4IgVR9/rNzKEBz87PXC5FCDSt8h88PawZBiFoMzkpCu+9s
 bjJ4GiXAEyAckJAfNIGYVRaBSWW/5xQB6VC9aqsN37D/jL3cdUyl3Y2yfv+152PCrHrBnN/
 KHlKU7pnaWzzTosVMDKiosZjQ/bTmZc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F8583E61F7
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:42:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741213C61C4
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:42:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3E472005FE
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:42:36 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso471061f8f.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782297756; x=1782902556; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uVB6DQO7LPGO/DSS4fKrFjkl58z2O7TPikiv2GSU7pk=;
 b=RiiHWYTSafqXaJgMBEs/7vMqC3rtPrQzrzfo1YwTC5ZYGwe5e4O7xkS1UsJVcWxjmu
 gOWlMZzHDPeax98TSIilEsux4OcZV6V95XFFGP+WboObk2izCXr2rpQROzLurLuLiQcO
 zq5j3hjBQLn661E2YJsg4QBFkzQCVoGVvdfTZHFS6A4kyulNCNr/u7g/hJ+L8gFyoCpB
 2AFnaM9H380nufJwu11V/x//Bz04ekDtlv4KxjIFaehlu0U6/rPfdEr8rwiCkiKh3zJ/
 OkZMzDLq25LlBAx6a9lycWyj5Re/PRP0lAAMzF/k/URpmmYosqCXGOw9g2vz307k2x06
 PCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297756; x=1782902556;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVB6DQO7LPGO/DSS4fKrFjkl58z2O7TPikiv2GSU7pk=;
 b=YggVboGW1pivnb5YzxRBqnizmTG79dNBiiGI8IovE7KlWe94i5Jr+abSarT9h4EbuA
 /pEX4Ee7xvxmWfg8v7mZSjhhERvc/zJu8znOoIG5z/BuqpDYN7Nb4McMHDZKiug98Wma
 zZqOzImMBpw/YRTDHiu2vqQQ/OOe/WWgvuxEHremPk7UZV7N1ee7hbUgvlhBHTmBderA
 7Ko4zLOr6tMrFHShFBsV34+zPvFiQfWCBjFMWsFT/2JUHUDqG6/dexQGJ6u7Se0Wwb3U
 LnVThMESAOvjllHL2JOxoKSYIkl+iKn9wnmdTW3q5MfmQC7Iik+bopxuabkq0/AnO4Gm
 tRBw==
X-Gm-Message-State: AOJu0YzBPd3vCSQcGnqrtQBMlehOoo2CkOMC0vOcraZFzRZ9Vxjmm0tn
 fZGIOOJ+Z5zZQhbvWggiSTW+zGpGsOErJC361vK06i6CqsL2jFZgxT9rmbtg+RwbOFg+DISM73z
 eBfpYSiij5Q==
X-Gm-Gg: AfdE7clTAPkD04i2L0KzLSBajd/tLu8vi5d1msKFHjtBG2EFOjnkfJJPr3GSU0FuARD
 d+qBZAVUF/fWR+ykoGRv0+HNwIT5qEIP8dkPcn+Hc25OMBicssk2ynSsqJ7SDjMiik5Gy1MZLrp
 1D4bDJoeM7SXEDqsHH2acbFSdRp8a90IBg9iFg1ddQuF1dzhb3OT/pBapbAaNV9J0raRgi+5ZOO
 bvvYUJ915791/Obdgtsipgn2PZOzMeB3Mw5+xOXqg+bkP2kZ9yse6V5O2NwmNuFN16o2RUxCMJM
 NYNBAm2CtIm+CTVmauARUVJJSKJApVGDB9gt9uKAlHEkjkovUhNGCJmv+0YidJLfRG80sw10u8H
 MwWZMe31nxM5cm/a2S0fEOkrtsTEggXybUDnU6/xHtcQYMhydLY+iu13wmXH/XoIUevkMLe+2Ra
 6i5K+CqsWl+p87z9AP1vyhWTBICcQpBh8toOfBNTP225tA5QtKsOQ1jbooe6ScUdxAhyaXhokqb
 lTyoHvtnsc1YJ6AUoAnxHUANPI4SzbVOHuWjORHeoN9xxsgIhyaIvJqrM7lcx5BORI=
X-Received: by 2002:a5d:4904:0:b0:45e:df46:ba30 with SMTP id
 ffacd0b85a97d-46adb1b24f3mr7155221f8f.34.1782297756126; 
 Wed, 24 Jun 2026 03:42:36 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c6csm6012416f8f.14.2026.06.24.03.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:42:33 -0700 (PDT)
Message-ID: <6a3bb499.283787d8.200e76.abe2@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-6-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 10:42:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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

as I already mentioned, I think we should do this in all tests,
instead of having it only for shell tests. I know manual groups
are error-prone, but they give us good control over what we are
setting up.

I'm not sure if adding groups based on folders as we decided to
do it for C API is a good idea. A tst_test->groups array feels
better suited, if shell tests can't automatically support the
same approach.

We should have the same approach for both C and shell tests
to keep consistency.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
