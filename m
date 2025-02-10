Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3DDC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93F853C98E3
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:59:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01C8C3C8136
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:59:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5483E141035E
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:59:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D5F421179;
 Mon, 10 Feb 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB7D13A62;
 Mon, 10 Feb 2025 15:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UcwWImkiqmdDQgAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 15:59:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 00D43A095C; Mon, 10 Feb 2025 16:59:36 +0100 (CET)
Date: Mon, 10 Feb 2025 16:59:36 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <rlvrkcwm6eefphbti2v5ooc4e3u62whbp7pk7iel3v2assov2x@g5dbtstfhgl4>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210151316.246079-5-amir73il@gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9D5F421179
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] fanotify24: Test open for write of executable
 files with pre-content watch
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

On Mon 10-02-25 16:13:16, Amir Goldstein wrote:
> Watching pre-content events should allow opening an executable file for
> write and executing a file that is open for write.
> 
> We have an existing test where the exectable file is not watched by
> pre-content events.
> 
> We add a new test case, where the executable file is watched for
> FAN_PRE_ACCESS pre-content event and access is allowed.
> 
> In the former case (not watched), execution should fail with ETXTBSY and
> in the latter case (per-content watched) execution should succeed.
> 
> When allowing access events, we allow for multiple events, because
> read() may generate more than a single access event.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify24.c     | 43 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index a7aa2e052..537773d52 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -144,6 +144,15 @@ static struct tcase {
>  		{
>  		}
>  	},
> +	{
> +		"inode mark, FAN_PRE_ACCESS event allowed",
> +		INIT_FANOTIFY_MARK_TYPE(INODE),
> +		FAN_PRE_ACCESS, 1,
> +		{
> +			/* This allows multiple FAN_PRE_ACCESS events */
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
> +		}
> +	},
>  };
>  
>  static int expected_errno(unsigned int response)
> @@ -206,6 +215,21 @@ static void generate_events(struct tcase *tc)
>  	exp_errno = expected_errno(event->response);
>  	event++;
>  
> +	/*
> +	 * If execve() is allowed by permission events, check if executing a
> +	 * file that open for write is allowed.
> +	 * HSM needs to be able to write to file during pre-content event, so it
> +	 * requires that a file being executed can be open for write, which also
> +	 * means that a file open for write can be executed.
> +	 * Therefore, ETXTBSY is to be expected when file is not being watched
> +	 * at all or being watched but not with pre-content events in mask.
> +	 */
> +	if (!exp_errno) {
> +		fd = SAFE_OPEN(FILE_EXEC_PATH, O_RDWR);
> +		if (!tc->event_count)
> +			exp_errno = ETXTBSY;
> +	}
> +
>  	exp_ret = exp_errno ? -1 : 0;
>  	errno = 0;
>  	if (execve(FILE_EXEC_PATH, argv, environ) != exp_ret || errno != exp_errno) {
> @@ -214,6 +238,9 @@ static void generate_events(struct tcase *tc)
>  	} else if (errno == exp_errno) {
>  		tst_res(TINFO, "execve() got errno %d as expected", errno);
>  	}
> +
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
>  }
>  
>  static void child_handler(int tmp)
> @@ -309,8 +336,8 @@ static void test_fanotify(unsigned int n)
>  	/*
>  	 * Process events
>  	 *
> -	 * tc->count + 1 is to accommodate for checking the child process
> -	 * return value
> +	 * tc->count + 1 is to let read() wait for child process to exit
> +	 * and to accomodate for extra access events
>  	 */
>  	while (test_num < tc->event_count + 1 && fd_notify != -1) {
>  		struct fanotify_event_metadata *event;
> @@ -319,6 +346,7 @@ static void test_fanotify(unsigned int n)
>  			/* Get more events */
>  			ret = read(fd_notify, event_buf + len,
>  				   EVENT_BUF_LEN - len);
> +			/* Received SIGCHLD */
>  			if (fd_notify == -1)
>  				break;
>  			if (ret < 0) {
> @@ -329,6 +357,17 @@ static void test_fanotify(unsigned int n)
>  			len += ret;
>  		}
>  
> +		/*
> +		 * If we got an event after the last event and the last event was
> +		 * allowed then assume this is another event of the same type.
> +		 * This is to accomodate for the fact that a single read() may
> +		 * generate an unknown number of access permission events if they
> +		 * are allowed.
> +		 */
> +		if (test_num > 0 && test_num == tc->event_count &&
> +		    event_set[test_num-1].response == FAN_ALLOW)
> +			test_num--;
> +
>  		event = (struct fanotify_event_metadata *)&event_buf[i];
>  		/* Permission events cannot be merged, so the event mask
>  		 * reported should exactly match the event mask within the
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
