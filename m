Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8F9C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855A23E55CB
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 18:28:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189323E29BF
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 18:28:01 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B440D600079
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 18:28:00 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51cad7c1c8cso1659651cf.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785342479; x=1785947279; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M+1nocNUzjRsYClgH7H9y48u0rSJn02CP7JxyobnW90=;
 b=ZWTnwBMF6oLFWWg90ejg4FwIkq3rRdGgPY3R+2R8uuFkdxOVZNEK8E9bzXpjClOTUk
 oBp59bcvxymn0/a96I/ok2XVwsAiAQSR4X3Gh1oKgheoHfY4aSTIOJYNvYqWpeJwSLlB
 XNMt7kxTTNJatWr6WCtgXrNCFVSnaV5orDLS3DYlVRgRJ71PxKAMkBzpqrfxnixQiP+9
 W4rKmKlEn4VZ85gfkJ8ZLhc1cwTne5kC+dmlkPHh5PlAaE3XSnkJnhaz8L0XwgXj0mHn
 gf0aHmq0pxqFk43/oBBsH6cblUf6t5M7af5scKAwqkLh2PxzFhpG2/lody5W3RNV9Hp5
 vWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785342479; x=1785947279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M+1nocNUzjRsYClgH7H9y48u0rSJn02CP7JxyobnW90=;
 b=oVOEx2u/XDb85Vb/586aKWzL02pygjfexEAJCCcZEopv7QAGJYgiYxSHY4HlYh14u/
 4fKBSkQrQiUA7RsdBH1Mx/4QYrjUCYa5re1DiO0pOTM8nVsOPw/NM4oObrXggktgUklG
 miX+/WNdw7ZUPF5kdUOkp76GpJrqMTBDiDzHLeVbWVmX06STfxH8xVTy+jfd+9NV9AH6
 RJ8XkiWyQTvWDigrmjwDgGc/LoEC+yqwzidBa+dGAOsEoTCcW9aI7KpHcIAnodFW+dc8
 N3pWljycICZdhxsOD5OZnWt2u4+DnWiEoRBRM3GhcmGOcMOLGeQ/EGBO/GmqVcw/ok+K
 xrrw==
X-Gm-Message-State: AOJu0YwWC3/TWdgGotcBIm/bcXU4bR9xZbchFzReeciSJ1lYb1xj8ht0
 e3jkkksjl2VQrdYGewWLCbUFedLsg3fp3S13ly9nAyDETfjKss9DUP6YUy65RaqpUEU=
X-Gm-Gg: AR+sD10iNUZAeFgqUQ7NLALQBTkJ4hetjPgOumg6B2Y5OVsbaoHOGJ6hW7ghhKor8wn
 szf102UK1LDpIq6S2VVrTIyJRKBAA08NwtAQkRvNyTqWhEn1TMa+putqpfU28rf5Q9+u26tAi7X
 Ts4R2tMBiqH6yaSS2Chx3ttWstpLAU+blnHU08R0Wm2iMJmUAmuIlJxKWbhbAiseAVlgStiEJzG
 t7qBzE9Iuamk3RPFfUaJvx2+anzUtGa4e/SHwzNOFY8JomJY8qP8Et6FfTz9InVwKhEjeUjygZD
 2JnN89l3Rk+Ko/GGrNhxnoMbgh9SGMP/Qp4qy80g2zOYVu31mA1J/x+5JtBW96tyNDw3YO9mL14
 FkiqIhOFGlmJip73FPWWaaLlwn49nwQE8egMI2KwcKS4MrNbosJbJsFezMI2kpUT+gf3fR6buWe
 0jfXxce14FHWgNxx0lDI7pwxFK7a894apRVqvz7yXF4jF0UTTViPwngQT8POtT0+zx4q58Ftj36
 9r6+D4vGF7U8O6W/tQtWagio6P0rOpIrcQS8snXA0Hrk65SV0dak/wlomFqzwgVCzaXiqx+9Q==
X-Received: by 2002:a05:622a:1347:b0:528:3b9b:4f55 with SMTP id
 d75a77b69052e-529d709ccbcmr74763791cf.6.1785342479154; 
 Wed, 29 Jul 2026 09:27:59 -0700 (PDT)
