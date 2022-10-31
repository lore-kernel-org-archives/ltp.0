Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A14EFA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC1E13CABF7
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:45:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDC1D3C0135
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:45:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4994D14002D1
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:45:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57923338D0;
 Mon, 31 Oct 2022 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667227525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gKkr0fzuNz2AgXIgNAhxdL913mJTPX+iPdI3OMIyYeY=;
 b=wkyyconnscy3Jel3VjyWDb3NMT1k8nCO16RKUClLl/YffI0/j0cv59LKA0GaoeUljNAQBi
 rJmB6KiyYgWHcH/yQN0xJ+29Z0Yju8xoniLrTN4SNj//hpnCLy3DgXH4GYR78xoB8a1MVN
 PVjk5YvFYsFjD+gL5oUd38S8NutdU3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667227525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gKkr0fzuNz2AgXIgNAhxdL913mJTPX+iPdI3OMIyYeY=;
 b=6YSl4mSv6h3mHoKZmy9wMRimge43gegruVrCmG8WCizoHBo6DKebPmNtV1JvKRDrCahYcs
 bBZJ3qXpWbHcUmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DFF313451;
 Mon, 31 Oct 2022 14:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AQN5DoXfX2NFBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Oct 2022 14:45:25 +0000
Date: Mon, 31 Oct 2022 15:47:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y1/f5Uar5lB3lz0E@yuki>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221029071344.45447-2-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, geetika@linux.ibm.com,
 ltp@lists.linux.it, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  extern unsigned int tst_variant;
> -
> +extern int tst_hugetlb_fd;
>  #define TST_NO_HUGEPAGES ((unsigned long)-1)
>  
>  #define TST_UNLIMITED_RUNTIME (-1)
> @@ -176,6 +176,18 @@ struct tst_test {
>  	int all_filesystems:1;
>  	int skip_in_lockdown:1;
>  	int skip_in_compat:1;
> +	/*
> +	 * If set, the test function will create a hugetlbfs mount point
> +	 * at /tmp/xxxxxx, where xxxxxx is a random string.
> +	 */
> +	int needs_hugetlbfs:1;
> +	/*
> +	 * If set, the test function will create and open a random file
> +	 * under mounted hugetlbfs. To use this option, needs_hugetlbfs must
> +	 * be set. The file descriptior will be set in tst_hugetlb_fd.
> +	 * The close(tst_hugetlb_fd) will be called on test exit(cleanup).
> +	 */
> +	int needs_unlinked_hugetlb_file:1;
>  
>  	/*
>  	 * The skip_filesystems is a NULL terminated list of filesystems the
> @@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
>   */
>  void tst_set_max_runtime(int max_runtime);
>  
> +/*
> + * Create and open a random file inside the given dir path.
> + * It unlinks the file after opening and return file descriptor.
> + */
> +int tst_create_unlinked_file(const char *path);
> +
>  /*
>   * Returns path to the test temporary directory in a newly allocated buffer.
>   */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8ccde1629..43cba1004 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -925,7 +925,8 @@ static int needs_tmpdir(void)
>  	       tst_test->needs_device ||
>  	       tst_test->mntpoint ||
>  	       tst_test->resource_files ||
> -	       tst_test->needs_checkpoints;
> +	       tst_test->needs_checkpoints ||
> +		   tst_test->needs_hugetlbfs;
>  }
>  
>  static void copy_resources(void)
> @@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
>  	}
>  }
>  
> +static void prepare_and_mount_hugetlb_fs(void)
> +{
> +	tst_test->mntpoint = tst_get_tmpdir();
> +	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> +	mntpoint_mounted = 1;
> +}
> +
> +int tst_create_unlinked_file(const char *path)
> +{
> +	char template[PATH_MAX];
> +	int fd;
> +
> +	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> +			path, TCID);
> +
> +	fd = mkstemp(template);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO,
> +			 "%s: mkstemp(%s) failed", __func__, template);
> +
> +	SAFE_UNLINK(template);
> +	return fd;
> +}
> +
>  static const char *limit_tmpfs_mount_size(const char *mnt_data,
>  		char *buf, size_t buf_size, const char *fs_type)
>  {
> @@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)
>  	tst_cg_init();
>  }
>  
> +int tst_hugetlb_fd = -1;
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	if (!tst_test)
> @@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (tst_test->needs_hugetlbfs)
> +		prepare_and_mount_hugetlb_fs();
> +
> +	if (tst_test->needs_unlinked_hugetlb_file) {
> +		if (!(tst_test->needs_hugetlbfs)) {
> +			tst_brk(TBROK, "Option needs_unlinked_hugetlb_file "
> +					"requires option needs_hugetlbfs");
> +		}
> +		tst_hugetlb_fd = tst_create_unlinked_file(tst_test->mntpoint);
> +	}

The function tst_create_unlinked_file() looks useful, but I do not think
that adding the needs_unlinked_hugetlb_file flag simplifies things that
much. Also this will not scale well when we would need two
filedescripors like that. Maybe we it would be cleaner to add only the
mount/umount functionality to the test library and call the
tst_create_unlinked_file() in the test setup in the testcases.

>  	if (tst_test->needs_device && !mntpoint_mounted) {
>  		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
>  
> @@ -1299,8 +1337,15 @@ static void do_cleanup(void)
>  	if (ovl_mounted)
>  		SAFE_UMOUNT(OVL_MNT);
>  
> -	if (mntpoint_mounted)
> -		tst_umount(tst_test->mntpoint);
> +	if (tst_hugetlb_fd >= 0)
> +		SAFE_CLOSE(tst_hugetlb_fd);
> +
> +	if (mntpoint_mounted) {
> +		if (tst_test->needs_hugetlbfs)
> +			SAFE_UMOUNT(tst_test->mntpoint);
> +		else
> +			tst_umount(tst_test->mntpoint);
> +	}

Is there a good reason for this, why can't we call tst_umount() for
hugetlbfs?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
