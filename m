Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B39CC433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 08:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6403CA2DB
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 10:26:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951323CA06C
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 10:26:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6FB6D1000ED7
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 10:26:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 796B821A97;
 Fri,  1 Apr 2022 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648801572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jn0/uKIj73Jborkt0YjQ2fNeQ8nPw10zGTSLUkpuHP0=;
 b=H1A6W1F0ffSjxXp5EdLW6uUKwI8PnpHHy3FkZKaVlLNHneUUcNmRBYPRu/oBaYCt2Uz6DD
 ch7wIvEn6saYCnpQjkYm78K/iREQt3+rWUnWGFTeezAck/mw+J9umBqkQeJlLZI1Yg5Uwy
 TgWkFDuZC2LCqPE2qv6ZxFTG1n7jzQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648801572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jn0/uKIj73Jborkt0YjQ2fNeQ8nPw10zGTSLUkpuHP0=;
 b=V+JqUwVH87rAa/wjXQtTRy6VU6ecM5z5vM78TbAfQ261k6duWRTvs52w2NsET/TzgDZURc
 epqKd4JECMknANBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A38132C1;
 Fri,  1 Apr 2022 08:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U00SEiS3RmI1OQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Apr 2022 08:26:12 +0000
Date: Fri, 1 Apr 2022 10:26:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Yka3Iu1NLRzLnIlk@pevik>
References: <20220329074440.26214-1-rpalethorpe@suse.com>
 <20220329074440.26214-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220329074440.26214-3-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] cgroups: Add first IO controller test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> +++ b/testcases/kernel/controllers/io/io_control01.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
nit: not sure if it was deliberate not adding it, but you may want to add your/SUSE copyright.

> +/*\
> + *
> + * [Description]
> + *
> + * Perform some I/O on a file and check if at least some of it is
> + * recorded by the I/O controller.
> + *
> + * The exact amount of I/O performed is dependent on the file system,
> + * page cache, scheduler and block driver. We call sync and drop the
> + * file's page cache to force reading and writing. We also write
> + * random data to try to prevent compression.
> + *
> + * The pagecache is a particular issue for reading. If the call to
> + * fadvise is ignored then the data may only be read from the
> + * cache. So that no I/O requests are made.
> + */
> +
...
> +static int read_io_stats(const char *const line, struct io_stats *const stat)
> +{
> +	return sscanf(line,
> +		      "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
> +		      &stat->mjr, &stat->mnr,
> +		      &stat->rbytes, &stat->wbytes, &stat->rios, &stat->wios,
> +		      &stat->dbytes, &stat->dios);
> +}
checkpatch.pl false positive:
io_control01.c:40: WARNING: unchecked sscanf return value
Obviously perl parsing has some limitations as we check read_io_stats() return
value.

...
> +static void setup(void)
> +{
> +	char buf[PATH_MAX] = { 0 };
> +	char *path = SAFE_GETCWD(buf, PATH_MAX - sizeof("mnt") - 1);
> +	struct stat st;
> +
> +	strcpy(path + strlen(path), "/mnt");
> +
> +	tst_stat_mount_dev(path, &st);
> +	dev_major = major(st.st_rdev);
> +	dev_minor = minor(st.st_rdev);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_device = 1,
nit: testcases/kernel/controllers/io/io_control01.c: useless tag: needs_device

Kind regards,
Petr

> +	.mntpoint = "mnt",
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]){ "ntfs", "tmpfs", NULL },
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const[]){ "io", NULL },
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
