Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7639C4451B
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 17:16:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A48A33E931A
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 354173CE2E5
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 19:15:56 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F0EF01400E44
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 19:15:55 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-91d4455ff18so222922685a.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784308554; x=1784913354; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yE/3mUERWLiACqOMXrhjvrdMOlJ5hiJVQ1U8zEnxNJA=;
 b=MMhOU5lo3brosYOo7gf0GFYWvydK3g0kyQe6SbO5nJJtVkaWaixpE+lAa+8/M+oyhk
 RyS7nL9BWyXf6liYMsDM77q3TrXOZuj8KOAAuvFv6ZPydvXwe5x7IbJXWwMxqCAx0rUX
 wEwH1Ug2o/b84lu5nyUk4htR3lcdq4t9M41Ow/CoACj6mhXEMLTBqDJwQUICyr64m8qf
 kfYS+/xn3wLvAjZ8st86vRysNpyL1JhlKG1uh4hLn65HdLu54Ixl06w0qpFN0G8k/voJ
 iG6VaZSGAPHk8vchAv/I2KY9gtSNA3mV4RcPuRasDq8I1x+XswUPfYsf57fI1pMKgYH8
 KJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784308554; x=1784913354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yE/3mUERWLiACqOMXrhjvrdMOlJ5hiJVQ1U8zEnxNJA=;
 b=DY7BAwkp3VoFXsHFGd2hMMNvgX01l+mzJ4SCx0sFWvQuNRf20la5ChpOgW/Hkw1Dzi
 5v8dJPk1xELWmnHnJRnb/KKhBhPgW5WrqqCqtaSal10gEOgSyj1CubA9ospLBm+nGl/5
 Z0lVpUzj1tB0mnr+X6dukEqz78zA4mqFfvPOc/Q9XBXJmnXyT/lYkeKAbn3HRbgFzYmK
 2Z06WHqV9YLyVLX0X6q+oUHN8Au6Wp+Kh5ekncUBq8tsNTdpYBOC0X1m8XxWlGKOdl9n
 fEjzq0gwxSTLFKl3kkH7wrfCViLPRwGv+QoWuFxKMQ8hMhLiSjTyYF/SeKuOHyqwet+j
 Vk8A==
X-Gm-Message-State: AOJu0YwlFKPkYKqkz1f2ARkCz9qRO1QkDUhKMfSzRo9vh3ifpsq74qPo
 pbH7brH25Q3N0/YlaCjYDmwLhpsvqXSgvAG8xyYwYI6MAMLV0h3kGMPEEAzj0aOl
X-Gm-Gg: AfdE7cnVOFXJyBsHVB5927HATKYMKL60u6ddMG2BIgOK+03IHUzrE7W8BNKXQLngDVO
 x6FnT41zBLGtmhs1Wr3YdWnFnpoYJOou+l75+niQi7wRsqU0l9mcZezNJXaF3+mk3wvH5+AV2+u
 mJENkf5fQOWR3sSRVmVA+R6tIaeG0BnecBD+hBtJDuQVa8qsn7bGPt+ey6h5ReSfa8GMdxTi1ZB
 sGWI6y89zOBAwOaVfFU2/lzONQva0V/ne0O5oEe2Jm5TFA4gw2bBnWAy00udTshQFdKXlK5lQbK
 Su4dQDqFShneNZuq25WJor6SdcJHFcKi/EMrEj/x4ol1ZswD/9uxHto5IJbftTq+0xXEKmnpE6i
 E3yuYipfA9VTCCKECgs0oxP2R1P7kt2jwKkHtP6wFKcdJeetK4J5ia5o+aHzWyVyKKzCf7cpTxi
 NGPdwtH40y8YOIZT0CAnw/L0DYELraajGkCTGwOc1mIlSzeokc6AIqJ6EIqLM13Gt1e5dnqPVM2
 eu12bPj82ky2nLV
X-Received: by 2002:a05:620a:371c:b0:92b:6805:9197 with SMTP id
 af79cd13be357-930b434913fmr375155785a.63.1784308554578; 
 Fri, 17 Jul 2026 10:15:54 -0700 (PDT)
Received: from
 runnervm3jd5f.iyv1fjjag1ruvfzpcleciafe0c.cx.internal.cloudapp.net
 ([74.249.78.34]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b5300432sm202757185a.17.2026.07.17.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 10:15:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Fri, 17 Jul 2026 17:15:53 +0000
Message-ID: <20260717171553.4066-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717153131.1154339-1-pavrampu@linux.ibm.com>
References: <20260717153131.1154339-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap35: migrate libhugetlbfs test
 truncate_reserve_wraparound.c
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

On Fri, 17 Jul 2026 21:01:31 +0530, Pavithra wrote:
> hugemmap/hugemmap35: migrate libhugetlbfs test truncate_reserve_wraparound.c

The subject names test number 35, but the patch adds hugemmap38:

> +hugemmap38 hugemmap38

> +/hugetlb/hugemmap/hugemmap38

> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c

Should the subject read "hugemmap/hugemmap38: ..."?

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
