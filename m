Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E5CC83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751881426; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=tn11lnizTb7R1yCwi9NHwkaG6fzik6Q/UAsPQ1AMito=;
 b=TqwIFNS/WTcIc17YLBbua6rbe/+2kcgnXs7KzfjZEy9jIDwrNrkJwWqjiGk4e+/QaoGR5
 osOs/n63LOe4TjW12JCTh2Y67femKlC+GS/CE0Ju6nlgul2ykIhQGumjK0SSaKWM+wARo8x
 ohsZAMg8qXpjahy7dwmNHtxOgKfwyAY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2933C9AF7
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:43:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC2F3C0639
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:43:24 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 833E07EEB71
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 11:43:23 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso2585772f8f.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751881403; x=1752486203; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3u9hRJzwlDxPcOgHkkPx4SVasyGzH+4/8wAJMSJiKd8=;
 b=P9NJEA72tIbyE04CDD5cRVfmRoYROGHKT1MLpf4pSJiIQ+8sMMFbRPHHmlQflJplfe
 JST8RzHuC5g3emUNVRKIyZrfKDdIkhxQ9uNnSa2ogUG35VsMfyWR9TRYBiYn4Oed/q4R
 dKCIm9Do7UbgTBsdimY37BWIy7w6rDJ8E61xSf5u3p5qxLN5fck0kq+PrvzAOSwaqXkg
 tsuJKaV7x1t8G+0zlPlMyRtJUXOIg/UgJ6U2//p0MjIPGeACcT6/coZJnNUBhoEzGiLj
 9pJcVqnK5WGEoYczui3O2jCd8DygsI3hZFPkbvILreODSo1PxMAEVbrFwFeoKCyrBfLp
 +s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751881403; x=1752486203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3u9hRJzwlDxPcOgHkkPx4SVasyGzH+4/8wAJMSJiKd8=;
 b=XtNKzen3A8zn7lRp4L9FktqzOZyc49z6IpbzpNhNtiPt7pL8Ydle922OFboxNeoPTx
 B6M226D6fKOS5Yls3AbQNChgM0J9zvzeAQxFGqaLXKd3DZ+zFDB3fu214uE4h+fi1YnQ
 FovXkrqpuHTdiQmrndjsaNo22Zku0Id588E6lZ3mfHuWZZUfJUTTnA0DB9pcAWsLNtop
 qSFow9gi90PPPf+R45Ar1/b3cB1k3nacxtOHuHyyJRMxhoYuin7euUxDuU54u05PL9Oc
 uY5eXTp1+RWCspU1d/kOEUadrNGNUNJnDngZ7XXKR8pkZSsWazyXW98T4xr/HeL7nzB0
 UuRA==
X-Gm-Message-State: AOJu0YyjuecqgrN+RSmDXKjr8Dp2L4c0vg4pkUMLZsqBpWbXHM64NJcw
 b/YPxYtq2v+G8GoUUlaz/RH1MjoW5dByb2mUumLuQLHklK8bkXPmjQCRBltQW9TnKzYsUdIBHYe
 mZvTW8mQdgXh0
X-Gm-Gg: ASbGnctEDrh0jYZX0PzudajxykZjSxz3OKj+Q2Vlmpg5q7ClsZz58rx5gL5rAd2xXml
 X8EQCFrASz6654K6M8NJoLTS/SJ3oe9Ro5A+KQGly2Mxwci2lb7OKfzUNKTBZI+q1UQ1pxMZXK5
 JRvXJn9AAJhTX6b7xtnsVYtenFA2gZWf5gxnuNTFj4ypOIKqVdkoTjMLKRs/3eBtxtQX+DZsuQ6
 H8HzLAXAt1YX7wAT+jSxu/iB9eLqVyNoFU5TTaiw1qE/kU/570SxRf+xF9cRlitojLPReLoqH4S
 DYvMPZ7JH5O6ctr0dWMD4CzoP2fmpHXjRWEfHwZdKdh71mfXuRpXxWXt8BQP7Xp9OI1rWcDS
X-Google-Smtp-Source: AGHT+IHDaXK0WHMfH9UPq+PiSNokUSuVzZpV83RuGqY2x2O5J68UqyEjhpEtHDFTXcFc/gUg7z2SjA==
X-Received: by 2002:a05:6000:1a8b:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3b49702e827mr8740246f8f.43.1751881402784; 
 Mon, 07 Jul 2025 02:43:22 -0700 (PDT)
Received: from [192.168.0.223] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce42ce64esm7931387b3a.153.2025.07.07.02.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 02:43:22 -0700 (PDT)
Message-ID: <4997d77e-3b5a-4815-bf30-96debfc969a5@suse.com>
Date: Mon, 7 Jul 2025 11:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
 <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv>
