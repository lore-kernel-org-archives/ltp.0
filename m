Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A1CD8CAC
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 08:34:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3522D3C6F29
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:34:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D70D3C6F29
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:34:40 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C32D8201734
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:34:39 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304d7f31215so4552240eec.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780994078; x=1781598878; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9ycUaC5swXnnx53P6G1iBDnRdCAsE2W8Shu6PkS5gI=;
 b=bm3BPCw0GxqgPfxhaMFZChqN5oOr3L77ERmHUN+LOvt4QAMj3gpHtYPlzTWNZzz9ZA
 +MnYZq0L1ZiJNI5vkhHgDF1LIHoZfr8mofgyh+XDWfwp7bp/E1WYUgDa8Yb1dYD51tcI
 lKWOrmZ8t0tz60oZ10M9aU4iRbqRugf9dO52nGgg3j6GyUwsCTdNTaJxUOLRoYlEngeZ
 QOsGnfb9rQSX6Z/v+T/dONB1DhktbBw4zacBssM04faUdDWDgtsa+o0KzjtN4viPY4Rm
 tj5ocSSBO5VSitM65rzgyciYDvadv6+fmB3iHfptUUBo+NDJxzVyBS95DCOP73SmzoGL
 cJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780994078; x=1781598878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9ycUaC5swXnnx53P6G1iBDnRdCAsE2W8Shu6PkS5gI=;
 b=Jh50pLwWyrcLvo4UtjQ5ncsWvhTsptbgARvuuwjVuUqMd9tRNI1RBAq2V8NOE8sZmH
 QH+8LokrjCdajz6/flcwOa5hNlYHYrKmSJoasjlzW2R8SCR4GSSybf0blRBzRoqrY7mE
 oYR+rXkbMLiclgNH5S3yHKZn7W1RzfR8G/w/U4vF+BpG6vP9vrzkd58VXWQtdsJ5YjFc
 rm+4QmkfJk18CwCIwSX1y+XQktAU/pFYi7pkfMAGGMx+3+pujdbqKBbzBUYVivmQg6rx
 rONOMtYmZbXA+WPBs+8fFIrtkQM3N/FQip5SctS1euah+MQbSscdwcTJpkXgUc+w1bRq
 HDDg==
X-Gm-Message-State: AOJu0YzrNPq+aGd/KEtTepBrr/zwtG8ab79s30QvlPgyZ/jHiffIsBm3
 e1v07Dj0fWEixCd43EjPtEzY680S7Dq4kNv01LRpSlzjD0c6ISoFuQMv
X-Gm-Gg: Acq92OG7PpcCP58kHMixeqFkkeFxlZh5r29SWTTIkBNBTzTVrfulHCwmLfk4b09GIa2
 WES8E5ekzKh7gCX+cmETFPHPp96LyOxAc4cWWs/lN7aIighEgVkY2zQUlnYJ+UrxaqAD4GUQ1Dr
 8s0O27lAT0X2RpfC9Pk7EJqxyg+kYDeZRmbi0nc4hUhwCOB0VaA3wa8qNF07Vl5TlgHlb+61nzb
 PFt5kiKUYeItPDFd3aAvD7R2qWxMmEgtOGBEZkYCKH4Wq46vfo7Sbdau3cQJWitD12iqOehwwZm
 dgC3TWz9/5uRHaQm6vENLrT+EuP9vz0vZeRwiean879nlfc/Ahh52JuDk/Qdv+q1m+DJjys4i3M
 VO470h4N9ptJhL2yECQ04Y9rqojOzdjUreflsUKnJ2s6e6tZAdBf/JS7HxvNUqh7loizYF38rxP
 shXstqQsaGodEoFGIsftTgjEva0bQ+VqoEKh4u2YsOdlHmFSuu2FMK+rNyaYUmMd9t7eXXAO4gm
 M7z1ko3xdyLuo3edrfHumn9lA7bO2xHyeRL52wk0XQRHFxsNi3F417B0JHvYA==
X-Received: by 2002:a05:7300:c88:b0:304:ccdd:594a with SMTP id
 5a478bee46e88-3077b25df44mr11306022eec.5.1780994077957; 
 Tue, 09 Jun 2026 01:34:37 -0700 (PDT)
Received: from
 runnervm3jyl0.2l2gaplnavqelbtbllxnbekw3c.yx.internal.cloudapp.net
 ([52.153.130.116]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm25315452eec.8.2026.06.09.01.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:34:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Tue,  9 Jun 2026 08:34:36 +0000
Message-ID: <20260609083436.3981-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525153352.188816-1-pavrampu@linux.ibm.com>
References: <20260525153352.188816-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol04: Fix race in pagecache allocation
 measurement
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

Hi Pavithra,

On Mon, 25 May 2026 21:03:52 +0530, Pavithra wrote:
> memcg/memcontrol04: Fix race in pagecache allocation measurement

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
