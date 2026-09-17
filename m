Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A1C982CF
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 11:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA8273E759F
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 13:18:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DDDB3E1D80
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:17:55 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A22B4600952
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 13:17:54 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a384b5f7so341133a91.0
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789643873; x=1790248673; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SxCx0wPQrk3D4b7xHcQrlQNf0fQ6ZHXLok5QMeRCMc=;
 b=Q2leXd73Vyd2O4O2ab639cIt2SocDeoRzcj+PnRXZfQlaCC0KzVWNCd9VCKEqwoMQT
 vmfgkA7XLvQTgAPj1TRfrjgsSuD3SbNbHSbnQBXKi7XJqWEJvm5AppWhRa0U96p6terc
 pOODYtbCCwqKgvTViysjs0MknOAU+mhOKz9NqZCt2CNgtrENPW89oyER5CI0NrxxhaPB
 5Hvg1G04RwjEq5qe/2xuYelfFxVOvct6hVxP/7utdn45WXQD1PNApSnWzsgPcsmMQUxn
 valE38JbBO1m+/JrHhQpDnkzwrdCgGJxyD/WPr2BW0akYU7AoZ8m0EqPUDy0LVJzlAKM
 NFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789643873; x=1790248673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SxCx0wPQrk3D4b7xHcQrlQNf0fQ6ZHXLok5QMeRCMc=;
 b=ZOCe59iS69DQLuOGw918dKc/qsn2SK6tutEBo5198gDK9rWbGGExJwnpXNS0VZaPVc
 X7SNdRafiBC9fQkKYi/YmmIYYXWBCuVoKyVrAg3xJ9Y6zxDZ5rIdz5rlfF2dIm4kSMB1
 sHre/xx7hU4g285aaV/mpO+WHk2rhxgawQs2324d1TvrbV5qEH8HsA2p6BR0Z8qxrzK0
 MXpWKqs1WLeaPV+hIShZU7JH1eSIBtjJfi0UXa/N6ovs52mzJFMl26wErz6g9d6OAf5B
 kMvr7Muyq+8tDkdn/Kr5WV59IWwRaHFfkUFlrDdkdtjHqSkos+mGSeh1Y15pzjqx1kuz
 SFrA==
X-Gm-Message-State: AFuF++kpvZwhlwn8YQzL3cgE11uzcUCpY9vcjvrce/CwDvgRX9ti113J
 SBoLydlhz2ano69R84QGWTlEQsTiKaxHbL7Ec+UBAmieDz2KSNbyQ4yYA23vCJib
X-Gm-Gg: AYBFou38BzCOssqyhYpoGov3VvjxJpEva1kU9kJb8ugTmgaWWRJ7VM7Fz6AVC5C7hzg
 J8a5VgDs/buvb/65Z4gsIrH215VkbHywZza1s+zotOX+AlADS8LqYyW7FYR0CbO08l+PF5LPWhN
 AHyNlljJqrbV47iT8jJwZDkILW0yYdKoeSphGRy8hTGLN05Kg4AACACTRi/iCJ1Z7Z31CmAt6iS
 2OLOvPUp6abFm39UcWyjqwRjWrjLwJ5qz6jsYx1UY1th/DepBasz04tcMCZjK20SV3DK4z6jJjz
 V1mnOThscYZq4AiLoQiK68K/afbfGQiRQmkJ827UkAz+qBnzeElDWenB8eoqIE8542VwOWoBOuo
 +zq4E7MiZ16pkbAW42gr97+hBMxM5f3o//W9/3sNHF9gTF6ld7vsQvSE0x1PFksZtM+AJ/x3B2J
 8SkiaH4p8wp5+AeF75Fj9KNbla5syhN8/wq0QL0mBrP5JwOi5B9I4KntbU27IzpHhlMjHk+SrHo
 0O9xzw90JKAEoxSNfVQ7Kg9H7a7re65QH6xNu2reedbq8j0GsFWmCqqI1QyZyXUrIChIQUbQpM4
 gXiHT7QfpQ==
X-Received: by 2002:a17:90b:4a81:b0:39d:f773:37b5 with SMTP id
 98e67ed59e1d1-39e1df6193cmr19277059a91.0.1789643872931; 
 Thu, 17 Sep 2026 04:17:52 -0700 (PDT)
