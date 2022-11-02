Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAFCC4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 13:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBD583CAD57
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 14:36:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BB403CA80D
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 14:36:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 624002009C3
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 14:36:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B513E336F9;
 Wed,  2 Nov 2022 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667396206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxeVDgm5OjydI7wT6oYNhSfNqCgWZrZSvoZEphj4Kvc=;
 b=bMUiCiA/G0PjuBvUkyV3pMjNHMEGIOheLyK58rW5HkbXkkSmvet3Zb6nAxBwQ/gLByH1tF
 QFLk5qWiXz1Nf45P8u2uFJksSlD4ZbdrU6vwRtFuOkMBvvZlZnxT6drbIec1PSJY2OPj57
 4T1wbfHRuKCPmQbUIYr4VDvMKav/8YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667396206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxeVDgm5OjydI7wT6oYNhSfNqCgWZrZSvoZEphj4Kvc=;
 b=trKyAnQia0v8Mt81M2u01gwIxz+B74Z2nRth+cdzaIYtg6c7J7V4ch1BtQi2jpLdoKw4ke
 CR33LS0PqjX5hGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A0C139D3;
 Wed,  2 Nov 2022 13:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kFF2Jm5yYmMzPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Nov 2022 13:36:46 +0000
Date: Wed, 2 Nov 2022 14:38:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2JyzD7vBxPSyeX4@yuki>
References: <20221102114923.447871-1-tsahu@linux.ibm.com>
 <20221102114923.447871-2-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221102114923.447871-2-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/4] Hugetlb: Add new tst_test options for
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Most of libhugetlbfs test require mounted hugetlbfs.
> 
> Here, this patch adds a new field in tst_test struct(include/tst_test.h)
> which user can set if the test requires mounted hugetlbfs. Also, this
> patch added support to create the unlinked file in the provided dirpath.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  include/tst_test.h | 11 +++++++++++
>  lib/tst_test.c     | 41 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index a69965b95..01bc5a05b 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -176,6 +176,11 @@ struct tst_test {
>  	int all_filesystems:1;
>  	int skip_in_lockdown:1;
>  	int skip_in_compat:1;
> +	/*
> +	 * If set, the test function will create a hugetlbfs mount point
> +	 * at /tmp/xxxxxx, where xxxxxx is a random string.

This is no longer up-to-date I guess that this should be:

"If set hugetlbfs will be moutned at .mntpoint"

> +	 */
> +	int needs_hugetlbfs:1;
>  
>  	/*
>  	 * The skip_filesystems is a NULL terminated list of filesystems the
> @@ -357,6 +362,12 @@ unsigned int tst_remaining_runtime(void);
>   */
>  void tst_set_max_runtime(int max_runtime);
>  
> +/*
> + * Create and open a random file inside the given dir path.
> + * It unlinks the file after opening and return file descriptor.
> + */
> +int tst_creat_unlinked(const char *path);
> +
>  /*
>   * Returns path to the test temporary directory in a newly allocated buffer.
>   */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8ccde1629..9965706ef 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1021,6 +1021,29 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
>  	}
>  }
>  
> +static void prepare_and_mount_hugetlb_fs(void)
> +{
> +	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> +	mntpoint_mounted = 1;
> +}
> +
> +int tst_creat_unlinked(const char *path)
> +{
> +	char template[PATH_MAX];
> +	int fd;
> +
> +	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> +			path, TCID);
                                 ^
				 Should be tid in new library code.

> +	fd = mkstemp(template);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO,
> +			 "%s: mkstemp(%s) failed", __func__, template);
                                                      ^
						      This is not
						      necessary

The tst_brk() prints filename and line number already, there is no need
to print the function name as well.

> +	SAFE_UNLINK(template);
> +	return fd;
> +}
> +
>  static const char *limit_tmpfs_mount_size(const char *mnt_data,
>  		char *buf, size_t buf_size, const char *fs_type)
>  {
> @@ -1191,15 +1214,16 @@ static void do_setup(int argc, char *argv[])
>  		SAFE_MKDIR(tst_test->mntpoint, 0777);
>  
>  	if ((tst_test->needs_devfs || tst_test->needs_rofs ||
> -	     tst_test->mount_device || tst_test->all_filesystems) &&
> +	     tst_test->mount_device || tst_test->all_filesystems ||
> +		 tst_test->needs_hugetlbfs) &&
>  	     !tst_test->mntpoint) {
>  		tst_brk(TBROK, "tst_test->mntpoint must be set!");
>  	}
>  
>  	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
> -	    !!tst_test->needs_device > 1) {
> +	    !!tst_test->needs_device + !!tst_test->needs_hugetlbfs > 1) {
>  		tst_brk(TBROK,
> -			"Two or more of needs_{rofs, devfs, device} are set");
> +			"Two or more of needs_{rofs, devfs, device, hugetlbfs} are set");
>  	}
>  
>  	if (tst_test->needs_devfs)
> @@ -1217,6 +1241,9 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (tst_test->needs_hugetlbfs)
> +		prepare_and_mount_hugetlb_fs();
> +
>  	if (tst_test->needs_device && !mntpoint_mounted) {
>  		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
>  
> @@ -1299,8 +1326,12 @@ static void do_cleanup(void)
>  	if (ovl_mounted)
>  		SAFE_UMOUNT(OVL_MNT);
>  
> -	if (mntpoint_mounted)
> -		tst_umount(tst_test->mntpoint);
> +	if (mntpoint_mounted) {
> +		if (tst_test->needs_hugetlbfs)
> +			SAFE_UMOUNT(tst_test->mntpoint);
> +		else
> +			tst_umount(tst_test->mntpoint);
> +	}

And I would just keep this umount part as it was.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
