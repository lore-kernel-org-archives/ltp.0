Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECCAC5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:03:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF10C3C5AE1
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 12:02:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FE2A3C5AE1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:02:42 +0200 (CEST)
Received: from mail-yx2-x04.google.com (mail-yx2-x04.google.com
 [IPv6:2607:f8b0:4864:41::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85B18200063
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:02:42 +0200 (CEST)
Received: by mail-yx2-x04.google.com with SMTP id
 956f58d0204a3-664cb182f0dso888919d50.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786442561; x=1787047361; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QSUGJuTJ3FTM7pUIwUWlq/5TLGlcEeOHz1pb9ZuTuLg=;
 b=eXOVOLnOo3/HjSwtia686vgx78o7lElbSWztlgtMkgA4ou660xcg70DxHClo6PgSiB
 56SVS34QLUkeLF0QOywSwglbZeaIA9S6A4fJtxr6jBxG8ryk90dGDAo2TbZimxkNzVrH
 91QFrS0tLuRHZhs5ZEez/JXg6ql2Fn4bUYdTHSRUdxrKlze8yWHsOM6xrxKa/gKgvGuk
 Dr/ar6IcGd3AgWQB1VDGy7DztbYb6Ek+JlU/KH5TNAI95LsINKU7tE56sgD9dLkTWswu
 UcAsQI+wUYEZjVA/c+prwewMskcQku7zXZ2bWTrgW7GNKqE4pUyrJjO64tt3MkPxnRDt
 VzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786442561; x=1787047361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QSUGJuTJ3FTM7pUIwUWlq/5TLGlcEeOHz1pb9ZuTuLg=;
 b=qooW1F2+RibKJEg0dCeOKmAFt1khq+TOyFJkwePgoG/kQSFJYD2baveanDoivwbWD+
 mI1UUrC3rzpPK4Ye94Z4eCJAxa+TA4QcPlL3or2IocJLK0EqnYV6Tgd6U1LHKKb9mDSG
 BA/qBAVQW1O8k88w51criOYiVkHt3mCY6qxEIcv/S1yWd8Dc5q8KpQycEX1qXq1spjjM
 Pux+HTabVBDZLACR//kJykG3YyZw9KtLet7o7e9UmCPzk3oW3Ua6L1Q2d4h+OT98KtGJ
 LBwiS69IFApMVjez6X3uQXsNFjSgbGF0k3Lgjy9/fPDqlu/aivPhvoL0gpj5u8lo3o7E
 5XTQ==
X-Gm-Message-State: AOJu0YxvV8ubq0mZxmRMXII5eOHPCD+UHekR5IQzIrvfbq0s3VT0qx8O
 REg0gkRvcVtITGcNlE4UtlyAiSZJevaUhrKheEbkeQvkN5Z502t8uSmN
X-Gm-Gg: AR+sD114W1BfWw9eGYpS5KUh9u0BwCxtWsKNzIrtr/MuBT10ofn/3weXMBUr4XToFXx
 awPp0R6ZcdnxPBQKXMTPMFpRtiXSNc3W8nsBv8GD+8+qFv2HF39zIY3tsM8uQLH0V4SIpwRd9f2
 Jdjk26nAXuuTEp/4GEY3GuvXmiSj2DlmhrnckEa93gsDbkZMszDioCb28tTHPvKphwSCHWgoDlU
 Mg+DCJwKWTYYufwsrrJuITB/UjygIHkqB/vXor0j7jXF/sumSdW1gmGIEshGnrfBLEvOAlOGGbw
 4vBgJyMhmJsr/VwHywpRFw18IzY8JCX8UDhcTVVMjOMc+oulIXYzyiOHah1SvAeaa45VxymjswA
 IKQhqyuBJvDlrZeqg20FmYs7ZVG4WIU9j08tfu+lWRvTu/4Cg2z7aIuhFZLtOne07kugrx6Wwsy
 4R6f0aoR/L77hym1cy12FOBX3Z3sCLyc9M4wcgTBRmhZZKc19+gOlFduXyno6OgWq9qtnffDfO+
 uzjrgFvq29yunFQ5zTwh7k4yQdp4s7vFAYL2BtUl5x4lZ7xkR4h5oQOs1vAmLeSLqcAhAePaTAc
 vL8=
X-Received: by 2002:a05:690c:b85:b0:826:dc54:403 with SMTP id
 00721157ae682-82f2f6e154amr13029307b3.3.1786442561112; 
 Tue, 11 Aug 2026 03:02:41 -0700 (PDT)
Received: from
 runnervmvrwv9.0z4bovtnfq5urlwfnpsoqlh1ea.ex.internal.cloudapp.net
 ([135.232.177.162]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-82ebeb0d1d7sm6477347b3.21.2026.08.11.03.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 03:02:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 11 Aug 2026 10:02:38 +0000
Message-ID: <20260811100238.4192-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811092050.29784-1-avinesh.kumar@suse.com>
References: <20260811092050.29784-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nfs_lib: Skip NFS versions disabled on server
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

Hi Avinesh,

On 11 Aug 2026, Avinesh Kumar wrote:
> nfs_lib: Skip NFS versions disabled on server

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
