Return-Path: <SRS0=aRd5=P7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52CC433F5
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 10:52:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E362A60C40
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 10:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E362A60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4819F3C7C6D
	for <ltp@archiver.kernel.org>; Fri, 12 Nov 2021 11:52:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C203C7969
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 11:52:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB1761400540
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 11:52:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7B3002198F;
 Fri, 12 Nov 2021 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636714330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWhWpW6EXBRwOoulhcQAhhqyj2UlDSAar/ewWmLAO6Q=;
 b=ZUXAWV6yf6HvfQSQYZsyVKY/h2K60Pa2keaWDugrzgAE9W8r/MNi85TQ7bGUL1+fQNcGDF
 mGDTOmKcz7cF8cDs+gaR+iZ+Zao9IkDzokTBk8kQK5/GhJfEaHFoDuff1G0m6C5xWiRocs
 jSq6lSZZps0zoZFrQqxP2Xk1VfcFFLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636714330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWhWpW6EXBRwOoulhcQAhhqyj2UlDSAar/ewWmLAO6Q=;
 b=7If9ISnCM2HZdlrESJcrTBeHXANSinprMrZYbmx8R/v1HX6mD2BaZkN17q4CdAugDMMWUi
 0XH103US5jAJpyDg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 14CD7A3B87;
 Fri, 12 Nov 2021 10:52:10 +0000 (UTC)
References: <1636619544-2369-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 12 Nov 2021 10:21:56 +0000
In-reply-to: <1636619544-2369-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87a6i9ejdy.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx04: use stx_attributes_mask
 before test
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Yang,

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> stx_attributes_mask shows what's supported in stx_attributes.
> Set supp_{append,compr,immutable,nodump} attributes only on filesystems
> which actually support it.
>
> Also merge duplicate code and document the kernel commits that ext2/ext4/xfs/btrfs
> supports statx syscall correctly.
>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v3->v4:
> 1. add kernel commits into top description
> 2. docparse formatting

Note that I also suggested NOT checking the kernel version. Because
these patches are likely to get backported.

Please see comments below.

>
> v2->v3:
> 1.add kernel version check for stx_attributes_mask
> 2. use test_flag(int) instead of test_flagged and test_unflagged
>
>  testcases/kernel/syscalls/statx/statx04.c | 197 ++++++++++++++--------
>  1 file changed, 123 insertions(+), 74 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index f8350ed2d..3c221b461 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -4,21 +4,46 @@
>   * Email: code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
>   *
>   * This code tests if the attributes field of statx received expected value.
>   * File set with following flags by using SAFE_IOCTL:
> - * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
> - * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
> - * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
> - *                        writing.
> - * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
> + *
> + * - STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
> + * - STATX_ATTR_IMMUTABLE - The file cannot be modified.
> + * - STATX_ATTR_APPEND - The file can only be opened in append mode for writing.
> + * - STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
>   *                        program such as dump(8) is run.
>   *
>   * Two directories are tested.
> - * First directory has all flags set.
> - * Second directory has no flags set.
> + * First directory has all flags set. Second directory has no flags set.
> + *
> + * ext2, ext4, btrfs and xfs support statx syscall since the following commit
> + *
> + *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> + *  Author: yangerkun <yangerkun@huawei.com>
> + *  Date:   Mon Feb 18 09:07:02 2019 +0800
> + *
> + *  ext2: support statx syscall
> + *
> + *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
> + *  Author: David Howells <dhowells@redhat.com>
> + *  Date:   Fri Mar 31 18:31:56 2017 +0100
> + *
> + *  ext4: Add statx support
> + *
> + *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
> + *  Author: Yonghong Song <yhs@fb.com>
> + *  Date:   Fri May 12 15:07:43 2017 -0700
> + *
> + *  Btrfs: add statx support
> + *
> + *  commit 1b9598c8fb9965fff901c4caa21fed9644c34df3
> + *  Author: Luis R. Rodriguez <mcgrof@kernel.org>
> + *  Date:   Fri Mar 1 08:14:57 2019 -0800
> + *
> + *  xfs: fix reporting supported extra file attributes for statx()

This is good. However I also meant that you can add the commit tag to
tst_test. E.g. from the cve-2014-0196 testcase

static struct tst_test test = {
	.setup = setup,
	.cleanup = cleanup,
	.test_all = run,
	.tags = (const struct tst_tag[]) {
		{"linux-git", "4291086b1f08"},
		{"CVE", "2014-0196"},
		{}
	}
};


