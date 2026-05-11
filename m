Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDCECD37AC
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 11:31:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BBAD3CB6BF
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 13:31:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 553CA3C94A0
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:30:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E58B214002D7
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:30:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2513061902;
 Mon, 11 May 2026 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778499057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJc6O0hI2kaJDeWXjMFNVxxmJOga27fJGm783MFh7c8=;
 b=cacETrShei3IZwTDtGFHM3GTUJAbOk8X/DmIMGf2YXGEwG2rRx1/IOORFPo0vbcOmqFgaS
 mytdkVNnfO+lcxbZ9KiUP2qT5gfSe1Sndq9UEEPVgDlsCBHwlf/8Rk7umfBLPTaIMmp6Do
 ylI/sBnRV2FwyjCDyLfaMzvHBKf8lNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778499057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJc6O0hI2kaJDeWXjMFNVxxmJOga27fJGm783MFh7c8=;
 b=wXicU7aC3fy3roxP0tWoSpK0ZuGE0/uCmEjugnrIoUAH7UGFESIUWGwkF8L+qty6cXEi5Y
 +NgrH2T++Uw6vkBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778499057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJc6O0hI2kaJDeWXjMFNVxxmJOga27fJGm783MFh7c8=;
 b=cacETrShei3IZwTDtGFHM3GTUJAbOk8X/DmIMGf2YXGEwG2rRx1/IOORFPo0vbcOmqFgaS
 mytdkVNnfO+lcxbZ9KiUP2qT5gfSe1Sndq9UEEPVgDlsCBHwlf/8Rk7umfBLPTaIMmp6Do
 ylI/sBnRV2FwyjCDyLfaMzvHBKf8lNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778499057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJc6O0hI2kaJDeWXjMFNVxxmJOga27fJGm783MFh7c8=;
 b=wXicU7aC3fy3roxP0tWoSpK0ZuGE0/uCmEjugnrIoUAH7UGFESIUWGwkF8L+qty6cXEi5Y
 +NgrH2T++Uw6vkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18946593A3;
 Mon, 11 May 2026 11:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Hr5BfG9AWp5LQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 11 May 2026 11:30:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id AD9F2A079E; Mon, 11 May 2026 13:30:52 +0200 (CEST)
Date: Mon, 11 May 2026 13:30:52 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <dllhd4i2z3jzj7eexflii5iu44dvlteh53tdwtnmcrlqru3il5@zimp5y7yyiys>
References: <20260331111857.10995-1-wegao@suse.com>
 <20260507025345.6722-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507025345.6722-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email, intel.com:email, pfd.events:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] fanotify22.c: handle multiple asynchronous
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

