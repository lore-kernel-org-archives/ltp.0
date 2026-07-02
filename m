Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B9DC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 15:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66CB93E4A76
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 17:24:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D4E3E16D1
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 17:24:25 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0FDB0600287
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 17:24:25 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-381072761d4so176253a91.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783005863; x=1783610663; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5t9p2eRdamSNGwh8Mt8q9Fia3LXArJj2uGH0RZQLXY=;
 b=Rr88bEVxU3FGd3Dwmsanhis4p/ShZdSaAYIuM10XBXJNCubzJ5tlG17OGTxgLrUjyX
 ljKlS+KrAcBtLtQ+/ncdM1Dj3E/nrat+QJqkYBustNZzgds4oCh01+92w1/RKfWKsAjb
 mUC+ihJFCVEDW5l6oaXynvIt8J6uCRvuavxG9ZFW9ZuNPldLWr5r9SFpUvsdcydXc3+r
 w5jxHWzB1PKpPlx/4XCJMRJvy0mGCy0BBU+A3d/8ewpnmIk1Dk2DkDGG+jGgOti1t1Ah
 CYF+mHwuw84Ce/cHexQkMqknx84q4GnVo/grxqtwgwh9PBM/YRiL+R0p9xxTkQ6gv8qD
 lsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783005863; x=1783610663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5t9p2eRdamSNGwh8Mt8q9Fia3LXArJj2uGH0RZQLXY=;
 b=KNA1r2g/K+aUC+tY+9RUaW8e4CLPK+FlWtYGseo1/QoEOFOOVeDhalbNuccYlqZ+A+
 wx6Xpe4GnImakbamRqpmF97NiUogjsNn6zKafa+aMsqDxgjg+V8FasviJGCc/obpjp8j
 GiFPxGl1TcBRviNiG+CFBvWfiplTzr/6+oJ/HGf9KRwpWFj8dubLxWkEMRPBwVXe6IZN
 T9oy6mi68HlslOyAexMawzw5JMjItWjT3Dg65kISJPhcu1EoXsbcw/X9ukG8t9/TzNZT
 NGdQi+AwkV8b3oMtJsucsehypmHxJljC61OIIkOwJin6S9RraI1wViiHJwfvq2I8kgKV
 8a1Q==
X-Gm-Message-State: AOJu0Yz4cZ/G4o8lrlce0vAVPZM3vWiQzzTPEr6cotMm5+zfqUG1B82b
 CSp+zMmv9xk3+OrVcO+qCmRyimeiFH9mFx67tx55OE+50Xky1UnmZ/lZlQM+Rgjz
X-Gm-Gg: AfdE7clsMFk8+UkpORdjaLCWj8lqNZbVfqcvIo6t1lY0FyCcuUOGk/h40baKAuYPTFs
 4nWwmRtwgEsNPUQ1KbxOalWeaGsscZ77vGpeYlWoXJpFlsO6NPRFKS8anJ5Jwc3m3xImLFiRh94
 lJ9zwocKgWc2louBJZyQEABDCkC/YSKUk5S5DS9kOMS5VG2T6UyTXogRcVbSGNCzV+zfrl4CQsl
 iqrtNd5GG0u2li7Em36wlPSpP6iXy4HQ7Tiblw0bB12TnXXNMVsqadiXeBXxU6X9zyqwPLP5As6
 /iqOCV0X16Rh1NP/S4j81VZu7ZDH+a9GpsebNFo96s+jgbsYmNsYjoLQM9yzVInY3655J5xhea5
 y9rJCYdEK/NRfd+XoLptzVyY+YALs91216lypRezh3Bry7P21SHet4cTuD5uAL/4YaMmB/qUrHs
 1cQRkc982lUN1z9Ej/8vqWqXq7BRYqSd3at0cm7RiPwT63fgdwBEX+obsaJT+NlK2Msl4tKnJOT
 sB1coXRj+v+H/yqQWlZGRhR7NZczA==
X-Received: by 2002:a17:90b:4984:b0:37f:ee23:e44d with SMTP id
 98e67ed59e1d1-380aa07e16amr6336967a91.3.1783005863031; 
 Thu, 02 Jul 2026 08:24:23 -0700 (PDT)
Received: from
 runnervmmklqx.hmqk1t2ztchetnetzydz33jw3e.yx.internal.cloudapp.net
 ([57.151.137.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm10460743eec.27.2026.07.02.08.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 08:24:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu,  2 Jul 2026 15:24:14 +0000
Message-ID: <20260702152414.4007-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702134553.98581-2-piotr.kubaj@intel.com>
References: <20260702134553.98581-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rfim: add new test for verifying RFIM sysfs interface
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

Hi Piotr,

On Thu Jul  2 15:45:54 2026, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

> + * so open() is what actually exercises access.

The doc block must use the manpage-link format for syscall references.
Should be:

  * so :manpage:`open(2)` is what actually exercises access.

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
