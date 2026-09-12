Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF72C79FB6
	for <ltp@archiver.kernel.org>; Sat, 12 Sep 2026 11:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84AB83E6CD9
	for <ltp@archiver.kernel.org>; Sat, 12 Sep 2026 13:44:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B4E53C5493
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 13:43:52 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EAA42003AF
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 13:43:52 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d72ff13so655298b6e.0
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789213431; x=1789818231; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+x0hudqTwLTcAQDWwjAknDNVE8G0OV2pOH2mhF763Q=;
 b=mJfPfTdMPffJHlvkV2FcJKe0Vg6yv/nsIUSS7gfBnqgefaDAmlZThdyhPggntqdo16
 APpIv2wIjMNZyiG0hXWUZ0RHyo24EG8o6yXZgU/zbgD+blwX7HfiW6V4ZvjjMdA9XfBV
 my/U0prNkupYNQgsV4t2urWax91gxuc0fHakzSAf77Al6TCa3GpvsOMLFhEvEx2CiScF
 /o/9P0DhJH1ZMMtfeTseGJ6dFx0924rUdJ9z73SfrYCP605QAMtAV7rdqpR+irOB08MG
 7dU9l3oGOgnQjMxfjJN44jqSjKD8bhB4Q2sbg4MyA5SSiUk/jhkqd+IupDstOgTuJoRH
 1wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789213431; x=1789818231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x+x0hudqTwLTcAQDWwjAknDNVE8G0OV2pOH2mhF763Q=;
 b=ErsK1Moa1SqHPc6hD2BaH6mfMdw3Y/T19hnpOQV2+sHv7VZTSsmfguRYssidm9YGnd
 XoKafu6LPgv7aZjUMOofDfk+Mgt9dRmUgHbaklI1bwu33fESUEJF7XE/PhVBj0aeSt0M
 AwaWhPTLxH4Os8Fd84M+/CeFCAV+HiZUsuvSxg8VhqJx82UNA1vllfI6NanEoQXJtMld
 yyM0K66gG55dVHqaST/cUWcQPJME6irnLye1kTa2+dvDEwsN64Wjnpg5NkyikwU+iS6C
 D6+QqJk1jE1w0QEJX6nI0Nme92yPDgw0zuI4SdZOa/Mv2E9CUaOBLFsXcLv0qR47IXCQ
 17xQ==
X-Gm-Message-State: AFuF++lsCc/sfBrXwsNYgQxWnz5eD/kvt8M3v9qh4a+CfBofkzBLdr8J
 UzzOtfAYZ4C+ziQAvTG8szZdwC6KD7sAmGYQQUr7lUOO7KUSMX+FO+ms
X-Gm-Gg: AYBFou0I/lcKJHZpehL5AtofN1L1J9d5JQ7FjBnDUEQ7C+XXk9cm1RxQg2BlrTg9LGb
 fXfrVcWjrPrkSgiQWqynT1HeLJyDxeToeGYwFLdesDpL5RjDY3myMFOoR8KlsDwB2jnQvisMyWb
 SRsphAkptYEv2wl953BmcI0t8jJMaOnF2pLlFsn/ZMtu92i+XofuSnNKQ4e04kpHArwrMx1G73b
 DiiroUVWO4eemDoRgPjoW9Lnz/KOXzBT62K2HzQWc8LGQTEsrPFQFMmyS1RAGJ9wBUBAGZh79Pn
 35sj/52JV1s7oSCvh2yR+E5TSp+gRfkZrziRrICP0Z0hT4ZUu9iEdbYs6cFmGWsBzsdMpvyOnfY
 n05if3KTkJwaDstqbrrwcYpzie2w/ee+JMZg5BsJKxPiNIZaRqJthRo2mF2vkPs8tfT8XoDcTnt
 DDAS2jkh+iQQR5sz9zqR0ziwSLHc2M86Jzih5uC+P7+SxIimu4Inn8hO3tyduyr+Bq+zWyRprjY
 oG4JOgGgFSESjf7553Iryh3R+Mp+GlZrGik0PSR2CEBJDj/11EC3nkl42+fvOovYP6KsPcjfIeU
 zsdrEZrLHg==
X-Received: by 2002:a05:6808:50a5:b0:4b9:e65b:8c36 with SMTP id
 5614622812f47-4c31c72c208mr7308684b6e.36.1789213431101; 
 Sat, 12 Sep 2026 04:43:51 -0700 (PDT)
Received: from
 runnervmlun5p.d2zfokrtz4tetnlfa0ddzqpawd.gx.internal.cloudapp.net
 ([20.29.31.195]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32bde3858sm4666848b6e.0.2026.09.12.04.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 04:43:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat, 12 Sep 2026 11:43:49 +0000
Message-ID: <20260912114349.9109-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912082235.2164616-1-pavrampu@linux.ibm.com>
References: <20260912082235.2164616-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

On Sat Sep 12 13:52:35 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

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
