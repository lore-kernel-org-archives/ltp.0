Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB60C4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 15:02:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71FE3CCBCF
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 16:02:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 411093CCB8E
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:02:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A0E210009A1
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:02:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A2641F8BA;
 Mon, 21 Nov 2022 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669042962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVm8718GRpWbskjkGd+pHsmZKO9so3qovkIJbRl4gNI=;
 b=CPBWrtazPmsETB2W+XfMGKCdJAzli/FAtglmXlpgbvU9ZMX0SbjCJsDE4ONFI+WUU4sbIn
 RHB2Cm9/TLft5VELR7w5IIhxIox9UzvcHSnMUVH0Oce9UV8zzo9lvE59Eha8CRHNWpHONO
 IH36WeUX+ksTlLS96Arr45RTBRN9Jws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669042962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVm8718GRpWbskjkGd+pHsmZKO9so3qovkIJbRl4gNI=;
 b=VBS3JVDNZhmb2Q0jNpKFmSGCJwQ8NC8YHhR/bCmIvHwMoxpYOyNdYPu+oE1bSSGs2j2hDG
 prHFAGPBWpIzT8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24E431376E;
 Mon, 21 Nov 2022 15:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uGNpCBKTe2MCMQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 21 Nov 2022 15:02:42 +0000
Date: Mon, 21 Nov 2022 16:04:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <Y3uTZVir3OBBTrJ7@yuki>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221115124741.14400-2-jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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

Hi!
>  static void drop_caches(void)
> @@ -482,6 +515,7 @@ static int create_fanotify_groups(unsigned int n)
>  	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
>  	int ignore_mark_type;
>  	int ignored_onchild = tc->ignored_flags & FAN_EVENT_ON_CHILD;
> +	char path[PATH_MAX];
>  
>  	mark = &fanotify_mark_types[tc->mark_type];
>  	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
> @@ -501,11 +535,12 @@ static int create_fanotify_groups(unsigned int n)
>  			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
>  			 * or inode mark on non-directory.
>  			 */
> -			SAFE_FANOTIFY_MARK(fd_notify[p][i],
> +			foreach_path(tc, path, mark_path)
> +				SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD | mark->flag,
>  					    tc->expected_mask_without_ignore |
>  					    FAN_EVENT_ON_CHILD | FAN_ONDIR,
> -					    AT_FDCWD, tc->mark_path);
> +					    AT_FDCWD, path);

This is minor, but I would have named the macro FOREACH_PATH() and added
curly braces around the block. And the same for the rest of the
invocations.

