Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D0DC79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:48:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 451773E4D7E
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:48:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EF2A3C708E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:48:35 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E82260094C
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:48:33 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-398b9f722abso1431854a91.0
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788850112; x=1789454912; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5lEp+R0BvfBdrwMRGKyngXKR90IcEfRhaysKKBNfrCI=;
 b=E4VMFY/wmPMcuHvIJiATY6s9nOXWmHTVlQxHlneQjIRs8o8yCd03NeIauVGzgKQXi2
 j60zU0QxqJUItvhDTPLIrtGjnh3z4VhQjk/KBkMBdvC0y1UBDmVBSHFd01yrdG3A4Amj
 MVewyyadnvVwQ/Psc9ErwbdHicY71xaFhNzDJvi9Ep05xLmIcakToj1t/PGGyyVx5b8D
 MeWM3PfXvOC2otx0ftPZnH8gCk1WnB69wqWJds6TXyH6AKa6Hk8EM+gDjyI89ncqizJ1
 cZ214SbafRg7jOFJ65ItYhX9zkBRxMMyTAtvtM9diTaZJsEydc7L9ru2f8iO6ek2jFgx
 1r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788850112; x=1789454912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5lEp+R0BvfBdrwMRGKyngXKR90IcEfRhaysKKBNfrCI=;
 b=F3CJNbd1LnU1rGBZjq4qJhvCAciol+cjXLWbd/HI4l95aSTuvv8Ov9sy7Te/mWumvm
 aFvQL9AEWbLmYHan9UWxexRGHHfoMR+A9OJ7AgR7JiGhk7FYytBCQN/0YvR64eS9EPAY
 /RvWi2I8zApZ0a00VdmdMQNp3p8TKvpPK30lmjLA+oS0m0T8s42W/WVir0eUtDzVrchQ
 z7QWg4ObXrj+ShnDwUc5GwreAKrmo2oVcZ7mEYcHjMU0y3J4ayTpdbcM29diGKM6CGTw
 5NqgadU6o2vH42fsZnopv6e6wIFM1J8iIgCeRBAdN6mtS+o5ULNdnsgdzQAcBEq4ghlM
 FQKw==
X-Gm-Message-State: AFuF++me1uRHjCy7rB5XKViOx/3vwEAv6O27vBfx3IIb9a3JBsmb+2mP
 gAZ6RbSN9Z0d1u+pqDh+E69S4QQwKNOrwXIgTGJmsF9LPj92BNka+91i
X-Gm-Gg: AYBFou2FUULPAVjPuuJ7l73r09sHSjBcczKLl/Q9DD5pv4kb9a2gHGIB9D0hI1sXqnS
 XMXinJ0xVoS0J5+YusHlOpl760D1Up5i+9aeYSAuIrsPvVEBrTZW6hnAWwFQj+A2Qh0lZhCS7n3
 akoaBXal5zKguBNbIS0jip60oOPcQz2gJ10e/rD+GsymJsJaGvWquYv+BsAx4mPwufENPnhFboi
 oplKlbvSEbw2F+1jSQo7e69RDY2kG6rqsgFPSB81w2B373FaxQ7ZxXCHBKhtHuoj/ormyqVqIvk
 LdlKVoxaNcDQ5u+kAn0r1CAMUhMv9atX9nLQXpEp7IR6+NRy2yWCoeRnT/K0RFqcnLMAoV4JNGn
 oOgzQTDUxpqrUi29hS3x1zmZri7DjdCGwSZiwVI06uJ+rcoTlVzHIGcxEhFxjXnk5MYIU/sns+j
 JkjNGs4Fvmk9LV1kozoAMQqoCDqbUr5j3z7mPcf9HBtJtom0TTOT8zOJqIFINBF9ZATriRN0/4j
 W5fr9dZFjxNcWTv+JP/H8CXAsG6n87O24TB+K0daGk/zOj+WUCqMuw5KYKVE2IotSFv9CgzUzbO
 HA==
X-Received: by 2002:a17:90b:580e:b0:398:c3c9:d0ae with SMTP id
 98e67ed59e1d1-39b25ee242bmr38688550a91.0.1788850111603; 
 Mon, 07 Sep 2026 23:48:31 -0700 (PDT)
Received: from
 runnervmejwal.arl50whhzdvufbrwthcsjsqx2d.dx.internal.cloudapp.net
 ([52.159.229.54]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1434bb7d71fsm3103771c88.15.2026.09.07.23.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 23:48:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  8 Sep 2026 06:48:29 +0000
Message-ID: <20260908064829.9168-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-coredump-v8-1-591f96004543@suse.com>
References: <20260908-coredump-v8-1-591f96004543@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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

Hi Andrea,

On Sep 8, 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

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
