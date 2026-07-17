Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF8C44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 19:14:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8EE3E976A
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 21:14:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87D963E269F
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 21:14:02 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 07BE8600EA8
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 21:14:02 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1447832a91.1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784315640; x=1784920440; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lhoeL6umMy5qYdmjb00JwsypMj61lT32uL2iRi63NW8=;
 b=NRgexFV6dMbHSJ81E4qrtRu9E1U7oWBrcKo+K2rzHmmes65q2sy2SiZN5tkU+r2I4O
 7d8OA0FSL1f5Fw4m/YX63Kxf6l5Szo/qm+oVASaUOYK7A1by+/WhCqbpYZQzADlU0c8S
 bm1oDddoJNGFYTEe0446pRkbKxW5/qyqDQLM8qDmp8VtZvIoReRZO3oBRf2pli3c9Oam
 hXgg0NgyJKI1s6ewMeh65E1pGzuAhOnpHPr0JRxt1MWl0p7Z/w2Afo4iMTfStJrSdfzW
 A2ZLyH6G6uBvARUOAc6NWfDvpMBNflykXOMMlolSCZF7C4HZHwG5fttCvVM3BdUbJOSV
 HCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315640; x=1784920440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lhoeL6umMy5qYdmjb00JwsypMj61lT32uL2iRi63NW8=;
 b=d/YD4M604LScUvBsVO0j0lSnMzUH0OwBpDDnnqOdLc/GriYvPEuMdpC5vptt+cGiBR
 Okhi8pQWxbsD0d0D9Rt4navMdGBe/ArK1JBGyUrAaSPVz9cYRXrrEpykCgXmarfTDVYs
 opZaYHEvyPU8ebL5MdYw0zXHuuW8+qapesN479RRRcZXLVGvepzhAgdzlRrjRTtn7A+Q
 l503jHUNyMqnQh/+V2ZLgiEvKtJjHTKZ1IAYVQpejmRaKV5/vNWadxZlyez+JtdIEc2B
 ZhlS1w3XBnIJm4hIsHjH3zr0fe5dB4cYuTGBXAsiX4LsUnOJWyFV+4qtelI1be8uubj7
 5N+Q==
X-Gm-Message-State: AOJu0YyFxN5P+hAIszYSIJ8EDd4tSazOumBURWzKejgUinvVgoJ2NSqo
 JsLbKZl55UIno2JydgzT3H5B8Y0nuH/7H9q6ttSDELTDlDfTyqTaLAk3L17U5oSfofo=
X-Gm-Gg: AfdE7cmXEtfesz/WlnTJpbVNs+WEcYAfLtuam/b1qfBp8WIjOuQ1b2e3otqOpo5vOw1
 CeE52kXHnit235befjoCI/WX3WFao+AMIGqY4FxXwhjWHdwqWj4xxZUo+5Iw6LgJEaPlO2lS+kw
 9hOdvAZ3VDwR6K7u0/E98ohvppaDJOBZ4aDuSEzzmkq64jEaJj5tfVOfpILbehuC3KWTtg7Fivp
 Om6ug7/eFlIMhrYolXxR67irFA3RriJ+uE0s9vSTyQBImiuEKBkj3qCjdw2oFfVVWagb/iFS64Y
 pO1pMHE1uEmXcvFKqayAfn0okb5t55EE4bN34GVQ9dxj3YuiuuZG0Epb/PQVjDJ4EXNTXXenYWq
 hCk4cDTMu+gYi7FRPYrw53GgAWPunSV0Nul27rnxjlXkMp6/bs8ucp4RTrVCWBmjDWc6p25ncnY
 jJWlwXY1H309genvjYEqdB7RUpkKiWa7Xg+cQFsGjRdvtgSxUkp1L3A6Io2C8HVjpEUGQzR2qIH
 MpRutHVtGeL4s486w==
X-Received: by 2002:a17:90b:4a10:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-38e3d133ff8mr9058024a91.1.1784315640193; 
 Fri, 17 Jul 2026 12:14:00 -0700 (PDT)
Received: from
 runnervm3jd5f.oam1fn1hls4exoxezxwf5hchaf.dx.internal.cloudapp.net
 ([13.86.196.192]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11590250eec.6.2026.07.17.12.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:13:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Fri, 17 Jul 2026 19:13:58 +0000
Message-ID: <20260717191358.4170-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717180533.1203314-1-pavrampu@linux.ibm.com>
References: <20260717180533.1203314-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

On Fri, 17 Jul 2026 23:35:33 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

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
