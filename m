Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDCC83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752650854; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lPYVmOCjBruUfML6cxzE9w5RR02hyq5zHjx9FkRxsCk=;
 b=W2ywNbFkYlqj351G+yOJ48TIVSD1V7qYhSwRAT86YCzCTI2tFBy+OGj1Bia/otSBL5v8X
 WsKULWj/CEwrUgi9mcQFitdk40DLfcSp0U3MEkqRSRcL6WoLFTal6yfvs4NTOMtnP52qVeC
 K+Z3uqJ8dKA+XiYOCytsvVBHnKLFl8s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02A1D3CBCE3
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 09:27:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39FCE3C2857
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:27:10 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4490F60071B
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:27:09 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so5425029f8f.2
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752650828; x=1753255628; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GzS29VrjBCxAFby7Kjs/f1BWjZIwER5nJ3e9VTNya/0=;
 b=QNLcBU96FXW96/j7sShekuCNjq9HTNOM/4if69m00D2D8A7unl1Xdsp46KjE2jCpo+
 Q0BI31nkM1nY9qT1C5t4grQhKTmsRkGRWdcnJP3eeRPIpUOUvjjJZ5EMIZBWax51f8wD
 s0jLenZ2KDbK8geoTD+jU5TIrX7wz0K0bUHah3eU/8fh8VS1rWv00Fr6l000zIhTI0pW
 KlJp9SU1Wvd1NtC9dhUiUo/rAYgs25OAhuvAAvq4U/IqCRLySXXZoYNk0FdZwFPmuhqt
 U9YtLvrv7AnMRpbmAUar+ufLYJCOBRmv3GdxVbT9R1DxIFVz61Qb5RqgkxcJyaFzu+Ox
 jGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752650828; x=1753255628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzS29VrjBCxAFby7Kjs/f1BWjZIwER5nJ3e9VTNya/0=;
 b=dbrgGBvFyONMA4hlpIZEtq1tSU8PPXqTaJy2qQJ8F12F66EbtQDW7sykm1qkt5Nk69
 47Id2v25TPeJkKZOQ72+fuHCVxme6+Jkfu3CZZvioyFX2t4AfXzD/3NYgKSqARBux8gi
 7s1qOWxXQlOrirml9roc5ro46iB1gJynrhsjhd1bgf/d9X77AANkZbMGkM93vdbLeiym
 dPGkdWxR7ERY8P0oHlNUmsrQbZ2e/0xzHsFnDgGFHZ0JKMj6h9MSt2rUMeRsOY00GoOF
 h8juKFdR733OaBgJvmzUzPa0+/RJLjDyEMHF5Fttts8Es4o3Fw89bNkPj9TKH0acUEAO
 c8sg==
X-Gm-Message-State: AOJu0YzPw1qQuluwn99vyulaI/M7MqneyL752yZHs5/5RXb64ux/27so
 b1etsNgvknQRjcf0bD7uH5BkBp5ax0f8KXUjar5r12DFj9u6H4BNOjnR+t0+EC8nH8aRCdQ5Zce
 wuS6Byw==
X-Gm-Gg: ASbGnct0izBC8T45BZGCkKdgWABgoIUzjf7NbN9bV4H3NgXSTVlfPouslVBC+xW6EpT
 zGJFgqmrxld4Sn5hrgWJi8slsAzqW+u3dMKumVvhBSWlAMJplcbcybZdAGp6eKUgEK3WybO4YTL
 jb4PZuyfQr9+bdD1hFhXSCkOHsocovb+d8dBDDgumV/8QRRgU3ilAGV15BirwUXb6eOyam3zJBU
 z/ZmHTHA4eQsK7qKHxrRzO3PD6+QJAnJwRPgxFQi383enCL4tZ428s+Y9AZYpfkHzmyH3Z5t5Tn
 KQUjpn7ymkMULUd6XoOf0yAhFJN6Xj7ratNB+JZ9uKwIE3o/kvHyNczSJ0XLIizzfwLsGezUFa3
 WPjlIo2WCTc+WlqexY2LSu6TedOxBYJdC
X-Google-Smtp-Source: AGHT+IGtmhYWhDkLw62Gxwq9DHSwYlhGmfyRrqAOJlYBG3UnC0BmD7VcHR07jARYIgFIJvgILa7buQ==
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id
 ffacd0b85a97d-3b60dd827a9mr1693202f8f.48.1752650828520; 
 Wed, 16 Jul 2025 00:27:08 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4284995sm121042895ad.11.2025.07.16.00.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:27:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:26:23 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv>
References: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
 <20250709-xattr_bug_repr-v3-2-379c2c291bb7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250709-xattr_bug_repr-v3-2-379c2c291bb7@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add listxattr04 reproducer
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

On Wed, Jul 09, 2025 at 01:37:00PM +0200, Andrea Cervesato wrote:
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
>  testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
>  testcases/kernel/syscalls/listxattr/Makefile      |   2 +
>  testcases/kernel/syscalls/listxattr/listxattr04.c | 108 ++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
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
> index 0000000000000000000000000000000000000000..b7357d6c2a8dda2ace72081bee9f45d7f84442d9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
> @@ -0,0 +1,108 @@
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
> +static void setup(void)
> +{
> +	int res;
> +
> +	if (!tst_selinux_enabled())
> +		tst_brk(TCONF, "SELinux is not running");
Current tst_selinux_enabled within your patchset not check running state
of selinux. so i guess you need check /sys/fs/selinux/enforce value
here.
Or you can use tst_selinux_enforcing. Correct me if any
misunderstanding.
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
> -- 
> 2.50.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
