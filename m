Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF05C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 070133E9A19
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 18:41:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F33A23E22C2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:41:24 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A474410005B4
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:41:23 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51c0184f082so10489751cf.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783960882; x=1784565682; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAZQfUM5uShsP33d6HP0y6IzwbT0LyPBVM1nMbWih/4=;
 b=EX7GFaDOqZ1jaxM4DlNZld9mpYtROlW60rQ7XmmeJLU8lBwW3Zx+Xaaxvn2sbaK/86
 PQv/F9PQWa86DHKynuypgEKs3NFZvijGZnynRNtna7WnAGuLJMKeneVy/VVGcFH9eXRo
 4rVJWXkHW2U9zOq9Q+Lw6aoPpaMqmELpNB3Mh9dLtz38igCujwq411Y02qQgHxHWIwN4
 c4Fqjfg97Ll1RfIAB6fo6hVSOa3LwpFCec+6Tluvjx4f+hrhdzem+8vaeg4PzEELZIdI
 wWwPBqdlwRMbkXk8MxagYzWjqGpkoiWIVCKl/wA0v/0kkOM5COxSB2PZT5U1tPnGSMmO
 p4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783960882; x=1784565682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BAZQfUM5uShsP33d6HP0y6IzwbT0LyPBVM1nMbWih/4=;
 b=U28shDRVbK83D33REQ3IoWmpxg3hQzt3WRUkh3MfU/5jsJFSbCMt/H5x60UcT5i7Lc
 X2kz+69KWBJPO9TwcCmO8+JJW239Y9eFXo7P8N48m546tYo5TU1IqIRe4VkusEfQa3AR
 jm8AQuWW83OUHqihZVfFSTCHQdkjRRMlDfEIi6EC+yk2KEgCQ2Gl3SICK4bXRxAAFl0M
 TCmtP6An31VDearUCzBzmWVm+b7G6oZvniclym9qaNsTD2skeJz3BKJLPqtOZL5s2WAe
 dbQZxRvWZb8aX4T15YOQiBeXGdut0xMqBTw6TsrKV1Vlrmdcwl/7ws4Pvzwfx17fnrPF
 1EPw==
X-Gm-Message-State: AOJu0YxH9gUwPyzPqEYxAjiYUvTsL46w0LcMtPVPVNKFN4pwDKSjCXbJ
 okupe+V529byP+hXU5lyWURmoAT3B9hdHtVImPc8SDCfTeOt3v25L3YX
X-Gm-Gg: AfdE7cnon0DWrrHW1m2BfFwWOd9iGDkzRQyxFesZrynyPZTqCfdiXBMfaw23TwWQvXd
 oJAGPmGgx79Nqz9axu2AptNAkJOHjJ9FLtloKq2m3umdATpV3mS7rPdXZUd1cU2fgH2aWoTeLOy
 V4pYBLY/y24L8yB2hYzLFHNFPXhjXUCnenXNKNwDah+cGw+oDni5V49SL2W+2OKHr7zTCZVSj+P
 Wlgpkpz0MzEflkuAYvxGh3M0RRvPN/p/EjfoeWNIKnnjanA0ozm0LAL7r3YUm1dgsxdjDXH2x4B
 VD/xmAWYwftn/agrWOXfw+tKHkh5zmn0SPTMUtHqFfVEwc5Qr9FhVwSyINrFREmGWu73Y4VcgLY
 M/5lA0zl6+M11OsERwRAjO4fZ/+czifrqbeZWN6qwThodviUhaNslalKg6Zzb9fe+iq+7uvuxZX
 IbdNTew1HRSc39Viz9Z55nP2CbS/Mj8TL879BAVhsAwL183UFmTpvzFcghmVfG7sglWhRDeJQk3
 8+kqXBEea3EY1MNTVA/FiZGcA==
X-Received: by 2002:ac8:5fd0:0:b0:51c:7b13:62fd with SMTP id
 d75a77b69052e-51e3c39cf0dmr2221851cf.83.1783960882154; 
 Mon, 13 Jul 2026 09:41:22 -0700 (PDT)
Received: from
 runnervm5mmn9.s45qwjd1e1xuhpuiv1334zs2ob.bx.internal.cloudapp.net
 ([20.51.199.1]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caaf671e2sm84983571cf.25.2026.07.13.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:41:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Mon, 13 Jul 2026 16:41:21 +0000
Message-ID: <20260713164121.3969-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713160725.1158208-1-sbertram@redhat.com>
References: <20260713160725.1158208-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pipe13: Scale child reap window with LTP_TIMEOUT_MUL
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

Hi Stephen,

On Mon, 13 Jul 2026 12:07:20 -0400, Stephen Bertram wrote:
> pipe13: Scale child reap window with LTP_TIMEOUT_MUL

> The failure before would happen, when using 4 paralell workers

Typo: "paralell" should be "parallel".

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
