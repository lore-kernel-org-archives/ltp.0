Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A864C83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751874200; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z66ypePi/7y0wJ8t/5LlglB5uoI2F0DJ+NL/zmjPnk8=;
 b=UW+Lms3l1OE8rrbcjKRiAwhsTF5p1CgOLumsHjur0HuOgaz63MdZtgJ9+yWWaCWIyoFX7
 koh9YbUYzOZ4EIz/GlFKrEFjmXndU/dhdgcb9WLq5XVoooHEZ4rolaV5OEM4Ov/kzlviwNY
 2Zv0JCwL/xFqjklxQ0vete6+LT2v7SI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8249B3C6965
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:43:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 606393C0980
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:42:59 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 51CFB1A00814
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:42:58 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so2715105f8f.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751874178; x=1752478978; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FwPEkT9+HdkYePg2KmG7sYjZZe57krIW19uDoOpGrEQ=;
 b=McAe4URUnSHozpF9p5s9VvIdAhUkwkHfNiPG81X8TxJ5FuCfqDN/Z9oIwj26LiwsPb
 4BJEH4ufg7Mp1mp0bdaPm8GFayNrT6miWK59vhHed5NfK1Ost73XbHtSlUObaXhuri73
 REo3ArPDMBEsGuJBnVDOM+jdA7GF1QvPlFrjuBgt7d0xwbcpa60BzK9XnGRXwGHWMTTc
 jGpc3Ib/Lx3l1MPpNp0L1kEhIkUfNfmLR7Vgb5Lg8ubUyjvIHvmVp3/l8wIFbcOIkrM+
 2HSwGxW6NBJ8eqjsYVQZaS4esYF6Aptt1hTymyDcQqrQfOtAhflcgtvU5Xfv6HutzwIM
 b10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751874178; x=1752478978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwPEkT9+HdkYePg2KmG7sYjZZe57krIW19uDoOpGrEQ=;
 b=r/YU++yFoX/OSjs2I3WgnWj891+Eb1z/TJI7frNnYUYA+fL6cPuJPbmR2a/QctUfA0
 u8247ntuAv2qudeFUXDpmdN0LvkfKmHVTg1bBi6PmHTJcRRTqpsfr6A+fGzE1ZRhXiWN
 sw+QNO5Mjkjr7jC9PXBBspsDTzbJ4mlmTaVQH8lFPjitquaJKUu2MQChXusJe+jaElPC
 gKVS9w3I5DqCljrizb8BKbdcO7SbotCLUaUxNL5qaH5qwMcNUmC+497h2csnCYF0i9Wl
 zu7/q5IxrhLTGoTRoRpdg9gteYc9VXYZAc70VrY2gX8uEulCZB1e2IYmW6/AAkpb6H5F
 54ew==
X-Gm-Message-State: AOJu0YyLZpXeWGyB7dWRuRXsdfCt2y3L2L0gp2VLLhHeYnTPQLxgu+m8
 vJ6T1oqoj0iOwCgRxBA7zGzYISuJrjB+OhdsWHrR1S4lkYApHCq2oVHvx4cdJquyE4zfB+F81Up
 w2yg=
X-Gm-Gg: ASbGncvWLQB/qZxsEbLWRbPw9eBRTmSwbj6n/lxNqzNpoZ2nDovVgIjTxPKKGItlIPD
 wH0Gd7DlJKzPFoq90WEI0o4RDF7lJi1RqEwJgb6AZUjyDrION5jt3ueoE+T4luYFPS4D66VQPNn
 LO3a2Xz6TfAmwpb3QEk5U+Gl14SmOsekgSsSWSd/ulee4LAxK1VbhuEG3wN3BcLlsbDIKKwp46X
 lwe782cN4WxZmkR//ADe1MKnSyYIhglhhlXHo6I3OlPlL2wRHLfKB1ZNT4Q5veUhibcKjKm5Zbv
 Z+pVF1LFHdDyaBJ3MAs2WUEuS2wPYnLieW8pR5x97w+5/GPhQKvAbLLqMRzMHg==
X-Google-Smtp-Source: AGHT+IEhPUK9iJRByWQcc8zZF89yBgddVKeJvrdDXzQuhjF/GuGY59ss4wRk2HRlbKo02Ai0K0iJUQ==
X-Received: by 2002:a5d:5f49:0:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3b49aa0f0eemr5676326f8f.2.1751874177619; 
 Mon, 07 Jul 2025 00:42:57 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce417ddb3sm8548851b3a.87.2025.07.07.00.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 00:42:56 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:42:18 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv>