Received: from
 runnervmlun5p.hxmkk5pzppputaon5psdmagzec.xx.internal.cloudapp.net
 ([4.242.52.176]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35daaa93sm5577244a91.2.2026.09.17.04.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 04:17:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Thu, 17 Sep 2026 11:17:51 +0000
Message-ID: <20260917111751.8642-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917105304.9674-1-gpathak@suse.de>
References: <20260917105304.9674-1-gpathak@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

On Thu, 17 Sep 2026 16:23:04 +0530, Gaurav Pathak wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> Fixes: #1224

Fixes tags must reference a valid commit SHA in git history. Use
Closes: #1224 or a Link tag to reference an issue.

> -AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
> +AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt],,,[
>  #define _GNU_SOURCE
>  #include <sys/stat.h>
>  ])

Do not use configure.ac checks to conditionally compile test logic.
Instead, add fallback definitions for STATX_WRITE_ATOMIC,
STATX_ATTR_WRITE_ATOMIC, and stx_atomic_write_* members in
include/lapi/stat.h so the test builds unconditionally.

> /*\
>  * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
>  * It ensures that supported filesystems (xfs as of now) correctly report their
>  * atomic write limits to user space when queried via statx().
>  *
>  * The test performs the following validations:
>  * - Creates a test file using O_DIRECT (a prerequisite for atomic writes).

Add a blank line before the bulleted list to comply with reST syntax.

> #define _GNU_SOURCE
> #include <sys/param.h>
> #include "tst_test.h"

Include "lapi/stat.h" so statx() and atomic write definitions are
available on older C libraries. <sys/param.h> is unused and should be
removed.

> 	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff),
> 			"statx(AT_FDCWD, %s, 0, STATX_WRITE_ATOMIC, &buf)", TESTFILE);
> 
> 	if (!(buff.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {

TST_EXP_PASS_SILENT() does not abort on error. If statx() fails, execution
proceeds to read uninitialized memory from buff. Add "if (!TST_PASS)
return;" after the call. Also drop the redundant, mismatched format string.

> 	if (buff.stx_atomic_write_unit_max > 0 &&
> 			__builtin_popcount(buff.stx_atomic_write_unit_max) == 1)
> 		tst_res(TPASS, "stx_atomic_write_unit_max(%u) is power of 2",
> 				buff.stx_atomic_write_unit_max);
> 	else
> 		tst_res(TFAIL, "stx_atomic_write_unit_max(%u) is not a power of 2",
> 				buff.stx_atomic_write_unit_max);

Assert that buff.stx_atomic_write_unit_min <=
buff.stx_atomic_write_unit_max. The ordering between min and max is never
checked when stx_atomic_write_unit_max_opt is 0.

> #ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
> 	if (buff.stx_atomic_write_unit_max_opt == 0) {
> 		tst_res(TINFO, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
> 	} else {
> 		if (buff.stx_atomic_write_unit_max_opt > buff.stx_atomic_write_unit_max)
> 			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
> 					buff.stx_atomic_write_unit_max_opt,
> 					buff.stx_atomic_write_unit_max);
> 
> 		else if (buff.stx_atomic_write_unit_max_opt < buff.stx_atomic_write_unit_min)
> 			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
> 					buff.stx_atomic_write_unit_max_opt,
> 					buff.stx_atomic_write_unit_min);
> 		else
> 			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
> 					buff.stx_atomic_write_unit_max_opt,
> 					buff.stx_atomic_write_unit_min,
> 					buff.stx_atomic_write_unit_max);
> 
> 		if (__builtin_popcount(buff.stx_atomic_write_unit_max_opt) != 1)
> 			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power of 2",
> 					buff.stx_atomic_write_unit_max_opt);
> 	}
> #else
> 	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
> #endif

Do not bury #ifdef feature checks inside test functions. Defining the
members in include/lapi/stat.h removes the need for this guard and TCONF
branch.

> static void setup(void)
> {
> 	char *data_buff = SAFE_MEMALIGN(ALIGNMENT, WRITE_SIZE);
> 
> 	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
> 		tst_brk(TCONF, "This test only supports ext4 and xfs");
> 
> 	umask(0);
> 	memset(data_buff, '@', WRITE_SIZE);
> 
> 	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
> 	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, WRITE_SIZE);
> }

data_buff is allocated with SAFE_MEMALIGN() but never freed. Free
data_buff after SAFE_WRITE(), and move the allocation after the
filesystem check so it is not leaked on tst_brk(). Also remove the extra
space after the '=' assignment.

> static void cleanup(void)
> {
> 	if (file_fd > -1)
> 		SAFE_CLOSE(file_fd);
> }

Use if (file_fd != -1) per LTP conventions.

Also, add an entry for statx13 to runtest/syscalls.

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