Received: from
 runnervm7i58z.dkmc3hnmub1exftwixtyqawume.bx.internal.cloudapp.net
 ([20.83.159.4]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e31f25c1sm22566341cf.31.2026.07.29.09.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:27:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Wed, 29 Jul 2026 16:27:58 +0000
Message-ID: <20260729162758.8946-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729143243.8433-1-always.starving0@gmail.com>
References: <20260729143243.8433-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open01: fix cleanup file descriptor check
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

Hi Jinseok,

On 2026-07-29, Jinseok Kim wrote:
> open01: fix cleanup file descriptor check

--- [PATCH 1/3] ---

> File descriptor 0 is valid, so checking fd > 0 may skip closing an
> successfully opened file.

Typo: "an successfully" -> "a successfully".

--- [PATCH 2/3] ---

>  } tcases[] = {
>  	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "sticky bit"},
> -	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "directory bit"}
>  };

Only one entry is left in tcases[] now.

Is the .test + .tcnt parametrization still worth keeping here? The
convention is .test_all with a plain run() when there is a single test
case, unless more cases are planned on top of this.

>  	SAFE_CLOSE(fd);
>  	if (S_ISREG(buf.st_mode))
>  		SAFE_UNLINK(tc->filename);

This guard existed only to skip the unlink for the O_DIRECTORY case.

With that case removed the only remaining file is a regular one, so the
condition is always true. Can it be dropped and the unlink made
unconditional?

>   * 1. Open a new file with O_CREAT, fstat.st_mode should not have the
>   *    01000 (S_ISVTX) bit on. In Linux, the save text bit is *NOT* cleared.
> - * 2. Open a new directory with O_DIRECTORY, fstat.st_mode should have the
> - *    040000 (S_IFDIR) bit on.
>   */

The numbered list has a single "1." item left. Plain prose would read
better in the test catalog.

--- [PATCH 3/3] ---

> + * Verify that :manpage:`fstat(2)` correctly identifies various
> + * file types.

"various file types" does not say which ones. The commit message already
enumerates them, so how about moving that into the description, e.g.:

  Verify that :manpage:`fstat(2)` reports the correct file type in
  st_mode for regular files, directories, FIFOs, character devices and
  block devices.

> +#include <sys/sysmacros.h>
> +#include <fcntl.h>
> +
> +#include "tst_test.h"

O_PATH is used below but only <fcntl.h> is included. LTP carries a
fallback definition in include/lapi/fcntl.h for headers that predate
O_PATH, so "lapi/fcntl.h" should be included as well.

> +	TST_EXP_EXPR((buf.st_mode & S_IFMT) == tc->exp_type, "checking %s", tc->path);

On failure this only prints the path, not what was expected. Something
like "fstat() reports the expected type for %s" carries more information.

Also, for the character and block device cases only S_IFMT is checked
while st_rdev is ignored. Would it be worth comparing it against
makedev(1, 3) / makedev(7, 3) as well? statx01.c checks major/minor for
its device file.

> +static void cleanup(void)
> +{
> +	if (!access(REG_FILE, F_OK))
> +		SAFE_UNLINK(REG_FILE);
> +
> +	if (!access(DIR_FILE,  F_OK))
> +		SAFE_RMDIR(DIR_FILE);
> +
> +	if (!access(FIFO_FILE, F_OK))
> +		SAFE_UNLINK(FIFO_FILE);
> +
> +	if (!access(CHR_DEV, F_OK))
> +		SAFE_UNLINK(CHR_DEV);
> +
> +	if (!access(BLK_DEV, F_OK))
> +		SAFE_UNLINK(BLK_DEV);
> +}

Is any of this needed? Everything is created inside the framework tmpdir,
which is removed recursively at the end of the test, and MOUNT_PATH is
either a plain directory in that tmpdir or a tmpfs the framework unmounts
itself (prepare_and_mount_dev_fs() in lib/tst_test.c). Nothing here
outlives the test.

open11.c does the same touch/mkdir/mknod setup with .needs_devfs and has
no cleanup() at all.

Minor: "access(DIR_FILE,  F_OK)" has a double space.

> +	.mntpoint = MOUNT_PATH,
> +	.needs_devfs = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,

.needs_tmpdir is redundant here, .mntpoint already implies the tmpdir
(see needs_tmpdir() in lib/tst_test.c). open11.c and fsetxattr02.c set
only .needs_devfs and .mntpoint.

Verdict - Needs revision

Pre-existing issues:

open01.c includes <errno.h> but never uses errno.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
