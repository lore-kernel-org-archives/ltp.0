Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AECFF8868
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 15:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 909343E1AA0
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 17:51:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F6883C8CBD
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:51:00 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 201E2200909
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:51:00 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d933da14f0so965110885a.2
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777305059; x=1777909859; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gduAHd4Z80Zs+PJ6u+JRlGeel7Ny8NP2LS+whx+P4oQ=;
 b=gZ1o7hfymCJWwvtybAOIMzeAlwq0Hdccx5IyjKLzgGsly+tVZeAj33uzbhE712U7bv
 2oiQs/JIfyHn+D44l1JZUYFaNW9kRWo6DEuCNYcRjhVmGqAv7j5UDeHWkPzPLd3g5snD
 /R+fSnSOoODFoOSRz2ZGkEqoYC+8YgTqk/mps/BL7egVZQC7d/HqL0RoZ2Db8jGeoa4V
 TVQ5YrDZGTNalDzF5ie+E9JPWuIUCwfkjP+WD9tc5mmSWBj9GMZwK5lGOEJQGldPm0yW
 A4S639nh3WKBElf9wlxzfCUHOuHhHBP7HSblTPWOA9+FHCZSOZH0m84HFdHM5sSn2Hfb
 tfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777305059; x=1777909859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gduAHd4Z80Zs+PJ6u+JRlGeel7Ny8NP2LS+whx+P4oQ=;
 b=H6Os5DxCgtihCRIo5NNrUUkszBdfYsRa0CeFFjBYyaJk7D7xQpJ/mGYJOzQWhSZK5d
 p6obHpdoUm+pkna2ytV/RRBZUZSnZvJD1aQynwPjTa3Wv3zqTn9kffMYQDpYbJ7DId7K
 ue54g1X+G3tD923FQVxek0Cd81QEneeTnXrXPzMNDP4fMtZL+M5ZSkkGYteXPslopzMp
 V1/hy0YhejF/GfieGuFH8z6vXQY4JL5pT54ZM0osY9Wy2m8kK/4Fa8O/V3Flf73sq7F/
 aZ+jS3aKH62LxnqpT181z8o60Pl4qLK2PXS0Z1yTMNt5WyIqaqM4jMkykZIZeTmweMMt
 /rcg==
X-Gm-Message-State: AOJu0YxB8esjHSy/C0aN64ELFGpfVW27MW6SheXMerPu5umNZj5sZ+1G
 odZt72zl/TD118V9f4IKSgI0jHiwWeoPcS3Oj2t+rX08uF1atLseBuUQ
X-Gm-Gg: AeBDiet7zomuFd1kXzACKgBoVpw1EVAP8EInJh4eLeQZ4TdvUcTHsrIaL9z2VwxYMmL
 ndHcumnsc+GpT2BKmW+AzG7gRXeJa2C90LXeeKLEJwtXEo5m2Mus6qbJ06C3DcIfidMmo7oOBrN
 1e0c4m5K+wKBzs7Ij8h10/l6cGZ4WTl3Y+/CFRHvei9z+RG1zFc+dDRM33IEuSG2imdvOce8jCX
 eqIUNnsC1NoMkPtMPEiqyGUTHBFcscLDh3n8maIwwT/NPMrC/P87i50dwosf8Ab9MnhwatRxS18
 DFoWvASY1ckwFtK1tz5Q5ymvbGQQKZ25q8l98ArZyt9PaqsjkC73aUsRnaWSUjfb37Xc1LPLzeg
 Ce0g2Apge3sExZK1i5VD5S88gsPzNxwu4yTs+9dRA5Gf+oCn9n5Yx0vo56ZYDHeB+2+GmBgFnxG
 in4GZpv0pfyshsYsF/FuonHZcW/UlB5cTq5NjFnHI8cAV+EZnpEQ01F/JZjPjKF5zDRiC76OQLU
 OFi8zAzEOuJwzayXDAln4SjZe37z7RlHZVsf8g1Vurv25S/ljJsbFZoDlBb
X-Received: by 2002:ac8:5d90:0:b0:50f:9c33:af18 with SMTP id
 d75a77b69052e-50f9c33b626mr466464651cf.51.1777305057745; 
 Mon, 27 Apr 2026 08:50:57 -0700 (PDT)
Received: from
 runnervmeorf1.alcvuz05nmmujijktqojz2jv5b.bx.internal.cloudapp.net
 ([20.55.118.118]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e39130d7csm256365951cf.0.2026.04.27.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:50:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 27 Apr 2026 15:50:56 +0000
Message-ID: <20260427155056.3896-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427150139.31685-1-mdoucha@suse.cz>
References: <20260427150139.31685-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/io_uring: Add IORING_OP_READ/WRITE constants
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

On Mon, 27 Apr 2026 17:01:35 +0200, Martin Doucha wrote:
> lapi/io_uring: Add IORING_OP_READ/WRITE constants

> +#else /* IOSQE_FIXED_FILE */
> +
> +#if !HAVE_DECL_IORING_OP_READ
> +#define IORING_OP_READ 22
> +#endif
> +
> +#if !HAVE_DECL_IORING_OP_WRITE
> +#define IORING_OP_WRITE 23
> +#endif

Placement and values are correct: IOSQE_FIXED_FILE was introduced in v5.1,
IORING_OP_READ/WRITE in v5.6, so this handles the v5.1-v5.5 gap cleanly.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
