Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCDCD5BD0
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 22:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1131F3C71CE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 00:30:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 097BC3C5F08
 for <ltp@lists.linux.it>; Wed, 27 May 2026 00:30:28 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7BB3710007C0
 for <ltp@lists.linux.it>; Wed, 27 May 2026 00:30:28 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8b8e98fd885so138668306d6.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779834627; x=1780439427; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiNOjPQECATSfY07BcnpTY2kKPn7g2EX9/oEFEFCd7s=;
 b=GyKb8W9eTDjQ+K4KljeB4GZL97ajFsANjaFNezekXusBSc7hDPPnZSE+LNSnA/n/EM
 u5SdPs8ucp+5OYaYtSYYUSXpgFCMNdB0zNfWBp8sB3iYqcFENzeKb1s/D+8xouzIe5RB
 jIEgvpJaml75KdoJ45GxmUxf3n72zbmwAxTgz9KtDKuMuPBMNaV99TAERbn+JphGzgQO
 Pmy1JTtF45FnOZq/K5WabOuf8Wg25ThV6wBPZ5c/NSTQha+1HrmQqeWsN8gzEv7Os4Df
 P6Kdh1HY4PcHec9IS0dDaI0PhDsfd4FPtT/vOB08X33CNZsmYneLx/nvs5oKUm6wYzLv
 P+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779834627; x=1780439427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HiNOjPQECATSfY07BcnpTY2kKPn7g2EX9/oEFEFCd7s=;
 b=qWSDV1e+JIrmZtkRElYTx1Jrvw4s6fGOp7BLPx/QFFCXZg3lUaHrU/usv2umhkXKoM
 cvznUaTP6k1iQHhglnOtP1TwCaQpKXPd5i0IaUR1UqMNItP3H6CRvOyjja3BDDLaFftf
 eX2mrGScRu1HWNc88xfg69J5OamjAos4weyjaxa7RvZH33ZIQvZjXrTlSXuGp2vfNST3
 T3vsBtuWtpZlaKgkyQbgy6mPD6zXmJ8t9r6YBwOqWVtNTce7mB1pwFUEMfhdBpfZv+SB
 EkY39rHGPIlFjwyoix/4JNGuYtIuzwoJDjatfKnFL5uF4ypmdbr8ZwFB1S2AG1EMZzzR
 e6Hw==
X-Gm-Message-State: AOJu0YzNQCoNfVkM4vRMKcpV1y75QkXGKTXS+vVBg86szzzN8snfdbhj
 SsCMBAkwWQI3ZjThxAre1pWU8G6txIFlvtrnukxkBkAmypGxKPCGP5+Y
X-Gm-Gg: Acq92OEOPZ7kzM55Z9g5tMQY570ZoUTnV06NakO0n/Fr2t8L8qf5knA/MeKDeqK/8xk
 tE2J2u78GTjaduZrbmleMa6Ou+k3XDFQRitZ/L7hLn0IlTI7uT1tm1an2uXXCWggEklgIT4vYu4
 X8zOicS5JF9wzKsWUbP7eXX7uBXDgKIwd6J62gkv8V6rwsvBoE5VQkbVe2hj2YW5SoHDn2aQaGw
 3ccxDKHAx+56sHl1kwHZ5BnPExBdaVdYUAwIjxsqpFWIai4QS4PDkC6gUhS0OvcJA6jTSV6tO0g
 C7dC527xzH5QjAisaIU56HRHaokXBGFJrHYOL6ZBQZLfgvJx0QGBEgOXZE4DeWzuVwLB0CpfFUp
 j0sZmCvbY4b4RMj2cyZe7UxhqvPDDVkaP3IMCm01ICT1029lfD4aBqcHbRd4vHrVXSGq2zH5Vl7
 RaZxY60QXXx5pPKpq2ijz7aucta/QRAkjjdJs661R79xxQ5Fv+7t5vvNNnHK6gT6FjbxaNCyTMU
 VbOMBe0jM7Kq+9StZL+eeumGSLTgVNoGKZhpRE=
X-Received: by 2002:a05:6214:2309:b0:8ca:2559:8886 with SMTP id
 6a1803df08f44-8cc7b53c1b8mr332404336d6.13.1779834627139; 
 Tue, 26 May 2026 15:30:27 -0700 (PDT)
Received: from
 runnervmg397c.2bjrkiugu45unjuat4bmm5ujeb.ex.internal.cloudapp.net
 ([64.236.160.24]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc81316e4esm153089066d6.41.2026.05.26.15.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 15:30:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 26 May 2026 22:30:25 +0000
Message-ID: <20260526223025.4047-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526214927.150812-2-mmenashe@redhat.com>
References: <20260526214927.150812-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

Hi Michael,

On Wed, 27 May 2026 00:49:24 +0300, Michael Menasherov wrote:
> futex_wait06: Add EFAULT error coverage test

[...]

Patches 1-3 look good to me. One comment issue in patch 4 below.

--- [PATCH 4/4] ---

On Wed, 27 May 2026 00:49:27 +0300, Michael Menasherov wrote:
> futex_cmp_requeue03: Add EFAULT error coverage test

> +/*\
> + * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
> + * uaddr2 points to unmapped memory, or when uaddr points to memory
> + * without read permission (PROT_NONE).
> + *
> + * get_futex_key() is called for both uaddr and uaddr2 before the
> + * *uaddr == val check; futex_var and val are both FUTEX_INITIALIZER.
> + */

The comment explains the key-ordering for the uaddr2 case but omits why
opflags=0 (no FUTEX_PRIVATE_FLAG) is required. With FUTEX_PRIVATE_FLAG,
get_futex_key(uaddr2) succeeds using a virtual-address key with no
physical page resolution, so the call returns 0 (no waiters) rather than
EFAULT for the "uaddr2 unmapped" and "uaddr PROT_NONE" cases. Please
add a note similar to the one in futex_wake05, e.g.:

  The test uses opflags=0 (no FUTEX_PRIVATE_FLAG) so get_futex_key()
  takes the shared-futex path and resolves the physical page; this
  lookup fails with EFAULT for unmapped and PROT_NONE addresses.

The code itself (opflags=0 in the call) is correct; the comment just
needs to explain why.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
