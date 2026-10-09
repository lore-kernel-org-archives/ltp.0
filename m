Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FB7CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 10:09:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D9A93E59B5
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 12:09:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24EA23E2EA2
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:09:26 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C1DC1400456
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 12:09:26 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6debc457754so2693369eaf.0
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791540565; x=1792145365; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9IjTJf8CvyFrfSUSaDqC9aQggtGRdrWmqnxeXjROT4U=;
 b=QmNlTQEEghaWunvfyKVq/V3euhDMkHXgQUQRMYJMK6maZskksJ8yz5254Eat3eUdm6
 2QFv1PaCd4Mhh3770A3UESUeYiJag43nrga2T6vW7TB37jel8gXz0asV2Mfynuo/WF9+
 skQg4E74YNBe+9V7pUqR2MM2cBC4Ljs+NVPJucsAod/pbwn5vb+RZDSwktI03tN4F6Yo
 2JtuM8Pg7XQJkYoTnja+kFrA+L+H2BKMZjlOobp0CofTangOq8My0D/Tb9hK909D2L40
 rAzLIoGmgmmRm7C5WN5xQTitAIKqvgCHBihRkEPDHL8D74FNpkfVz74+fsdEH3104NEx
 9kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540565; x=1792145365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9IjTJf8CvyFrfSUSaDqC9aQggtGRdrWmqnxeXjROT4U=;
 b=IV0dIGBuLXZCXB7IttAYfEAJy2dx0XudVSFExawVrQv9717eSuH4UAvB90wogD1Sn2
 vss9kyrcryr3D8STyO9wt1Dl+jdtjXfg/JZTtKUICP47Je6g/LEEXQMV0KtqgqhjVYoU
 7WNpEXk3zEsRG4QVl8JPt1ouzYw5OCQtQRATsWUAL9jTcIXnvTwAkF72BBmTbhLb/d5q
 SYe/hrIH8IQHfHolVRo5CTjiOBMIluXDzcuhSiXeDjO0hQaspX1Q9sotQTGOWLr8knbv
 j4iRX/fEPetXfWuurP4uDOKaH3Eqof7YtwczssZK8fWgiP9mqCUnPGTO7pkw64Diftn9
 ZYzA==
X-Gm-Message-State: AFuF++mzIlF/wzKewrnD28wORitp3zUgrZcIJ/ho3p2Mit0qs2ucIBTc
 usaM+lgobAEY8k2rRGJ74ZoCBctVvVvFnV/5gZxk6ZiDgShL0Zq18fUA
X-Gm-Gg: AYBFou3u4nbtZcE+tcA3NtjQfVjJNlKxS1xtaXHEdFZjL1yhUE/xPbrywP+gK0jxWr8
 7CciVqLzjnFfpetxT6DK9/QvG3LlslWVju36miobCMVyu/migxQRmP8Fa7S1LSYixNfFND8TJSX
 IGzF9asqBDjw+3kfuiA/U+ZQOdwAVWZv/gqRoCpS06aSjIts+v9E0QT4li7PZ3sugIb+bOdg4/3
 UK2C6z4cLFQqdwZIfOl52aFul04HRdXUtZUfg7I27ozc3M/hCU9muxhfl41XqaITGnANdZnsrqD
 5e2e3kDGsCzhKvXctHdZhfqvYbGKEoIf/bOx2KgBmlGNb4NjSCJt3fm9CCaBVasiZxLJtls9sFt
 rKoEQXSWHZXd9+KxQiljQaBcugeXHGgsGVqzkupJBH2dSE+Sd+RofucnJ9hWD1Wt7BtLeGCIxuN
 ENiKuJsBcJami6l3LQD6pBh2JrRv7BQCEsn1S7bkkD85KiYwImzsLftWuEwFAXxKZkVtW7QWf5T
 KVIOcuaU4y936kSrlL4b6RroLDJUduvAbIlnAvmIS2BBs7zulAXA+c6EG2PrZfRVM2ZYQCT0mVL
 IVmRlmbF2rZu
X-Received: by 2002:a4a:e911:0:b0:6dd:6d12:2317 with SMTP id
 006d021491bc7-6ef0eec20camr1007532eaf.25.1791540564605; 
 Fri, 09 Oct 2026 03:09:24 -0700 (PDT)
Received: from
 runnervmmprz5.givru4gvcybuxl0txu4is0bsyd.gx.internal.cloudapp.net
 ([172.212.205.20]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef00ff3b83sm1412300eaf.6.2026.10.09.03.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:09:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Fri,  9 Oct 2026 10:09:22 +0000
Message-ID: <20261009100922.4010-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4e46078e97ec7c6678cabd9f2b32cba8be3ee3cf.1791528355.git.jstancek@redhat.com>
References: <4e46078e97ec7c6678cabd9f2b32cba8be3ee3cf.1791528355.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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

On 9 Oct 2026, Jan Stancek wrote:
> openposix: timers/twoevtimers: Wait for both timer signals

> +	while (left > 0 && !(caughtalarm && caughtabort))
> +		left = sleep(left);

On glibc and musl, sleep() discards the fractional remaining time.
If the first signal interrupts sleep(3) after 2.1 seconds, it returns
zero with about 0.9 seconds still in the budget, so this can fail before
the second signal arrives.
Use nanosleep() and retain the full remaining timespec, or wait against
a monotonic deadline.

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
