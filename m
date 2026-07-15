Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA82C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 10:56:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1C9C3E5697
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:56:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87BA3E1E71
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:55:54 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5D09760086A
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:55:54 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-51bfa429aa6so2842341cf.0
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784112953; x=1784717753; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+U5bovjkLnzOQuXBUZE8ZmqVM4ENT8WDvC2vlecWb7U=;
 b=X/RU/0/aT76Ja94OauqHHWyBz6yZS2CGFkrzvy8fQh5Q6c1fTMyDXI17ptutf1+XaK
 vYJGeROWFV5Nv4tfYVLqOMsJyrVD7/QZs14RL0X2+dZVAruiXHsIJdY5xqQXVNPODktN
 GedRmZgo0SwMEeMAzmjZEvZusVc19WHCYDalgi9gpYktYJexKOhLOJI1Ei/ragnE47xQ
 o29xMirOUy0A1uwcmlMeVa3gXmLb9Eqvk8NMeM7q18WolN6kfDZQreCmF+QGhwJ+CN5/
 7pqiM0RxPqQwrx8kl1HbakITbPpuGvICwXpT1lNC+h21CNTSncCyylp+EO0t04MODDYR
 sduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112953; x=1784717753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+U5bovjkLnzOQuXBUZE8ZmqVM4ENT8WDvC2vlecWb7U=;
 b=sq14+anFk/C1inHY6AULBm9ykHPiQoEUTk6uT4DhNrwI268Uj6zGG1kAOdtG6Tcb+b
 rLhaHox4AtjJK7dxtUsUGKtOIFQN1EwjxRv+XB/kUxol3pU5LgAyUTCbN5Jh2UCo4Ove
 GxxAbCl9T7A7eOOQ77nXTT4OgHTMWhsjMr+gtw04MFMx3f1WMbe/uiB7YALjWH5oXzyn
 ubOVdHyAUQdwm7SQuu/STkkUI+yewzkNJvWl1zhnLGyV2G6xyfZ/0YQNEX38fGu2V2a0
 h660dKzt+njPcAeKp0fT1Gbed8xnJKVhdofyH5kC87f5SHuppn8acewSNQnLIJ3oyjbZ
 6oUw==
X-Gm-Message-State: AOJu0YzlpyQrQ18kPqB2OTEgVSd+0kh7TDV6tqvMKf4Wwj8L/rfRSmPT
 LmDs1Uri8yI1enIv9tbypPvQpwFhGgJ9+LznSQzp4+sW3yhMEIqgrL0a
X-Gm-Gg: AfdE7ckYJLqTaJESz+bRo/v9UOvFAmwMPsOxgARUUQavIGJ9J7nPnNVshmAoBe5BTs/
 d50dQXZuVga1IAYSvWkL/GbancYThB5ALXw2lLqlgGEU/BpSu6R81wCZdH0ZvSbIrp2XapRR33X
 sHnVrvRxHn4Uy3pSKuJzzon1n1BjlU352vP1tRn42Tw4tlPYaKC0ojytXImjdN5D692kmtWLy5U
 wYa37T0LNznZTlRrZhEi21sLpG/9SzV4QGPMocg6VMovGdc8sAyq3JuvzC6mTjAhUi0ckS4rLd+
 NWiSBOzE5KOBBl+0pBuiZxVrK6LKW/oKccWxlL4UdDGE3J7wEuc4q3aX15L7Ohw+bHrhc6ToIzn
 lVTzxuuS+YFUJNu0KmVSt0jEhqlmohGKVnAojFz5/vU6t5wYmBt1efJJgi0ItRevbaozCBeBmZt
 OF0CERbRlkrd7YMLO1/NJnnYXn8MmkwF98J+TR0/A6h93o/lJLZFsU08Yl6zK3ZmbU9FpPcd6kJ
 NfV55mLZCmjV3zidfvqex+s+7OD1wkq6As5mt8=
X-Received: by 2002:ac8:7f92:0:b0:51b:feb2:3827 with SMTP id
 d75a77b69052e-51caa1702a5mr207160701cf.32.1784112953086; 
 Wed, 15 Jul 2026 03:55:53 -0700 (PDT)
Received: from
 runnervm5mmn9.vabwialry0veddbuxkn1euc0sb.bx.internal.cloudapp.net
 ([20.62.207.245]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4b78sm190921676d6.18.2026.07.15.03.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:55:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tomas Dzik <tdzik@redhat.com>
Date: Wed, 15 Jul 2026 10:55:51 +0000
Message-ID: <20260715105552.4081-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <158dabe0ae0768b71da55574ab6fdcbb06dff898.1784103831.git.tdzik@redhat.com>
References: <158dabe0ae0768b71da55574ab6fdcbb06dff898.1784103831.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/Lite test float_trigo core dumps due to free():
 invalid pointer
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

Hi Tomas,

On Wed, 15 Jul 2026, Tomas Dzik wrote:
> LTP/Lite test float_trigo core dumps due to free(): invalid pointer

--- [PATCH 1/3] ---

> Function read_file() does not initialize *data on failure paths
> (for example if malloc() fails) and caller ens up calling SAFE_FREE()
> on an uninitialized pointer.

Typo: "caller ens up" should be "caller ends up".

> +	/*
> +	 * If read_file() fails for whatever reason, these pointers might
> +	 * stay uninitialized. Initialize them to NULL, because SAFE_FREE()
> +	 * can handle it.
> +	 */
> +
> +	double *din = NULL, *dex = NULL, *dex2 = NULL;

There is a blank line between the comment and the declaration it
describes. A block comment that annotates the immediately following
statement should have no empty line between them.

--- [PATCH 2/3] ---

> Because it was contributing factor to observed core dump I am adding
> these checks to make debugging failures easier.

Grammar: "it was contributing factor" should be "it was a contributing
factor".

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
