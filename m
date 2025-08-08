Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A101C87FD3
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832743CA7D1
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 15:53:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AACB3CA1BC
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 15:53:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7A863600951
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 15:53:19 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so11432375e9.2
 for <ltp@lists.linux.it>; Fri, 08 Aug 2025 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661199; x=1755265999; darn=lists.linux.it;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WoAIVL3JK0HVlB3UYmIhL0LARECku8HKaDj1ovTJBU=;
 b=HAl+SkWTqXG8GmMVigJlrNxa39IPoec+uAFKfwZKTEeU37BPaeVKEgKkswdCqsgYYu
 mxvD6Y+a8wwC4c0sZHYaeRGMW1cskHRiWVL0SLWUJhIy0kbkIAaS53TgBsvyD5cCNDvF
 24lZvpHdXmLWJfT33J3fIRnEk6zDmPYDNdFPYr8+RJ2enOmov4Gy/Rm5QRw3NBlOz/06
 4iiEQJX4mFsDJAQH0CkF/CAVPc5o69c0FOJlYMezi08+xAydq1tiPXPB8FCPhPmGzUSC
 cP+75k+mWA3hZzYCg6iQnEZaFgb97l81JwAUN3MqdN6ZZALEjDntqpSs1pj/DPyRv/Ut
 Vu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661199; x=1755265999;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WoAIVL3JK0HVlB3UYmIhL0LARECku8HKaDj1ovTJBU=;
 b=nEOH0n0aTVgplxPClBW2Mto2rb6okH9tqP+qkxEBKDYRsvm1ON7Lpxnj6zu+ATc6sp
 yp5IwowK0vt/9L4YRBX5pGgISTi3lIkLyiaIggR0eMIkqNRm5WcwKcRhWR2bP7WItkR1
 C1ktwvXDXLq6YrHegyY3c7a8DyAZez2nb1naHua77jrSJQ1TA0B0MAEGKAq7SeM6r7M4
 cFNtxL/6dgV0jdpeUJDq0k8xeDfZgwZUghjOzUVKu9uurrQ7S4FBQhJ+rn2x8msfxu3S
 RZxDHpAOKy/45gHcjJ9WGq4gwgyvETyltBo4C4WKswpAUgwESJExQcy1m7V51SGz4VWA
 U4wQ==
X-Gm-Message-State: AOJu0YwAcDbio7qOvn6m0b1e3YBfHQM2x4bKSdOZxFcjuGEtGqC79hjP
 vHppKpNVNdqfBczGnDjh1IW/w5Kj/4aR951PhZimFB0mkpSnj38j8rkRqpH9yWAaRJN6IpnI9HQ
 FGOOb
X-Gm-Gg: ASbGncs6hPq6YCMxLBq+BW8IQV5s+aom1g64bhrDkAT+H1i94jOAKuLQRciqmvrweHN
 dRny+wunneETfSourUDG2FbUlc0TFZWi5FkZPn8QNohx7gXcCnE5BYXb5wTXrayNpBZiAkIs/Gi
 hwCgumcupNGSt5t0GPADPStek+KEy4g8rrbQWoXx5fgYMTxBbcJk+MLT3E3XKlIDmlPV598xJic
 GJlNXGsGVqvh5f15ecEFBMvv9byFVWEECEQH9x7UnIuCYyqapAi/2myZi3mSgAIyphst3x9d3BE
 DW101QUgcdYI28PYOS0I+M1alGxNDkfupDq0FArj6MaTc7mMqkhdeyFVwpK5CjkuuQwVUHg0eej
 WfsnJq18kz/IZGAfy1Dw3NQsHJqY=
X-Google-Smtp-Source: AGHT+IE86Ik2SfGCEFCmSHvCzF8AVKP012d+1onhoQSXPhOxsFsBH/Fep4LeH9XHHNmicl2u1DIr5Q==
X-Received: by 2002:a05:600c:4e8f:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-459f4f0557amr29752815e9.16.1754661198654; 
 Fri, 08 Aug 2025 06:53:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3b79c3c51e2sm29586407f8f.32.2025.08.08.06.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 06:53:18 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:53:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ltp@lists.linux.it
Message-ID: <aJYBSmcQpbHUvOqW@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] shmctl03.c is broken for 32bit compat mode
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
Cc: Theodore Grey <theodore.grey@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In 32bit compat mode the shmctl03.c test will always fail:

shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
shmctl03.c:34: TPASS: /proc/sys/kernel/shmmni = 4096
shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295

The test basically does this:
// === === ===
#define _GNU_SOURCE
#include <sys/shm.h>
#include <stdio.h>

int main(void)
{
	struct shminfo info;

	shmctl(0, IPC_INFO, (struct shmid_ds *)&info);

	printf("shmmax = %lu\n", info.shmmax);
	printf("shmmni = %lu\n", info.shmmni);
	printf("shmall = %lu\n", info.shmall);

	return 0;
}
// === === ===

It compares that output with what we read from the file.  You can run
"gcc -m32 test.c && ./a.out" to see the issue.

In the first line shmmax is not the value that we read from the file
because it was capped at INT_MAX by the kernel in commit af7c693f1460
("Cap shmmax at INT_MAX in compat shminfo").
https://elixir.bootlin.com/linux/v6.16/source/ipc/shm.c#L1347

With the last line we're trying to store a u64 value into a u32.  We're
going to lose something so it's not going to be accurate.  The difference
is how scanf() truncates it.  If you have 32bit longs then it will give
you the first u32 but if you assign a u64 to a u32 like the rest of the
code does then you'll get the last 32 bits.

What's the right way to go about fixing this?

regards,
dan carpenter

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
