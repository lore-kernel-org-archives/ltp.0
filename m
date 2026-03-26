Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDB8106F30F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774519673; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=APKeqPfTKnlJRl39u72vSP2QcRUKQdwj0rd6SSSxEBg=;
 b=SDGjrHsfpw6Pn1LmnGm+nn96ykihtGqckTmgjTkcbgnhYHgJwGLrom/DTPRGCvEjvXJE/
 GARRE7aTNK8+J9M8j/fskMF7l++iBbE43z6DXC2U1k0bTeFc3wdOydrOkjwmJ7vBaseaUBp
 GEGhSjqc5LmXJImlUhHJxGBr/zyJoTM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330B43E2AFC
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:07:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF8803E2735
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:07:29 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C9C9201DC0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:07:29 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so9321885e9.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774519648; x=1775124448; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=XAYhBkHMQooumbcP93OFIOE8xuNOQPpUAXRTfHSXNc8iR69QhSfJlqh4+N7U0JuP1g
 HK52P3DXi2Lhf9joQQnslhOd4uQpVpnJ/gWmEF/6/J6HgeZ90K4aPBBE7EgvbsZ9gemW
 msH4tUBdrGVMGmA4zDI/FAXTaSzO2/pfc7NmACcRArQ3X1+JpAJ0KcgEfAWY8yowLucm
 c7S+U+owTxcYJAFCjcUkGF/dBrvOJ447YTeDb9eurgz2BNNKk0+ntbAn3gbKSJd1Jzqg
 L2wywk+bZQte+mUqPJKQKm8pvtdEzQH/ipx88FaDOZrGcZC24ft0cLHzeJCo5QQK2srO
 5Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519648; x=1775124448;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=V0WvgFzWYXYCBmsHdsJ5lCvLsTJaL9w/htTxJBcrReAhmgesHDkE0yklepU5e6KDp4
 CCBBza/ZXmYQCX0FuCBn8pgNLWGK1G7Wbfhjh2fb6u6dqKQ9X1H2v7y8PRypCPv+boRT
 QuVnacxi/hCWFc/7xm9Q4KtTKqWFF4nzLbdacCuiDYSbL9xb3UAIAcba0G9Wtp+bvzcp
 6SNAsXZ88rE579qhaZHG9yOcopLJxhl3okWGpEU0G6HWFOwXz9Hwi+GsJL2GgSjJG4yb
 ptth4FD5CdTgGLHheB/k7gc95orhQZ+RY0ml+xY7ivlA/VY1DWVj39xOcQTUILSfDkhn
 b0aw==
X-Gm-Message-State: AOJu0YzTInJmBSiNDMBXMHLIasPMhSrFgulpZgKn0eLOOvt5gXR0SwyT
 yTNtTawmldOfhgmjSogUm5JSxcuYfQBqd/UfsZi0zsydsLfN7PRZ4E5R19hlbLRPXqad95BaMIq
 IUEj5z8nPEQ==
X-Gm-Gg: ATEYQzyl+Rl6G0BgBZ4c3w3hh801f8EQoyIn71+x8q29fF95VAzxktTi0toTbmnHBKz
 8cLG0enXDVYK5WRE7FzByPYJOnCGfGperOf4bDvt4l7ybq8XC7g2z/x/YZgPYFIkTJtwii7bSZ0
 XzA8O8hzsk1zU19G4PAm5eeJ08/TkuvovyOX1QBmEPMcmScpHkjAbWdsQwbBMws25iLzX9i0rK5
 Ou6j+4/md1B7lRlMc+DBquafFQVrIQKKVs4NvMAsCju1vO/0WJRQ/aJx5lkZ/vX20bLDfe/Q7Nh
 IqE0Qy4r1F3Uw32652zFmNizrD0/Jq6yStI/ikvMJwtE3ziRAA43qruWD4XDTPFjTW7YftF3u8J
 oZvfDTmTMBPzpVvDrBoZHSt1DaRJgmPioPvwOG6ccZzdLKfbdBGEukUU7lzJkVuJUUnVShM6xVW
 tWtlfz0/OtULd2mXXC0q3PyESzhEoQWxpXVMXRvIVDqRWO53l+/rExeBqrVS6s5JBXvEAi3lqmZ
 caIMJ1BU8cEUfXvvmlu71376d9udSTrKW0=
X-Received: by 2002:a05:600c:524e:b0:486:fe45:483 with SMTP id
 5b1f17b1804b1-4871605078fmr102408075e9.22.1774519648476; 
 Thu, 26 Mar 2026 03:07:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722ca344dsm17487055e9.12.2026.03.26.03.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:07:28 -0700 (PDT)
Message-ID: <69c50560.050a0220.256bbe.9036@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260323060846.4675-1-wegao@suse.com>
Date: Thu, 26 Mar 2026 10:07:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mseal02: Handle multiple errnos for 32-bit
 compat mode
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

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
