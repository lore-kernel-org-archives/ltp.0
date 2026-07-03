Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF28C43327
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 02:57:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28BD53E724C
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 04:57:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D833E4A28
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 04:57:00 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99F31600A3C
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 04:57:00 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-38109499830so38416a91.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783047419; x=1783652219; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eJn0Z37QhncetZX71I+jNzjXHLmLcX+cWNSg/RVKPC4=;
 b=cCTLRX2ct7J2B0qJz9Zrp2SeJ1Ng8dlllkr3EbZtrkJ8iBgsgPJrqyp3WKvmydR9Jc
 quPSbn1tHSHh6eWysLS7l4YKSw7u56hNSFmjPpCSl8E6vim6zYhvH9cLRzETt9SBHPSP
 5AzI/hJ5UL1OPmXN3fDlAryS+1bwCCYDBzX8qwmumwU4z/f0h649MZXKu7OcUWafbNxs
 u2H/S+YCrAna1EReFuNsJhGLy5lFYYrTrsr+3yetJ5zEo8+1KoM4C7sDsVPX67y2VKdu
 xGcgaUwosEbNszMKnSdq6YEX280omnvaONKu/rMt3br/xYUMJJZx4y0BBkBOnUlcsJZC
 qxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047419; x=1783652219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eJn0Z37QhncetZX71I+jNzjXHLmLcX+cWNSg/RVKPC4=;
 b=rxZXB5BsM2qwQ3S0JhZaDG/S3uogzgieOnbRnDmzhclPUsJqMHAmVYRnLU6ExlRxhP
 mclQqrts42ExjTrEZvRAIvt8EbrtimmNavqyxzg1bhoQ3FcN//v0tLQz/WDvPhPrt4ET
 m7Gh9pq69fhOJ7R5Cd1ULwqU5FOWZaXZVXLN4e5aQXDW24QYGrfiVN1+7SiCa/ShC7U0
 Fd+3uVFPlfwA47efnaJBJ6c1FtmHI6nUjrvqE+ucPgCH3lcoGQBR7ympZ3L2cpctWriO
 Uuh807wPtHux3dej+afW9CmvIXOn1+JvJjctX+3tovs2p+4jSoUePDhhUph7kEvQezt5
 vlwg==
X-Gm-Message-State: AOJu0YwlVwcGRa1dhAFFlWPRiUSyXMTLxn2DRsvnkgSSgKZoy0/fFKX/
 2zxB7j3zLTGG5OnDyToJIRaJiNnQQAQKxuNgEYicTlvJvmzwVzRXOjjdXrpR01e2
X-Gm-Gg: AfdE7cn+kUDFkNK3vfdGslSNp3aguIZxBD1/lyrJPbT+8rLkW2SbToUyKeWF95AcRn7
 461XIngX9ac8ULNEVttDNU1UBO2lwo5/BxUvqZ9AexIeZm/o0165mWz9JxU99O4ITzOphpDVzgf
 1qPTemFI+tJUyhZ677AzKlqoFrfD5+CDqo7+vQdJLk821JV5XSYjXb5NkYnNt5uU1wF86wzZo4H
 /KKWug0UGpUffjpTW/2NTi/7/uUzTHDKIq4/NNVoCfJhLo7CQfRbcT9G8QBGcRKJy2090MaksSE
 2fZDf+9EsPcetxFyQrD7XsoiNa3zy8vNUId0C+MwNrl1UXUvbQCi7hNgV83ltSUpib7I8u5Ivir
 1LJ1L7/Pt1zYkHdTSud2hgvpISNdDiEQnVYkQNk7JNGRtq9wfK42q0Rh6DXY3rwtgAaPbL4YdBT
 CfRAdC10YqyToEp1kvLYHg3PljgANWeV+jZKd7mejen3F61NpYHFdqaeUVKEEnf4KhtQOtKu4U9
 smOLyDdUn0lUj3hSVA+RmjillUGU6OlIvUlMw==
X-Received: by 2002:a05:6a20:b40b:b0:3bf:7081:9356 with SMTP id
 adf61e73a8af0-3bfed1dc2f4mr10402087637.17.1783047418672; 
 Thu, 02 Jul 2026 19:56:58 -0700 (PDT)
Received: from
 runnervmkkn4f.asvzwpaisvpufprmrd2hncfpjb.yx.internal.cloudapp.net
 ([52.161.57.34]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7bb8fasm14280310eec.1.2026.07.02.19.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 19:56:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri,  3 Jul 2026 02:56:57 +0000
Message-ID: <20260703025657.3966-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703015745.20728-1-wegao@suse.com>
References: <20260703015745.20728-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] statx/statx04: Skip vfat and exfat filesystems
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

Hi Wei,

On Fri, Jul 3 2026, Wei Gao wrote:
> statx/statx04: Skip vfat and exfat filesystems

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
