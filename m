Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4069AC982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 09:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FAA23E6C0B
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:59:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30D8F3E48F7
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:59:12 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46A4A600B2C
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:59:12 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-9369a6afaf8so47022385a.0
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790157551; x=1790762351; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YslwNDvdVR51UbeVRzoJcVS1yJkeF7Mtif9cJn7zESA=;
 b=S86ykMmyqNNcYcTen5O3OiySZH4z2ur1O+9uZ9ZoAcD3HxKXHvrnwlZRO0IEJtanDT
 GKhYiOmFjbdOBNpFcRUvG7yHK+356OmRFn4w/ovqZcn1cA5FWaLmsGNHirPRyABQ/VYS
 fhmtSkKTfNNAcgflS9ro0UNell8SkxT1PP6SsGJemAEqtqMIeVyYpO6zxgAxAIvL3W/N
 JyuGfATsQTGYAp8fERQ6vRfiAQ9K0rVbV8SgDR8FpjeOcXiiJHnCM6WzVelkeeRVvBHf
 IcxszT9R2tMoIOu3Bf3sTtORnylR8U5P+ZaoBk7av4bZ8sRm563COPbLuPSCDIWWUzTT
 dUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790157551; x=1790762351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YslwNDvdVR51UbeVRzoJcVS1yJkeF7Mtif9cJn7zESA=;
 b=LNfq8IUBYScW01Ywpr/YuvGQMNJDqayugTbIKPnY290Uj4a84mtobTFZHzpo2fo5/d
 zVnGI7EifBwo0pygVZqyI5LnBZVSRrLV4sNP/qfbZwhWbEU2Vt/z6OD7+p1jBr1FUVOL
 cy2+eeqnon1h+wY7ebk77u3bPnI/JSkXAaKJomC1Jo75GqMp/r6BQ4FSepPJkEW441zY
 WhJopBKEFsMa/5lJvpCbpzwnFFZUy8ncWPx2Z7tjuAADxlv2jOYCkBqvFPvB17NMpLhn
 MmYo8jfsBrQqiz5QUCS4MyD8rDNIJ/HOthPoY1k0k2iXiHy6V7QTAmy9VIlaiftkHrey
 1rig==
X-Gm-Message-State: AFuF++ltLJe2Cgz1DBIdy78svv32zBGn+w2iaQwyEyFAO9Sy3gFTE1pI
 PoqWk1G7dnD6IKXBCuhFMLHf9TEQMPHnj7rLv+TQP4iKfkw59PXpIRBHF7zYgpJk
X-Gm-Gg: AYBFou231PE8nSzQK9eD/HbJGbGRIBqirTr3MIfzsK4A5zWPma1RmMxO8cn6hOagb+1
 9G2fhMPzarBiiDsyILiWHjDZpIf7uZWP9GHAjH+t3jeRtzCkykrA8mwufg7wZJY3zoVvdOaRxE6
 hU0dVioVshbjmx7HZ3fQKJMnunbYIPyOVvhsTNYuX4tbXxUCab49Tj5OWrI7AUvcGo6p9pzgubi
 bjbMgGetT2V/SdOJtF7T6ea95PytHeODfuyrtmLy54vzmqT1kCDKkeK8OyLAGG+mVrm00nJlJIl
 7CE9TK1WxLR/u0/YKfMn0l/KPA4oF/9xi9eJXjbZOCwgAzkzyNht8qyobeToTeXHWJf9A/ZK9Ng
 bLSuy9guOu96maoC7lo3i38BWQzBWtH19Z806guTd6HN3iTNDW2WZZTWOAPLzU7dpJMSwLfuffb
 n19LYRONHs2Mz5Ls8Rya5OotEaJ/6hc9RkK2oA7PRQb5cX2GqVnvNQn3GkkEK7oTgyA6KVtMI2g
 jVunDQeTXf9oEVpCL/o9XTtMu0PWc6yNxxaMcoyCJ9HS0pnJw/XLhAgPW4qgL9l1RGiP22PLtNq
 mDELqHzCljVfhu4MlG5zVbg=
X-Received: by 2002:a05:620a:440e:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93c24f19f01mr322974485a.0.1790157551052; 
 Wed, 23 Sep 2026 02:59:11 -0700 (PDT)
Received: from
 runnervmlun5p.iamlbuy3v1luthk2jn4vllyqrc.bx.internal.cloudapp.net
 ([20.119.103.10]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c2485c952sm190934685a.25.2026.09.23.02.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:59:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed, 23 Sep 2026 09:59:09 +0000
Message-ID: <20260923095909.9312-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923083300.54026-1-pavrampu@linux.ibm.com>
References: <20260923083300.54026-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmget: Add hugeshmget07 to test SHM_HUGETLB
 with /dev/zero read
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

Hi Pavithra,

On Wed, 23 Sep 2026 14:03:00 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugeshmget: Add hugeshmget07 to test SHM_HUGETLB with /dev/zero read

>+	zero_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
>+
>+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB | SHM_R | SHM_W);
>+
>+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
>+	tst_res(TINFO, "shmaddr: %p", shmaddr);
>+
>+	for (i = 0; i < size; i += hpage_size) {
>+		TST_EXP_VAL(read(zero_fd, shmaddr + i, hpage_size),
>+			(ssize_t)hpage_size);
>+	}
>+
>+	SAFE_CLOSE(zero_fd);

File descriptors must be initialized to -1 and closed in cleanup() with an
fd != -1 guard. If SAFE_SHMGET() or SAFE_SHMAT() aborts, zero_fd is not
closed. Define static int zero_fd = -1 at file scope, open it in setup(),
and close it in cleanup().

>+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
>+	shmid = -1;

SAFE_SHMCTL() sets shmid to -1 when called with IPC_RMID. The subsequent
shmid = -1 assignment is redundant.

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