On Thu 07-05-26 02:53:33, Wei Gao wrote:
> Since the introduction of the asynchronous fserror reporting framework
> (kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
> due to the non-deterministic nature of event delivery and merging:
> 
> 1) tcase3 failure: A race condition occurs when the test reads the
>    notification fd between two events. Use a poll() and read() loop to wait
>    until the expected events are delivered.
> 
> 2) tcase4 failure: The kernel may deliver errors as independent events
>    instead of a single merged event, as different worker kthreads can
>    end up generating each event. As suggested by Jan Kara, this patch
>    introduces a consolidate_events() helper. It iterates through the
>    event buffer, identifies the primary event matching the expected error,
>    accumulates the error_count from all independent events, and updates
>    the primary event's count in-place for validation.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v7->v8:
> - Fix a logic bug where the test would fail if a secondary error (like ESHUTDOWN) was the first event in the buffer
> - Move variable declarations to the top of blocks to follow the preferred LTP coding style
>  .../kernel/syscalls/fanotify/fanotify22.c     | 119 +++++++++++++++---
>  1 file changed, 102 insertions(+), 17 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index e8002b160..c124e1904 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -28,6 +28,7 @@
>  #include "tst_test.h"
>  #include <sys/fanotify.h>
>  #include <sys/types.h>
> +#include <poll.h>
>  
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
> @@ -88,7 +89,6 @@ static void trigger_bad_link_lookup(void)
>  			ret, BAD_LINK, errno, EUCLEAN);
>  }
>  
> -
>  static void tcase3_trigger(void)
>  {
>  	trigger_bad_link_lookup();
> @@ -104,6 +104,7 @@ static void tcase4_trigger(void)
>  static struct test_case {
>  	char *name;
>  	int error;
> +	int error2;
>  	unsigned int error_count;
>  	struct fanotify_fid_t *fid;
>  	void (*trigger_error)(void);
> @@ -134,37 +135,79 @@ static struct test_case {
>  		.trigger_error = &tcase4_trigger,
>  		.error_count = 2,
>  		.error = EFSCORRUPTED,
> +		.error2 = ESHUTDOWN,
>  		.fid = &bad_file_fid,
>  	}
>  };
>  
> +static struct fanotify_event_metadata *consolidate_events(char *buf, size_t len, const struct test_case *ex)
> +{
> +	struct fanotify_event_metadata *metadata, *primary = NULL;
> +	struct fanotify_event_info_error *info, *primary_info = NULL;
> +	unsigned int total_count = 0;
> +	int event_num = 0;
> +
> +	for (metadata = (struct fanotify_event_metadata *)buf;
> +			FAN_EVENT_OK(metadata, len);
> +			metadata = FAN_EVENT_NEXT(metadata, len)) {
> +
> +		event_num++;
> +		info = get_event_info_error(metadata);
> +
> +		if (!info) {
> +			tst_res(TFAIL, "Event [%d] missing error info", event_num);
> +			continue;
> +		}
> +
> +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> +			tst_res(TFAIL, "Event [%d] unexpected errno (%d)",
> +					event_num, info->error);
> +			continue;
> +		}
> +
> +		if (!primary && info->error == ex->error) {
> +			primary = metadata;
> +			primary_info = info;
> +		}
> +		total_count += info->error_count;
> +
> +		tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
> +				event_num, info->error, info->error_count);
> +	}
> +
> +	if (primary_info)
> +		primary_info->error_count = total_count;
> +
> +	return primary;
> +}
> +
>  static int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
>  				 const struct test_case *ex)
>  {
>  	struct file_handle *fh = (struct file_handle *) &fid->handle;
>  
>  	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> -		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> -			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +		tst_res(TFAIL, "Received bad FSID type (%x...!=%x...)",
> +			FSID_VAL_MEMBER(fid->fsid, 0),
>  			ex->fid->fsid.val[0]);
>  
>  		return 1;
>  	}
>  	if (fh->handle_type != ex->fid->handle.handle_type) {
> -		tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
> -			ex->name, fh->handle_type, ex->fid->handle.handle_type);
> +		tst_res(TFAIL, "Received bad file_handle type (%d!=%d)",
> +			fh->handle_type, ex->fid->handle.handle_type);
>  		return 1;
>  	}
>  
>  	if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
> -		tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
> -			ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
> +		tst_res(TFAIL, "Received bad file_handle len (%d!=%d)",
> +			fh->handle_bytes, ex->fid->handle.handle_bytes);
>  		return 1;
>  	}
>  
>  	if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
> -		tst_res(TFAIL, "%s: Received wrong handle. "
> -			"Expected (%x...) got (%x...) ", ex->name,
> +		tst_res(TFAIL, "Received wrong handle. "
> +			"Expected (%x...) got (%x...) ",
>  			*(int *)ex->fid->handle.f_handle, *(int *)fh->f_handle);
>  		return 1;
>  	}
> @@ -177,14 +220,15 @@ static int check_error_event_info_error(struct fanotify_event_info_error *info_e
>  	int fail = 0;
>  
>  	if (info_error->error_count != ex->error_count) {
> -		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
> -			ex->name, info_error->error_count, ex->error_count);
> +		tst_res(TFAIL, "Unexpected error_count (%d!=%d)",
> +			info_error->error_count, ex->error_count);
>  		fail++;
>  	}
>  
> -	if (info_error->error != ex->error) {
> -		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
> -			ex->name, info_error->error, ex->error);
> +	if (info_error->error != ex->error &&
> +	    (ex->error2 == 0 || info_error->error != ex->error2)) {
> +		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
> +			info_error->error, ex->error);
>  		fail++;
>  	}
>  
> @@ -248,19 +292,60 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
>  static void do_test(unsigned int i)
>  {
>  	const struct test_case *tcase = &testcases[i];
> -	size_t read_len;
> +	struct fanotify_event_metadata *m, *primary;
> +	struct fanotify_event_info_error *e;
> +	char *current_pos;
> +	ssize_t ret;
> +	size_t read_len = 0;
> +	struct pollfd pfd;
> +	unsigned int accumulated_count = 0;
> +
> +	tst_res(TINFO, "Test case: %s", tcase->name);
>  
>  	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
>  			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
>  
>  	tcase->trigger_error();
>  
> -	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
> +	pfd.fd = fd_notify;
> +	pfd.events = POLLIN;
> +
> +	while (accumulated_count < tcase->error_count) {
> +		if (poll(&pfd, 1, 5000) <= 0) {
> +			tst_res(TFAIL, "Timeout waiting for events");
> +			goto out;
> +		}
> +
> +		if (BUF_SIZE - read_len < FAN_EVENT_METADATA_LEN)
> +			tst_brk(TBROK, "Insufficient buffer space for next event");
> +
> +		current_pos = event_buf + read_len;
> +		ret = SAFE_READ(0, fd_notify, current_pos, BUF_SIZE - read_len);
> +
> +		m = (struct fanotify_event_metadata *)current_pos;
> +		while (FAN_EVENT_OK(m, ret)) {
> +			e = get_event_info_error(m);
> +
> +			if (e)
> +				accumulated_count += e->error_count;
> +
> +			read_len += m->event_len;
> +			m = FAN_EVENT_NEXT(m, ret);
> +		}
> +	}
> +
> +	primary = consolidate_events(event_buf, read_len, tcase);
> +
> +	if (primary)
> +		check_event((char *)primary, primary->event_len, tcase);
> +	else
> +		tst_res(TFAIL, "No primary error event found");
> +
> +out:
>  
>  	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE|FAN_MARK_FILESYSTEM,
>  			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
>  
> -	check_event(event_buf, read_len, tcase);
>  	/* Unmount and mount the filesystem to get it out of the error state */
>  	SAFE_UMOUNT(MOUNT_PATH);
>  	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
