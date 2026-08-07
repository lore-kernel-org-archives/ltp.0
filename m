Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E568C2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 20:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46BA83E6FFC
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 22:43:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D43063E2649
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 22:42:56 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D4C5200B8A
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 22:42:56 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca7a25cd87dso3080651a12.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786135374; x=1786740174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UtjLG3h1RSXsWWxdbUX/D6RkotPbmso0gA7NO6toJP8=;
 b=MgNDt/yz/YhwxwAsPpLZtjRPbUyE96a0xIsggs2TIkqwlh5SZ3vXk8mkerNvRgrKVl
 2Nnb69RBNQ4UyajveOoABl6eMxgG5KDOxNpxhgNw8PdsP+mxtqjGCdGWDVMOfKbk7d8n
 ShWF5fLUBP3NZ+lKOeKNXlbW1hhWBsCe7SeErK1h7Io4icK1+jr5vm9u8IGSKv7a/4d0
 pmVugXJzfpXkxLara0TJzI9aSV+MlxnqnCJLuoAd6eVEyyMwQFuqr6+ZZiLAObdAdLOX
 1Lc/WzEs2qmHkgLzpK8iLp8U3MQ1aUiDuQnHu3PUndlgr/y4FmehLobgSXnrKJwUFQR8
 7Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135374; x=1786740174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UtjLG3h1RSXsWWxdbUX/D6RkotPbmso0gA7NO6toJP8=;
 b=Zoh7S2bEbR42FkIXxsYOMhv/1ST7K+yO1nKd2Jes55+/gFUX4Az9hyusW6MsPADffj
 s0M5D0auzgK1nV7NtQ4b1pY8bFnQXwoanVop6nDzTFWJN5mrCAmH7svDFGCKkwJ5ZH9A
 56QoXKnZOhztPHkuZDlV0Wnj3pusJP+QI3cvyuSFksbZ6BuDTQIldAnLUua7dU0xAKbn
 5fJtCc//+lCdOVQEs1V2XJY6arBz/MwC/m7L6zKBDpZcU8U92l4hhlKj53dO6Bm0afKe
 elxe2an0se4SLK55+W87JAQN02TgqwkSRbGKnCFgJlneXvyfCw5Lh0aAK3L0NcW07CXt
 scjw==
X-Gm-Message-State: AOJu0YycpS4IKi69ErV/DFhKPBYuChwGxn6gKCx3qcf4Yk4j2p+p/vQB
 DfDAGhVX0TcxKV69edWNe/TUV0/7dwJqFNMHeSbhcy4szux9AqIcwXfW
X-Gm-Gg: AR+sD12FZqKowYw7/EgGPv2i6NWnW0yJwzxQyLfzRxXkGvmwDSyYJ1hRYoch+5B6Nbn
 +Fl2FwlCif/iGlPsiFo00zRaHoxFPgaMyvbAyGL31br1TTeuRmpfYRf5kQBaDMhCWvy5SmXo2dz
 PYDpiryENNs54ZVPzMPhrxnbaYIgOxy5mAU7+snDPVGi70/LF9hVeWHJoBUkqV/4QHjy3TNw1oa
 mE8GfjXozyKNZ6YPxTJE73uQzsdwDGkaNKGXaPQLgkiTLb0xaRX83YSdpM7hKyNDjDYpZNe0yxY
 cbe2see7Ocg4M8ag8pButr8N9T5RpjcMOfROJo398KcwXCACYoTk2KBE7B9DT63DrIrRuG2HHID
 +LVd6XNBXSdoQnfAcl62YHYR7TJzCv6L/hDDhj8gE446QiQCFStMjel26tOItHPRaxP2hhD78Fp
 Gd7DPTrWXdUIxjaR+FHduwNwYBvlbT4NxpHKIy6S5GGg4EijVM1wMtd1BmgGHiCsi0A4Pibr7HD
 iSMR4jpZyHN1UzKyV3IP26evNvt+mwhriMrTQo4cy5eez2s+VL/Dx9OKmCTlDbQ+QPFN0HuHG5M
 V8cXQmLBYUp/
X-Received: by 2002:a05:6a00:3cd5:b0:845:d650:b75f with SMTP id
 d2e1a72fcca58-84f5df3c774mr6396728b3a.8.1786135374247; 
 Fri, 07 Aug 2026 13:42:54 -0700 (PDT)
Received: from
 runnervmvrwv9.5mota3rayj3elfrkaatbuxrvgb.xx.internal.cloudapp.net
 ([20.29.188.144]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a3fe7d6sm1544870b3a.26.2026.08.07.13.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 13:42:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri,  7 Aug 2026 20:42:52 +0000
Message-ID: <20260807204252.34887-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807201209.116225-1-avinesh.kumar@suse.com>
References: <20260807201209.116225-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Handle SIGSEGV on invalid
 timer ID
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

Hi Avinesh,

On Aug 7, 2026, Avinesh Kumar wrote:
> openposix: timer_*/speculative: Handle SIGSEGV on invalid timer ID

> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	printf("Got SIGSEGV when calling timer_delete() with an invalid timer ID\n");
> +	printf("Test PASSED\n");
> +	exit(PTS_PASS);
> +}

Could all four new handlers use PTS_WRITE_MSG() and _exit() instead?
printf() and exit() are not async-signal-safe. Since SIGSEGV is raised while
libc is processing the invalid timer ID, calling them invokes undefined
behavior and may hang instead of reliably reporting a pass.

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
