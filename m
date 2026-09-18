Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF4CC982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 12:58:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F80F3EA166
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 14:58:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C653E9201
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:57:48 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8D3F600BA2
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:57:47 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a384b5f7so418589a91.0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789736266; x=1790341066; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8urQ4gw2oFkoaVfHuXpa/q0+81yjYZ7jcNVNRgshrA=;
 b=Wq/LdCVjKrjCdFZ9q6GWcUGw4H7GbmULyXwWuetd37cRckHxXU37lTBtEVQgMkYcFq
 +Qk6Rm9NcJXyWT5Dktxwtpg++wVZzCscuze49kx9LIuN9rSbZjUCP421E4gl1dDacbD1
 ABylttfQ0gPdUqbz8QdfqrKd54H0AOQuNvABmEnlLGx0PBqYTnV9yHmIiMupJLFU2MVu
 vNi2abht5dqYDuhxsCHYpO+YkZnJhWO6/K93ic+eYmoviTv05iwTcdvO8WKge3BY0wUA
 MvHhU1BJeKa+xkswKErkYRYxvvRF+ZCgXlODWDZWwChSue7j09mdDOJMep8F54Da8JDS
 Tseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789736266; x=1790341066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8urQ4gw2oFkoaVfHuXpa/q0+81yjYZ7jcNVNRgshrA=;
 b=aNwdDwRE+1PYjZfIvm/8W+Ijjb+ISzhFW3ydt4S+BtT+UcEUWO+t7mZgQ0DOJOkO52
 ZcdTmGUK2YYq81bs5b+lS8OE7yEOGQQk9uleVbz6EU2D27ESYHXCICmcnns6uBbx6Mm0
 P33xywabF5RgKMrOAem+6kJgm1y3X8TTswrqGmi7G7//k4meZevAfijx0NRIBeRXtUxz
 Vq7sUs7r0oDH4JgP5zw50iTAxQuYZJyHy6EV7z43MyBV7Rs15ldP3dpWjRLOt/ZJcgnd
 OzEOgKS0gjlnoj6yVMPv2td+v5Ahir1fnel1t5K8SMxY3zGE05tNGk4VwzZ9Ry74ckxK
 VwBA==
X-Gm-Message-State: AFuF++kAV4jk/MeUDBdij1eVa0NN+UGPBR71UtgN4+UWrsinGrGCbSu6
 JUR1bbnhE5eJMql70h4bayrbvZcRdHfj+0EE6p7aSDrIowEVIhyXiso/
X-Gm-Gg: AYBFou0n9yRwLamTt608NHHd0h6/qr36M7hZQ29eYbVFaSXxO2w1eefDW/Ua5Ibi2Vp
 N6/4uDCRjf3ZZtl4e9ils+4zRRYj0Ldcf1Uxt6ebu2vvX6EyLBZCGuWL2MhzsKXe9z9RcGplXtA
 gvJiX90tdiLzdJnnD4SwU+d9zXAag8SqUCxumQfPmwZT6fCWoHKYwOOIg2k9y6JOtgZr5hKD7zr
 +Lf8kRt91sPiPXgsWEQMRHyVfiOd/NcggOxEbBcPnvxSKrj+viewZOvAYk2S3UoyXBvg6Iq18rL
 praDJXjSmQla/XZl173jxSI3gOK2uhVuyegk11v80BqHmDfnbH4Ll6YRZSkrMb9tG8yXo9DycfY
 iJVnumSnR5Q+KlvFMKLKVYYFGCIue5Kmm/J/jhnKvnD+IQyff+u4HzEPfCbQhMON0YqN7eI8i9N
 s98vAVEYhKLmpMbke6FlsufIbdkQ0pMlDI4J598ims0SKsDUbJblP9qqbYxgipMmRUhJxppzSdo
 prEzKsUUt4RMhgIc0tG/h6JFlHzHDExUtW8GgpXXtHOgBO8bs/1lzi72LZOOrsPf/qOATNRBUiO
 O2Pv2pQQCuKn
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39e54dcd917mr9460437a91.6.1789736266004; 
 Fri, 18 Sep 2026 05:57:46 -0700 (PDT)
Received: from
 runnervmlun5p.5qr31r2nspoeljg1erhdaodzzd.phxx.internal.cloudapp.net
 ([134.33.102.52]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144ce02b063sm3724087c88.9.2026.09.18.05.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:57:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 18 Sep 2026 12:57:44 +0000
Message-ID: <20260918125744.9214-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918075228.21423-2-wegao@suse.com>
References: <20260918075228.21423-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid
 success path
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

On Fri Sep 18 07:52:21 2026 +0000, Wei Gao via ltp <ltp@lists.linux.it> wrote:
> lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path

--- [PATCH 3/3] ---

> +/*\
> + * Verify restricted opening (:manpage:`open(2)` and :manpage:`openat(2)`) of
> + * FIFOs and regular files in sticky directories. This protection is controlled via
> + * `/proc/sys/fs/protected_fifos` and `/proc/sys/fs/protected_regular` sysctl values:
> + *
> + * - When set to "0", writing/opening is unrestricted.
> + * - When set to "1", O_CREAT open on FIFOs/regular files we don't own in world-writable
> + *   sticky directories is disallowed, unless they are owned by the owner of the directory.
> + * - When set to "2", the same restriction also applies to group-writable sticky directories.
> + *
> + * This test requires root to modify /proc/sys/fs/protected_* sysctls and
> + * to manage file ownership and permissions in sticky directories.
> + */

Use double backticks (``...``) for inline literals in the reST description
block instead of single backticks or unquoted text:
``/proc/sys/fs/protected_fifos``, ``/proc/sys/fs/protected_regular``, and
``/proc/sys/fs/protected_*``.

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
