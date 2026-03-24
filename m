Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20BAF54AC5
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774363704; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=JyBgwa5es0r2I+6ozAJnNWwHoHllZWm4Cj/Q1UiAf50=;
 b=XIxAstKBWKWrEaIIFbsFmLM1Jr9MagisO5YWr3PStdZ1xw05P1MK7CsSJprZD2twJLqyf
 9NoO41dsP3nXQ9y6WOa5T6hDZawMli6rBc6DqhRQMs1U/0wIM/Sh52MJhUuYnZaNhBbgJbd
 kjEEzC771NOoamr0EQAR/+0Ip9pYbm4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BD103E5546
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 15:48:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B363E1365
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:47:59 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 273EF1A01079
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:47:59 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486507134e4so17105895e9.0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774363678; x=1774968478; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=h/oaXjhGeyIIUOzOnfyDMgSkVl7pxtznPFFbCVzwhis=;
 b=KWhi+j5F0esjbP5adwiu5Ht9qjLraY0TzxXiJUKCq28lBMq5H6yVKU2pF9s81RO9JN
 jDFLEbziARRUHX+xq40znnQXgJ+ak3BqUf3ml5o3KojESfBI1BEg9gkNL86eYZuJ9q9y
 u/JhQvz44pqaSyaPE/xjplfqVW3nQJqwiF61BLDb1+RpfKo+krlbFefjtMQrOH9ubpyG
 VAjF7C8qId4MH2P/bJc+qILdt0qKpYWVFNFzGRZzrbD8p11mTIqnQdq+lB0qQmdBAJj4
 u3+gI363Xwu6M4/pF8OA8C4ynntElI9aB3OeiXKVvfs6mEDyVet0ULMTkloI8excSNEv
 ibVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363678; x=1774968478;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/oaXjhGeyIIUOzOnfyDMgSkVl7pxtznPFFbCVzwhis=;
 b=SRMq1kUHPVXQSTqufSLS1mZtIrypDrRPgL49DJLpPD4SlsS/RKsOPBKDyjMolcPNGM
 mpjsAwPIi6/xRIk4w8jsubDowz8u80qasVYC6ZKMwAFWLodfBMLM60sFi7Zs7fF3M7Ua
 vniwrZbkOzbJSGhmI7pLPAyxefWnQJ4U5LwkaAAL/jHGP0QtyLxWKRS8O1309IBw8no+
 6yiOm+KDWpmfU9W+m9UWg2AmDIU/HmS6OLszbktJNeNRAosGux+XYuGo1VGYD6dOZR7x
 yK3PPzJmwVdbzXIesEhlLNEKup4vTJYD+t2VWJf/1wFWR7cIawmm+NaDNF7eKhG7ThE8
 L2FA==
X-Gm-Message-State: AOJu0YwDY9z3rQPn75WHQSlAAp1u7L0ZwcZ9zzHOPULKTMzogsN7fuvD
 06t8LX2d338P49fO1HrNx2990JWVoDb/L+iqMelsu36aK1vfAZyd1m6Q4wm6zv0PpyQT4dZmo1h
 JsDP/+hI=
X-Gm-Gg: ATEYQzwkf/ygNrCjHRzMPBxipROPNzGBFHC4G6c5gI0wVYzx3cVaHaA9sQ68Gf/REF1
 JHPRGSmrdImehSwMZ4UPueMWVq/mMKYNbqu4e2tcwz+eKAMxJqJPixaipQRI9YvCubPw1vHamiA
 /N+9n3yJ9gs2eN5MpWAZj1csfPhMfvXNPquzt7DjG7jZYUdacMEwrQEPdTFrg0Si0r8fkIIPoCw
 i/bYyGz65rdBhoriC6xT9Gwe3ZvaY76EZtmRSS+f8nSoQF/ORuc6OKuJB0sO3Pz+yuk6vU2f71k
 M5kZSPEBITJ7omiN/VQu7GeQ0ur25TNEQQD+DZeqTdSl4PiWye+JjeuCU7lBzg/H632h50vW28Z
 cZJLwOrS6GcpN1UzK30FG4vEgXw+dhGdzqIZJ83sV4lmuCIDaIPDF7mNCaMfNhwYb4bgUouD/Vo
 OzlAb5ecwsafnbvVFwoEJJplfpgoltcNzioLt9pEn1
