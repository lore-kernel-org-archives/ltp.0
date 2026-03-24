Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF3F532ED
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774341602; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=9FxTmDKS/FKAuSQynPLpxKPIneFNihdcWGBqwBOuZfE=;
 b=iSQu5Uicm1KolMFHKvra0c54mmnz51KO5ViaOcV1Ndat+mOHLqQ5IN9GqE13LTt17m8PQ
 8VFD893opq1U6b8sFmNP7NvMz4tEfDX4usZAWXl+kvWvgaZGx/JcrmNsFRBPgQot2ngChy8
 gRANYGTVHEDks3UVZgL4caa0+EAneNI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BCEA3E26EF
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 09:40:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C4BC3DEC78
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:39:38 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0141B2001D9
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:39:37 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso9205155e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774341577; x=1774946377; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x/NAW4fB4CNXsh5kGh4XGqWRLUTWwh4yw2eZc2nmCjk=;
 b=HJy6FAb5mIPze/kwNujK5Tq0NtiMfRewBI4HaORCHXeL7UAMrkTlght5kusEpJowSr
 cMPfeBvFu7xSKpnzsBhQzEyoFyXx7pZNotO0AkHuQYrvQ0rvLUKzY2RwXsIiAWp6gcsm
 lgIo02FNRxlmMM/+r98QcXr3VH5Y6XGhkPXfNc7YF3hmseyWCwBk/j/b7209ofzj3Arr
 FfRA0PdXQ5zfCu+d+AJYpdNhsD5H88k16U30AQYmCCcvxp3ScXIz0uHUTLP5yTKRQr2k
 mu/vNT7Si95PTzmInVhWQZ3CIi9rrbwGbKaveCEs6TXYHLAMnw9RH1+RiE1dFLhJLJzP
 Cdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774341577; x=1774946377;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/NAW4fB4CNXsh5kGh4XGqWRLUTWwh4yw2eZc2nmCjk=;
 b=JMv75g2mMUj/Noe2G0AmncgKOFV9lzrXz8OnhQDH6qQw59XH5PPpgydJGtMvMN3ifc
 8LDqAcQj7uoTJeDQRjJdHpOb2jxtA80R2d8x98yfveCNVNgKQxm6wKaX+5wSjEhBVmAW
 BA2p5zZL+fvGAPC5U+pHlVJ9Gxf3TePB1H3PtNgUL9n8ZaxiwcDv1HV12ESaHIzUT8kk
 1xSam58r5sEZzhjw9Y3rwniwJfP0VlBQG5pcCGNhJcASuC5On94ypM5bY7Utnuby86A0
 lYAHQjIRQ/RwLg9VUbcM2ikUon1BqfyfzYdWjJwwrBu5p6oy+MVeJb56vSDuREEa5dwn
 BKkA==
X-Gm-Message-State: AOJu0YxlpN2RrxPjkZH5RnxDQ4eHjzvgBL6Z7f04CP1GVclRu63nEKRn
 0xIObz8DR2fuRAmkgYxYRcdJsLLgTJnoEG/j60TTX3DYEdmQ5/40pip2uBp/J6lgyG5dMZZtkyE
 fhjSnjxA=
X-Gm-Gg: ATEYQzza+Qy0a/xq8bmLiL8/e17ptkXebCZx0/fqu9HVxT6d04dApfFkh+EdIHXwlJ/
 y/0aCkXhG7pDAtczcTB+EJaNcFWCzunwN9hb+x2g2F+VOv7KYqJB1cWuN9t+9wedepYfTg7Wfpz
 34/Pdrny6oJU4fumHwkpLJT5LfoorZsqTwrQUOZfFeiDdhM4kY/9mYDwN20FaUJ1dfKt7jPsY2B
 YtsOQ8mGg3ugr7fPCIM1U6QglL8FftwOG3F4NzlTEZKogzgXWIQkFKW3GddsHPL6ESsoIg84WH2
 dv2c6Bkl+v2MPXsHH5UEBzIgTKiBpTPKwzesrEN1rx0fPqJEd6e2kT+IGWwVo0zNfLtIZBviA0R
 9mc+bklLvqN9Z/sM+uM008RMFVKPhNMtCWDArLQanK/bWCSpOzPcNHkOjDLd8CpQCEvLWU3q2sk
 L4Au8S2x8ctQ05+jNSdB7NhmCh9Wm6gViHEXQWRxkl2gFjfWXrVLP8fBJwKdnZQco30lVVdpxyg
 hnl5ceOclraEryLkIKpAIRXkkY8aucJjfRXM3r62O9OwpUZKc/7ICl7RMvlR9gB+lQfTHkH4Jr4
 zQ==
X-Received: by 2002:a05:600c:3495:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-486fedf6b7amr211458685e9.8.1774341577243; 
 Tue, 24 Mar 2026 01:39:37 -0700 (PDT)
Received: from p200300ef2f4fc9009d1d98240e97e0a8.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711709b48sm31870635e9.7.2026.03.24.01.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:39:36 -0700 (PDT)
Message-ID: <69c24dc8.050a0220.136a0d.3fa9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260323205547.19058-1-pvorel@suse.cz>
Date: Tue, 24 Mar 2026 08:39:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 0/5] network: cleanup stress
 tests
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

Hi Petr,

This is a huge change. Did you verify tests one by one? I can trust this
patch-set but we really don't want to remove anything that might be used
by people at the moment.

There network testing suite is indeed quite complex and ugly, so you will
have my approval if you think we don't need it anymore.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
