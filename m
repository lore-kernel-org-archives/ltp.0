Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786ADC48260
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707442083; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=y+/Y4XH5EtqM6O5pmzIXXN5LSepaNnARYctuG7Q7Gds=;
 b=U9tQUwL7WgD7G1kbX5fn5445m9U+CttbKO/Sv9K5xRi8aUvOBurMQmGwTSJVCai6OmjgD
 k8HOZ1YxXvpkMdGM96Evkn8jiwSqfoLfBc1u1mMUwBEeFFf0BwG3aG4t29V3c4EHbekI96A
 iQJWS0ZPGZXJR9Kq6bzVWVfylvm6hgA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 729D93CF558
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 02:28:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37B023C8DAE
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 02:27:38 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA827201DA6
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 02:27:37 +0100 (CET)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d066b532f0so6448261fa.1
 for <ltp@lists.linux.it>; Thu, 08 Feb 2024 17:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707442056; x=1708046856; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u348FKMgKqSC3T/qI0XXVHJ34QHESizDEGfe9Sv6IAA=;
 b=BsoHY4Jvs76ZLtVAThe1IzNjC6FtsFiZE+iQu6rMc6W3qZ7V1FF2m9pIBqAoOT8FxI
 njOJFaYTaD9nobGLqvuN+RJiPwKfEG7x1MVA5o/a3Pwf+1KmWB5Q7Ua3koXXxnTcuWg1
 lbR5m2c8edBrAZzjvztBJkMEEmVoIHKP3TX+M4lUiIFU92Evo7YcgLc8RV/xcwBGWxFd
 EFhJo9SNAVk/n8wEF7qeKuwx5kQey+th1/ry4PHmLN01yjhhj3z4IoOA0h+e23gwjtMy
 5f5VVR9NQrtmuPWSuPfz0tx8guD7P9OL5nViRypVcveAQnteWx4+t+mDrh28/Q1rAYxY
 lLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707442056; x=1708046856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u348FKMgKqSC3T/qI0XXVHJ34QHESizDEGfe9Sv6IAA=;
 b=Y9IDqsr2ZA1FcZPR6GNjs/jQNR8vTCwPx47qgN9tvyVDU2O17bectqEQvOhA3izFtQ
 94gU6PeNEZswA8+FSK3zIoInmfRWK4FqB4eZhoReJ57Y+fntgBct6ljszgWNG0hnylwQ
 kkREFxpnJRMT9jJQFZVjIdwWpo1M3BXlC3eN+TgjJqcb96vtLSrBVYBunHjIGUJ1zXZw
 JewerhaCnEPjOTfqcNHB8NjLXFtygG23CbZZIiebPxJ2+j6m9V928ZGjaLDxsSRv17NI
 +TO6uUU2lWYxLT7W7PPykr2LFG/opL8Vh2uSRBpclHgTURZ80p/VthOBbD2uCi7NazDB
 MeAw==
X-Gm-Message-State: AOJu0YwE0n9umfBh2MLDoUFupBL3HT7NPixEM9gHKBt4w4S85rmjlJTE
 GQOBswGosIEaN4Vedq9gA6YJy5GlFT7ucPxCfxlSo3cs9hqmMhiJAYEYWNrVKOjDlX+/sCQmy1o
 =
X-Google-Smtp-Source: AGHT+IFs7oM9LWRqMO7lW00IQ3h0x802pt5WWhSkvSG6vTnMz/wIXoYJx3zwL4ith4+nLMZTW1YzRQ==
X-Received: by 2002:a05:651c:381:b0:2d0:b0f9:26db with SMTP id
 e1-20020a05651c038100b002d0b0f926dbmr160259ljp.37.1707442056454; 
 Thu, 08 Feb 2024 17:27:36 -0800 (PST)
Received: from localhost ([223.72.87.18]) by smtp.gmail.com with ESMTPSA id
 d3-20020a056a0010c300b006e050c8f22bsm421271pfu.207.2024.02.08.17.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 17:27:36 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 20:26:57 -0500
Message-Id: <20240209012657.10797-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231203235117.29677-1-wegao@suse.com>
References: <20231203235117.29677-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Futex_waitv: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
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

Futex_waitv can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall in 32bit compatible mode.

Detail info you can refer following email thread:
https://lkml.org/lkml/2023/11/23/13

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/futex/futex2test.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
index ce97f47c1..a3cd0ef5c 100644
--- a/testcases/kernel/syscalls/futex/futex2test.h
+++ b/testcases/kernel/syscalls/futex/futex2test.h
@@ -12,6 +12,14 @@
 #include <stdint.h>
 #include "lapi/syscalls.h"
 #include "futextest.h"
+#include "lapi/abisize.h"
+
+#ifdef TST_ABI32
+struct timespec64 {
+	int64_t tv_sec;
+	int64_t tv_nsec;
+};
+#endif
 
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
@@ -24,7 +32,16 @@ static inline int futex_waitv(volatile struct futex_waitv *waiters,
 			      unsigned long nr_waiters, unsigned long flags,
 			      struct timespec *timo, clockid_t clockid)
 {
+#ifdef TST_ABI32
+	struct timespec64 timo64 = {0};
+
+	timo64.tv_sec = timo->tv_sec;
+	timo64.tv_nsec = timo->tv_nsec;
+	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
+#else
 	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+
+#endif
 }
 
 #endif /* _FUTEX2TEST_H */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