X-Received: by 2002:a05:600c:1548:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-48715ff7432mr979125e9.15.1774363678383; 
 Tue, 24 Mar 2026 07:47:58 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871105c799sm25753795e9.20.2026.03.24.07.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:47:58 -0700 (PDT)
Message-ID: <69c2a41e.050a0220.1db94b.c696@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260219163507.24341-1-pavrampu@linux.ibm.com>
Date: Tue, 24 Mar 2026 14:47:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH]  Migrating the libhugetlbfs/testcases/quota.c
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

Consider this as a simple first-looking review. Probably more will come
when you will send more patches.

Thanks for working on migrating this test. A few issues below that
need to be addressed before this can be merged.

> +/*\
> + * [Description]
> + *

The [Description] tag is deprecated and must be removed. Just start
the doc comment directly with the text.

> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/vfs.h>
> +#include <sys/statfs.h>
> +#include <sys/mount.h>
> +
> +#include "hugetlb.h"
> +#include "tst_safe_macros.h"

The "tst_safe_macros.h" include is redundant since tst_test.h (pulled
in by hugetlb.h) already includes it. Please drop it.

> +static void verify_quota_stat(int line, long tot, long free, long avail)
> +{
> +[...]
> +		tst_res_(NULL, line, TFAIL,

> +#define VERIFY_QUOTA_STAT(t, f, a) verify_quota_stat(__LINE__, t, f, a)

> static void do_map(unsigned long size, int mmap_flags, int action_flags)

In this function it's better to use goto to cleanup memory at the end of
it. So we reduce nesting after mmap() failure. Also, should we TBROK mmap()
when there's no quota pressure but the syscall fails? At the moment we are
failing for mmap() for any type of errno.

> +static void test_quota_scenario(int line, int expected_result,
> +[...]
> +		tst_res_(NULL, line, TFAIL,

> +#define TEST_QUOTA(exp, size, flags, actions) \
> +	test_quota_scenario(__LINE__, exp, size, flags, actions)

tst_res_() is an internal LTP API and must not be used directly by
tests. Drop the __LINE__ parameter and the wrapper macros, and use
plain tst_res(TFAIL, ...) instead. The failure messages already
contain enough context (quota counter values, expected vs actual
result) to identify which check failed without needing line numbers.

> +	if (actual_result != expected_result) {
> +		const char *result_names[] = {"success", "signal", "failure"};
> +		tst_res_(NULL, line, TFAIL,

checkpatch flags two issues here:
  - result_names[] should be static const
  - missing blank line after the declaration

> +	if (mount("none", quota_mnt, "hugetlbfs", 0, mount_opts) == -1) {
> +		if (errno == ENOSYS || errno == ENODEV)
> +			tst_brk(TCONF, "hugetlbfs not supported");

checkpatch warns about ENOSYS here. ENOSYS means "invalid syscall
number" and mount() will not return it. ENODEV alone is sufficient
to detect missing hugetlbfs support.

> +	.needs_tmpdir = 1,

The test already has .mntpoint and .needs_hugetlbfs set, so it gets a
temporary directory via the hugetlbfs mount infrastructure. Is
.needs_tmpdir = 1 actually needed here? If the test does not create
files outside MNTPOINT (it does not appear to), this can be dropped.


Also, in general, I think that we should have multiple test cases for
different types of quota, instead of calling the `test_quota_scenario()`
with different parameters one after another. In this way we can organise
test in a better way and reduce redundancy inside the code.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
