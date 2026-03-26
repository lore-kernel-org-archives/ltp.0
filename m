Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12BD106F307
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 08:57:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19763E2ABE
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 09:57:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7E63E2ABC
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:57:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37A192009E3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:57:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 061634D1D6;
 Thu, 26 Mar 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E356E4A0A3;
 Thu, 26 Mar 2026 08:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ldN5N+f0xGlZFwAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 08:57:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A5695A0976; Thu, 26 Mar 2026 09:57:07 +0100 (CET)
Date: Thu, 26 Mar 2026 09:57:07 +0100
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <gpqxnb2jbilwnmpvx5nev4nuanb6mvg3m4cau4hyfywvr5mrcd@pdtgkf4imrbw>
References: <20260325124428.6497-1-wegao@suse.com>
 <20260326012908.6885-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260326012908.6885-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 061634D1D6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] fanotify22.c: handle multiple asynchronous
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

On Thu 26-03-26 01:28:58, Wei Gao wrote:
> Since the introduction of the asynchronous fserror reporting framework
> (kernel commit 81d2e13a57c9), fanotify22 has encountered sporadic failures
> due to the non-deterministic nature of event delivery and merging:
> 
> 1) tcase3 failure: A race condition occurs when the test reads the
>    notification fd between two events. uses a poll() and read() loop to wait
>    until the expected.
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v4->v5:
> Added a continue after an unexpected errno2 is detected
> 
>  .../kernel/syscalls/fanotify/fanotify22.c     | 87 ++++++++++++++++++-
>  1 file changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index e8002b160..2e5e6a3fa 100644
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
> @@ -134,10 +135,53 @@ static struct test_case {
>  		.trigger_error = &tcase4_trigger,
>  		.error_count = 2,
>  		.error = EFSCORRUPTED,
> +		.error2 = ESHUTDOWN,
>  		.fid = &bad_file_fid,
>  	}
>  };
>  
> +static size_t consolidate_events(char *buf, size_t len, const struct test_case *ex)
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
> +		if (!info) {
> +			tst_res(TFAIL, "%s: Event [%d] missing error info",
> +					ex->name, event_num);
> +			continue;
> +		}
> +
> +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> +			tst_res(TFAIL, "%s: Event [%d] unexpected errno (%d)",
> +					ex->name, event_num, info->error);
> +			continue;
> +		}
> +
> +		if (!first) {
> +			first = metadata;
> +			first_info = info;
> +		}
> +		total_count += info->error_count;
> +
> +		tst_res(TINFO, "Event [%d]: errno=%d, error_count=%d",
> +				event_num, info->error, info->error_count);
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
> @@ -248,19 +292,54 @@ static void check_event(char *buf, size_t len, const struct test_case *ex)
>  static void do_test(unsigned int i)
>  {
>  	const struct test_case *tcase = &testcases[i];
> -	size_t read_len;
> +	size_t read_len = 0;
> +	struct pollfd pfd;
> +	unsigned int accumulated_count = 0;
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
> +			tst_res(TFAIL, "%s: Timeout waiting for events", tcase->name);
> +			goto out;
> +		}
> +
> +		char *current_pos = event_buf + read_len;
> +		int ret = read(fd_notify, current_pos, BUF_SIZE - read_len);
> +
> +		if (ret < 0) {
> +			tst_res(TFAIL, "%s: read failed: %s", tcase->name, strerror(errno));
> +			goto out;
> +		}
> +
> +		struct fanotify_event_metadata *m =
> +			(struct fanotify_event_metadata *)current_pos;
> +		while (FAN_EVENT_OK(m, ret)) {
> +			struct fanotify_event_info_error *e = get_event_info_error(m);
> +
> +			if (e)
> +				accumulated_count += e->error_count;
> +
> +			read_len += m->event_len;
> +			m = FAN_EVENT_NEXT(m, ret);
> +		}
> +	}
> +
> +	read_len = consolidate_events(event_buf, read_len, tcase);
> +
> +	check_event(event_buf, read_len, tcase);
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
