Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D398C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6BE53E2E1E
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:29:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C9EB3E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:29:18 +0200 (CEST)
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6FCA1A00CAF
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:29:17 +0200 (CEST)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c95bd574471so267505a12.0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783672156; x=1784276956; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9zbhQGigeiO4jY3/0wb7/yIWiD3N1ECbnjsQsj1BlqU=;
 b=AZASnf3DI2Sy+vHZTi6om6z28fWp4oJzsEDen34q7Dv/SOF1OP0FCcC+CHA0LSM6nv
 BjsHg+YSe1Q0AcxWqTv3VP2/1xyOpmVbujyLTzWLyEwsoYpzM698ikEd9Mal1uGrHTBI
 8kAW/J+3B6Mlv6MXShOOl/oQJYOFML15kfkjjb2AGsmHN6K2pISWBMM54m+RwPQVwMpn
 wiHp94U+RIJR9c0ryK53NA7x+gbmYmH61N1zetPNaouIGMdftAP6RufMgnWE4pb8XTLS
 hBRIuh/9dE+OBrvbhoiooYzI1g1Qa51ZU331XnDONE5KuLHlv0QT3hXPDpUpxv6Kcr5M
 fUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672156; x=1784276956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9zbhQGigeiO4jY3/0wb7/yIWiD3N1ECbnjsQsj1BlqU=;
 b=Li0pOmRrLoBiqjZ9ECfW7scetKbbEFGss9UujRDpm4mEYXbBYTQM6q7+f45oNI4lhI
 9nfCZx4FovNi4u7tk3dyx1fE0yuDAhF18tfJil/pJXRjFaG5YepJkZ0KoXbQwZx6k1la
 eqdpEWvKiXR/czzJrXpMAreR+EmwHo5PcDg2oSTIVB8YpAR7wDz4ppuqLDgTnKgvxLfz
 EgAUeETScpyZKFKj+Dl4GRaIgr5ghAfoiTrX0OyoI+Qf5kkOG8sEsK0soyNbIJsGLJTE
 CWmR8kP4fD+HcID0esuPCb1cxKU+PXTO4k7yPIoj+CqC8Bue0yz1tJNJFpONDzu4eoYb
 0Ycw==
X-Gm-Message-State: AOJu0YypYf8PgCiaGZ9K0OFXD6RTHtWB4uNwynnzyasB0G0v6U76L2JN
 iVVr0T/X9UbeCL97egZt/L4slLPF6p39E+6G7Gg1GpmQNGKH2AKCmep/
X-Gm-Gg: AfdE7cnJQ0240qOrvXhQWByqPsliYzEJ5bjrGQFirc5ivSfdTtJUdJskhb+wZvNP2yd
 l7A/ttWHYXMgcXnKMh8nHAWO5BztfcU0P91goQTrY1HTz8c6dseWzDgRwe/rOQvh7ww+fNqMehF
 mZ0JIKi0+rl2dIAYJmXL4iAmkt2OktoPqx+Igd5cHFVBRfn6KDuJQ8IHeCg3en3/qnkFi/w4XF8
 iNxANckccXB/SbwlxRMnT4Q+xTKwJVdjcmoNxc1DiQtuHIuP3rBtjb34ek/AmBMXEGUH0TJKHsm
 8LExhAVg8aUZDJ8YhTqeJNQvgeXqhfOQYCvGaBuof3aAvPx9A9k23+s8NJWY1AhYNZDFh6miiKD
 TpoxRFidMXnQxEi1WRYNUT9zATX0KpX3IBtrKY+7tLOOWMs+wue51Xd4yyw0xuacA2sLv1XLnqQ
 vbfVbP38wtMMVm9KCWG0Pp3znSg92EW0+SmlO1/CHf89t59NsOri4Gm1rRl6aF7JcFu3mE4ZLbQ
 mJSMss6VTnL22BlfJYdtNxAyjsygw==
X-Received: by 2002:a05:6a20:c998:b0:3c0:9c19:b278 with SMTP id
 adf61e73a8af0-3c0bcc9d063mr12350693637.70.1783672155771; 
 Fri, 10 Jul 2026 01:29:15 -0700 (PDT)
Received: from
 runnervm5mmn9.jumomkzmldje5pabznlpr1ssie.dx.internal.cloudapp.net
 ([52.241.147.115]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm42011648c88.1.2026.07.10.01.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:29:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2026 08:29:13 +0000
Message-ID: <20260710082914.4110-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-2-pvorel@suse.cz>
References: <20260710055556.1109220-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Makefile: Skip test-metadata on cross compile
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

On Fri, 10 Jul 2026 07:55:49 +0200, Petr Vorel wrote:
> Makefile: Skip test-metadata on cross compile

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
