Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44ECEFCD9B
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 11:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55F933DD46D
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 12:30:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 936B33C4EC6
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 12:29:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 26F0010007DC
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 12:29:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 992575BDC7;
 Mon,  9 Mar 2026 11:29:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906F83EE92;
 Mon,  9 Mar 2026 11:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E6I7IyivrmmtfAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 11:29:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 32CD5A09A4; Mon,  9 Mar 2026 12:29:36 +0100 (CET)
Date: Mon, 9 Mar 2026 12:29:36 +0100
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <k7qmbhtdldeaikatdnr3y4zzbmguf6sz6t656zl4ohfwwab462@6g5l2uu7ewn7>
References: <20260304133810.24585-1-wegao@suse.com>
 <20260309075946.28119-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309075946.28119-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 992575BDC7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 09-03-26 07:59:42, Wei Gao wrote:
> Since the introduction of the asynchronous fserror reporting framework
> (kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
> due to the non-deterministic nature of event delivery and merging:
> 
> 1) tcase3 failure: A race condition occurs when the test reads the
>    notification fd between two events. Adding a short delay
>    (usleep) ensures all events are dispatched and ready before the
>    read() call.
> 
> 2) tcase4 failure: The kernel may deliver errors as independent events
>    instead of a single merged event, since different worker kthread can
>    end up generating each event so they won't be merged. As suggested by
>    Jan Kara, this patch introduces a consolidate_events() helper. It iterates
>    through the event buffer, accumulates the error_count from all independent
>    events, and updates the first event's count in-place.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
...
> +static size_t consolidate_events(char *buf, size_t len)
> +{
> +	struct fanotify_event_metadata *metadata, *first = NULL;
> +	struct fanotify_event_info_error *first_info = NULL;
> +	unsigned int total_count = 0;
> +	int event_num = 0;
> +
> +	for (metadata = (struct fanotify_event_metadata *)buf;
> +			FAN_EVENT_OK(metadata, len);
> +			metadata = FAN_EVENT_NEXT(metadata, len)) {
> +
> +		event_num++;
> +		struct fanotify_event_info_error *info = get_event_info_error(metadata);
> +
> +		if (info) {
> +			if (!first) {
> +				first = metadata;
> +				first_info = info;
> +			}
> +			total_count += info->error_count;

Please verify the 'error' field in the info matches before merging the
count and fail the test if it does not. Also if we get event without error
info I think we should fail the test as it currently shouldn't happen for
any of the tests.

								Honza

> +
> +			tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
> +					event_num, info->error, info->error_count);
> +		}
> +	}
> +
> +	if (first_info)
> +		first_info->error_count = total_count;
> +
> +	return (first) ? first->event_len : 0;
> +}
> +
>  static int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
>  				 const struct test_case *ex)
>  {
> @@ -255,7 +286,11 @@ static void do_test(unsigned int i)
>  
>  	tcase->trigger_error();
>  
> +	/* Wait for asynchronous kworker threads to dispatch events */
> +	usleep(100000);
> +
>  	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
> +	read_len = consolidate_events(event_buf, read_len);
>  
>  	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
>  			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
