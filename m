Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA3DC43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:04:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1BD53C94AA
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 15:04:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5233C006A
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:04:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 768A810009DA
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:04:13 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8D9F91F8F1;
 Tue, 14 Jun 2022 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655211853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBEFdT2uPOmU/7K+RMm6lhYrVkT4RyjNXWmiL3g9dIU=;
 b=WMk+z2kna5TLlCt8SIDAzS/e7TW/kXHoLYKWo47ZZAeeY0IS4WglBptU2b/oB9NCtvYoGn
 m1kKqfJJKNnYMLpm/2FoLbHuAtFh985MezneuCe0gUiyPuy8M3sh+5U4Ha8372NeQoFNC1
 f+TXdmP+a3faQCRoFyjnUM10LKO0NbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655211853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBEFdT2uPOmU/7K+RMm6lhYrVkT4RyjNXWmiL3g9dIU=;
 b=7yMwfvPojYjbQcKh0o5Hu2jPrZmX9CL+/8CmATfN5iqvBk7/2PyQWSfP85A7K2eGLCTHcg
 4DvzjegvYj6/UGDQ==
Received: from quack3.suse.cz (jack.udp.ovpn1.nue.suse.de [10.163.28.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 78A202C141;
 Tue, 14 Jun 2022 13:04:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 97BDEA062E; Tue, 14 Jun 2022 15:04:10 +0200 (CEST)
Date: Tue, 14 Jun 2022 15:04:10 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220614130410.k5d4rhjd7ps2pkif@quack3.lan>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-6-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/fanotify10: Add test cases for
 evictable ignore mark
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 13-06-22 17:38:26, Amir Goldstein wrote:
> Test multiple groups with evictable mark with ignore mask
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index b9a50672d..52277d0b7 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
>  static int exec_events_unsupported;
>  static int fan_report_dfid_unsupported;
>  static int filesystem_mark_unsupported;
> +static int evictable_mark_unsupported;
>  
>  #define MOUNT_PATH "fs_mnt"
>  #define MNT2_PATH "mntpoint"
> @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
>  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
>  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
>  
> +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> +
> +static int old_cache_pressure;
>  static pid_t child_pid;
>  static int bind_mount_created;
>  static unsigned int num_classes = NUM_CLASSES;
> @@ -98,12 +103,14 @@ enum {
>  	FANOTIFY_INODE,
>  	FANOTIFY_MOUNT,
>  	FANOTIFY_FILESYSTEM,
> +	FANOTIFY_EVICTABLE,
>  };
>  
>  static struct fanotify_mark_type fanotify_mark_types[] = {
>  	INIT_FANOTIFY_MARK_TYPE(INODE),
>  	INIT_FANOTIFY_MARK_TYPE(MOUNT),
>  	INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> +	INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
>  };
>  
>  static struct tcase {
> @@ -289,14 +296,59 @@ static struct tcase {
>  		0,
>  		FILE_PATH, FAN_OPEN, FAN_OPEN
>  	},
> +	/* Evictable ignore mark test cases */
> +	{
> +		"don't ignore mount events created on file with evicted ignore mark",
> +		MOUNT_PATH, FANOTIFY_MOUNT,
> +		FILE_PATH, FANOTIFY_EVICTABLE,
> +		0,
> +		FILE_PATH, FAN_OPEN, FAN_OPEN
> +	},
> +	{
> +		"don't ignore fs events created on a file with evicted ignore mark",
> +		MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +		FILE_PATH, FANOTIFY_EVICTABLE,
> +		0,
> +		FILE_PATH, FAN_OPEN, FAN_OPEN
> +	},
> +	{
> +		"don't ignore mount events created inside a parent with evicted ignore mark",
> +		MOUNT_PATH, FANOTIFY_MOUNT,
> +		DIR_PATH, FANOTIFY_EVICTABLE,
> +		FAN_EVENT_ON_CHILD,
> +		FILE_PATH, FAN_OPEN, FAN_OPEN
> +	},
> +	{
> +		"don't ignore fs events created inside a parent with evicted ignore mark",
> +		MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +		DIR_PATH, FANOTIFY_EVICTABLE,
> +		FAN_EVENT_ON_CHILD,
> +		FILE_PATH, FAN_OPEN, FAN_OPEN
> +	},
>  };
>  
> +static void show_fanotify_marks(int fd)
> +{
> +	unsigned int mflags, mask, ignored_mask;
> +	char procfdinfo[100];
> +
> +	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd);
> +	if (FILE_LINES_SCANF(procfdinfo, "fanotify ino:%*x sdev:%*x mflags: %x mask:%x ignored_mask:%x",
> +				&mflags, &mask, &ignored_mask)) {
> +		tst_res(TPASS, "No fanotify inode marks as expected");
> +	} else {
> +		tst_res(TFAIL, "Unexpected inode mark (mflags=%x, mask=%x ignored_mask=%x)",
> +				mflags, mask, ignored_mask);
> +	}
> +}
> +
>  static int create_fanotify_groups(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  	struct fanotify_mark_type *mark, *ignore_mark;
>  	unsigned int mark_ignored, mask;
>  	unsigned int p, i;
> +	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
>  
>  	mark = &fanotify_mark_types[tc->mark_type];
>  	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
> @@ -345,6 +397,20 @@ add_mark:
>  			}
>  		}
>  	}
> +
> +	/*
> +	 * drop_caches should evict inode from cache and remove evictable marks
> +	 */
> +	if (evictable_ignored) {
> +		SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
> +		for (p = 0; p < num_classes; p++) {
> +			for (i = 0; i < GROUPS_PER_PRIO; i++) {
> +				if (fd_notify[p][i] > 0)
> +					show_fanotify_marks(fd_notify[p][i]);
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -439,6 +505,11 @@ static void test_fanotify(unsigned int n)
>  		return;
>  	}
>  
> +	if (evictable_mark_unsupported && tc->ignore_mark_type == FANOTIFY_EVICTABLE) {
> +		tst_res(TCONF, "FAN_MARK_EVICTABLE not supported in kernel?");
> +		return;
> +	}
> +
>  	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
>  		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
>  				" has undefined behavior on kernel < 5.9");
> @@ -527,6 +598,7 @@ static void setup(void)
>  	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
>  								      FAN_CLASS_CONTENT, 0);
>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> +	evictable_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_EVICTABLE);
>  	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>  									  MOUNT_PATH);
>  	if (fan_report_dfid_unsupported) {
> @@ -545,6 +617,10 @@ static void setup(void)
>  	/* Create another bind mount at another path for generating events */
>  	SAFE_MKDIR(MNT2_PATH, 0755);
>  	mount_cycle();
> +
> +	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
> +	/* Set high priority for evicting inodes */
> +	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
>  }
>  
>  static void cleanup(void)
> @@ -553,6 +629,8 @@ static void cleanup(void)
>  
>  	if (bind_mount_created)
>  		SAFE_UMOUNT(MNT2_PATH);
> +
> +	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
>  }
>  
>  static const char *const resource_files[] = {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
