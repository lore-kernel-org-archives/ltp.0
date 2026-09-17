Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D5C88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF883E75A5
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 13:15:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18C693C0031
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:15:36 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B15C1400DEB
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:15:36 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-5281c4c55e6so2169971cf.1
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789643735; x=1790248535; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVgLVi1G1F0b19zCB4Xi6l+ITQZgZa2ZRluwiTli174=;
 b=UpmSCTeUmrpLAyHI/YdJDBrA3ERbGF6gaQVHeuQm+hqCs8IgFvhs6jEjwlHvbEsv8w
 7uIWgncHt0DL9DEQ/kI2DXCBgqAaDB1J1hjOmoLNxhcf0dcLcPqR9aFYSRBSXHQT7zcU
 4kGzbJgOCq01c2ZtkuNKGFUg76nTaLNaR5NbvJ7DelxZ098hmVq0qGQwXTOWQDpKI1dB
 6GRiVMAxDUELeXwiPplS4vp6Zq0hC6b6aGnvrMkPcrkeDsF5de2eZSBJypdv9v+ttK14
 j2ZhdAJJMFNiledGhnYpkZ8mSDC/TNj0RKAcZwFEQesJXSQ4eADQvaqRRx5m484yWvc9
 wYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789643735; x=1790248535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aVgLVi1G1F0b19zCB4Xi6l+ITQZgZa2ZRluwiTli174=;
 b=CiCsuzerFkPk3KzU/flyOmYReNB+mQz+UtQtUyH8lHCg5Ouuuy2PdBdeqfBtGVVQk1
 mCJ4a1F8lH1EHxo1V0aljY5JJZEBD2epBfPERMzLrVsFyVaPpEWI+VP/zaNOeZr2BPyr
 VTK0HfaRtCkQXCmQZfRdlAW4EcO31hF8lC6Iz+HVCqW1Xwbn7IlMC3jir0GQXZrtG0GE
 kXt+z/891r9Jm5dlG54XiXwboTrGsadAh5Gy3edgRUNrmQ1Guq1qjpCEeOrUE9SmqKvA
 USLbvBga20G7EtCm7ZZThnk7g00zKKMll7wab+yyCK0hAvF2QTlENNiRdI3MXGMISX4I
 UCQQ==
X-Gm-Message-State: AFuF++nYEMsjqZ5JzLng8+swzIPT8o67b1j8CpPXnkeEPiCnJ+HrDBWS
 h6oetkBCfDiD1O9fd5ydD8fLbHDisX5Tg0fjP64CdB56lkK/nhGMCV/YCIL5L1+E
X-Gm-Gg: AYBFou3G5l8U2i0IsMx9kW2lcp4vjye+/x/Ytkl7ebriZuiCJ4eHTTQ6ff1Jf+00Et6
 vXebwh4cChszcDKY+Bwm64UPm4EiHZPohLbpFFLVmcXNdT8yMu0gHypuM1MO/q7uKxuPhH8efb+
 SrzbqA88Q9uYUNBd6ybwkcOoix3QMTSZBv6KREbxn/hSRNoLCjuXYVWVjdGaXFzD0gIZOcik1S4
 BbQa2XKcJrmajE59LpOO/ut47uqCV0zD0ldunNjTiOuZ0LniAGnqZV2WF6oxDHO+Caa6JoaAspJ
 Qcd9Vd3d1Kbke1eaYdi7iIFC0TKkVqNDxRpecJ8RVtAwl/9f9Tf/sQwmfVhZiGw21wq4nwBpSNB
 LUBdUK9qoJFYf+TTzFI5gwMwYK8hAX+G6vAC0N/pL0HrZMOyESelTvB8BnWuvHpXxhQZF433LxS
 /D2nmfQfD8gxqrDGsHbYM3Nq/FGu/AyOddwAm5y5jG5p8c9TNXxrzBc049I14jJqAV5L0Qn1PVd
 JhESgmtr7CkgoCgwLlfiPyMzf1lu1Sw8cnqfUkoI7OrPggWqPxQiC2LDEi5Z7IU+Y3DWRIUoUmN
 P/qp+wUwHqU=
