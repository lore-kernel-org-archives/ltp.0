Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245D9C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 12:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F6093CCAEE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 13:27:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 116443C1B75
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:27:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 29B2711EE18A
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:27:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 213B51F86C
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669120046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eP8p0+lz3mdFsG/NrzQuqzDHSM2YlUpdI7BFXREeeXI=;
 b=0qXQApxXiARfItA+pbZMtswvOHmWrz9A2GtVIK6wIK1jBQ9QasvqFvo6DtUAFfPSG9j/oB
 9cgr9s0FlQPp5BLiwAS7sc62SL9gFR8N1WcoTO1f+PlEQEZK/hsaak4GYBmz4NIhrS3+Dh
 TCUOfhnenG6+B6UCEi6x+ZKQN+SZ3vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669120046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eP8p0+lz3mdFsG/NrzQuqzDHSM2YlUpdI7BFXREeeXI=;
 b=FveCiMr4AgFqNmYEm+VMi7pcbytPcdXSICYBMraVhAkzbDjbt+cS3Hkcv20QXXvlIDLpW4
 JXFn3Qyf5110z5CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E13B32C142;
 Tue, 22 Nov 2022 12:27:25 +0000 (UTC)
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3uTZVir3OBBTrJ7@yuki>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2022 12:10:19 +0000
Organization: Linux Private Site
In-reply-to: <Y3uTZVir3OBBTrJ7@yuki>
Message-ID: <871qpvfa3c.fsf@suse.de>
MIME-Version: 1.0
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
Reply-To: rpalethorpe@suse.de
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  static void drop_caches(void)
>> @@ -482,6 +515,7 @@ static int create_fanotify_groups(unsigned int n)
>>  	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
>>  	int ignore_mark_type;
>>  	int ignored_onchild = tc->ignored_flags & FAN_EVENT_ON_CHILD;
>> +	char path[PATH_MAX];
>>  
>>  	mark = &fanotify_mark_types[tc->mark_type];
>>  	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
>> @@ -501,11 +535,12 @@ static int create_fanotify_groups(unsigned int n)
>>  			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
>>  			 * or inode mark on non-directory.
>>  			 */
>> -			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>> +			foreach_path(tc, path, mark_path)
>> +				SAFE_FANOTIFY_MARK(fd_notify[p][i],
>>  					    FAN_MARK_ADD | mark->flag,
>>  					    tc->expected_mask_without_ignore |
>>  					    FAN_EVENT_ON_CHILD | FAN_ONDIR,
>> -					    AT_FDCWD, tc->mark_path);
>> +					    AT_FDCWD, path);
>
> This is minor, but I would have named the macro FOREACH_PATH() and
> added

This is actually not in line with the kernel style. At least IIRC
foreach macros are lower case in the instances I have seen. This is also
what we have in tst_cgroup.c for e.g.

> curly braces around the block. And the same for the rest of the
> invocations.

At some point checkpatch stopped complaining about this, so it's now the
authors discretion whether to use curly braces in these cases. Unless
there is something wrong with our checkpatch.

IMO there is no mistaking that it is a loop macro with one function call
in the body.