>  			/* Do not add ignore mark for first priority groups */
>  			if (p == 0)
> @@ -519,9 +554,10 @@ static int create_fanotify_groups(unsigned int n)
>  			mark_ignored = tst_variant ? FAN_MARK_IGNORE_SURV : FAN_MARK_IGNORED_SURV;
>  			mask = FAN_OPEN | tc->ignored_flags;
>  add_mark:
> -			SAFE_FANOTIFY_MARK(fd_notify[p][i],
> +			foreach_path(tc, path, ignore_path)
> +				SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
> -					    mask, AT_FDCWD, tc->ignore_path);
> +					    mask, AT_FDCWD, path);
>  
>  			/*
>  			 * FAN_MARK_IGNORE respects FAN_EVENT_ON_CHILD flag, but legacy
> @@ -578,9 +614,24 @@ add_mark:
>  	if (ignore_mark_type == FAN_MARK_INODE) {
>  		for (p = 0; p < num_classes; p++) {
>  			for (i = 0; i < GROUPS_PER_PRIO; i++) {
> -				if (fd_notify[p][i] > 0)
> +				if (fd_notify[p][i] > 0) {
> +					int minexp, maxexp;
> +
> +					if (p == 0) {
> +						minexp = maxexp = 0;
> +					} else if (evictable_ignored) {
> +						minexp = 0;
> +						/*
> +						 * Check at least half the
> +						 * marks get evicted by reclaim
> +						 */
> +						maxexp = tc->ignore_path_cnt / 2;
> +					} else {
> +						minexp = maxexp = tc->ignore_path_cnt ? : 1;
> +					}
>  					show_fanotify_ignore_marks(fd_notify[p][i],
> -								   p > 0 && !evictable_ignored);
> +								   minexp, maxexp);
> +				}
>  			}
>  		}
>  	}
> @@ -613,7 +664,7 @@ static void mount_cycle(void)
>  	bind_mount_created = 1;
>  }
>  
> -static void verify_event(int p, int group, struct fanotify_event_metadata *event,
> +static int verify_event(int p, int group, struct fanotify_event_metadata *event,
>  			 unsigned long long expected_mask)
>  {
>  	/* Only FAN_REPORT_FID reports the FAN_ONDIR flag in events on dirs */
> @@ -626,33 +677,35 @@ static void verify_event(int p, int group, struct fanotify_event_metadata *event
>  			(unsigned long long) event->mask,
>  			(unsigned long long) expected_mask,
>  			(unsigned int)event->pid, event->fd);
> +		return 0;
>  	} else if (event->pid != child_pid) {
>  		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
>  			"(expected %u) fd=%u", group, fanotify_class[p],
>  			(unsigned long long)event->mask, (unsigned int)event->pid,
>  			(unsigned int)child_pid, event->fd);
> -	} else {
> -		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
> -			group, fanotify_class[p], (unsigned long long)event->mask,
> -			(unsigned int)event->pid, event->fd);
> +		return 0;
>  	}
> +	return 1;
>  }
>  
> -static int generate_event(const char *event_path,
> -			  unsigned long long expected_mask)
> +static int generate_event(struct tcase *tc, unsigned long long expected_mask)
>  {
>  	int fd, status;
>  
>  	child_pid = SAFE_FORK();
>  
>  	if (child_pid == 0) {
> -		if (expected_mask & FAN_OPEN_EXEC) {
> -			SAFE_EXECL(event_path, event_path, NULL);
> -		} else {
> -			fd = SAFE_OPEN(event_path, O_RDONLY);
> +		char path[PATH_MAX];
> +
> +		foreach_path(tc, path, event_path) {
> +			if (expected_mask & FAN_OPEN_EXEC) {
> +				SAFE_EXECL(path, path, NULL);
> +			} else {
> +				fd = SAFE_OPEN(path, O_RDONLY);
>  
> -			if (fd > 0)
> -				SAFE_CLOSE(fd);
> +				if (fd > 0)
> +					SAFE_CLOSE(fd);
> +			}
>  		}
>  
>  		exit(0);
> @@ -665,6 +718,37 @@ static int generate_event(const char *event_path,
>  	return 0;
>  }
>  
> +struct fanotify_event_metadata *fetch_event(int fd, int *retp)
> +{
> +	int ret;
> +	struct fanotify_event_metadata *event;
> +
> +	*retp = 0;
> +	if (event_buf_pos >= event_buf_len) {
> +		event_buf_pos = 0;
> +		ret = read(fd, event_buf, EVENT_BUF_LEN);
> +		if (ret < 0) {
> +			if (errno == EAGAIN)
> +				return NULL;
> +			tst_brk(TBROK | TERRNO, "reading fanotify events failed");
> +			*retp = -1;

If you call tst_brk(TBROK ...) the test exists since that is supposed to
signal unrecoverable error. There is no need to propagate the retp from
this function.

> +			return NULL;
> +		}
> +		event_buf_len = ret;
> +	}
> +	if (event_buf_len - event_buf_pos < (int)FAN_EVENT_METADATA_LEN) {
> +		tst_brk(TBROK,
> +			"too short event when reading fanotify events (%d < %d)",
> +			event_buf_len - event_buf_pos,
> +			(int)FAN_EVENT_METADATA_LEN);
> +		*retp = -1;
> +		return NULL;
> +	}
> +	event = (struct fanotify_event_metadata *)(event_buf + event_buf_pos);
> +	event_buf_pos += event->event_len;
> +	return event;
> +}
> +
>  static void test_fanotify(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> @@ -672,6 +756,7 @@ static void test_fanotify(unsigned int n)
>  	int ret;
>  	unsigned int p, i;
>  	struct fanotify_event_metadata *event;
> +	int event_count;
>  
>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>  
> @@ -715,7 +800,7 @@ static void test_fanotify(unsigned int n)
>  	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
>  
>  	/* Generate event in child process */
> -	if (!generate_event(tc->event_path, tc->expected_mask_with_ignore))
> +	if (!generate_event(tc, tc->expected_mask_with_ignore))
>  		tst_brk(TBROK, "Child process terminated incorrectly");
>  
>  	/* First verify all groups without matching ignore mask got the event */
> @@ -724,64 +809,52 @@ static void test_fanotify(unsigned int n)
>  			break;
>  
>  		for (i = 0; i < GROUPS_PER_PRIO; i++) {
> -			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
> -			if (ret < 0) {
> -				if (errno == EAGAIN) {
> -					tst_res(TFAIL, "group %d (%x) "
> -						"with %s did not get event",
> -						i, fanotify_class[p], mark->name);
> -					continue;
> -				}
> -				tst_brk(TBROK | TERRNO,
> -					"reading fanotify events failed");
> -			}
> -			if (ret < (int)FAN_EVENT_METADATA_LEN) {
> -				tst_brk(TBROK,
> -					"short read when reading fanotify "
> -					"events (%d < %d)", ret,
> -					(int)EVENT_BUF_LEN);
> +			event_count = 0;
> +			event_buf_pos = event_buf_len = 0;
> +			while ((event = fetch_event(fd_notify[p][i], &ret))) {
> +				event_count++;
> +				if (!verify_event(p, i, event, p == 0 ?
> +						tc->expected_mask_without_ignore :
> +						tc->expected_mask_with_ignore))
> +					break;
> +				if (event->fd != FAN_NOFD)
> +					SAFE_CLOSE(event->fd);
>  			}
> -			event = (struct fanotify_event_metadata *)event_buf;
> -			if (ret > (int)event->event_len) {
> +			if (ret < 0)
> +				continue;
> +			if (event_count != (tc->event_path_cnt ? : 1)) {
>  				tst_res(TFAIL, "group %d (%x) with %s "
> -					"got more than one event (%d > %d)",
> -					i, fanotify_class[p], mark->name, ret,
> -					event->event_len);
> +					"got unexpected number of events (%d != %d)",
> +					i, fanotify_class[p], mark->name,
> +					event_count, tc->event_path_cnt);
>  			} else {
> -				verify_event(p, i, event, p == 0 ?
> -						tc->expected_mask_without_ignore :
> -						tc->expected_mask_with_ignore);
> +				tst_res(TPASS, "group %d (%x) got %d events: mask %llx pid=%u",
> +					i, fanotify_class[p], event_count,
> +					(unsigned long long)(p == 0 ?
> +					tc->expected_mask_without_ignore :
> +					tc->expected_mask_with_ignore),
> +					(unsigned int)child_pid);
>  			}
> -			if (event->fd != FAN_NOFD)
> -				SAFE_CLOSE(event->fd);
>  		}
>  	}
>  	/* Then verify all groups with matching ignore mask did got the event */
>  	for (p = 1; p < num_classes && !tc->expected_mask_with_ignore; p++) {
>  		for (i = 0; i < GROUPS_PER_PRIO; i++) {
> -			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
> -			if (ret >= 0 && ret < (int)FAN_EVENT_METADATA_LEN) {
> -				tst_brk(TBROK,
> -					"short read when reading fanotify "
> -					"events (%d < %d)", ret,
> -					(int)EVENT_BUF_LEN);
> -			}
> -			event = (struct fanotify_event_metadata *)event_buf;
> -			if (ret > 0) {
> -				tst_res(TFAIL, "group %d (%x) with %s and "
> -					"%s ignore mask got unexpected event (mask %llx)",
> -					i, fanotify_class[p], mark->name, ignore_mark->name,
> -					event->mask);
> +			event_count = 0;
> +			event_buf_pos = event_buf_len = 0;
> +			while ((event = fetch_event(fd_notify[p][i], &ret))) {
> +				event_count++;
>  				if (event->fd != FAN_NOFD)
>  					SAFE_CLOSE(event->fd);
> -			} else if (errno == EAGAIN) {
> -				tst_res(TPASS, "group %d (%x) with %s and "
> -					"%s ignore mask got no event",
> -					i, fanotify_class[p], mark->name, ignore_mark->name);
> -			} else {
> -				tst_brk(TBROK | TERRNO,
> -					"reading fanotify events failed");
>  			}
> +			if (ret < 0)
> +				continue;
> +			if (event_count > tc->event_path_cnt / 2)
> +				tst_res(TFAIL, "group %d (%x) with %s and "
> +					"%s ignore mask got unexpectedly many events (%d > %d)",
> +					i, fanotify_class[p], mark->name,
> +					ignore_mark->name, event_count,
> +					tc->event_path_cnt / 2);

Apart from the two minor issues I pointed out the rest looks good to me,
but honestly the code is getting way to complicated I would refrain from
adding anything else into the test without some refactoring.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
