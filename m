Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A107F30928
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 09:36:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8F93D0E3B
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 10:36:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A8E83CB408
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 10:36:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19B2320007B
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 10:36:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D46C5BCCB;
 Thu,  5 Mar 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532C23EA68;
 Thu,  5 Mar 2026 09:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QxdHFIVOqWl6NQAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 09:36:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 04ED1A0AB1; Thu,  5 Mar 2026 10:36:04 +0100 (CET)
Date: Thu, 5 Mar 2026 10:36:04 +0100
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <vkxlr754g4xhqhypya7ybullssszqvduqvvisy4e5dzmxwupqr@2qobtjcvvjuy>
References: <20260304133810.24585-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304133810.24585-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5D46C5BCCB
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify22.c: handle multiple asynchronous
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
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 04-03-26 13:38:07, Wei Gao wrote:
> Since the introduction of the asynchronous fserror reporting framework
> (kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
> due to the non-deterministic nature of event delivery and merging:
> 
> 1) tcase3 failure: A race condition occurs when the test reads the
>    notification fd between two events. Adding a short delay
>    (usleep) ensures all events are dispatched and ready before the
>    read() call.

OK, but please add a comment in the code why this is needed.

> 2) tcase4 failure: The kernel may deliver errors as independent events
>    instead of a single merged event, The test logic is updated to
>    validate the expected error_count by either a single merged event
>    or the accumulation of multiple independent events in the buffer.

Did you investigate why the events didn't get merged in the kernel? If they
are against the same filesystem they should get merged AFAICS.

								Honza

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify22.c     | 32 ++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index 6578474a7..82eed7ba9 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -53,6 +53,8 @@ static struct fanotify_fid_t null_fid;
>  static struct fanotify_fid_t bad_file_fid;
>  static struct fanotify_fid_t bad_link_fid;
>  
> +static int event_count;
> +
>  static void trigger_fs_abort(void)
>  {
>  	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> @@ -88,7 +90,6 @@ static void trigger_bad_link_lookup(void)
>  			ret, BAD_LINK, errno, EUCLEAN);
>  }
>  
> -
>  static void tcase3_trigger(void)
>  {
>  	trigger_bad_link_lookup();
> @@ -176,9 +177,10 @@ static int check_error_event_info_error(struct fanotify_event_info_error *info_e
>  {
>  	int fail = 0;
>  
> -	if (info_error->error_count != ex->error_count) {
> -		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
> -			ex->name, info_error->error_count, ex->error_count);
> +	if (info_error->error_count != ex->error_count && event_count != ex->error_count) {
> +		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d && %d!=%d)",
> +			ex->name, info_error->error_count, ex->error_count,
> +			event_count, ex->error_count);
>  		fail++;
>  	}
>  
> @@ -255,8 +257,30 @@ static void do_test(unsigned int i)
>  
>  	tcase->trigger_error();
>  
> +	usleep(100000);
> +

OK, but can you please add a comment why the sleep is here.

>  	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
>  
> +	struct fanotify_event_metadata *metadata;
> +	size_t len = read_len;
> +
> +	event_count = 0;
> +
> +	for (metadata = (struct fanotify_event_metadata *)event_buf;
> +			FAN_EVENT_OK(metadata, len);
> +			metadata = FAN_EVENT_NEXT(metadata, len)) {
> +		event_count++;
> +		struct fanotify_event_info_error *info_error = get_event_info_error(metadata);
> +
> +		if (info_error) {
> +			tst_res(TINFO, "Event [%d]: errno=%d (expected %d), error_count=%d (expected total %d)",
> +					event_count, info_error->error, tcase->error,
> +					info_error->error_count, tcase->error_count);
> +		} else {
> +			tst_res(TINFO, "Event [%d]: No error info record found", event_count);
> +		}
> +	}
> +

This looks too lax to me. I think

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