>
>>  			/* Do not add ignore mark for first priority groups */
>>  			if (p == 0)
>> @@ -519,9 +554,10 @@ static int create_fanotify_groups(unsigned int n)
>>  			mark_ignored = tst_variant ? FAN_MARK_IGNORE_SURV : FAN_MARK_IGNORED_SURV;
>>  			mask = FAN_OPEN | tc->ignored_flags;
>>  add_mark:
>> -			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>> +			foreach_path(tc, path, ignore_path)
>> +				SAFE_FANOTIFY_MARK(fd_notify[p][i],
>>  					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
>> -					    mask, AT_FDCWD, tc->ignore_path);
>> +					    mask, AT_FDCWD, path);
>>  
>>  			/*
>>  			 * FAN_MARK_IGNORE respects FAN_EVENT_ON_CHILD flag, but legacy
>> @@ -578,9 +614,24 @@ add_mark:
>>  	if (ignore_mark_type == FAN_MARK_INODE) {
>>  		for (p = 0; p < num_classes; p++) {
>>  			for (i = 0; i < GROUPS_PER_PRIO; i++) {
>> -				if (fd_notify[p][i] > 0)
>> +				if (fd_notify[p][i] > 0) {
>> +					int minexp, maxexp;
>> +
>> +					if (p == 0) {
>> +						minexp = maxexp = 0;
>> +					} else if (evictable_ignored) {
>> +						minexp = 0;
>> +						/*
>> +						 * Check at least half the
>> +						 * marks get evicted by reclaim
>> +						 */
>> +						maxexp = tc->ignore_path_cnt / 2;
>> +					} else {
>> +						minexp = maxexp = tc->ignore_path_cnt ? : 1;
>> +					}
>>  					show_fanotify_ignore_marks(fd_notify[p][i],
>> -								   p > 0 && !evictable_ignored);
>> +								   minexp, maxexp);
>> +				}
>>  			}
>>  		}
>>  	}
>> @@ -613,7 +664,7 @@ static void mount_cycle(void)
>>  	bind_mount_created = 1;
>>  }
>>  
>> -static void verify_event(int p, int group, struct fanotify_event_metadata *event,
>> +static int verify_event(int p, int group, struct fanotify_event_metadata *event,
>>  			 unsigned long long expected_mask)
>>  {
>>  	/* Only FAN_REPORT_FID reports the FAN_ONDIR flag in events on dirs */
>> @@ -626,33 +677,35 @@ static void verify_event(int p, int group, struct fanotify_event_metadata *event
>>  			(unsigned long long) event->mask,
>>  			(unsigned long long) expected_mask,
>>  			(unsigned int)event->pid, event->fd);
>> +		return 0;
>>  	} else if (event->pid != child_pid) {
>>  		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
>>  			"(expected %u) fd=%u", group, fanotify_class[p],
>>  			(unsigned long long)event->mask, (unsigned int)event->pid,
>>  			(unsigned int)child_pid, event->fd);
>> -	} else {
>> -		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
>> -			group, fanotify_class[p], (unsigned long long)event->mask,
>> -			(unsigned int)event->pid, event->fd);
>> +		return 0;
>>  	}
>> +	return 1;
>>  }
>>  
>> -static int generate_event(const char *event_path,
>> -			  unsigned long long expected_mask)
>> +static int generate_event(struct tcase *tc, unsigned long long expected_mask)
>>  {
>>  	int fd, status;
>>  
>>  	child_pid = SAFE_FORK();
>>  
>>  	if (child_pid == 0) {
>> -		if (expected_mask & FAN_OPEN_EXEC) {
>> -			SAFE_EXECL(event_path, event_path, NULL);
>> -		} else {
>> -			fd = SAFE_OPEN(event_path, O_RDONLY);
>> +		char path[PATH_MAX];
>> +
>> +		foreach_path(tc, path, event_path) {
>> +			if (expected_mask & FAN_OPEN_EXEC) {
>> +				SAFE_EXECL(path, path, NULL);
>> +			} else {
>> +				fd = SAFE_OPEN(path, O_RDONLY);
>>  
>> -			if (fd > 0)
>> -				SAFE_CLOSE(fd);
>> +				if (fd > 0)
>> +					SAFE_CLOSE(fd);
>> +			}
>>  		}
>>  
>>  		exit(0);
>> @@ -665,6 +718,37 @@ static int generate_event(const char *event_path,
>>  	return 0;
>>  }
>>  
>> +struct fanotify_event_metadata *fetch_event(int fd, int *retp)
>> +{
>> +	int ret;
>> +	struct fanotify_event_metadata *event;
>> +
>> +	*retp = 0;
>> +	if (event_buf_pos >= event_buf_len) {
>> +		event_buf_pos = 0;
>> +		ret = read(fd, event_buf, EVENT_BUF_LEN);
>> +		if (ret < 0) {
>> +			if (errno == EAGAIN)
>> +				return NULL;
>> +			tst_brk(TBROK | TERRNO, "reading fanotify events failed");
>> +			*retp = -1;
>
> If you call tst_brk(TBROK ...) the test exists since that is supposed to
> signal unrecoverable error. There is no need to propagate the retp from
> this function.

Yes although it's confusing for static analysis becuase tst_brk can
return in cleanup code. Also this function needs to be static. So I'll
do this before merge.

Will merge with gnu99 patch, after CI completes, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
