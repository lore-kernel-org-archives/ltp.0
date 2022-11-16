Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE42C4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 10:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244873CD046
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:58:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94FF3CD025
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:58:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A07CE1400DBC
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 11:58:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D825336F0;
 Wed, 16 Nov 2022 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668596295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/5a54KDrDw4h1HGsmAwy2pCa9sEir5FMYLPEAc8GLM=;
 b=ZeRJ2jnIjZ7bUBn4W1KphcA8GIR1lvYVvB+tktfc2E718aBXBNAAJtF6yA8Ux/8WIA8uBE
 TJVBMT3VDdv+GDVR/WRNiRmzonlS8BjSGdpOY7SkUxkLxB1SDJtWPlI6l1chbu2YdNTa7Q
 QiEjWH/snQ1+8BwLZtWlJ2Mq6pDLviA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668596295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/5a54KDrDw4h1HGsmAwy2pCa9sEir5FMYLPEAc8GLM=;
 b=c8ijRBpJdEMCMDxfV9xAWppp4HQb2I0zTys3W40klO7rZgdmradZFBFqARvMf4Ompo09OG
 X3eGzkBJEoQJBDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FBD013480;
 Wed, 16 Nov 2022 10:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ++FdF0fCdGN0XwAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 16 Nov 2022 10:58:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id EE8C1A0709; Wed, 16 Nov 2022 11:58:14 +0100 (CET)
Date: Wed, 16 Nov 2022 11:58:14 +0100
From: Jan Kara <jack@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <20221116105814.ozfankn5qkizj2zr@quack3>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-3-jack@suse.cz>
 <Y3RIKsBUx+KiH4lD@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3RIKsBUx+KiH4lD@xpf.sh.intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify10: Make evictable marks tests more
 reliable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 16-11-22 10:17:14, Pengfei Xu wrote:
> Hi Jan Kara,
> 
> On 2022-11-15 at 13:47:38 +0100, Jan Kara wrote:
> > Tests verifying that evictable inode marks don't pin inodes in memory
> > are unreliable because slab shrinking (triggered by drop_caches) does
> > not reliably evict inodes - dentries have to take round through the LRU
> > list and only then get reclaimed and inodes get unpinned and then inodes
> > have to be rotated through their LRU list to get reclaimed. If there are
> > not enough freed entries while shrinking other slab caches, drop_caches
> > will abort attempts to reclaim slab before inodes get evicted.
> > 
> > Tweak evictable marks tests to use more files and marks in parallel and
> > just verify that some (at least half) of the marks got evicted. This
> > should be more tolerant to random fluctuation in slab reclaim
> > efficiency.
> > 
> If possible, could you add the Tested-by tag:
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Sure, will do. I'll just wait whether there will be some other review
comments.

								Honza

> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  .../kernel/syscalls/fanotify/fanotify10.c     | 62 ++++++++++++++++---
> >  1 file changed, 52 insertions(+), 10 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index e19bd907470f..cfbf4c31dd08 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -86,7 +86,10 @@ static int ignore_mark_unsupported;
> >  #define TEST_APP "fanotify_child"
> >  #define TEST_APP2 "fanotify_child2"
> >  #define DIR_PATH MOUNT_PATH"/"DIR_NAME
> > +#define DIR_PATH_MULTI DIR_PATH"%d"
> >  #define FILE_PATH DIR_PATH"/"FILE_NAME
> > +#define FILE_PATH_MULTI FILE_PATH"%d"
> > +#define FILE_PATH_MULTIDIR DIR_PATH_MULTI"/"FILE_NAME
> >  #define FILE2_PATH DIR_PATH"/"FILE2_NAME
> >  #define SUBDIR_PATH DIR_PATH"/"SUBDIR_NAME
> >  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> > @@ -104,6 +107,7 @@ static int old_cache_pressure;
> >  static pid_t child_pid;
> >  static int bind_mount_created;
> >  static unsigned int num_classes = NUM_CLASSES;
> > +static int max_file_multi;
> >  
> >  enum {
> >  	FANOTIFY_INODE,
> > @@ -378,9 +382,11 @@ static struct tcase {
> >  		.tname = "don't ignore mount events created on file with evicted ignore mark",
> >  		.mark_path_fmt = MOUNT_PATH,
> >  		.mark_type = FANOTIFY_MOUNT,
> > -		.ignore_path_fmt = FILE_PATH,
> > +		.ignore_path_cnt = 16,
> > +		.ignore_path_fmt = FILE_PATH_MULTI,
> >  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> > -		.event_path_fmt = FILE_PATH,
> > +		.event_path_cnt = 16,
> > +		.event_path_fmt = FILE_PATH_MULTI,
> >  		.expected_mask_with_ignore = FAN_OPEN,
> >  		.expected_mask_without_ignore = FAN_OPEN
> >  	},
> > @@ -388,9 +394,11 @@ static struct tcase {
> >  		.tname = "don't ignore fs events created on a file with evicted ignore mark",
> >  		.mark_path_fmt = MOUNT_PATH,
> >  		.mark_type = FANOTIFY_FILESYSTEM,
> > -		.ignore_path_fmt = FILE_PATH,
> > +		.ignore_path_cnt = 16,
> > +		.ignore_path_fmt = FILE_PATH_MULTI,
> >  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> > -		.event_path_fmt = FILE_PATH,
> > +		.event_path_cnt = 16,
> > +		.event_path_fmt = FILE_PATH_MULTI,
> >  		.expected_mask_with_ignore = FAN_OPEN,
> >  		.expected_mask_without_ignore = FAN_OPEN
> >  	},
> > @@ -398,10 +406,12 @@ static struct tcase {
> >  		.tname = "don't ignore mount events created inside a parent with evicted ignore mark",
> >  		.mark_path_fmt = MOUNT_PATH,
> >  		.mark_type = FANOTIFY_MOUNT,
> > -		.ignore_path_fmt = DIR_PATH,
> > +		.ignore_path_cnt = 16,
> > +		.ignore_path_fmt = DIR_PATH_MULTI,
> >  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> >  		.ignored_flags = FAN_EVENT_ON_CHILD,
> > -		.event_path_fmt = FILE_PATH,
> > +		.event_path_cnt = 16,
> > +		.event_path_fmt = FILE_PATH_MULTIDIR,
> >  		.expected_mask_with_ignore = FAN_OPEN,
> >  		.expected_mask_without_ignore = FAN_OPEN
> >  	},
> > @@ -409,10 +419,12 @@ static struct tcase {
> >  		.tname = "don't ignore fs events created inside a parent with evicted ignore mark",
> >  		.mark_path_fmt = MOUNT_PATH,
> >  		.mark_type = FANOTIFY_FILESYSTEM,
> > -		.ignore_path_fmt = DIR_PATH,
> > +		.ignore_path_cnt = 16,
> > +		.ignore_path_fmt = DIR_PATH_MULTI,
> >  		.ignore_mark_type = FANOTIFY_EVICTABLE,
> >  		.ignored_flags = FAN_EVENT_ON_CHILD,
> > -		.event_path_fmt = FILE_PATH,
> > +		.event_path_cnt = 16,
> > +		.event_path_fmt = FILE_PATH_MULTIDIR,
> >  		.expected_mask_with_ignore = FAN_OPEN,
> >  		.expected_mask_without_ignore = FAN_OPEN
> >  	},
> > @@ -864,6 +876,8 @@ cleanup:
> >  
> >  static void setup(void)
> >  {
> > +	int i;
> > +
> >  	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> >  								      FAN_CLASS_CONTENT, 0);
> >  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> > @@ -880,7 +894,24 @@ static void setup(void)
> >  	SAFE_MKDIR(DIR_PATH, 0755);
> >  	SAFE_MKDIR(SUBDIR_PATH, 0755);
> >  	SAFE_FILE_PRINTF(FILE_PATH, "1");
> > -	SAFE_FILE_PRINTF(FILE2_PATH, "1");
> > +	for (i = 0; i < (int)(sizeof(tcases)/sizeof(tcases[0])); i++) {
> > +		if (tcases[i].mark_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].mark_path_cnt;
> > +		if (tcases[i].ignore_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].ignore_path_cnt;
> > +		if (tcases[i].event_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].event_path_cnt;
> > +	}
> > +	for (i = 0; i < max_file_multi; i++) {
> > +		char path[PATH_MAX];
> > +
> > +		sprintf(path, FILE_PATH_MULTI, i);
> > +		SAFE_FILE_PRINTF(path, "1");
> > +		sprintf(path, DIR_PATH_MULTI, i);
> > +		SAFE_MKDIR(path, 0755);
> > +		sprintf(path, FILE_PATH_MULTIDIR, i);
> > +		SAFE_FILE_PRINTF(path, "1");
> > +	}
> >  
> >  	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
> >  	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
> > @@ -896,6 +927,8 @@ static void setup(void)
> >  
> >  static void cleanup(void)
> >  {
> > +	int i;
> > +
> >  	cleanup_fanotify_groups();
> >  
> >  	if (bind_mount_created)
> > @@ -903,8 +936,17 @@ static void cleanup(void)
> >  
> >  	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
> >  
> > +	for (i = 0; i < max_file_multi; i++) {
> > +		char path[PATH_MAX];
> > +
> > +		sprintf(path, FILE_PATH_MULTIDIR, i);
> > +		SAFE_UNLINK(path);
> > +		sprintf(path, DIR_PATH_MULTI, i);
> > +		SAFE_RMDIR(path);
> > +		sprintf(path, FILE_PATH_MULTI, i);
> > +		SAFE_UNLINK(path);
> > +	}
> >  	SAFE_UNLINK(FILE_PATH);
> > -	SAFE_UNLINK(FILE2_PATH);
> >  	SAFE_RMDIR(SUBDIR_PATH);
> >  	SAFE_RMDIR(DIR_PATH);
> >  	SAFE_RMDIR(MNT2_PATH);
> > -- 
> > 2.35.3
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
