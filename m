Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B1DC55164
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 17:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDCBD3E7251
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 19:31:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2BD03E2D2D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 19:30:54 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3340C1000486
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 19:30:54 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e5eef2abaso1946385a.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785432653; x=1786037453; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FS4OjDnJ5bczxnvhcOD4zWEtCNF/4r2Ite8bJ0lZEMM=;
 b=qoLAN2hgsgAatuyC8ZMwgIdKyWCm1VGn6YiWTmwaARuGjzPviux4hHZf6AoDvFrO9D
 0Kf6yh2QVuwg8Gb2U6aYavy1j1tAJpe8IXiGUQ8dsei49ikuQy7C5qtHKIDpxZhkFgrA
 bvjx9AJGSdvWQgEU/S/ZBcdKhmUaG5kTFO+xrVC6wrkpRlEenrbpk+WmBCNEZvDTdQsv
 ucTWZcwM4jns41lHIY4P5PFbwXxo2exfUicKUCyYYYm+KRVrqLo6qq1NpcRVnEpzU0w6
 YmT4nzwarmYy56b1EQyJoOMxEIhLm3yzLl7SbVv3YMG9/80ahqh7khQPqVSIZCkyhH4F
 yFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785432653; x=1786037453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FS4OjDnJ5bczxnvhcOD4zWEtCNF/4r2Ite8bJ0lZEMM=;
 b=D8aEBIiPnMGM10OfOVcXVe+8aMKDH/0SpmS5J0t2QGG95GtnyOeQeEe2uCBvzuoM/h
 ZTEC9BQv6MG4YxoB00/PdVqWRsBI9/UTHVMNIdVJrd2UyKtBQuS6udHHBYKRlarOD9zf
 FIQ5T3JN9IverEOlCj8fdbUtzG+LJoLdB/8ztUVIFBiovvPSVcneh/qMQsuXSOCsT14F
 axBn692ij7BVg2b4icq2cZg49QN4H+VL3f4sNAGggPN92rM6LUE3/CElqSQCdxOuMxT/
 KitUoZ81dp6n+GKPOKXaS/VNcM6JOXK9Yh5yAjwhUm1ejs+Jpn3qr3di+xVTDUPwHJZs
 zBaw==
X-Gm-Message-State: AOJu0Yz7JmKwmecD6+rYhHkHYn+GjJ4CLrfD+jwyKlGcKKqC6RW0DwiG
 vtYCnx2QUA4HnxHysevBdVYDqrrJzVs+f+AnK86nAGAKZqOU7C+6TWCV
X-Gm-Gg: AR+sD11wT7jceYFteUoLbPKGHiofeaSS0nFpaNRegLRDY7+lIFonvIIze3HUz434Aeb
 ASHFb7UnpIJkFO56EBinjQLU93GqW9ezMdPPSiTlyfGqO/e+7IT5Y0vqL1rk4RzDQsFik9+iMDq
 BV2sN4635Xw3VT4stTxJ7ualtfSlMxsXJk8CS03F2Oli3SUFuwKJO2daeLMLkPdU73JkLIUWEnm
 +jC3aF8+DqZOcS4ZENIGH1G26ttPOwaXqfoMyUFf1ItXl/OCI4fYU4VF6AFF3tjgbT3ltIQzJfg
 MA+cIwcvR07ts1Qp1HlOaP5RlC0kRo70saHFWCU8zZyDP2gDAvyVXo1vu3+Z7+mDVK/PYMvuYI1
 uzarYluWLhkTmcIcHgUTahyiVnAAHVVRueV0LIoKWiugtkTImNOtcj0aGIFkhtP9CY7R1cSrCcE
 hcLeSKVZnwJT41+gf8sH+162CGqL5osYPyvbHjDaGEYEdZlSz3WxxLdedy9oomxBGDFfHGAZD4b
 zbHPzsddVSXX6qTrkLXkMAyPHsRS3rhwbFNBmAEGm23GcdvOVJb4H29ntmISN1N57mlEMc6+4e5
X-Received: by 2002:a05:620a:454d:b0:930:f67a:a9a0 with SMTP id
 af79cd13be357-93486ef23b9mr344865885a.79.1785432652645; 
 Thu, 30 Jul 2026 10:30:52 -0700 (PDT)
Received: from
 runnervmvrwv9.ajpjuzvd0pcu5m1ughqrvmkcxa.bx.internal.cloudapp.net
 ([74.235.126.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e733e682sm456116785a.40.2026.07.30.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:30:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 30 Jul 2026 17:30:51 +0000
Message-ID: <20260730173051.4022-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730171956.237584-1-sbertram@redhat.com>
References: <20260730171956.237584-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: fix SEM_STAT failures under parallel LTP runs
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

Hi Stephen,

On Thu, 30 Jul 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

> The per-index lookup duplicated shmctl01's get_shm_idx_from_id(). Move
> the common loop into a new get_ipc_idx_from_id() helper in libs/newipc,
> shared by semctl01.c and shmctl01.c behind a small per-family stat()
> wrapper on each side.

This patch does two things at once: it fixes the SEM_STAT index lookup in
semctl01, and it refactors the already-working shmctl01 to route through a
new shared libnewipc helper.

Would it be cleaner to split this into two patches, so each is one logical
change and bisects independently?

  1) introduce get_ipc_idx_from_id() in libs/newipc and convert shmctl01
     to use it (no behavior change);
  2) fix semctl01's SEM_STAT lookup on top of the new helper.

The semctl01 fix itself, the func_iinfo()/func_sstat() reworks, the
Makefile -lltpnewipc addition, and the kernel-doc on the new helper all
look correct.

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
