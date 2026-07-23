Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1610FC531CC
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55AB83E75F2
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 13:14:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1913C3E2E48
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:14:09 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 95D4310007A6
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:14:09 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c1ff471c1so2713901cf.0
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784805248; x=1785410048; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uRmRWhevIMEO7Z1vSMLT7QJkM8M9JZGEhfPEzxnFyH4=;
 b=gS8v4ZAnoWTzka1lLPLUTnjUSoUPRQ8D+ezbARuxmx9yfTJlEWkBCHy499HFXl9dL7
 3+Ta77R0OSFeP1kUv9JNKVnTySEGItzRC+vEWUf2ty/ZSMjXEofxOFZ4p38byp/teML+
 L0If1MvDPoSftWOL0s5Wf/0R1q6SSZhEVr+xFXxjRNBLlA8Y8dBcL2KqV5DEmDf1d50Z
 +Upe4Gd4cldu0vLz1dN2B/gzXMMmv1xVp4vt0LQlbY0OMmMuS3ZRo4fx9RF0cNmpFXkJ
 KHXr4gVoCobYCKfk6x6mhQ2ShPAkd+ojF1y2/1lILMI0OQSsW4Ev6qCf11Bc7Y2OlA5G
 rlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784805248; x=1785410048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uRmRWhevIMEO7Z1vSMLT7QJkM8M9JZGEhfPEzxnFyH4=;
 b=AHBC8l/vzA8Y+gnb4NXMExTujPP46oBzYlsKXpCzPMZ1vkNrcXT2fNfTfQwQB29vXI
 kn8msL3TuGhLLkw+tSWDJ30MZcEHfkewKv5675G1uVCgV/jJo8VCcpx1m9SrewHQF4zX
 GhgEDa+JdL69D6//jiZXbdRDoa20/lZwqXv2IevLGbzUR/FwTbrWvwjNBNkku8rD/z2r
 PBnttIAycvMk9NJe3LcPe8wvn1iSXTLHNhhwcurAZTatyN9wsS3hQAvRqRZKy4CpS06J
 SeNxfrumivHnkpBa7B3PbkERgc8qpF+Up2UKRVFR/j1KBW6lGNTAdgajE4yCaRezFfHp
 Pjsw==
X-Gm-Message-State: AOJu0Yz3hgr4HMyWOjts5iGYmqUxdH9Yj2vdYEGhDCDDpvkyaWV7i2T1
 TudM2xBKp+/P5+bTzx28fAXD+ausqy/yfvhBWcnHJbAIvSRqlBycG9ft
X-Gm-Gg: AR+sD10fc1pdRJiaRdDpDN01ZcsX2INQkUjhbTsrive1H2gm4GhihM6QQOG67gk79yM
 JoRBLEV9n+Oh6EYOM0Usf3y6mTwkadDoxeDur2La98O8qDtGjDWb9cBRfvDpKzgs9q63DC2k7Wy
 jEWTeCNmVRss/LGS6POr4D5sbxfPDbxMV0T6J4PEfW5pfOzUz/QWQQhzfFIUZOEBtoEsN/alMVj
 f7PG8JjhYsBFSabvDk7akLuUBlAiWAUt+TaGzmWL5XcncUMletX/C10OHv0RMfYCi8Ro31d9uRl
 vWJOgQrsO59wB5UVIebpeB8M90JN8DQVeyq0WSoNgaRei1yPj27cHk5N5HSpXHJFSOlyYORZ3ET
 HRN35KxphDHEudtteS2xho//hlCXkt7wu/FCzVR4yWvBBqCipWa+mP3osB3rXmRZF2lHy/7nWwC
 tldPefONSNsJ0H1ZYfw6VwQzE4uOp1lczf3cw0n6ZFswB0ehCeaypkoncmOwQczp9oFkiIwFl1G
 a2UPbg/BnoXXZqQDubEQET909Y=
X-Received: by 2002:a05:622a:5917:b0:51c:478:32a1 with SMTP id
 d75a77b69052e-5283dda80e8mr26243151cf.18.1784805248136; 
 Thu, 23 Jul 2026 04:14:08 -0700 (PDT)
Received: from
 runnervm3jd5f.ndtsheiqjcounhtwo050w5fsih.bx.internal.cloudapp.net
 ([20.55.15.224]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d0c4fe92sm32288881cf.11.2026.07.23.04.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:14:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Kuba Pawlak <kuba.pawlak@canonical.com>
Date: Thu, 23 Jul 2026 11:14:06 +0000
Message-ID: <20260723111407.4101-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723094947.2639934-2-kuba.pawlak@canonical.com>
References: <20260723094947.2639934-2-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_rtctime: close RTC fd on the ioctl() error path
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

Hi Kuba,

On 07/23/2026, Kuba Pawlak wrote:
> lib: tst_rtctime: close RTC fd on the ioctl() error path

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