X-Received: by 2002:a05:622a:110f:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-5327ed7b12emr105630521cf.2.1789643734742; 
 Thu, 17 Sep 2026 04:15:34 -0700 (PDT)
Received: from
 runnervmlun5p.fitldde52jauziqwlxzvrlyhde.cx.internal.cloudapp.net
 ([20.109.38.178]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bee64d1sm47335366d6.46.2026.09.17.04.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 04:15:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Thu, 17 Sep 2026 11:15:33 +0000
Message-ID: <20260917111533.8907-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917025657.327887-1-gpathak@suse.de>
References: <20260917025657.327887-1-gpathak@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC
 on regular file
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

Hi Gaurav,

On Thu Sep 17 16:23:04 2026 +0530, Gaurav Pathak <gaurav.pathak@suse.com> wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> Fixes: #1224

Fixes: must reference a valid commit SHA in local git history. If
referencing a GitHub issue, use Closes: #1224 instead.

> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index f6a423eed..e601a46a3 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -10,3 +10,4 @@
>  /statx10
>  /statx11
>  /statx12
> +/statx13

The new test must also be added to runtest/syscalls.

> -AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
> +AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt],,,[
>  #define _GNU_SOURCE
>  #include <sys/stat.h>
>  ])

Compile-time checks in configure.ac may only enable fallback API
definitions in include/lapi/. Fallback definitions for STATX_WRITE_ATOMIC,
STATX_ATTR_WRITE_ATOMIC, and the atomic write struct statx fields belong
in include/lapi/stat.h so the test builds on distributions with older libc
headers.

> + * The test performs the following validations:
> + * - Creates a test file using O_DIRECT (a prerequisite for atomic writes).
> + * - Calls statx() with the STATX_WRITE_ATOMIC mask to retrieve the limits.
> + * - Verifies that stx_atomic_write_unit_min, stx_atomic_write_unit_max, and
> + *    stx_atomic_write_unit_max_opt are logically consistent (e.g., max_opt is
> + *    within the min and max bounds).
> + * - Ensures all reported atomic write unit sizes are valid powers of two.

Add a blank line before the bulleted list. Reference the syscall as
:manpage:`statx(2)` and align the continuation indentation on line 15.
Also update the doc comment regarding supported filesystems since ext4 is
tested as well.

> +#define _GNU_SOURCE
> +#include <sys/param.h>
> +#include "tst_test.h"
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE MNTPOINT"/testfile"

Drop unused <sys/param.h> and include "lapi/stat.h". Add a space between
concatenated string literals: MNTPOINT "/testfile".

> +static void verify_statx(void)
> +{
> +	struct statx buff;

Tested syscall struct arguments must not be allocated on the stack.
Declare a static pointer and allocate it via .bufs in struct tst_test.

> +#ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
> +	if (buff.stx_atomic_write_unit_max_opt == 0) {
> +		tst_res(TINFO, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
> +	} else {
[...]
> +#else
> +	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
> +#endif

Compile-time feature guards must not be placed inside function bodies.
Provide fallback definitions in include/lapi/stat.h instead.

> +static void setup(void)
> +{
> +	char *data_buff = SAFE_MEMALIGN(ALIGNMENT, WRITE_SIZE);
> +
> +	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
> +		tst_brk(TCONF, "This test only supports ext4 and xfs");
> +
> +	umask(0);
> +	memset(data_buff, '@', WRITE_SIZE);
> +
> +	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, WRITE_SIZE);
> +}

data_buff is never freed, leaking memory. Free it after SAFE_WRITE(), and
perform the allocation after the filesystem check to avoid leaking on
tst_brk().

> +static void cleanup(void)
> +{
> +	if (file_fd > -1)
> +		SAFE_CLOSE(file_fd);
> +}

Use if (file_fd != -1) to check file descriptor validity. Also, file_fd is
kept open across test iterations but verify_statx() only accesses TESTFILE
by path; close file_fd in setup() after writing if fd-based statx is not
tested.

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
