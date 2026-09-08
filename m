Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B6DC79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 18:26:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC843E94B1
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 20:26:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3FA93E94A2
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 20:26:33 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 231AE602267
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 20:26:33 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso16784475ad.1
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891991; x=1789496791; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HgNzBTs739MAZhYzmWI8k4tFoUgCtbGGWWhs7POKGPw=;
 b=sB/REhlRlQjj89DMmkd7txUu0IIei2FtQH9mYkjjjr9goLL4AKC+9eZM/tHvU7nKtR
 MDMfbPXNcKlUBvHBQ+1X+tQ20NXryDcHV1PpIaYPCVzzh85glZhP6OU85MIPhC+5oFPd
 V0Kof1ha0SpI7HTd9gZ5Y8F8G4KL0v5wBN8qljhFxiiE70uXffuY4OG/V+9GU9MX5qu+
 xNE8yAPmMTrwrZSkfVtZoiYip8K5eyi9QiAystk6RZCyNL0iJvCC6ZCQ2HPtNE1XDEYI
 lU/k0rBigjBa/F0MoL25os+SgnYXOciScL11F6hYbL90Jc4GCqrcRIpMTYZQiWJvinhS
 uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891991; x=1789496791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HgNzBTs739MAZhYzmWI8k4tFoUgCtbGGWWhs7POKGPw=;
 b=aysAnoIv7yYXVyyFcRvfOp+5N2fOM977WFuaxBzB4ZE9O5iDA6ZKE5YXBJpOnz+KTs
 gFhplOhtN4qmpnxfpTPu+KflVg8vrks8OwCDIhmdSs6hdh0EmjfCg+bb6dmEKO4sRfyn
 fevzAlBUcdK39pMWRIanBct/4V6tzuK0AMf/k2WUPJ52AB5ztyiC6AsyDagLpoP/g9JZ
 7RVdpCjjqDCB22gsfDYI2tc5bTYjcrGxwEozgA8AVm7hmPd2LnCl48qEeI2JJz0mS6vm
 Ad0QVlSovIpNc6+PhlS+AL44bLj5Ojyf+5MyvhkhxxV43vkSAfcooFZ3gWUH777v+BuS
 n6Uw==
X-Gm-Message-State: AFuF++lqIbptNTVddhWOx/FDYhrwtZyugaVNQPEN2LJ80bW6bSsNBJ4w
 32BIPOgoDAsSaX1nvmwbLOLb689unkUKRVAnL5DBuc4cutcg0iZcF47WiB1bIPN5
X-Gm-Gg: AYBFou3AprmFpayf1Jft+nCBzHEmgifJ9F62nNpE62WT0eiTIDzvN/VP/IRHI4l6dX+
 k3xhleBjSaRWzMeF5towGIrmwU33Y8A0qWPqWjnHJuQI2L0A8s4M1KxntxvjSW9GzPfEi8R6xAb
 +PVUo8NB3I0iXCzBOkGBZjPCzWI1xJP+bb648dl/vyeK/hNRAMi/Bv+WZ26hHplH48nC4FBMadu
 xnoW8OUbio1EaLS3fy03+x99/siUciwbs/Wlo4lyMxEOZdd7d7zOTunQl4a+Z9+Z8cWfvPL1Y+S
 qSJesxPaJHvI0EAT3YSS3GLdkDyE6FA3rh20lRnM0mV8MyDn9Gau1I9wI66oPR5VTz2eJPwydcW
 Vug8AF/3GNwomRjJbpjNjF+GupjFTJq/9+QcCVREYqKaNF+uRuRzFueaAfIpPW4aXDHtGuKyVyX
 6tYX+V0Qtoa27pp42k+DwbjP/0UQhxIUE/t3jLUkVdxt5cJo9FQQlPhrgYGrgSIWjIqnsHWkCGI
 vhbOxGxI8F4k1bgMpB6sTta548lnQqTTUgnj+TLbfVoG/TYNFowqSyIGQQqD7A65ywz1q7X/gO6
X-Received: by 2002:a05:6a21:4014:b0:3c4:3767:adb2 with SMTP id
 adf61e73a8af0-3da39b71be4mr51274078637.1.1788891991339; 
 Tue, 08 Sep 2026 11:26:31 -0700 (PDT)
Received: from
 runnervmlun5p.kzjvvldx0noebl1foq1lmjshzg.phxx.internal.cloudapp.net
 ([57.154.4.168]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b314cfcsm37954385eec.19.2026.09.08.11.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:26:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue,  8 Sep 2026 18:26:29 +0000
Message-ID: <20260908182629.3920-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908165430.251897-2-japo@linux.ibm.com>
References: <20260908165430.251897-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: group runtime state and skip when /proc/self/mem
 writes are blocked
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

Hi Jan,

On Tue Sep 8 18:54:28 2026 +0200, Jan Polensky <japo@linux.ibm.com> wrote:
> thp04: group runtime state and skip when /proc/self/mem writes are blocked

--- [PATCH 3/3] ---

> +	for (i = 0; i < TEST_ITERATIONS; i++) {
> +		if (*shared->test_ptr != shared->expected_val) {
> +			tst_res(TFAIL,
> +				"Iteration %d: expected 0x%x, got 0x%x",
> +				i, shared->expected_val, *shared->test_ptr);
> +			exit(1);
> +		}
> +
> +		if (i < TEST_ITERATIONS - 1)
> +			raise(SIGSTOP);
> +	}

The condition i < TEST_ITERATIONS - 1 prevents the tracee from stopping on
the last iteration, causing it to exit immediately. The parent's waitpid
sees WIFEXITED and aborts with tst_brk(TBROK). Call raise(SIGSTOP)
unconditionally on all iterations.

> +static void run(void)
> +{
> +	char path[64];

Do not use a custom buffer size for filesystem paths. Use PATH_MAX from
<limits.h>.

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
