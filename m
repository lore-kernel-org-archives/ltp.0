Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D892DCD8CA4
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 475203E6F90
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:54:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EDB3C0322
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:54:22 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E95E140098E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:54:22 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-137dd523634so6879281c88.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780930461; x=1781535261; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOdw9cCuEOIwi+tKQqPOZIqgpIjmcy3XROK5S3UwD2A=;
 b=ZSU2OHv1jue8V8I2bBNSyMUDWlrhfreKDuWAj7vSBv4aQFpLRPC+oHzItw0Bd6pBmb
 V/zRKcQ/IVgXzj73PjOSOYEOt4ZVhBAmcBUEVysAQbsUfMT/tDBsHRMfMV2wo8TxgGMr
 RSr/JxSWnO7oKFdB1Pp4pVIeAJP02nGzq0EXiQ3cS4i2O3VfqIzdbvAQ+JQWfGO8Nuwq
 BiRkEtPFDo/WzLMoueBtMiuTOOVyqc+fUJvbefXvnzTjJmSenzlCqRNi1Hk94ostmt/2
 D4nclRsh6sFR9hgt5DIscKHXqIrjYRHyf2n0IEpWE8zO8YAMB58lCYBZpIip993m+pGK
 ELmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780930461; x=1781535261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOdw9cCuEOIwi+tKQqPOZIqgpIjmcy3XROK5S3UwD2A=;
 b=ibdOzDs5ghtqRaCuQkEKK61DOFAwiTnwaBgGTpAMqaehxxwheShoClky6vHqh5YvM5
 olSatmpQN9cIzy8fJ/XVDA++M3S67pQgGQBkr6t9ZoiGHkPoWcO/vFslo2xVs/9fr5HW
 aS/Li9voF4HdAU8ewxcx9rDH1yIVQvop5d6w6lKAr7ywGIlGrFxCj40Do2k1B8s+yjUs
 BEreMex0Ue+NRO7vjTKh8tumptLvTQo4BH6uS91sjc8tpHx2bKToYWBbBklmEmrWAp5A
 a3sx0tKo++4tiU/JqAGJ2eogK7UD/jqM1RSWb6nbo6xLhHcVJqoFxPv4x1a1fLvcF/Nz
 ht5Q==
X-Gm-Message-State: AOJu0YwHvBvqlVUrgSbY2VP8e+8AqOF/ITb/OmbBm1Ucyd/eTVbNxrPd
 f3mGpWSnYkj51fRSA7BcOlSF9cMUje9bTO8dq6Rk2LGYeA4l0xqtB3rP
X-Gm-Gg: Acq92OHgXgVxNTv8Trf9aQ2MmyWc5KX0H3tKd8TVost/po3Cro/USTazVdT/BNLayaH
 z5T5IpTfNxFRaseGdu+VpUA6Y7s+NJvfhVIrE/U2wYtzPODkCmwOZQ/FoBOSntRuOKYUKHB3wWb
 oQm/ogjSX7RVK+HjfTaGCmoYenG7Q29AJa018ZLkKgaF2M0Wco4GeW3ZpWO1vFY7y3hX2e26CtX
 64Twy5+PwN5NYviQpaoDmVQqUACRT4V6nI1NBMI1Hf8jvE1YZzKkY7dzucdkm1w0c+HFlSzU5Q2
 ectDm9xPHVnkIQ161/eIHa2fJy3/FHuWDwIW9jbBgWYA1noZS8ctJMYzeMO8blAjpq5INLfkNsc
 BqzpToQxFAHsXXEoAQnQBfIEuekmn/NcE+a9N5cBmPYsPvVvjtYKEzYV+0Qi66sjgd+U6E6zrjL
 IJoRcuTY5NQRvD/owQSySpokIdJ6LuJEINh41gcAhhZJtgg9MGSWeX+Zn8Zv+JpCFJbRd89eIZZ
 MKQKME1t9pEEa1c0vjfTnBJM3h6m/NJA3JNgp9FYJVrNGDGBSq/ZGnYUvvPp18=
X-Received: by 2002:a05:7022:1a83:b0:138:e4:c44d with SMTP id
 a92af1059eb24-138067200f7mr6728560c88.25.1780930460442; 
 Mon, 08 Jun 2026 07:54:20 -0700 (PDT)
Received: from
 runnervm3jyl0.fbcs4f1a0mzurhha54c3jlq3de.dx.internal.cloudapp.net
 ([172.184.172.216]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f554f732sm11918688c88.12.2026.06.08.07.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:54:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon,  8 Jun 2026 14:54:18 +0000
Message-ID: <20260608145418.4160-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608143652.6356-2-sebastian.chlad@suse.com>
References: <20260608143652.6356-2-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Redesign common helpers to follow liburing API
 conventions
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

Hi Sebastian,

On Mon, Jun 8 2026, Sebastian Chlad wrote:
> io_uring: Redesign common helpers to follow liburing API conventions

--- [PATCH 1/3] ---

> - io_uring_prep_rw(): generic SQE fill for read/write perations

Typo: "perations" -> "operations".

> -static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
> -                                               int fd, int opcode,
> [...]
> -static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
> [...]
> -static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,

This patch removes io_uring_submit_sqe_internal(),
io_uring_do_io_op() and io_uring_do_vec_io_op() from the header, but
io_uring01.c and io_uring03.c still reference them until patches 2/3
and 3/3. After applying only this commit the tree does not compile,
which breaks git-bisect.

The false-positive guide (section 10) lists "remove the consumer
before deleting the API" as the correct ordering. Could the series be
reordered so that the callers are migrated first, or the header change
is squashed with the caller updates?

> +static inline const char *ioring_op_name(int op)

ioring_op_name() was previously called only by the removed helpers
io_uring_do_io_op() and io_uring_do_vec_io_op(). After this series
it has no callers and is dead code. Should it be removed here, or is
there a planned consumer?

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
