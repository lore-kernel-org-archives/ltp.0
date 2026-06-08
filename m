Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7077CCD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:01:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79473E5F88
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:01:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1F73E4E83
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:01:15 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E424F600F05
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:01:13 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-3042a388168so2268204eec.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780916472; x=1781521272; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW0QUc/fyO6oRvYvCQ8IX9qBO0WZPTRGHV8hEo3RmBs=;
 b=eTrJLV3H7cGvLBYbjJIYm4wsCbqXohQ7IPT0c/Nfs7TAfw+MC4dwkkJqz/EAof29Zq
 1S6VE+X8XWF6kFDa+oLG2eSXeY8+R0k5gjKMGXcvT/CLGPJIsnzSnM6pJcc/+aJ/rLJI
 U06o17iC9zFsidOfB4i/Y6GgR7L/wCeEr48qqvLyS6PmjB6c/EEhNtunqJRvYDLIYV69
 fizjtEORJEPKKC9BqtE6S8dyyOmqzzTvL4I8KaVJKJnQIR8fcKv+QH43YrNYDdZbfoz5
 dq1KyDQvb03ydnFmAyH6DWv0odBYJTTExelVETL6Zg6WUi6pmZNjTYCntMbtKSRJM7CN
 zkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780916472; x=1781521272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wW0QUc/fyO6oRvYvCQ8IX9qBO0WZPTRGHV8hEo3RmBs=;
 b=sOgX1+sXC2b4lkW30iSI9CmOupEQ/LMS8w8ItrvEbHDU1g3lYYPC2+6Q1P7i/IKmo5
 FYIToIgdKoDxXCME0jyUejfFph2N9PyOk+1l2lWNfR7FsUy4E8QreHH8MiWjazhZ/D1i
 n3UuQ+vdB5X9iNHDC59d4XfVABWomvu4beblmja3Ffgl9UQyVWIEJfcvcMi27llZbR1z
 vh9GZLnAHEEk7gAt7j42+DhZt0cxKGs0wLxM/SdZq/mFVLnyuTkOHSU1W90MmbqAOpYj
 1LUnABGuetYrBDHJpHjuskuSzYCM9TSFBOyn7pUNTdFUym7kREMUh0zhoR0nuQF4SmXK
 OgZg==
X-Gm-Message-State: AOJu0Yx6p7CNAb4cz+ulMZnC7I8eOtTn77wuhQMp3XojN18h7aoDvG9y
 2vM7J1aJT88WKDxUsz49lJUanX1T2vl0VD7MR9TZWA4G6QYwq1mPAkV/6Vi7pVzO
X-Gm-Gg: Acq92OHQMpUulzcFAoRCnmmdhN5dhBWoVlzLS9QWoW2P5i0S+ShsEkmeuE9219AMik+
 +vx6t4xDXE8xSNoQIsmpk8+uYgzbBxMYKLwGwQEMgXPpIVdxRvf4NGhQQ+LwmME49wRtLc4TX5W
 I1jbynd6CaxG2nQDzWcEMfrGvP2q26uKeo92NI9Bt22ekm4YsZn5EmKSHWF3qj+c1kix2cjJIWu
 oZTEQ2F9Td0KIOjnLOMeF4iWmM3JX5oq7bPrO+1Qws9xSoCN4PFNA5e98anT+Uj5cDSrDGwCxrq
 E1joeXE/aJUnVdFqcRIUVi2JohXw4oR5qzAnJ1abIC1Y3zziELQHCvCISHTkVu85/4sXFHH/LyK
 puwsPUg22RH7404h9axz0Pzoeu630X+AvYbNBWyz7vXzsueOfIUP2XvWZxoGrjVgxEDYdMAYG67
 miEC05T390PK4WnGlKzj9mVY+uDnibP0sFR1uYkOd4og0sYHiGtoMB+eWYr1w9/6w9u6LYkaE9C
 8NjYbbH4mXu2Xowh6Br5uWY3IHaUgNCo5K+tgGFM4lYeglO3Zk=
