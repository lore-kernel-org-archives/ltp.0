Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAB5C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 07:23:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E056C3CE4C8
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 08:23:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DA223CC2AF
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:46 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD9BB600C35
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:45 +0100 (CET)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507cee17b00so7050935e87.2
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 23:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699946625; x=1700551425; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QxrHlSoCBMMFv7ivAvbBTxcLyyYe8Wyhi8kqX73X/l0=;
 b=WNBLzKHe5v7wYEdz2Zk2+ylNGsFFcpVcFwdBsTE/RHMs5JW0UrHeASaBg2GfF3Ccim
 IXPDK4dxJlWl7OG1scSNtDMAQly8RY1c/7phdUFYpLtqRfdWH6Wqlmsd0EtMhiIE7XH6
 RZDfHlf3tML8oQ8qzdFjPY1KB9A4ajQHv/4pKqrorZG9iyPeqHwq65E4vCZ9Dw7c6Khw
 I9tWDe60V2ep8ILjG5qA9awDlfOrSQr3PnVtI/r94PDViw417Oapc7fZYMh/QAkxnpwj
 78S0s1UUPe95zqcYoxYD654C1kglXwyTwR/Wi87U2bipApjF4G51tjM+EBjfKlnUuAQs
 HULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699946625; x=1700551425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QxrHlSoCBMMFv7ivAvbBTxcLyyYe8Wyhi8kqX73X/l0=;
 b=cQ18P1t4Iv0J+Kf8xiXGNiQsSwgV+TQnRCRjzXaW9dpaP5GTgTAUPbG/le6pG3rsVF
 PZW8TLYAdIjUYHtyDambYL9eintDqVTimQKc8FwLUlnNH3qb6x1R04JSuwpkZzMXgqig
 vISAqZyEg2XFGEdLmkDvf8KgT059pmAYLi/9OwwhK2AXnOrONdWqAPbwSA2P6vA7Zqsm
 BHEKiLmARO8sIQLmZhNscXmC4GMi8cnGUp4Fxggn5+r6LU60QL158Zm9POXuqUaAzP5W
 1EStPwqBkKJal8xnfShaicif7txU2HushTf8YiJU2NU5PoID6UJrUzOmcIvc4jrghPHq
 C/9w==
X-Gm-Message-State: AOJu0Yx1nkoqp1TPiWLKo1OcV3kNVuFJ6l7mH09iZeJY6joonQTlGtch
 w3vJtRq4d7LMvKc5DZb0K6I=
X-Google-Smtp-Source: AGHT+IHrcS5uug2e5MWimHP/ThzHzOnrjskCSltfm4uRTqTLPkXGm2+SEzN/4ktWLhvH9sTZ0nnOhA==
X-Received: by 2002:ac2:4d90:0:b0:509:4ab2:3635 with SMTP id
 g16-20020ac24d90000000b005094ab23635mr5361520lfe.59.1699946625007; 
 Mon, 13 Nov 2023 23:23:45 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adff409000000b0032f7d7ec4adsm6865681wro.92.2023.11.13.23.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 23:23:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Nov 2023 09:23:36 +0200
Message-Id: <20231114072338.1669277-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] fanotify LTP tests for v6.6
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
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

For v6.5, we added a new test variant to fanotify13, to test fanotify
watching upper fs path while making changes to overlayfs.

To increase test coverage, adding another test variant for watching
lower fs path instad of upper fs path, which also runs on v6.5.

Adding two new test variants for watching overlayfs paths.
The new variants only run on v6.6 where overlayfs gained support for
being watched by fanotify.

Thanks,
Amir.

Amir Goldstein (2):
  fanotify13: Test overlayfs while watching lower fs
  fanotify13: Test watching overlayfs with FAN_REPORT_FID

 testcases/kernel/syscalls/fanotify/fanotify.h | 28 ++++++++---
 .../kernel/syscalls/fanotify/fanotify13.c     | 50 ++++++++++++++-----
 2 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