>   *
>   * Minimum kernel version required is 4.11.
>   */
> @@ -34,85 +59,67 @@
>  #define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
>  
>  static int fd, clear_flags;
> +static int supp_compr = 1, supp_append = 1, supp_immutable = 1, supp_nodump = 1;
>  
> -static void test_flagged(void)
> -{
> -	struct statx buf;
> -
> -	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
> -	if (TST_RET == 0)
> -		tst_res(TPASS,
> -			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> -	else
> -		tst_brk(TFAIL | TTERRNO,
> -			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> -
> -	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
> -		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_APPEND)
> -		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_APPEND flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
> -		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_NODUMP)
> -		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is not set");
> -}
> -
> -static void test_unflagged(void)
> +static void test_flag(int flag)
>  {
>  	struct statx buf;
>  
> -	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
> +	TEST(statx(AT_FDCWD, flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED, 0, 0, &buf));
>  	if (TST_RET == 0)
>  		tst_res(TPASS,
>  			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> -			TESTDIR_UNFLAGGED);
> +			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
>  	else
>  		tst_brk(TFAIL | TTERRNO,
>  			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> -			TESTDIR_UNFLAGGED);
> -
> -	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
> -		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
> -		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_APPEND flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
> -		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
> -		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is set");
> +			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
> +
> +	if (supp_compr) {
> +		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_COMPRESSED flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_COMPRESSED flag is not set");
> +	}
> +	if (supp_append) {
> +		if (buf.stx_attributes & STATX_ATTR_APPEND)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_APPEND flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_APPEND flag is not set");
> +	}
> +	if (supp_immutable) {
> +		if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_IMMUTABLE flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_IMMUTABLE flag is not set");
> +	}
> +	if (supp_nodump) {
> +		if (buf.stx_attributes & STATX_ATTR_NODUMP)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_NODUMP flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_NODUMP flag is not set");
> +	}
>  }
>  
>  struct test_cases {
> -	void (*tfunc)(void);
> +	void (*tfunc)(int);
> +	int set_flag;
>  } tcases[] = {
> -	{&test_flagged},
> -	{&test_unflagged},
> +	{&test_flag, 1},
> +	{&test_flag, 0},
>  };
>  
>  static void run(unsigned int i)
>  {
> -	tcases[i].tfunc();
> +	tcases[i].tfunc(tcases[i].set_flag);
>  }
>  
>  static void caid_flags_setup(void)
> @@ -135,12 +142,17 @@ static void caid_flags_setup(void)
>  		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
>  	}
>  
> -	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
> +	if (supp_compr)
> +		attr |= FS_COMPR_FL;
> +	if (supp_append)
> +		attr |= FS_APPEND_FL;
> +	if (supp_immutable)
> +		attr |= FS_IMMUTABLE_FL;
> +	if (supp_nodump)
> +		attr |= FS_NODUMP_FL;
>  
>  	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
>  	if (ret < 0) {
> -		if (errno == EOPNOTSUPP)
> -			tst_brk(TCONF, "Flags not supported");
>  		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
>  	}
>  
> @@ -149,11 +161,48 @@ static void caid_flags_setup(void)
>  
>  static void setup(void)
>  {
> +	struct statx buf;
> +
>  	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>  	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);

So we create the dirs here. I assume they are created with all blank
flags otherwise the existing test would be broken.

>  
> +	/* Don't check ext4 because ext4 supports statx since 4.11. */
>  	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
> -		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
> +		tst_brk(TCONF,
> +			"Btrfs statx() stx_attributes_mask supported since 4.13, see test description!");
> +
> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(5, 1, 0) < 0)
> +		tst_brk(TCONF,
> +			"xfs statx() stx_attributes_mask supported since 5.1, see test description!");
> +
> +	if (!strcmp(tst_device->fs_type, "ext2") && tst_kvercmp(5, 1, 0) < 0)
> +		tst_brk(TCONF,
> +			"ext2 statx() stx_attributes_mask supported since 5.1, see test description!");
> +
> +	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));

Then we get the flags here. They should all be blank.

> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TTERRNO,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> +
> +	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0) {
> +		supp_compr = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_COMPR_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0) {
> +		supp_append = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_APPEND_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0) {
> +		supp_immutable = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0) {
> +		supp_nodump = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_NODUMP_FL");
> +	}
> +	if (!(supp_compr || supp_append || supp_immutable || supp_nodump))
> +		tst_brk(TCONF,
> +			"filesystem doesn't support the above any attr,
> skip it");

So this will always fail with TCONF?

>  
>  	caid_flags_setup();

And then we set the flags here?

Note that even if you move setting the flags to the top. This will still
result in all unset flags becoming TCONF instead of TFAIL.

IMO statx is broken on older kernels except for ext4. It can be fixed by
backporting patches. One of the main use cases for LTP is to find
missing backports.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
