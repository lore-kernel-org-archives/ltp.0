Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D052C624D6
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 15:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 407153E9357
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 17:50:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D149B3E525C
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 17:50:41 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 097441A0016F
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 17:50:41 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-52f837d0456so6708421cf.0
 for <ltp@lists.linux.it>; Sat, 05 Sep 2026 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788623440; x=1789228240; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0KhC7fLc2S+hJprdl7/tJHAwVj6FhwmhdzMdvfegJU=;
 b=CUT3mMGprIetWPscZHjJDkKf2JVBgMlld0gDnlgwHRvFLpqzR0f8MGP4qQAdPMFvWS
 lDIIAUs0IPepEcWJkbltW9COHaEJaMgpJLwlnChmX1Q3Ujw3jpd9LVG3if0/axk1UhAu
 RN1Hp3oH9Eq7q1Ccfs5z5w5r4heIaHHbQWtipLLL0tlthgwXdH41KmOh09CjB2q+6t31
 QZYmbJYBnu4huXt076WmY4QH3j0TsYCKvQuhIRi1uNgjLav1jN+jBOv/5LUrLalx3IC+
 G4eu0WQdkOo8TqLoviadGFXZrChwBrdMNBkTjIhTwxw/z8H/h/kbdsxK4XeUUXhM0xEs
 +DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788623440; x=1789228240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b0KhC7fLc2S+hJprdl7/tJHAwVj6FhwmhdzMdvfegJU=;
 b=cbrEzEYA6jD0oTYf3nQeOrDD2yRXou/CvE4SexhXWrZOPaSoOkk7fmZ9Da2j92IY9S
 RcIfa5pBu/jOgmBRn+rU+KDy1ZZ7tE3tJzVahAlbML6bdZJjMuXIQM4ADiOq3RF+5IqZ
 isy6Ap9PLoKmvmxh3+xfaE6JmL83lQ96x4WUj2A4PImmMO9K7u2bANXvHMag5f8sKNGc
 kEDXumNEfzDvEtEH3B1cst8idberKfgPOPe8k+syr/mxvJegBx9x3lImAIkKgFtkjHJE
 DoPqaiGl81ZVKBC5hOReYwn2LO2TScIRwmQ1Y3sn5ANtUf33uaGuftsUHk3bcPKRjmkr
 OeRQ==
X-Gm-Message-State: AFuF++kj0GwbqS2dwd+6cMZAYrmBdP0qR9edpThjneT3H6sGFmsZ3Qty
 5OdlaXorfOPpVaxfoFANQcWr6WM4lQvgxkjqkKGsgeSalzRfJjMkVUaBz9rSKsIq
X-Gm-Gg: AYBFou1fDWdG1iDFbXXgrOb2vHujUkm/5xx2KU9VkKa72DFVGMQBHnqp1Z6SOyV+dYR
 oabjr9p0dpDnDMzOLebj98OlvXzoh0cxbDC6jv1bgmCkdVtgO7nK8ZFCHc1cySl2BTtLbtpUfms
 mXdHHDg6l1s+oaWtSxd1aHyUdApROGZNI1X5YH77/6uIfClY2bfQ4FBXXOgaJXmQbAqLqqvbb+/
 PmIOj6/4ocmn4n5ktzj1ozJ+fGhVY5BWQGNoYGVvdUXRFGvfWkvzm1xsIgn4ebGPhToP80qSb1R
 /CJDzr6aZ4/UzhaVBjY+MBRzbSeF8R6Z3NzSo/0lE5ti4RnG3D6uCnlaLyqiQefNL7lX8pVlJC/
 V0xiS7pWnaoJf491BrfnrsSmJx00jpP0RgRP94A/D9b2AJobZqUc+nL+IuJ67yEqPN+GPFDf2ga
 u7PhDqUhkG8UfcOtaanDGoh0l5joPnSMbRCYGf0FHxdm94Xd5pXnTk9EPpopllf5CCubbCm1oO5
 hlu6kS+JBTUrefJFjnbmBTIZtN2p2vrHTrwi+BM6h/Jc1CgDyD8dHo+7Udmr/1ChG3oRijVb0Zc
 xhg=
X-Received: by 2002:a05:622a:1393:b0:530:15f1:b16c with SMTP id
 d75a77b69052e-530545049f0mr147440451cf.0.1788623439805; 
 Sat, 05 Sep 2026 08:50:39 -0700 (PDT)
Received: from
 runnervmejwal.y150fp0xxqiuxfk2vvyikatomh.bx.internal.cloudapp.net
 ([172.208.125.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054117eb4sm46533321cf.8.2026.09.05.08.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:50:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Sat,  5 Sep 2026 15:50:38 +0000
Message-ID: <20260905155038.8625-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905125041.27985-1-changwei.zou@canonical.com>
References: <20260905125041.27985-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: count only the test file's page
 cache
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

Hi Changwei,

On Sat, Sep 5, 2026, Changwei Zou wrote:
> cpuset_memory_spread: count only the test file's page cache

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
