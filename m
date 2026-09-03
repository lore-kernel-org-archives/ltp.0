Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB3C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:01:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AC313EA7E4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:00:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8E293D753B
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:00:45 +0200 (CEST)
Received: from mail-qv2-x06.google.com (mail-qv2-x06.google.com
 [IPv6:2607:f8b0:4864:33::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C82B600A75
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:00:45 +0200 (CEST)
Received: by mail-qv2-x06.google.com with SMTP id
 6a1803df08f44-90cd0a3019eso8004966d6.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788436844; x=1789041644; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oPYU0QuBFrFYayvrz9i1pj7rBL/Q23Mdpk4dcIf/02s=;
 b=oOjc/Ho1CvB7JlV6oKemm33OoQwcyV4s2he4iGxJKDpM1yp+MJ0eMoToXI1Gv3Okbg
 lOrLuu6jOGokhBJwYcB7SZT2kPDROtiMqidpOl+oqymSwM/PIY92i53TCfKMNwJ+HAPr
 3L5tD9mznXHpDqeO85SLXGMBPQLIZiR00ePw//4Vvdl4u1wogg1Zhb6t20mj05FYHyVN
 a/vEZ1in2bSM3xSpGq0GUoHCdSpng2wqqwKO0/j/Up1a+vuXn8FHBM/UTBorDoB88HT6
 o/omz4Iw5ZePNa5IrpvUBNalBj473HObjHUJxmshdU0+zi3f9X4CdTTqjyWwfjXGMJyU
 CLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788436844; x=1789041644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oPYU0QuBFrFYayvrz9i1pj7rBL/Q23Mdpk4dcIf/02s=;
 b=rxFUC3fDJM5eAJqqQHkkCYj2fwzroD4n/U/MSlVVyQ5pKRwEpsCeIDuJik+15KK7DJ
 rCHlmH/nKpFRkOFcbT6V6Dg+aDrAZgABu6YDBDyE8bvW4qkenOH4oJxTBvaZSkhbV7Yj
 NdwyXoS3n6gYO4JKeNrvS8UeAVPOjvWj7kfjcsGX2EKtzzQHg+5ljC9ZfCFt+Fifo4i5
 vQs1YOBrsMtDzjxysWiCRlUrilhWb8B8Y+88cvt509TZ/7a8rboE+qbo+GR9b6NTUC1e
 WCwTqtndNzjXP7d9s+F2xSDLvZ0cRXcUJnYkxCTw2W3x/qxG0F4qx+Pfe4gaYEaybRdi
 z0eQ==
X-Gm-Message-State: AFuF++lLtMpHWxLrkNg9gWGWkH5CNFPabu7aD4V2+AxMn8c61QYriOSx
 bGdEJPs8DLas7TleGvx9ixNrnuFVbgjI6cVWKGTEBqCO3rn6VEYVUhUF
X-Gm-Gg: AYBFou3WV0v0c/3Z+gZ1ofIVOxFe7JeN6l1e6ARUMJtBM0+kv1rvLJk+E1lsdSNp18F
 cf0WS4yQZ7BLdaCOBYgPTlKAwQ4JuFxqapInKSq8aWCyEJLqluG+uXjRawqcplv3r/Ya+uZQogm
 w8hugwErDLPuADUkVnmySCqdxdRyNgng9Vbkt5tpfq7OFRc1N3JznG0RJ5xHci9OhEWHV9y5nEF
 0fmGjblkioxqH4YWdlof9CU5YjF4tXgcK7zrdt1bgPzOOF1203feYt5vTKd9TOt0AdYhXVXpGim
 n84Q1ifCA9KTVsS/GdEjVTClg3VUffpVIC42me4Xnol0WerCyf7G20ZAnHcgRNnoKCtji8Iv4Wf
 hCP/KrS5aMRDYnQ3ju+zNapL46ZHvwHfHbL0iGt4ayTkyUi+og0wMQy3IRsGLrsgbddgLR97EM9
 oQtIKmiR4jTCbC0YI2pMmsCF5UC6thY/p/jfSSTce3vSMsD3LhKxiVhM75RW7RiRSaHcMfD0rLW
 JzkQk9/ui4zoY0hs17obQc/JXDCU0ypvM2IlUhCvdEz+kSdAS0u+yxgRDi/pqlIDxofEweTG/66
X-Received: by 2002:ad4:574d:0:b0:90e:9a7c:e5a0 with SMTP id
 6a1803df08f44-90eb64bd10bmr119153826d6.17.1788436843767; 
 Thu, 03 Sep 2026 05:00:43 -0700 (PDT)
Received: from
 runnervmejwal.2ud13pocgmbu1lsymactxegu1h.cx.internal.cloudapp.net
 ([20.161.30.245]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9eec8482sm41905106d6.31.2026.09.03.05.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:00:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu,  3 Sep 2026 12:00:38 +0000
Message-ID: <20260903120038.8629-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903095255.4925-2-wegao@suse.com>
References: <20260903095255.4925-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Extend tst_assert_ulong() with enum flags
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

Hi Wei,

On Sep 3, 2026, Wei Gao wrote:
> lib: Extend tst_assert_ulong() with enum flags

--- [PATCH 1/2] ---

> +#define TST_ASSERT_ULONG(path, val, ...) \
> +	tst_assert_ulong(__FILE__, __LINE__, path, val, \
> +		TST_2_(dummy, ##__VA_ARGS__, 0))

TST_ASSERT_ULONG is a modified public macro but lacks the required
kernel-doc comment. Please document its optional flags argument and the
zero-flags default at the macro itself.

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
