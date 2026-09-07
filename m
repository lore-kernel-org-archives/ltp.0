Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C3C79FA0
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:58:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D44193E950D
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 16:58:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DE983C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 16:58:34 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17512600712
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 16:58:33 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so3204264a91.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788793111; x=1789397911; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FBGWSljYMp54s8Y6h0dS7W7A0gnkA6PFPTuwfUq+ttk=;
 b=oiyNEN6rSX2iC36mEUbq5iH6dLsu870npiYEIqsmz98R66xYGztZqZl/IHOie+SQQ8
 tAaGKgjJoKo3LbSGoWPUXdJox6leKsoTe3BSlmudaQUAUMZAh5EkNw7KbMEEoN4tMz0E
 8Ty27gqoZA1sZuOAetqcCw0ZRWqaO7TC9W6p1Nqn8OAsHst1YUjAwbruS+j9E/qJ/XCf
 xVF0jJaZJ5JLEFRAXCc3tha/Vv96UhzdP1Te9KywqzTCZTFp/6X77Bi55LReqacl1VtG
 skFa1Y8ukU3QbRlkVN069qFB19Z3ff7e5RRW2CvB8wDLCCPg7BVMIRfpL/imiVLQupCP
 Pu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793111; x=1789397911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FBGWSljYMp54s8Y6h0dS7W7A0gnkA6PFPTuwfUq+ttk=;
 b=bCYjYCXMxucZBEFKhz66uyQePLE3ZgZgS5ArbnNJzquB0SwDXZVpIJkfh0+tO6xD4t
 qj51b2QG0c0BI5ALkvJjuXvQ/fNOR1Z/bgKfsdwmMKWBYGu+MzqH9P8OyURkCXNHSHq3
 vAmbZ+TI3syEmABEQ+VNfZr/EAvjgtie/3UN4YA/1W7YZSy5MXRqsS+q05mMfzMxFP6w
 /NUzTxueyuewWI32mbu0OOivNNu9lCVd7BYd7/qj40UuCI6UuETGrXfIDmwzctF+f0R2
 NM6x8e+d0P6xzsoPVlOiVTXWCkL17hs3EFe5yJKASLH8c3b7w8ZU+0qGKsmS5dATwH+k
 BAbg==
X-Gm-Message-State: AFuF++kbB+9y3ElGWFYUkuVh6ExqnPi6HUVfNU2bBtqeJjTjZMG+8cbZ
 dz7r9nO5rAQd/UK6Sk5WBi3Y6SA6o+w/v741AgkK3Gn62LO+0no9DZ1m
X-Gm-Gg: AYBFou1kjN3tbw3r6LBnSgCg1cIWkMfDdPLJffpxG0L5/xwXpaYn8zk1ttcEkk7s2Ly
 zzGehGogkkX0eI76ZcWk17jWS+JG7Sbws9uIu0JeR12RVHrZ8jtzWKGd9eV8wzIVamp7BTGKueq
 AqsK4phdrCSl3hMdWAGFGTGsd5QBrSC9N2vrl2MuHSWCmvqsdQDrLKfX42D9qSIN0qGof6cHcij
 2sOlyz9IJqCYqOL+BcD7sQb7QFAm9zHK2zLfv2cyeCnw3pN4wBbedbyO3DCzOcV5m6A/SGkCqmJ
 UePHiGIU4QSSOfWtuPu6wYTqhfP18DOlyFlwcfYzsrrLP1G6g+blJr7h6/y0q7cgqzTwra4HC+1
 87ZwIbClmcs8rYw5SgRANOf3VzTIN4xjJBdh30PVRZQu+IIKMQb5G2iVjXjJSvhWo2SkL7FOd4l
 a0zo/WB5bylsLXthU8xxXlEdQ9KLHxNxXtwfGuWIqckZo64gKh97kqnbjARIbaS0WtXlJkuWYbc
 T74a1z1G1kAWP+CChdbYsjpBvRFdZv6YYsjr+R7Rti4AC6M7P1sMH+xaVVA/WeY/KRV+MHnPhsr
 n3k=
X-Received: by 2002:a17:90b:570b:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39b260de5bbmr36582966a91.5.1788793111336; 
 Mon, 07 Sep 2026 07:58:31 -0700 (PDT)
Received: from
 runnervmejwal.ujbej0qg0ive3kvrwq5foysb5c.yx.internal.cloudapp.net
 ([172.215.217.201]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432437d0f4sm25507282c88.7.2026.09.07.07.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:58:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon,  7 Sep 2026 14:58:29 +0000
Message-ID: <20260907145829.9000-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907120308.32898-1-mmenashe@redhat.com>
References: <20260907120308.32898-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] read_all: Fix buffer too small for long paths
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

On Sep 7, 2026, Michael Menasherov wrote:
> read_all: Fix buffer too small for long paths

> +#define BUFFER_SIZE PATH_MAX

With the existing `if (++j >= BUFFER_SIZE - 1)` check, this still rejects a
valid PATH_MAX - 1-character pathname and reports TBROK before writing its
terminating NUL. A 4095-byte pathname reproduces this on PATH_MAX=4096; change
the queue_pop() bound so PATH_MAX - 1 characters fit.

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
