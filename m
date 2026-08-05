Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6802C56201
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 10:39:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BEE83E2BC9
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 12:39:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A868B3D00A7
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 12:39:36 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F07710007E3
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 12:39:36 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2cf02ecb572so8937725ad.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785926374; x=1786531174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9+NXNsI4h12Ehsg3liJGarJi0WTnsaci6aRLrjuUEcc=;
 b=lMCA2I6ZBni58326ltqo0qdmaHUX7sS2259V0kwDAQMTBLXuaa7eDL6u6caK30XaX9
 x9vX0/7AQG2JIbeHeXjJEAECfKSgvXT7+HPBPgF7XzbMWLAFhtrYZJTHD7uE0VKKjRQq
 HSlI7Q8Xo8M9BuXsFWsMp8IEk2YQ2Iw2HM0pz++NFofFi4wE0Up0K5Z/QwTOZNWztWVb
 EnKm/YW4t8fHQGBQR0bhfEWTAy4hBUEZQMwLXk0LXbUjLCG2r4w8VqhEOeQ8pWq13nH+
 XXM9jr8OWWtcvoBvvWYHRc6/xdUfzBrP2DRhfMB6A/X9H09XBvY0PnLz2tFzNeyFRk20
 vmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785926374; x=1786531174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9+NXNsI4h12Ehsg3liJGarJi0WTnsaci6aRLrjuUEcc=;
 b=YnVWHaBKMRbfih54e5ownSWgOT7/gtu1nyilmO2N78j6EUQV1nY6MsALaT2o1eiVB4
 BJ7XIw0PM9gHGbDFGS81qaonS02S5y8Q4kkA5KHuM+M9dzeQ3RrcjPy6/MO8OffQubaZ
 +2S2eIJGcnTwpSc5wHFohdN8111V2ZeJCQdNyiQgl5sEdY4JK6neabcv/FwmT+ufZzlB
 Ic91NMrkOqz3TX+9BU8Qny7o+EbibrKnfSbDdeMat6VWXLTv7LBbtxOb6Uj7CmILlYLC
 gvsRnz4b9hh8dPHTlqIFmphjpfilscWUa8HtG70c2/0NhjvUExypEmjv1/zk5YLoKROM
 JoDQ==
X-Gm-Message-State: AOJu0YzTaoINdtapkOppl+JwCG300HMQZJgSF6EyfxEL+4Yc88nSi6hK
 IGYajCdbkwcfqNEf86SS8WhyyxEJgnzu/kQvtn2LkPRbGxtiqnfTqpvG7rM3Yar9RX0=
X-Gm-Gg: AR+sD10JySmxhMrv8z7jXeIOyr75cB2eX0twgGvb/6Pmt2D2+75B0YOD+FrEXfg5VbE
 TSdgoslGsCAIOIiREOFj3mRUzvfan9ndq3naR2XJhgsmiQeAb6J4dDysNygRNmtG9Cxx1Vwi8d/
 DEXdgItDrKz/g8Q0ZfrhzJDLlwRp3WxqCUNvgVwBBhPelan7irfRe7Zy48uPLTFX3cdUh0RUIzF
 ZZkVn5HjIqxZAQ6zyUofnzaeYadGMb3KB6PE8xLBGbRq4ms96JZwm6QrWUrD/8hEmeCqAyIsRV5
 37QLf3coYdB9A07gycojphcAwcReMPj8vqiW/Uxkosv6cnFgn/54ar4X8CH1TAvVmPX2Nj8VYM7
 ZQEUpqX6mRkvj1dtDWtyKYNziKBn5y+jv3vJviCW2BCuXMIwnuLUZMib4xIcsmIIkzVBsrFyylf
 WxTH41bPDDIWwc/zNnqfrrZX0zj/ePQFCB1F4JBGcbMcSZCg+Qo0vQU+0DClkHwb/VzUpFNDyJm
 mc8DVYtSPxARONKC55xVyCfCpkGyP34g4Gi0JF1f7sHNd04nz9INPPjVPQKlU84DyIUBtkUBRTY
 Kg==
X-Received: by 2002:a05:6a20:7fa8:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3cb85ded9c0mr6238620637.5.1785926374469; 
 Wed, 05 Aug 2026 03:39:34 -0700 (PDT)
Received: from
 runnervmvrwv9.h4hp2ch4jnienhhu2usyohcrub.phxx.internal.cloudapp.net
 ([57.154.3.251]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm16374711eec.7.2026.08.05.03.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 03:39:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Aug 2026 10:39:33 +0000
Message-ID: <20260805103933.16659-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805094935.448896-2-pvorel@suse.cz>
References: <20260805094935.448896-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
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

Hi Petr,

On Aug 5, 2026, Petr Vorel wrote:
> [PATCH 1/4] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3

--- [PATCH 2/4] ---

> +# linuxdoc 20260504 is too verbose by default

Could this change be folded into patch 3? At this point the requirements
still pin linuxdoc 20240924, so the comment names a version that is not
present in this commit, and the commit message explicitly depends on the
following patch.

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
