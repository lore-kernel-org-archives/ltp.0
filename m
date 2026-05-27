Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C28CD5BD0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 22:06:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 634CA3CD380
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 00:06:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2FE93C0EE0
 for <ltp@lists.linux.it>; Thu, 28 May 2026 00:06:15 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B18F1400C6B
 for <ltp@lists.linux.it>; Thu, 28 May 2026 00:06:15 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8be236ce888so118086946d6.3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779919574; x=1780524374; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxWdHCNOyvmBa1l5Znb7REtCwamHEmJaf/5hIdZ6p4Q=;
 b=Dtq1axbBhyFZugpJohbe5XQkU/8gUML5e+xyMls8epQ/tq3CveJCJ17diCiE+XvS+n
 b/p/S9nmO4ZHXudJhBCW/Dq3YBzEqknIFHKKeTWdU5RRIM0ZnfGycxSSnysnWF2lP/e+
 iX0LNWtFMKPv8q5D8NKWm3wY7KzcUz0Adq5LESWN6OHE+31UHZUA1NkOHDj8zQy6Yt29
 Sdzu8sR0q/xbdPYPsMQydj6gqpwO2mQtxSJMoCHoLCGC4tFPu6sbhGLHFVxm0oBbg0qX
 223yr2vlf5gjVFCEvp3qPN4R9l4BhrjgVctiuvau65H+yYWZskSjQxfOlddpBrQdE3bE
 ByKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779919574; x=1780524374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxWdHCNOyvmBa1l5Znb7REtCwamHEmJaf/5hIdZ6p4Q=;
 b=NG6VYHtwhrUU9gFWAxLMaXiNPMUofc2OznpYiA3z5erdpPXTEXslX0zFCWMNr4x5+D
 7hEsindIx5zXrD6K+9EVkW1HJKpravGgU5o4WbdG+m76qzv7L7OSsddeC2ighCRYTTNS
 jEFVNEiQhXJrF+0nx6cR0t0wkfs/WbFZPldxQt6eHCKWx28LfQg/B3kqr+9qBglu2oKE
 bJY9zecYjj3DTlUKnDa3eKU604yKm08iwbEhxIXsR1NF9H5BhjfcfB+UY0Mhyw8snAUJ
 +E7ncZBJNC3ySITV1aPSPKYoGhjdVPmrPHlgtoZnQUTPahxo77t7+VSMUsBhFotSuN2B
 HihA==
X-Gm-Message-State: AOJu0Yx5qtGxN6mlJAfG/aR2Who/Xv7m3MOTofp5YKHPDNMDnu6ycrmB
 lRd2iYfmfseLuL2HFcObGppxBKtQJRvPei6UWJsU4yru0NT73j4VZAaS
X-Gm-Gg: Acq92OGmv+UUWbJAIELG7yXqwQXX6iGYXPZ5y2F3vudrfttyayJjKBP/JSm4OTYiFVW
 AFJmWo7w0WrLuhhyxdc0MEihjclk2iBzy+vgx1yw2+IzTtID6jnhnfV+R9OUWU8IkBTe/wWhcUv
 2+DjSVcfatWqu2zY6fTgOesGiiy1IluG3DOcQjzmri5AzqYDn43X7YwG7W1AYSmg95zOM1Os0vN
 wUOLzzAj8vt3DmVZsJ/fq+GCWgEGU9YrzTnnGNkOIrj32PhJulVxUS4CxoRkaLHBYXtAQhbZ/rX
 g2Lb2X6dXzI2XIE/jIUZ2+zkiKHhNzyEMyVPo3rWNIR39oN5AJ4gPg1LqPU1ft/poRQ+D6hyIIY
 RCZfODcHkBc4L/jH0/VZFTfb9/SVHGdfFYqqym2C5YqyBTWFcYlaDeIldbWfm5cwp79Rdvn9OVS
 shMqlym7MHB/vAY9hDpnXCYJ5sglVYIbmoz3S5c8V+E+4Ef/MftFkr6kBBFDhAfocGecyHV8Gwn
 XoLRNU5tl+j+0ri+Y8MOwQSXvPr2Fm32Ve5VGyzBND/Nl2O
X-Received: by 2002:a05:6214:5244:b0:8cc:1010:bbcb with SMTP id
 6a1803df08f44-8cc7b675899mr402074096d6.27.1779919574081; 
 Wed, 27 May 2026 15:06:14 -0700 (PDT)
Received: from
 runnervm3jyl0.guklbwq1g02unjtnn4f2llqnib.cx.internal.cloudapp.net
 ([48.214.53.82]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e60ffsm197800546d6.23.2026.05.27.15.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 15:06:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: AnonymeMeow <anonymemeow@gmail.com>
Date: Wed, 27 May 2026 22:06:13 +0000
Message-ID: <20260527220613.4056-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527195056.337081-1-anonymemeow@gmail.com>
References: <20260527195056.337081-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify: fix crash when running multiple iterations
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

Hi AnonymeMeow,

On Thu, 28 May 2026 03:50:55 +0800, AnonymeMeow wrote:
> [PATCH 1/2] fanotify: fix crash when running multiple iterations

This commit fixes two unrelated crashes in two separate test files.
Consider splitting into two commits for cleaner history.

> +static void clean_upper_dir(void)
> +{
> +	unsigned int i;
> +
> +	SAFE_MOUNT(OVL_UPPER, MOUNT_PATH, "none", MS_BIND, NULL);
> +	for (i = 0; i < ARRAY_SIZE(objects); i++)
> +		SAFE_UNLINK(objects[i].path);
> +	SAFE_UMOUNT(MOUNT_PATH);
> +}

SAFE_UNLINK is called unconditionally for all objects, including
DIR_PATH_ONE which is a directory. delete_objects() correctly uses
SAFE_RMDIR for directories. This works here only because overlayfs
whiteouts for directories are character devices, but it is fragile
and inconsistent with delete_objects(). Use is_dir the same way
delete_objects() does.

[...]

> --- [PATCH 2/2] ---
> fanotify: prepare tests for thread pidfd reporting

> +#include <pthread.h>
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
>  #include "lapi/pidfd.h"

> +	*(int *)arg = SAFE_PIDFD_OPEN(gettid(), PIDFD_THREAD);

PIDFD_THREAD (added in Linux 6.9) has no fallback definition in
include/lapi/pidfd.h. This will fail to compile on systems with
kernel headers older than 6.9. Add:

  #ifndef PIDFD_THREAD
  # define PIDFD_THREAD O_EXCL
  #endif

to include/lapi/pidfd.h.

[...]

> +static pthread_t do_pthread_create(int want_pidfd_err)
>  {
> +	int pidfd;
>  	pthread_t worker;
[...]
> +		int status;
> +		struct pidfd_fdinfo_t thread_pidfd_fdinfo;
> +		TST_CHECKPOINT_WAKE(0);
> +		SAFE_PTHREAD_JOIN(worker, (void **)&status);
> +		if (status != 0)

status is int (4 bytes). SAFE_PTHREAD_JOIN writes a void * (8 bytes
on 64-bit) into &status, overflowing into adjacent stack memory.
Use void *status instead:

  void *status;
  SAFE_PTHREAD_JOIN(worker, &status);
  if (status != NULL)

[...]

> +	if (tc->trigger_in_child && !tc->want_pidfd_err) {
> +		int status;
> +		TST_CHECKPOINT_WAKE(0);
> +		if (TST_VARIANT_PIDFD_THREAD) {
> +			SAFE_PTHREAD_JOIN(worker_id.pthread_id, (void **)&status);
> +			if (status != 0)

Same int/void * mismatch as above.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
