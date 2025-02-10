Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2090C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:13:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA0303C98C1
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:13:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03B43C272F
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46403239255
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:21 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dcae0d6dcso1780545f8f.1
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739200401; x=1739805201; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9DonbUXvak9yF2TDutSm7AcSC8S05uLqtViIXX2IZxI=;
 b=VMS3hDao3XnsxrTPCpIi4T8ZhC3Yl3rwks0YwdUR2qOt+L+PkXJSryC1wpV+cwHkXG
 pFEzmzlnAIE13Ggx7vw2Pbfg1fpEgM4x0otOG9d2Wgtfvd3Yt3zSLDiJW/jG3Vpm+U6F
 GwWsTGgLRNz2QKgwaso9astT7F6hB5BP3HTdZ9DdOK+HEm44gVuhJ+lMF7Bw6xXNfhCs
 gO6TJkCdmBMqBChjtwcYudMsouPBCv8J8xSv942gHP/lix8WgtadfbkOFpJA4zo7BPAK
 V7h3LrLKvsIxFqhin4CGs7J2uVrWwPccpFsal4ULsqXSYhLV59TKQgHWXlYpAfEjdqZy
 imoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739200401; x=1739805201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DonbUXvak9yF2TDutSm7AcSC8S05uLqtViIXX2IZxI=;
 b=fDACL70lWvupMjfnUezpe8RF916J1mnKnhd87SJesW7FQNS6DrcjChT7CruSzBKnD9
 Yu8+/CoMyrl7NX2RX5cRXxXnp2qpANMe8X66lGZidI4IifBO9uQjqfoU7rYKO3DPkAiw
 9RahDbCpsptU5lv5oSfW/KO87Z9INaRw2t7YnTcmpuzjEx2sc2Q5Cs3Wf7Vi4q5mSnzh
 VDesog2IRpn7QnAkkWFId2g6JSa6HN7uo4bU9hku527c7mO8vOBLsFTW95sRRyS9KIWu
 Ua/sY6ZKyoMANWzJGD8RmqGDLuojxjipXYdblU2mLvZjkTEFd1FnT9XqWPBZwdM69mcg
 K//g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWJQlRoSwdbdFDCir+qj5RtN6jXV0WuXxmrpihyetXpsizJHqdI7NX0YX79bdEyfyFZ1Q=@lists.linux.it
X-Gm-Message-State: AOJu0YxiV8y+S6qOFS1hHr4cThNqbZEs1eFmAu1QONZQFf7JXlLj3qM9
 +5rHRTsGoIa1ABY3X+RWEpO1dSxPW04KJmsydyuTY0pwzRUa6QrwEb9Lwyom
X-Gm-Gg: ASbGncv/Bi/3Gc13ToO3dCZwyRV5NhgqHLCJS3CrfZOqLQCftZHON6cpJfnvIs9NpUx
 M0dH0jcMrLyXHyTRWanDslHZR7fYEoghJyrVlij+8s4E1wgwu0uZo1hvuypeklsvBYmkBqCPAeW
 fqU1iFiub5AH30kLYL4WtMj9q6RywS/g6sNkIu4So6u0hAlfPnvtpRJNM0qCekYvOAsVBf+wCDD
 V5RFX73HYh2F8fZwwvODBEbkOtCEoGFX1wYhE2BBUpmczxK2MuJ1+AdW86mqRwe0qxd7BcQKIFq
 bd3ZNNYlu7TSrxWm78YJ9iDwUUEev5+1+2/NDiSytTd2SXAqIVsoZPtOwh+KuEyHRJRyFGFZBsW
 +ELsUNF/sOjPn
X-Google-Smtp-Source: AGHT+IGKpE/ejSW80IoVVydPFnQoq7zS0YpBRjP7FBSFoEBW/uQDb4/fWpPAZpHmVP/Vw6M9uszXZA==
X-Received: by 2002:a5d:6da1:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38dd946de79mr4202933f8f.5.1739200400330; 
 Mon, 10 Feb 2025 07:13:20 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce6f2c37sm9106869f8f.99.2025.02.10.07.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:13:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2025 16:13:12 +0100
Message-Id: <20250210151316.246079-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] New tests for fanotify pre-content events
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr,

These are the tests used for the development of the fanotify pre-content
(a.k.a HSM) events feature that was merged to v6.14-rc1.

Because this is a new test for a new feature, which is skipped on old
kernels, I am posting it early, so that others could run the tests.

Following the request to split out large fanotify LTP tests, I resisted
the temptation to add a pre-content events variant to the existing
fanotify03 test and I forked it to a new test.

I did however add one test case to fanotify14, because as I wrote
before, I find it useful to keep the test matrix of allowed flag
combinations within the same test.

I also added two test cases to fanotify03 before forking it for cases
that were regressed during the 6.14 devlopment cycle and did not have
proper test converage.

The number of test cases in fanotify is still below 10, so I was hoping
this addition is still acceptable.

Thanks,
Amir.

Amir Goldstein (4):
  fanotify14: Test invalid init flags with permission and pre-content
    events
  fanotify03: Add test cases for permission events on children
  fanotify24: Add test for FAN_PRE_ACCESS and FAN_DENY_ERRNO
  fanotify24: Test open for write of executable files with pre-content
    watch

 include/lapi/fanotify.h                       |  12 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
 .../kernel/syscalls/fanotify/fanotify03.c     |  47 +-
 .../kernel/syscalls/fanotify/fanotify14.c     |  20 +
 .../kernel/syscalls/fanotify/fanotify24.c     | 472 ++++++++++++++++++
 7 files changed, 550 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify24.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
