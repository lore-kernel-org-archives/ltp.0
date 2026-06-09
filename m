Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5073ECD8C85
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 08:03:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B4C13E4E71
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:03:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70F4E3E2B39
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:02:56 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1379414013B2
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:02:56 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ccda0ac4fcso53441006d6.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780992175; x=1781596975; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxwjbhzdwAhLoNv+J9GWdx4xGfH4j7yjgQO3aNrl0gw=;
 b=d3K70SO6KejP4yCAhnjSIHP4W5mkcKbM2AbnAnMI6YIfZ3gKXgCILszLbxwMhOxRp+
 bnvfyzIwCfivvp71fovLTdr+xcinAdpHfMEgydc5VO7EHAbLbwJiIS/HDTwms2TWDUNu
 z2sHCEX69tC3PhjkRySgxYgydybk5u1f9P+k7IIHFXtWC5DpAo/y4ryrboE+9gtibILQ
 WM1V1BhHDKb1CRPfk4Zi1wuxJ8xI38gQo8fWJQUMSBFWmCLhBW+e009e7o8WsQX6JY2n
 fv9X+EiW4qQ1zxUS1Yv6uz6nXwB6ds63Q/DpQe9dQFgT9tXkobsCBG2ZVBUAgSH2mQuG
 0Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780992175; x=1781596975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fxwjbhzdwAhLoNv+J9GWdx4xGfH4j7yjgQO3aNrl0gw=;
 b=X2FHEAEanWolamotdmoAiYkUgnOXQKYhv2/W8fA0e68q+VD6vOJuokltf5AicbrnRp
 ZQ11xNkF/EHX6q2hSzq2uQSBS60oOoFlWX5yVgclpXMByW13+pfrQvZCZ6J07k1PUimY
 y2vzcxR2wvz0qXMewsPlLgKcf5NZEX6tIAyW/4iR8Nh4Mcf4JKEFN589JhOywMSx3pPn
 4l5wHaOVKkbCUUWYbh9f8iS0cCVxGcxG64StZxTXKFx78ADWwnPBpc8S/4EMAAav+uiE
 A2hiXdunrbdQlAVdQ6eLlbMLT2u5l6iZFSRG0TGlwADw5HD8ZztuGMByZZ/yilgFFPe9
 hZ9w==
X-Gm-Message-State: AOJu0Yxr0rz+zhMKnP2VX5QMJO6ZWNSrfx7DgPrDl/v7jaPnQb6D82FB
 ibHv/gaHPBTDi4oXmJ0Wiw06B/cICLwQ6UxysVgALkKh/0gu4D5Akumo1/EXlIBc
X-Gm-Gg: Acq92OFlys7Ivs+lDJlc8K2pPkFhI/icfiBBQUy65A5VXbLXPDvQf3+j/2D7oSI7zMs
 CWntT+qwoyoiNL1h1Y/vP33PZ2vhwHDc7uU/mvP6oEOFCn8kcPBI0o6bBeu2Da4DKDTwXfYdQZl
 9glomUKY6KjY/KgQciXh9+kcpLLEJ+NEr4WNeHVwgdYOyh2CX/kDHkOM0c1YQOhk/vQocs0Flj7
 1al/RyRHSdW+Nre/4FNDrCWM16QoZJ9eYSmwW50nxBaou5H5E8qkBTxMfgzu7WKQf5GE2XnfpYW
 aX89ftjKuiGbbU4paqFz+xbJYaSvaOKTVJOy/7Cju0Fnb6mtK5J2WRwG0CqxyK0C1VjX8xXhi8M
 VfF48zedIyTEgI5kUwGdKMreVIzol4MQSAAdDDQZYv0fErcc/4jIDal2mqgkrOZsfB4lTJ3zbdg
 UD5QPqeiNahRwbRM/E+t6ft1CrM2tz5nFgLZiJTLnccXrggB1h4P/LLvrb93tWTzrRC4sye2nKJ
 Pmp5GATeMszALACQT6AbTgJNnrWpuVx078iv8lC1q6XQtOA4g==
X-Received: by 2002:ad4:5947:0:b0:8cc:f72d:6a5 with SMTP id
 6a1803df08f44-8cf1dc0a68cmr20934946d6.36.1780992174676; 
 Tue, 09 Jun 2026 01:02:54 -0700 (PDT)
Received: from
 runnervm3jyl0.ywgp2imo21luxe0qdw54wwlgfe.cx.internal.cloudapp.net
 ([20.161.68.243]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb5e92sm195920506d6.11.2026.06.09.01.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:02:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue,  9 Jun 2026 08:02:53 +0000
Message-ID: <20260609080253.4025-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524154221.2064-1-always.starving0@gmail.com>
References: <20260524154221.2064-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

On Mon, May 25, 2026, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

> +static void verify_cpuidle(unsigned int i)
> +{
> +	int fd;
> +	char path[PATH_MAX];
> +	char buf[32];
> +
> +	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
> +
> +	fd = SAFE_OPEN(path, O_RDONLY);
> +
> +	SAFE_READ(0, fd, buf, sizeof(buf));
> +	SAFE_CLOSE(fd);

If SAFE_READ() triggers tst_brk(), execution jumps to cleanup but
there is no cleanup registered, so fd is never closed.

The LTP convention is to track file descriptors in a static variable
initialized to -1 and close them in a .cleanup handler:

  static int fd = -1;

  static void verify_cpuidle(unsigned int i)
  {
          ...
          fd = SAFE_OPEN(path, O_RDONLY);
          SAFE_READ(0, fd, buf, sizeof(buf));
          SAFE_CLOSE(fd);

          tst_res(TPASS, "%s read successfully", path);
  }

  static void cleanup(void)
  {
          if (fd != -1)
                  SAFE_CLOSE(fd);
  }

  static struct tst_test test = {
          .setup = setup,
          .cleanup = cleanup,
          ...
  };

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
