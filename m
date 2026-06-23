Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DC0CD98F2
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 12:14:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DEE63E6558
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 14:14:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76D853C041D
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 14:14:22 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11EDB6008FB
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 14:14:22 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-519eedc30a3so42957221cf.1
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782216861; x=1782821661; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmLofX6+EMP3NEwoCI48w2aNkiG0CKE+w+VdCc+Q2EI=;
 b=NJE8x5j/fg2gNV8kYT6/4SwBp6q8gMY97lAkCwZYX95PHwzTEogz4L1WtaGHeTe7Xz
 9kCSceoRPIjs4lXyrc9dSdLj66X8Rb/LtSnZR20B7p+PvXD4U/iKeMvUDKe159FCsupf
 yzf1b32eedAfH6wbjb79VLx8ZE6VPo0HDAOqmybCQymjkNAhoSsiG16uXtRqNWFE5REC
 XDsrKzPKu8vMsY4zWrI1JenLLvDtny9pSBxyF1EpdkOMFC81SgAlox4W9saP6WUOWiaK
 8rghfJrLNd2xB/bBj2sChDMSe84fvX1BiN6SXAIS0DS4POUqzwt4AR+z5RXu4oZdT4ST
 ORLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782216861; x=1782821661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FmLofX6+EMP3NEwoCI48w2aNkiG0CKE+w+VdCc+Q2EI=;
 b=JwG4GhSX9JVT2sEfUH8zTe8fLDWh0kXYpIItGcd5X3Y7S06B5UeEU5ZYAT5gFsDFRQ
 5pWONkQm4b8z3EeEosiHViiAoc/Tt3EGRPj/odeD3zbup8gJLcDwcNgk6Bs9QKS0B2aK
 5xxCy/VOObLSSAi6xF49df4p+uOOo5dd2ZnxT3A5pkneGDKuOeR++nkovRCewW4R19jx
 JtEx9GdtpcVHE5pliwX38EnUiE9HjM0lC0ww1RF5vfbmW7o/S5QGW2aImEO5HFu0Hhoh
 l+Sf0Rp0QYq0feeG8OOp8wrO9RI6/g6V4qP2J26TZuFrFMKHBHM84dDUIbZWdkbJw9Jb
 ZxYQ==
X-Gm-Message-State: AOJu0YyMc4LD+Lsv+Xhl5csU3Ehzcm9l5u6T2CfTZSGzG9xculi/fl6E
 Acz7kbYlpvnFKR7qpdcroUpACKB9DAlbUW7b15In73QPt4HoeWhKmx5A
X-Gm-Gg: AfdE7clGcHfeyOPwWZr32dR4My4QPTpuK4JCMcHMAOpJuRxF/UkWntZPp792kjMCNcV
 Q2n3FGCehcwG3yGxu51Q4oSlfefSjohn3ww1cJAK0Wwj/RGU99HsPHucs8hH/uVPrvPsSBRLcWB
 7smhOSOkuvX/i7nz2tfHm6foQfabD3MzTvKcZpDxpPCS9N4TdvrUcaVnSRQrUyZhN3ue+cYV7Oe
 +ME0JLuthcJBO3w3joZbjxEEY1NghmfeGqt0c8MPABP5Ym7rlKiuQk3Fr4ZHcrPEPkrHsGAmbgL
 Ag8/tpOvdtRz6Z59YfmtvX2TwDOoVtzpNAeG/kerfv5dREYJwI7meCFCJi/EAOKC3XAMV3pTC1K
 o6+NSoM5ISM8Ur4UETjgnS3ZDJC8Sa9j2v1b5BhwzL7dFFq3dEx+98PtYEhow9ZWcj0gVA8Vr19
 //Dx/drY5woNwNNcfQoXYXBGTY+KlGJSjQtD21tOGCY+K6g5DKpUTwVctHcW2ejeli7W0FUATfy
 zROEgjOJJSif35jKBtVSECHqTI=
X-Received: by 2002:ac8:5883:0:b0:516:e085:b76e with SMTP id
 d75a77b69052e-51a5579e249mr33287731cf.0.1782216860808; 
 Tue, 23 Jun 2026 05:14:20 -0700 (PDT)
Received: from
 runnervm7b5n9.5lz0t1jpl4juvdzdnrubm1g2wb.bx.internal.cloudapp.net
 ([20.119.79.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a514b50b9sm21601681cf.3.2026.06.23.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:14:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue, 23 Jun 2026 12:14:19 +0000
Message-ID: <20260623121419.4156-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623113422.188364-2-piotr.kubaj@intel.com>
References: <20260623113422.188364-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

On Tue, 23 Jun 2026, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

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