X-Received: by 2002:a05:7301:420a:b0:2ca:bd22:6102 with SMTP id
 5a478bee46e88-3077fff0c2fmr3980584eec.14.1780916471975; 
 Mon, 08 Jun 2026 04:01:11 -0700 (PDT)
Received: from
 runnervm3jyl0.gqycc2zpl1wenkeeoydy3zbfbh.dx.internal.cloudapp.net
 ([52.159.247.233]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df349d8sm16580059eec.22.2026.06.08.04.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 04:01:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Mon,  8 Jun 2026 11:01:10 +0000
Message-ID: <20260608110110.4175-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608092200.92827-2-sachinp@linux.ibm.com>
References: <20260608092200.92827-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

On Mon, 8 Jun 2026 14:51:53 +0530, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 1/8] ---

> +#include <sys/xattr.h>

acl_lib.h includes <sys/xattr.h> unconditionally. LTP's configure.ac
checks for this header and defines HAVE_SYS_XATTR_H. Other xattr tests
(e.g. setxattr01, setxattr02, setxattr03) guard their code with
#ifdef HAVE_SYS_XATTR_H.

Each .c test file should wrap all test code in a file-level guard with
TST_TEST_TCONF in the #else branch, e.g.:

  #include "acl_lib.h"

  #ifdef HAVE_SYS_XATTR_H

  /* ... all test code ... */

  static struct tst_test test = { ... };

  #else
      TST_TEST_TCONF("sys/xattr.h is not available");
  #endif

Without this, the tests will fail to compile on systems where
sys/xattr.h is not available.

--- [PATCH 6/8] ---

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.forks_child = 1,

acl_link01 never forks a child process. It does not call SAFE_FORK(),
try_create_as(), or create_file_as(). Should .forks_child be dropped?

--- [PATCH 7/8] ---

> +	TST_EXP_PASS_SILENT(setxattr(TESTDIR, XATTR_TEST_DIR_NAME,
> +				     XATTR_TEST_DIR_VALUE,
> +				     XATTR_TEST_DIR_SIZE, 0));
> +	if (!TST_PASS) {
> +		if (TST_ERR == EOPNOTSUPP) {
> +			tst_res(TCONF, "Extended attributes not supported");
> +			return;
> +		}
> +		tst_res(TFAIL, "setxattr on directory failed");
> +		return;
> +	}

TST_EXP_PASS_SILENT already reports TFAIL on failure. Then the code
reports TFAIL again (or TCONF for EOPNOTSUPP), resulting in
double-reporting. For the EOPNOTSUPP case the output will contain a
contradictory TFAIL followed by TCONF.

Since custom failure handling is needed here (EOPNOTSUPP -> TCONF),
TEST() should be used instead:

  TEST(setxattr(TESTDIR, XATTR_TEST_DIR_NAME,
                XATTR_TEST_DIR_VALUE, XATTR_TEST_DIR_SIZE, 0));
  if (TST_RET == -1) {
      if (TST_ERR == EOPNOTSUPP) {
          tst_res(TCONF, "Extended attributes not supported");
          return;
      }
      tst_res(TFAIL | TTERRNO, "setxattr on directory failed");
      return;
  }

The same pattern appears for the second setxattr call in test_xattr()
and the first setxattr call in test_xattr_backup_restore().

> +	.forks_child = 1,

Same as patch 6/8: xattr_test01 never forks a child process.
Should .forks_child be dropped?

--- Applies to patches 2/8 through 7/8 ---

> + * [Algorithm]
> + *
> + * 1. Set up ACL with full permissions for the entry

The [Algorithm] section must use a bulleted list with "-" markers,
not numbered lists. This applies to all six tests that have an
[Algorithm] block (acl_mask01, acl_other01, acl_inherit01,
acl_file_ops01, acl_link01, xattr_test01).

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
