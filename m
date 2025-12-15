Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A0D5B84D
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765815865; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gsya64glb9WYKS0wJTB58fwknKp46GZ208dhSoFyz28=;
 b=qmqNf90vZByvPbFPHBy/+7d/gylGNZtHvRSCb3XnwxnPYgasDZjzjHFCIsCc3Z6Am+n0j
 +pwHlz1JEpRr1KPOj9trTkzXXhkmHs1bJidMcG6vurC0D2HRCQ7nN6zCTIFn2pIF/bTNpTK
 QKzScm1F8sTm0eFwq9qr/lSCQswZjGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165893C8AAE
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:24:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F0173C8AAE
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:24:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF2B2200058
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:23:56 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so24162875e9.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765815836; x=1766420636; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUkTkTrmP1Mm8VLxLTnRS/EFlpDsNfPVkmIVaA4MISw=;
 b=Gm+XEdS/uI03ok59s9nt+/eta5OlN2UwW+4WiZKXHH+beSj8t05jvQtE+EtTPMshIZ
 pOdVkGhZSXbrpshyu8qp+ipXQaLr3Tdruwetay1aSDuksldYcw0GOo5Q2DcERyB+F2QL
 tj5gRt05fsScQdCSCYhbqPcVLyTnLIxRw7nRPPlKqbZWP9dr5bMQz2gm6NjrP4H6oZ98
 HiyoWTeF8e1EvuJamM/lu/1TmWg5zaAPrG736chrDewo5ygqMxxJS8XJdderIlX/Gx37
 qH4tBEu9y+bFBjG7sGLg46Xgt+86DrKirJUXFOdTA0NFXreZh+n7Hf8RSCKTVwMwDE9W
 0pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765815836; x=1766420636;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tUkTkTrmP1Mm8VLxLTnRS/EFlpDsNfPVkmIVaA4MISw=;
 b=ZIJyvUOpGcBUXMPr66l/vNH3AWMWRy2lIY/vAGmaPAx3CO7j0w5981GSbOmhn0YAIr
 5UF4SQAhHzV4ULsIPVTM6ntxVWzXgbrzuOgJfQSB/czb7Ul3IYfRyusMoqDX6E63XyQf
 nrUntloYvQdGKpjNzyyuNMzjsxJX99h9exaFaW+I2c2uxy0P25lvYHR2+iu1EmJzsmYL
 HxiTxJf9DKgM0O75TV+PAsCKOeTikwThy8BCjtCel9UwXJgjudsaTdpIqt2afaKDl+ut
 oQoh56GWZLlCjvhjz8QkFTD7vx1YAUzi5ExSABCXqOwhsrUJZC7YKcqjrlf/lfK9uVSj
 3XEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWeT6LP8GpIq1xMT1LIDlROFDu5VT2k/533+Zo0iK8yjHasZNIDGqj8BF09TEdxl8NUuM=@lists.linux.it
X-Gm-Message-State: AOJu0YxMYGHHCsEc5vzmV8NfhP6cDHBJmk/rwT5+E50L1G9twXJPJo6Y
 pqQbfuW2WGdu8+nMUVob39JEka0gRQYpDRtOQ3WlfiMDNQV4ofdHluvubEV4eS4ILdU=
X-Gm-Gg: AY/fxX71ZVHDPpR4y22rrDf2EpvLzKCMhUQIxmLD0AjQbiA0hnnMfoqdLlppQTXnzQQ
 LiRvFaiTF0A/BjfaldL8IRZ+Z7OAsjoEHVDyknRI908xec8d4YeGTBoAqwzqPruYiLHQKZDSZRR
 FllTX7FrTmyXDzX+OccP59J4iGTxb7qhqbTCIZ5J5IsYQkdmlcmyl01woG+HQZ2DKogGthFWikr
 0bEfqfpvAT7ku7tDVGzXuPqoAiIp5oEAXeKCl/CnK6mUdTPIgDhRasrev/EK6Ng0pYt693LRXYj
 mZzbJumRx9c/1JtImY/v+undaBccOXfhzTb4aGn9XGrP2g/7Hka/x10NBgabJk6P2O5bDR8s+bu
 o7LXO/sQvo9ybyfWt9owILQLCuxoxyg3S+Tcde2gBPXwCNlhdHxEhpd15ktTwldsMZnyfUc1bLq
 rptp6z2sg2yt74S98rlXE=
X-Google-Smtp-Source: AGHT+IGwucs2CgxCoC+De1Xmk7MHCsG5mCugzyvhwMM+oCFjvn4922zVVAZXiSFjXEInC9uY986aAQ==
X-Received: by 2002:a05:600c:46cb:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47a8f8a7f0fmr121647305e9.8.1765815836253; 
 Mon, 15 Dec 2025 08:23:56 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430fa5f6ab7sm10292264f8f.25.2025.12.15.08.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 08:23:55 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 17:23:55 +0100
Message-Id: <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik> <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
In-Reply-To: <20251215161353.GA282302@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.
>
> Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
> visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
> Do we now prefer everything kind of document with .needs_kconfigs, even it's
> possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
> for kconfig being available even we can figure the support otherwise).

I believe we shouldn't see this as black/white but use this feature when
it's really needed. This is the case.

>
> And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
> /proc based detection (i.e. to use the same approach).

I didn't check this, but I'm pretty sure we should go all around and
verify many other tests with the same issue. We should do it in this
patch-set or on a searate one.

>
> Kind regards,
> Petr


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
