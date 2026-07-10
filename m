Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A51C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:26:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9EF73E2DEB
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:26:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99F103E176A
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:26:15 +0200 (CEST)
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 41DCC600AFE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:26:15 +0200 (CEST)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c888c19b85dso128947a12.0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783671973; x=1784276773; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W2hOuyahKw996jlVDeQfx0LW/TejY70O7SCL8p7Lm8Y=;
 b=Uf4GfA3+tNxgejqRC/pcPrs3nR2AkQKfa/MUNEbwngG0jNGRkOvCXkT9A9x7t7qvV1
 W5voEwiCDhHQ8xQ6BYx1I6bDd8NX9i8b1TPfnjGq/vFypjHm8uVyfScKl10YNOTCucTq
 ehjySLdbimaixIYW6WAQSNoc2IJLyJvtlEBa6/ujwS6p9Jf8N3PSaAXhg7FVUwY+lyI7
 rEyO2SC29c8Ewi6rdnSUlryHIO+4+/HRf7JRxb3p2yLFUl5SIWrOmp9aLkdnj6sbMitp
 Hqp0HpfE7iUA9vP/upcq4IuIYwp18u+gFZZHBp96f6duvKrqrhaS6X2SOv+GGL5ahWfV
 uFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783671973; x=1784276773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W2hOuyahKw996jlVDeQfx0LW/TejY70O7SCL8p7Lm8Y=;
 b=NOV1N3p8YN4QjhB7wd2XPEBkkvZ5ZdChjVKtUf+e5CIfyD96R91OQqHWixV0SRMW09
 0Y93eR3hhCFRQg9b0c+OMuKnmktlbQxkC0GnipuIdqS0bHkijHH5ZxBLJbsaWL3gH/5h
 cIwX6xjRGUC+L4ILaYThUkVw0yWypC426jCahboobcrHKnAoSgDBuSf16eNvElCh1LKF
 A0siuncSwDUMnxmjQo0dGZ2L7tKZodnMram+TxvacuIwmITk3q12WcNjUohvEmHXcFKd
 PFRVbag2hbrgVJZY/kwbhsFfiHUFaEEHeZp6tRxrtEh2cZF/VrW2S2VBLJGbdTdwqo/p
 2Rhw==
X-Gm-Message-State: AOJu0YyK2u6KX07+3abayQML8bIPIOHkw3vtD0e5DHyd0YwodxS3u3EE
 4VUXAntJgNI5XtqaI8IwXnOLlmmLJthpGLu0MRWwptEEF/6qvi/+O46n
X-Gm-Gg: AfdE7ckcxTHrkwwB2cQBZGOMwR9uNNZABlpRbcrh+fyQV2btPkeulJ3jvRfo4jU8/QI
 1CXgc7tC9Tns+P1OXoyLz70kKv6L/YZqYnVPaf80hcxVfbtET9TNighPSeUJ44vOI8J9e6XdoJq
 kjNthkHb7feacrmFKfRYF15/gUrd5zwDyh8ENguox96eq90gODz3xNLAt9bLpAmC8X4VfU1yGid
 YdVMmHpD2j9r/CPXnSF8j6fF0Su3Qm5dt0dxGS+/67yaQGzwRIg2ONptJc5e3HHFJaxyLZQ2ZaL
 pTwTnnuaNavuwDLNqgoyg+C7ADutDoTsjlKz+1PT95QUTqc9ERXvY9K8wWFFotMtzzt3lrQ0suT
 6eMvGGDXJ0mJqcOTbZoLbXn4Qf0sLt2972IL0EfekpDQsP0fJ7UENQER4Zc0+0O4x3iJhRyzQhZ
 UbvPcZgX7VOSNnPFldeOcCVFQjvez0NKGKSrLO9glReYttDeop6eoP6JQi7FiCO8ZFgjjCAoGe8
 PqWPRnpQf8BabYPNHJwLkMP8p6fYY28YY+Nk/zBEA==
X-Received: by 2002:a05:6a20:ad98:b0:3ba:cd5b:3dd1 with SMTP id
 adf61e73a8af0-3c0bcf5d7f4mr12092285637.33.1783671973464; 
 Fri, 10 Jul 2026 01:26:13 -0700 (PDT)
Received: from
 runnervm5mmn9.csywkskczy5uzdr4uags05v2db.dx.internal.cloudapp.net
 ([172.184.166.103]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6080dsm24059674eec.17.2026.07.10.01.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:26:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2026 08:26:11 +0000
Message-ID: <20260710082611.3783-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710075548.1167519-1-pvorel@suse.cz>
References: <20260710075548.1167519-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test.sh: Remove LTP_ERR string from error message
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

Hi Petr,

On Fri, Jul 10, 2026, Petr Vorel wrote:
> tst_test.sh: Remove LTP_ERR string from error message

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
