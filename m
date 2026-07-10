Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB33C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:59:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912333E5BC6
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:59:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AD3D3C857A
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:58:53 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A21B210001B5
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:58:52 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f3c172f5so504344a91.1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783684731; x=1784289531; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOw68WWdDWwBUqOExRtT4avnjxgVXs8cAKPpcIX00C4=;
 b=XJ6rcQVOnua/1VdjIliUcR2ogd7zP6hY+E4svBa9/cJ4JQXl5t34KrrpF5gWLw+aBz
 qbxbKb1pc6YJ56oD8QUAc84wyBAq0afiR2LCl8y/oomd7I6ZvFZpdqlanZwCBw3UcxfP
 jH3svogiii7qCENCfN29P+SYHt9rOi4DsukpYlxSOgu0OPVnnyIkTERUsUl7qqv4w0kV
 U6yALDBmB5RkXyBBVgDq9AK589Uh2JnYB8a/IGseuC6qC1ITxAexUdbq4xMoczrie3Wq
 36gbUru4loKTTmcp8x6FdtOKnROmQOEEz7IvKxsH/61q9KhswopNPMymVkso+gpyvJBh
 JzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783684731; x=1784289531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iOw68WWdDWwBUqOExRtT4avnjxgVXs8cAKPpcIX00C4=;
 b=ecwjSwnc6Fb4zOcjzCgCP95OVIlUPl9OfCrNxderHP7HQqLjx528M/1oX6ILo8F7pc
 MKGcbylH2RPeQLddHV0nDH/qQ4YAE9xeRskjw1WkD6gyTl9KR2D295XFx03p7/8Hqv/P
 xDKkjATAap3qcuwx2rqzaP+nSSwBtBZEV0nzYsmBVSbbvpJycIa3b9ed5a758X60pFJS
 s1dt2rRLZCTqH7ZUvCMjnXVDzMGLXzzEL+n2Lnq00qg8t2jvwoB53spJ1Ird9vOgF7q4
 ehCZ7e+AfpJSgaJUchg9mt3MRhV7UNdF70MR1ETgPKA9hO3r1ZDLPnJrMBk5ij2W7Rpd
 AM2w==
X-Gm-Message-State: AOJu0YylvsRJ76z8r3fA8wdPlQDZUoNu5DfwFDaZPzD3iW9L4CjmH9Vr
 El/0LHPIj8tDxSab3acB0Vybk98oJhAYZbZt/WLlLnO38IVNh7kvKqgBorKwQsfK
X-Gm-Gg: AfdE7ck8+djRy85wTKxpnHFGz54uAymUMwF1wc7asEcB6J3xR120ZzEXs3XIMWD3dAy
 y6cJOTYSSSe0w9EceLE+dzeE/+2KlSsmFuYWClpEAseM28GUyx3vA683Zu7nbz5CoqpHbA3Rtku
 nNj3xtPsXLmhfsxab8OREJpK8dDGki0jf3J/AYnEvQpOC7/3xsNJqy1mxyLQVoIP+cDKoR5kE8g
 SQ3LXYHINYET6XsSDyxm4y+RuezkbSkNi1HP5WO4WOhUbK3Qz3mAA3Yi54dr2TbSXgvSlVZdP16
 FpJFY/CHTPyv2Rs7Xr2gKHfTBPUlplnM49qzVxMnGmM5b028fXshXVyBAC/zQh5SdbIaEF73i/i
 bQCF5XieBwHo3X4+ynEbVl6rqbngPCsJxfRJ7dPlRDu6eLMgMns7R3DweY66fTMuyaTCBDXgnyb
 TRsSKlMWQedLgHJ3oelY89GdJ4q9aSlILGCJ7Oe6SiYC5H2NO6yws2rMjheWaeE0g4wOtkeqCai
 Xsjfv5n77VWJUYN8eDktG91e8Uo31I=
X-Received: by 2002:a05:6a21:4582:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3c0bcf49ca1mr13231380637.33.1783684730846; 
 Fri, 10 Jul 2026 04:58:50 -0700 (PDT)
Received: from
 runnervm5mmn9.d4bn4w2zevbevjaafbbr1wzekd.dx.internal.cloudapp.net
 ([172.184.211.116]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b84d6ce15sm6085862c88.5.2026.07.10.04.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 04:58:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Fri, 10 Jul 2026 11:58:49 +0000
Message-ID: <20260710115849.4080-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710091437.92148-1-sachinp@linux.ibm.com>
References: <20260710091437.92148-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/min_free_kbytes: fix comment typo and whitespace
 alignment
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

Hi Sachin,

On Fri, 10 Jul 2026, Sachin Sant wrote:
> mem/min_free_kbytes: fix comment typo and whitespace alignment

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
