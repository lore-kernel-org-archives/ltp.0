Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43AC982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 12:52:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7625F3EA165
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 14:52:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E51373EA165
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:51:59 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B0FF600BA2
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:51:59 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-398b9f722abso362747a91.0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789735918; x=1790340718; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=78OOTEbYt3ANKvHS0VMbSWSmGcT9tI+CmYM1JrAlM00=;
 b=ZthM14/bbHR7cuhaQQP5+BuXN701p8Kim6I/jp7Y2GdpLb+ISI+xYIz9NbzmqwJg1R
 oQ6vqIRsKhlRFl28N/pTGNiwiv2Ub+8GFHBpqB5gIXcAeDuuCV34m/B5nfyRDQPk+xau
 BV6Q0FPS8KGH/5HzmFAZKhew+pPz7wz5R7D8TYjIVmpbSXL9S0lnEam5T6QjnxL4Jrof
 EQDSKDKfrUjKHHI6jBSthcnVPIgDq7miir2YDO2nlWdPK6BK2nq60YWW7+eSqwiYpFdO
 REukexS6t0zHMM5TrjVWxvuLZ3UDIMH+C0mK4JX/Mdcef73Bj1zHzLJVuQ/M26F8KGXT
 Velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789735918; x=1790340718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=78OOTEbYt3ANKvHS0VMbSWSmGcT9tI+CmYM1JrAlM00=;
 b=Ie9GISz77E0ZITjiGqtnGB02foj4SZKQszzdB/UlD5KtAoQuJ2kwx/q/L8oEtckkKM
 4kGWjPyyW8lv9lDQTogvEE+wNCJpdATlSkrBIclIEy1DycwmyVFyxqK0PFfVtlJvlGxt
 SQvRibG5/S36gCwN11K/DwDy3zcKkQFlh3A8l+1b0JTi9o2B4lUGA0oJuP0uPLbzmLi1
 a/BBm0ktDdPn/LOIN3Cfz3IxzNBuYbHKJDMxbHB0REQPWReFRrge92bTOu/DjeEWs78z
 J/FFIKwEMZkiu1CBp0yfYD1uWXv97ZBGbA+pjwW7IsQ+yUMvFT8vYR7MUvW+xWe8wuTZ
 +PdA==
X-Gm-Message-State: AFuF++lxNRNJvrg/Qib9DKPZyysykMZJ30u41OhS4SLptYt5Qcy+X293
 Nc903tgzUucypC+Jb/iP3RElxJBAx/ryJZ5WqC3drO32tIbMtDBTp2/c
X-Gm-Gg: AYBFou1jcSmghtz1jAtHTJGV5D7jVmBg3cwA5FLnGOwMrJKRCbQKE7GOAnNbOw6R9EL
 1ygNxRTrlohhiLQMy00ABQgczCmtdQVe2k/InYg/w9fCHfX5oe74eJy7T0BundV4gNlfbonAAxl
 7Eok2fxAl8SH+ljktlKkKJiGr3XzJlvgf5ryul4EefbIbL7kUSx1v7bAVP3W7HrmiR0/NqT4/+T
 NVI2CEncJxBzgqE8iyuZ2DO4EhL2i1cCxnZcTei6wRUHgTPAuu5628oC48jicf736cqmIIEYSSx
 s8siSVxpRvmE4zWVtPW19aJmBLeYPSQgZTjQmk2po1hNmAj4OWYVa8rZDNpzsEJI1qgs19RY0z7
 46eh2uxBSBk7x2cfZm54zG5rmlOqcHMSYdSjk+M6xyEpGMpCaa2QB9fnhUxqIsak1m0kyfL87Lp
 x/Y/xJqLBEauUZKpKRF11y/R5ptRFVWesYsbGU+lRkiwRotwMs6qldOEmNUVXGdnbvxSolTOwVB
 VPcdm1b4ROARcR5Axkgt6YQApFA8nFMYDylSK42rnfqZYBg4/595icLwxSxQebfH8c58d1LkpqP
 Dx6lcD3dwmg=
X-Received: by 2002:a05:6a20:1eaf:b0:3d0:ba81:79b7 with SMTP id
 adf61e73a8af0-3dd8c42a411mr5669792637.12.1789735917542; 
 Fri, 18 Sep 2026 05:51:57 -0700 (PDT)
Received: from
 runnervmlun5p.nqmrxwab4rvujcbmygto4uphkh.phxx.internal.cloudapp.net
 ([51.57.83.103]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c2876ad4dsm4289807eec.21.2026.09.18.05.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:51:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Fri, 18 Sep 2026 12:51:56 +0000
Message-ID: <20260918125156.8501-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918111208.116077-1-gpathak@suse.de>
References: <20260918111208.116077-1-gpathak@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Thu Sep 17 16:23:04 2026 +0530, Gaurav Pathak wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> Fixes: #1224
> 
> Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
> Closes: #1224 or a Link tag to reference an issue.

Fixes: tags must reference a commit SHA present in git history, not an issue.
Use Closes: #1224 to reference the issue. Also remove the unedited template
instruction "or a Link tag to reference an issue." from the Closes tag.

> diff --git a/configure.ac b/configure.ac
> index 18bfdb88c..72f423c56 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -181,7 +181,7 @@ AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
>  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> -AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
> +AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt],,,[
>  #define _GNU_SOURCE
>  #include <sys/stat.h>
>  ])

configure.ac checks may only enable fallback API definitions in
include/lapi/. Fallback definitions for struct statx extensions and atomic
write flags should be added to include/lapi/stat.h instead.

> diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
> new file mode 100644
> index 000000000..ea42a102c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx13.c

Add an entry for statx13 to runtest/syscalls.

> +/*\
> + * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
> + * It ensures that supported filesystems (xfs as of now) correctly report their
> + * atomic write limits to user space when queried via statx().
> + *
> + * The test performs the following validations:
> + * - Creates a test file using O_DIRECT (a prerequisite for atomic writes).

Insert a blank line before the bulleted list so Sphinx can parse the reST
block correctly. Also, reference the syscall as :manpage:`statx(2)`.

> +#define TESTFILE MNTPOINT"/testfile"

Add a space between concatenated string literals: MNTPOINT "/testfile".

> +#define _GNU_SOURCE
> +#include <sys/param.h>
> +#include "tst_test.h"

Include "lapi/stat.h". Fallback definitions for STATX_WRITE_ATOMIC,
STATX_ATTR_WRITE_ATOMIC, and atomic write fields in struct statx must be
provided in include/lapi/stat.h so the test compiles on older C libraries.

> +#ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
> +	if (buff.stx_atomic_write_unit_max_opt == 0) {

Do not place #ifdef guards inside function bodies. Define the fallback
struct in include/lapi/stat.h so the test code compiles unconditionally.

> +		if (buff.stx_atomic_write_unit_max_opt > buff.stx_atomic_write_unit_max)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
> +					buff.stx_atomic_write_unit_max_opt,
> +					buff.stx_atomic_write_unit_max);
> +
> +		else if (buff.stx_atomic_write_unit_max_opt < buff.stx_atomic_write_unit_min)

Remove the blank line between if and else if to follow kernel coding style.

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

data_buff is never freed, leaking memory. Move the allocation after the
filesystem check and call free(data_buff) after SAFE_WRITE(). Also remove
the double space after '=' in file_fd assignment.

> +static void cleanup(void)
> +{
> +	if (file_fd > -1)
> +		SAFE_CLOSE(file_fd);
> +}

Use if (file_fd != -1) instead of file_fd > -1 to match the LTP convention.

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
