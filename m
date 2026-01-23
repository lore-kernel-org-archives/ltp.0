Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1ECD6CFB1
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 02:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769135824; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UsXOSV677+pGKwT4VxQ+CBhT69punaLiBdAnn0msTcI=;
 b=oqSMgFxXQjFHKac4NmUw+W3fpznYwRtSDTsJsVDEGnPCt+1CjSODN6gyx1reNPx7iBPVu
 MTlX4TKua/fXG8Hwhzj14iAALqgQjgH252lFtZ949ZnpTGMxtMqThGFkLoO6vLk2kpBsKjk
 ws7lnuBZC3+pJt9RjA3hWxZPR9pr9N8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7FF3C4C70
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 03:37:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BEC3C4C70
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:40 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64E48600070
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:38 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so12395715e9.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769135797; x=1769740597; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73BOC1yk2bEIqtkgkjJewvWQwrXTEMoH15DfZgdalic=;
 b=djCgpYMfxJS5k/bWXviZQu98OJKO7wR1UHKi0Y09LdvJoCwrw3AbVgptgcNStMAGU+
 MkXWRuljm+p9GJLA/GU1xrvwjpOhcXOD8Xqo65jGS6KloITJZvOEkCrGZqIdYhNon01K
 CvTnNYcaMJMaVMgHmnybJq1vocBoordGWPzhc3fqWAdX38PmdUd64GWUicz53QFeYvIe
 J/c9k8iis1ASZBQKTC7SogNr1xtX0tca9+QcRvdnlMwALFj9Z4UArEQaP9frD22BCbPi
 Aayan9B56prP0AwEAnfM0nC2LKxZPcxY8IT440mB5yvClbR2OEIc329bk1DxYxAgcCsi
 WjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769135797; x=1769740597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73BOC1yk2bEIqtkgkjJewvWQwrXTEMoH15DfZgdalic=;
 b=sV8nUUfm8vh9LZowLi9gk/YNH8fNsdrNQNmheGOs5I+ONwbkZiZC2tCghPOq9odhXv
 Vr6XpL6d8IlT9UAn7aq1QajO8wIqE5Wo68lG88NzwLn9ABbYW80ehSf37jPr++6JwUNM
 R2M9XIg24KRgSeVE1he/x+eDvUv7fUjGFdk93r6OdgmH7a+3uztmPDLXcpZF481bVJ93
 b3vbewE/QlnCzqIiyH7wWqJrJy2QBC9MvVR0rGUUgxY5khqCPZOD3riPkuvTTduRFR2Y
 SwDvzFCXKLIXL7Z2Li/Sl27g7AHpD49yjUD7oQIDddlVA5Pm+4/qaC1Kx07itYm3HoSQ
 U/xQ==
X-Gm-Message-State: AOJu0Yw0g/wNJbIz6uc50FO234VQpwP46Bl4dVQiV+KCCbjl/FkyTlWv
 oXHJV4bEpsgdFaCugsWRKXiPb4+Y9vKt96ytFHpCZClJCwkYuIMauJ7OjfGH0LUojEttjHb3Y9b
 iK7Q=
X-Gm-Gg: AZuq6aJvTyB1bPJ+8I+NBbGdOjYO8O24vtTr1CLa9HjLrGL/rh/d0XwHE6AOAt4U7Gd
 NLVudSTXr4L12Ta59zkFfLqc1ew4mUecLio+e6A0k2cIp/y2FYSFiAC0zeV50t8sdMc6vDJW/Nu
 Mk89fpvLLjfQVQXqtzKJGk422MDNC8hjRHkQXTAvq7J6As18lt361zQnmateTASLO0yFNxnJMNB
 iNUPuFnajGrM+SQuFBrqRaVcQtgi69Al7i7aUdlxx2ARBSGLlOLEVQkpOtdbZ9PEInYOeCvM/qg
 wI6yIXAcnKvuScX9/tnngPqtViHi+c0znmstJnBoEwqrR1d/JDYCAYuk2kka4k3DG/DiQF2CRCI
 Ul3xE46IM8k8VWlTWVlFJcD9y/30mmWgceDqiXQxZp2/tm10pZ/h6ne33WB3chwLhJdnFLVF/tL
 E=
X-Received: by 2002:a05:600c:3b18:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-4804c94c4c4mr22072205e9.11.1769135797557; 
 Thu, 22 Jan 2026 18:36:37 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4804daf23f4sm8749935e9.1.2026.01.22.18.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 18:36:37 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 02:36:25 +0000
Message-ID: <20260123023635.29692-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113015242.799-1-wegao@suse.com>
References: <20251113015242.799-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] tst_filesystems01.c: Add test for .filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v4->v5:
- Adjust 'char*[]' to new 'struct tst_cmd[]' since commit 39a284442

v3->v4:
- Use #define for 128 and 10240
- Change commit subject with ci prefix if ci related changed
- Separate change which unrelated 

Wei Gao (3):
  tst_filesystems01.c: Add test for .filesystems
  ci: Add mount operation for busybox
  ci: Add e2fsprogs package for CI test

 ci/alpine.sh                                |   1 +
 ci/debian.sh                                |   1 +
 ci/fedora.sh                                |   1 +
 ci/tumbleweed.sh                            |   1 +
 lib/newlib_tests/runtest.sh                 |   1 +
 lib/newlib_tests/shell/tst_format_device.sh |   2 +-
 lib/newlib_tests/tst_filesystems01.c        | 108 ++++++++++++++++++++
 7 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