Content-Language: en-US
In-Reply-To: <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On 7/7/25 9:42 PM, Wei Gao wrote:
> On Thu, Jul 03, 2025 at 03:51:33PM +0200, Andrea Cervesato wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
>> simple_xattr_list to always include security.* xattrs").
>>
>> Bug can be reproduced when SELinux and ACL are activated on inodes as
>> following:
>>
>>      $ touch testfile
>>      $ setfacl -m u:myuser:rwx testfile
>>      $ getfattr -dm. /tmp/testfile
>>      Segmentation fault (core dumped)
>>
>> The reason why this happens is that simple_xattr_list() always includes
>> security.* xattrs without resetting error flag after
>> security_inode_listsecurity(). This results into an incorrect length of the
>> returned xattr name if POSIX ACL is also applied on the inode.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> Reproducer for https://lore.kernel.org/linux-fsdevel/m1wm9qund4.fsf@gmail.com/T/
>> ---
>> Changes in v2:
>> - only check if SELinux is up and running
>> - Link to v1: https://lore.kernel.org/r/20250703-xattr_bug_repr-v1-1-5dcf5dde8b61@suse.com
>> ---
>>   testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
>>   testcases/kernel/syscalls/listxattr/Makefile      |   2 +
>>   testcases/kernel/syscalls/listxattr/listxattr04.c | 133 ++++++++++++++++++++++
>>   3 files changed, 136 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
>> index be0675a6df0080d176d53d70194442bbc9ed376c..0d672b6ea5eec03aab37ee89316c56e24356c1d9 100644
>> --- a/testcases/kernel/syscalls/listxattr/.gitignore
>> +++ b/testcases/kernel/syscalls/listxattr/.gitignore
>> @@ -1,3 +1,4 @@
>>   /listxattr01
>>   /listxattr02
>>   /listxattr03
>> +/listxattr04
>> diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
>> index c2f84b1590fc24a7a98f890ea7706771d944aa79..e96bb3fa4c2c6b14b8d2bc8fd4c475e4789d72fe 100644
>> --- a/testcases/kernel/syscalls/listxattr/Makefile
>> +++ b/testcases/kernel/syscalls/listxattr/Makefile
>> @@ -6,4 +6,6 @@ top_srcdir		?= ../../../..
>>   
>>   include $(top_srcdir)/include/mk/testcases.mk
>>   
>> +listxattr04: LDLIBS	+= $(ACL_LIBS)
>> +
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/listxattr/listxattr04.c b/testcases/kernel/syscalls/listxattr/listxattr04.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..af80e0c609d5931132b3bf16b28805577b2a853d
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
>> + * simple_xattr_list to always include security.* xattrs").
>> + *
>> + * Bug can be reproduced when SELinux and ACL are activated on inodes as
>> + * following:
>> + *
>> + *     $ touch testfile
>> + *     $ setfacl -m u:myuser:rwx testfile
>> + *     $ getfattr -dm. /tmp/testfile
>> + *     Segmentation fault (core dumped)
>> + *
>> + * The reason why this happens is that simple_xattr_list() always includes
>> + * security.* xattrs without resetting error flag after
>> + * security_inode_listsecurity(). This results into an incorrect length of the
>> + * returned xattr name if POSIX ACL is also applied on the inode.
>> + */
>> +
>> +#include "config.h"
>> +#include "tst_test.h"
>> +
>> +#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
>> +
>> +#include "lapi/lsm.h"
>> +
>> +#include <pwd.h>
>> +#include <sys/acl.h>
>> +#include <sys/xattr.h>
>> +
>> +#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
>> +#define TEST_FILE       "test.bin"
>> +
>> +static acl_t acl;
>> +
>> +static void verify_xattr(const int size)
>> +{
>> +	char buf[size];
>> +
>> +	memset(buf, 0, sizeof(buf));
>> +
>> +	if (listxattr(TEST_FILE, buf, size) == -1) {
>> +		if (errno != ERANGE)
>> +			tst_brk(TBROK | TERRNO, "listxattr() error");
>> +
>> +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
>> +		return;
> Why ERANGE is Checked Separately?
> Such as tst_res(TFAIL | TERRNO, "listxattr() error") will also report
> errno.
ERANGE is the error we get if kernel is affected by this bug.
>> +	}
>> +
>> +	tst_res(TPASS, "listxattr() correctly read attributes length");
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int size;
>> +
>> +	size = listxattr(TEST_FILE, NULL, 0);
>> +	if (size == -1)
>> +		tst_brk(TBROK | TERRNO, "listxattr() error");
>> +
>> +	verify_xattr(size);
>> +}
>> +
>> +static int selinux_enabled(void)
>> +{
>> +	uint32_t lsm_num;
>> +	uint64_t ids[32];
>> +	uint32_t page_size;
>> +	int available = 0;
>> +
>> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
>> +
>> +	lsm_num = lsm_list_modules(ids, &page_size, 0);
>> +	if (!lsm_num)
>> +		return 0;
>> +
>> +	for (uint32_t i = 0; i < lsm_num; i++) {
>> +		if (ids[i] == LSM_ID_SELINUX) {
>> +			available = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return available;
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	int res;
>> +
>> +	if (!selinux_enabled())
> Mabye we can use is_selinux_enabled instead of self build function?
I seen it, but it's related to the libselinux header files used to 
communicate with the LSM.
We might not have libselinux headers, but SELinux enabled anyway.
>> +		tst_brk(TCONF, "SELinux is not running");
>> +
>> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
>> +
>> +	acl = acl_from_text(ACL_PERM);
>> +	if (!acl)
>> +		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
>> +
>> +	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
>> +	if (res == -1) {
>> +		if (errno == EOPNOTSUPP)
>> +			tst_brk(TCONF | TERRNO, "acl_set_file()");
>> +
>> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
>> +	}
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (acl)
>> +		acl_free(acl);
> unlink(TEST_FILE);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "800d0b9b6a8b"},
>> +		{}
>> +	}
>> +};
>> +
>> +#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
>> +	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
>> +#endif
>>
>> ---
>> base-commit: a908cff70f9389c2dd2bf535976cb179bfa8f340
>> change-id: 20250702-xattr_bug_repr-5873b84792fb
>>
>> Best regards,
>> -- 
>> Andrea Cervesato <andrea.cervesato@suse.com>
>>
> Thanks for your patch, some minor comments see above.
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