References: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add listxattr04 reproducer
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 03, 2025 at 03:51:33PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> simple_xattr_list to always include security.* xattrs").
> 
> Bug can be reproduced when SELinux and ACL are activated on inodes as
> following:
> 
>     $ touch testfile
>     $ setfacl -m u:myuser:rwx testfile
>     $ getfattr -dm. /tmp/testfile
>     Segmentation fault (core dumped)
> 
> The reason why this happens is that simple_xattr_list() always includes
> security.* xattrs without resetting error flag after
> security_inode_listsecurity(). This results into an incorrect length of the
> returned xattr name if POSIX ACL is also applied on the inode.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Reproducer for https://lore.kernel.org/linux-fsdevel/m1wm9qund4.fsf@gmail.com/T/
> ---
> Changes in v2:
> - only check if SELinux is up and running
> - Link to v1: https://lore.kernel.org/r/20250703-xattr_bug_repr-v1-1-5dcf5dde8b61@suse.com
> ---
>  testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
>  testcases/kernel/syscalls/listxattr/Makefile      |   2 +
>  testcases/kernel/syscalls/listxattr/listxattr04.c | 133 ++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
> index be0675a6df0080d176d53d70194442bbc9ed376c..0d672b6ea5eec03aab37ee89316c56e24356c1d9 100644
> --- a/testcases/kernel/syscalls/listxattr/.gitignore
> +++ b/testcases/kernel/syscalls/listxattr/.gitignore
> @@ -1,3 +1,4 @@
>  /listxattr01
>  /listxattr02
>  /listxattr03
> +/listxattr04
> diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
> index c2f84b1590fc24a7a98f890ea7706771d944aa79..e96bb3fa4c2c6b14b8d2bc8fd4c475e4789d72fe 100644
> --- a/testcases/kernel/syscalls/listxattr/Makefile
> +++ b/testcases/kernel/syscalls/listxattr/Makefile
> @@ -6,4 +6,6 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> +listxattr04: LDLIBS	+= $(ACL_LIBS)
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr04.c b/testcases/kernel/syscalls/listxattr/listxattr04.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..af80e0c609d5931132b3bf16b28805577b2a853d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> + * simple_xattr_list to always include security.* xattrs").
> + *
> + * Bug can be reproduced when SELinux and ACL are activated on inodes as
> + * following:
> + *
> + *     $ touch testfile
> + *     $ setfacl -m u:myuser:rwx testfile
> + *     $ getfattr -dm. /tmp/testfile
> + *     Segmentation fault (core dumped)
> + *
> + * The reason why this happens is that simple_xattr_list() always includes
> + * security.* xattrs without resetting error flag after
> + * security_inode_listsecurity(). This results into an incorrect length of the
> + * returned xattr name if POSIX ACL is also applied on the inode.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
> +
> +#include "lapi/lsm.h"
> +
> +#include <pwd.h>
> +#include <sys/acl.h>
> +#include <sys/xattr.h>
> +
> +#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
> +#define TEST_FILE       "test.bin"
> +
> +static acl_t acl;
> +
> +static void verify_xattr(const int size)
> +{
> +	char buf[size];
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (listxattr(TEST_FILE, buf, size) == -1) {
> +		if (errno != ERANGE)
> +			tst_brk(TBROK | TERRNO, "listxattr() error");
> +
> +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
> +		return;
Why ERANGE is Checked Separately?
Such as tst_res(TFAIL | TERRNO, "listxattr() error") will also report
errno.
> +	}
> +
> +	tst_res(TPASS, "listxattr() correctly read attributes length");
> +}
> +
> +static void run(void)
> +{
> +	int size;
> +
> +	size = listxattr(TEST_FILE, NULL, 0);
> +	if (size == -1)
> +		tst_brk(TBROK | TERRNO, "listxattr() error");
> +
> +	verify_xattr(size);
> +}
> +
> +static int selinux_enabled(void)
> +{
> +	uint32_t lsm_num;
> +	uint64_t ids[32];
> +	uint32_t page_size;
> +	int available = 0;
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +
> +	lsm_num = lsm_list_modules(ids, &page_size, 0);
> +	if (!lsm_num)
> +		return 0;
> +
> +	for (uint32_t i = 0; i < lsm_num; i++) {
> +		if (ids[i] == LSM_ID_SELINUX) {
> +			available = 1;
> +			break;
> +		}
> +	}
> +
> +	return available;
> +}
> +
> +static void setup(void)
> +{
> +	int res;
> +
> +	if (!selinux_enabled())
Mabye we can use is_selinux_enabled instead of self build function?
> +		tst_brk(TCONF, "SELinux is not running");
> +
> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
> +
> +	acl = acl_from_text(ACL_PERM);
> +	if (!acl)
> +		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
> +
> +	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
> +	if (res == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "acl_set_file()");
> +
> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (acl)
> +		acl_free(acl);
unlink(TEST_FILE);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "800d0b9b6a8b"},
> +		{}
> +	}
> +};
> +
> +#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
> +	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
> +#endif
> 
> ---
> base-commit: a908cff70f9389c2dd2bf535976cb179bfa8f340
> change-id: 20250702-xattr_bug_repr-5873b84792fb
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
Thanks for your patch, some minor comments see above.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
