Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4A2C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 00:00:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67BC63E706E
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 02:00:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3EBB3C73AF
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 02:00:22 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 555A2600755
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 02:00:22 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51bfca7f85aso11616541cf.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786060821; x=1786665621; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6Y8WMTqQoewLQDdqY6TRmKokhBc4EygWxUXEUhW/DM=;
 b=ZdICsP/zHjq+zlRVPZLc+DNTcdkqPkYEi6nxmMHWN/WpRkBaVnsfWgT2/wDQB1RY7F
 9Z2V0z3ljxZNRoJtZwKnmkJQTfVC7WpAEPpeygG8FuT4JOwXTl5WokIJ9wT3Uxxu99bp
 wUgZI5jWwI7RWtoG9hV2En4cowuwIVx2Vdmczt1+azXeTBE2TG3hROEIyN4b84mqvCJJ
 6EKPJ4jyGKFXauGz+6LdG7eyPGFy4m1cLfgb4oUZjLKLZwOUzi+DxuMS5ivuzOWDKSOV
 viLhqDdaK4gPKVi5hhNra3QWlRxtX41EzQ/YqAwgO+B30O1wmyBSOsLr/Z0ZIkbV3i76
 Mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786060821; x=1786665621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g6Y8WMTqQoewLQDdqY6TRmKokhBc4EygWxUXEUhW/DM=;
 b=rEMjSzctce1NdfYavnRhxOuiS2PZEqNVC95INn4zKuZ9glGCyGA4f9VXpUfLCh9bdT
 FBWwVIRTXDWDfXuYBs+kPwdocg7X2D4tpwWmfe8K3PzfBYO2Mg+lgYo1aZNpXrSq92Yi
 bHY6Tcded8tZ9267IIrpMeeFhjHnR6MF7sFnDwR7HOKl7WUPyzUOLuEx2ml/+/0EhF3I
 gr069maHvlDwoNTj18GqfumCllY/sedMmpme3rXczl+Iyuj432pVCBJa1BZrdXlR+F1u
 xxLhjsVWTXHSGz1lL46dzN6TgMrScCIMq5DRn13r6qs4CGTi32wzwo803HDiWfcGGYg5
 Aqaw==
X-Gm-Message-State: AOJu0YwABWWg8dSxH10AEXlFd83EB4dUL9LZU+vwXzPlaj/O6C3ohNNJ
 JBg2BkcnvVvRmIRPCQEJWqq7gAQDbkwQGMjgdpvhmRkg3OcF0XNcoJuM
X-Gm-Gg: AR+sD12ugeVUlvONM7LcImSIQIK07J30YGAS3b4fc6pCUxniiUcMk7zJkTfxeKlPrRx
 vyHwpea9xCx3Cbdm0U2ltdEdmnR5AAlehfE8ob/kib1d3CoRhEAD8YtUCrPYPqpRXm4bcX5gcDe
 DCVboUkndqBffwRzR+rFuLRZcOT5WtQpjMGHaz1pFATVtniY3bDxiH9qFhK6m0//zE9nWwjg+cY
 v4YDLgrn3O5FUmNdIA8TgZokdbYkbDczE73rBBCeRnsL5J5o550fPrE1McbRhBERJpvnZWSzvGn
 X3Sq/PEVrUP+s1a6G91dbL59lg0uKadDm6h/9ro0oT7Ou2f00D0vdnbFvCA2wm5ekxbwe1pTy5n
 oOElJT121MgU2DIgNv7khISy0HJ6IWFdDszbUPJm/I0jBq819hPT99ntReyXq1l0dMqr5a7Lku6
 De/dFz3eQdbXOhGrWRib4xrUxn0dQ9eR5CuzzmpLZWeZ0LSePw/tJASw2elRsOcPwBO7D98/epJ
 y+8hpjA+afK8wjfJJu1DbjWdpZ9bm+ZZoV8WTlQtCqMzqgPf6rp3oUpWTKCm804YncPGrHs3X4r
 VA==
X-Received: by 2002:ac8:7d48:0:b0:52c:cc14:ff63 with SMTP id
 d75a77b69052e-52ce61dc797mr180475661cf.37.1786060820879; 
 Thu, 06 Aug 2026 17:00:20 -0700 (PDT)
Received: from
 runnervmd93pd.sdkwdzzwaqsu1mar1bzdugii3h.cx.internal.cloudapp.net
 ([135.119.236.53]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d16380af8sm682721cf.11.2026.08.06.17.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 17:00:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Fri,  7 Aug 2026 00:00:19 +0000
Message-ID: <20260807000019.8488-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806150814.4947-1-always.starving0@gmail.com>
References: <20260806150814.4947-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: consolidate getpid02 into getppid02
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

Hi Jinseok,

On Fri, 7 Aug 2026, Jinseok Kim wrote:
> syscalls: consolidate getpid02 into getppid02

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
