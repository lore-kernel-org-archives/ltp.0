Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB2C624D6
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 08:07:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EC303E9350
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 10:07:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EE153E4B98
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 10:07:31 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1209C10006A6
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 10:07:31 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2ccc2e84048so7535715ad.1
 for <ltp@lists.linux.it>; Sat, 05 Sep 2026 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788595649; x=1789200449; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DhRefo+ilHNUzqqmCGAhZaYLb1cWyXBCZe7A54fwYwg=;
 b=Gw9wyDFC1ooCOjD89x76qGJGKd1kA+U8MMwIYo+Lx/phLq2g3fpOxBSILQ+8xNsCVO
 lSBb+bZ2VvL/SQUGdPoWQX8aCjINJndpngTpONBKOtd3kLFmqOB8Wxi6swLwy3aAI3Vq
 2qnG3qUZTWE9zYNmkz5CV02lSU8Ko5XCR7JkgVesYlCp5BJBRYRcKhhoflhLJADQAZLP
 8cymqBA52GXpYuRYBSnxdtkChZEM7USJ2FqBMl2HmblCoMUDTqQfx8Jm+gF0AAysRz/C
 Ta9j/tS4Su8qBHrwQa/e4FNJ9nOlcqyMVt0uE8GGxEEFp5grh5KcSEidLujuXCIp+88w
 EfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788595649; x=1789200449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DhRefo+ilHNUzqqmCGAhZaYLb1cWyXBCZe7A54fwYwg=;
 b=rljdRDRvVZn8VLB1hAq6kaOTc1Q4DJ/PySlhNNTIw0m5QGsOa0RVzoUAzCmClqPc5L
 gAErLq/dC7BXSb2VMAs5j8R/QOR9xK5Gn5nAFNfJTHsMMaRTJsAW5oS/ZvyUKst3OA++
 eV6g4+PsO8fxpzKojyyMjKQ0uVClEGEtiAf3I/iCqJnZiWxIZX0avLc4s7jIAQV4xic3
 RHdejtuQvS+r6s5YLkiJMqA2pU/Anrpy3E/UaKMNTlm6Jt451BaIUzZWGQBEr0MvsxMX
 GlRJ9lWzw5QTYc92FNADkO2aY0cXfnHRdbo0l5jHdleY8CfKNUVF/HImksZkhEdurDGx
 EuMA==
X-Gm-Message-State: AFuF++m3e47LDaNutrbaLju0spDGT5O+I48ngJYfO6ibasmSQdWmSi4U
 majzkzHDcp+3V/geOOkH7LpE2r2Ycee0JufyTOP8gMX9yodsEPEkFkbs
X-Gm-Gg: AYBFou2qwW39wn0RITxVqloJrkoBkX/9amjFBnjPfTQmBiC+O1kcLFW5NE8J1HdCbVJ
 l3Zl7YESlGoYpUFThX3PoBRU2tb8aBzTLjm26l6igK4qR6VdZwjB6QK5ONtpcKsK7intOmfl7pL
 /bzJ2kyLWQ5goc3au9frjeElkiD2gvLZrxHhHu/bTrESR8Z2j5Y1wYCZv7VilG1wyOjNzGTKXWL
 IBLzYPs8tFcrt1I17FHLp0KuXh0X63w3MYgnhHAeXVuJOB26XD7XcTEZI8wXcmiLSNPmQepX+we
 rpz/DVvFXDN8nKirzKUK7nozGhPoMBtp2qPk1Dif1hTUsxxSmbfDxGCBOdFLM/vUB4Mfu0r9QSf
 8D2pn3v4U3ItkUWGLblX/2inahNi5HtnXjgzD+vpmRJ1dAVuf7ALmNvXcHPW0QfzcOSvh36uT21
 PIVdbfkY2WWFgeWeNj/ufbvprDu5j5gTNi01FJACFxmHsADBlkwk5Hoir0jvXMAzPdwIC92/e3H
 uhLZIae3nprRi3EXIeTKQclgAkPCU4l9iJDCR6Yl7g4/mMqvMN8cBMAFbzIYyK9cvQxLI65H2kN
X-Received: by 2002:a17:902:d987:b0:2db:257c:9fd5 with SMTP id
 d9443c01a7336-2db257ca020mr85245155ad.16.1788595649261; 
 Sat, 05 Sep 2026 01:07:29 -0700 (PDT)
Received: from
 runnervmejwal.mlatwgtx3xgu5eejbrqchy0rkg.xx.internal.cloudapp.net
 ([20.64.173.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149ca6c2sm19094805ad.70.2026.09.05.01.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 01:07:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Sat,  5 Sep 2026 08:07:26 +0000
Message-ID: <20260905080726.8660-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905061840.14172-1-changwei.zou@canonical.com>
References: <20260905061840.14172-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: count only the test file's page
 cache
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

Hi Changwei,

On Sat, 5 Sep 2026, Changwei Zou wrote:
> cpuset_memory_spread: count only the test file's page cache

> 	for (i = 0; i < npages; i++) {
> 		if (status[i] >= 0 && status[i] < MAX_NODES)
> 			counts[status[i]]++;
> 	}

Medium: Per-page -ENOENT and -EFAULT statuses are silently omitted even
though move_pages() itself returns success, so result_check() can compute its
percentages from only a subset of DATAFILE and falsely pass. Fail on any
negative status and verify that all npages were counted.

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
