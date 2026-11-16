Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC0606FE9D
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iAGxie/a;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Tbepe48a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iAGxie/a;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Tbepe48a
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BB2F3E9520
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:18:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AAFF3C70D9
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 12:18:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB10D660DC9
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 12:18:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D0D5222A6;
 Mon, 16 Nov 2026 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794827901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSVFafJET3PVrSyd5yvOX3p/KXQd7m5D0Nk32lg9NZY=;
 b=iAGxie/aHkD13Fac0Hu7hQrbvKQDyTKOWCgdzx5nuBhj0KHi3mCCQ99tLBK0LXVT6b4fY6
 EGfDryXfZAqYB18aU9gbJ2YGUE9D070tHkNdmsJAq2WoUcskoWmnq2Uwrp2prRYiRtEn/a
 2f6jFHDjCWNmCW0zWt7P9CYQdr/zc28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794827901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSVFafJET3PVrSyd5yvOX3p/KXQd7m5D0Nk32lg9NZY=;
 b=Tbepe48aaKqeR6KFpb9FhWkBuE7kBvxbqZo/88YWME/0y0dZV0hMNCtiOp+1a4lhAXUmxX
 AvAFupQPidWDTrBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794827901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSVFafJET3PVrSyd5yvOX3p/KXQd7m5D0Nk32lg9NZY=;
 b=iAGxie/aHkD13Fac0Hu7hQrbvKQDyTKOWCgdzx5nuBhj0KHi3mCCQ99tLBK0LXVT6b4fY6
 EGfDryXfZAqYB18aU9gbJ2YGUE9D070tHkNdmsJAq2WoUcskoWmnq2Uwrp2prRYiRtEn/a
 2f6jFHDjCWNmCW0zWt7P9CYQdr/zc28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794827901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSVFafJET3PVrSyd5yvOX3p/KXQd7m5D0Nk32lg9NZY=;
 b=Tbepe48aaKqeR6KFpb9FhWkBuE7kBvxbqZo/88YWME/0y0dZV0hMNCtiOp+1a4lhAXUmxX
 AvAFupQPidWDTrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EBEC13408;
 Mon, 16 Nov 2026 11:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WDgwN3zm+mpXHAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 11:18:21 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
 id 95C8F24DB9; Mon, 16 Nov 2026 12:18:20 +0100 (CET)
Date: Mon, 16 Nov 2026 12:18:20 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <ht2wqzjfehy3erx4kuxh6p7gfrs2d2qjnzzqtil2btyu3sf442@mrwo7jhpwlx7>
References: <20261113175119.455908-1-amir73il@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261113175119.455908-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify27: Test FAN_DELETE_SELF on unlinked
 hardlinked open file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 13-11-26 18:51:18, Amir Goldstein wrote:
> Verify that FAN_DELETE_SELF is reported only once, after the last alias
> of an unlinked inode is gone.
> 
> Open a file via one hardlink, unlink that link and then unlink the other
> link.  The unlink of the last link drops the last reference of its dentry
> while the inode is still open via the first link.
> 
> Before the kernel fix, that unlink reported FAN_DELETE_SELF and removed
> the inode marks of the still open inode.  Closing the file then reported
> a second FAN_DELETE_SELF event.
> 
> The hardlink reproducer was provided by Daehyeon Ko and the double
> FAN_DELETE_SELF event was pointed out by Jan Kara.
> 
> Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/20260828042421.964822-1-4ncienth@gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  .../kernel/syscalls/fanotify/fanotify27.c     | 161 ++++++++++++++++++
>  3 files changed, 163 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify27.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7b6a7d376..92507a7c7 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -705,6 +705,7 @@ fanotify23 fanotify23
>  fanotify24 fanotify24
>  fanotify25 fanotify25
>  fanotify26 fanotify26
> +fanotify27 fanotify27
>  
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index c13d9b33c..d0b0fed48 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -24,4 +24,5 @@
>  /fanotify24
>  /fanotify25
>  /fanotify26
> +/fanotify27
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify27.c b/testcases/kernel/syscalls/fanotify/fanotify27.c
> new file mode 100644
> index 000000000..50cf9f9ee
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify27.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 CTERA Networks.  All Rights Reserved.
> + */
> +
> +/*\
> + * Verify that FAN_DELETE_SELF is reported only once, after the last alias of
> + * an unlinked inode is gone, and that the inode marks are not removed while
> + * the unlinked inode is still open.
> + *
> + * Create two hardlinks to a file with an inode mark for FAN_MODIFY, open the
> + * file via one link and unlink both links, so the unlink of the last link
> + * drops the last dentry reference of that link while the inode is still open
> + * via the other link.  Then write to the open file and close it.
> + *
> + * Before the fix, the unlink of the last link reported FAN_DELETE_SELF and
> + * removed all the inode marks of the still open inode, so the write to the
> + * open file did not report FAN_MODIFY.  Closing the file then reported a
> + * second FAN_DELETE_SELF event.
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <errno.h>
> +#include <string.h>
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +#include "fanotify.h"
> +
> +#define MOUNT_PATH "mntpoint"
> +#define FILE_A MOUNT_PATH "/file_a"
> +#define FILE_B MOUNT_PATH "/file_b"
> +#define EVENT_BUF_LEN 4096
> +
> +#if defined(HAVE_NAME_TO_HANDLE_AT)
> +static int fanotify_fd = -1;
> +static int file_fd = -1;
> +static struct fanotify_fid_t victim_fid;
> +
> +static int event_matches_victim(struct fanotify_event_metadata *metadata)
> +{
> +	struct fanotify_event_info_fid *info;
> +	struct file_handle *handle;
> +
> +	info = get_event_info_fid(metadata);
> +	if (!info)
> +		return 0;
> +
> +	handle = (struct file_handle *)info->handle;
> +	if (handle->handle_type != victim_fid.handle.handle_type ||
> +	    handle->handle_bytes != victim_fid.handle.handle_bytes)
> +		return 0;
> +
> +	return !memcmp(handle->f_handle, victim_fid.handle.f_handle,
> +		       handle->handle_bytes);
> +}
> +
> +static void read_events(unsigned int *delete_self, unsigned int *modify)
> +{
> +	struct fanotify_event_metadata *metadata;
> +	char buf[EVENT_BUF_LEN];
> +	int len;
> +
> +	*delete_self = *modify = 0;
> +
> +	while ((len = read(fanotify_fd, buf, sizeof(buf))) > 0) {
> +		for (metadata = (struct fanotify_event_metadata *)buf;
> +		     FAN_EVENT_OK(metadata, len);
> +		     metadata = FAN_EVENT_NEXT(metadata, len)) {
> +			if (!event_matches_victim(metadata))
> +				continue;
> +			if (metadata->mask & FAN_DELETE_SELF)
> +				(*delete_self)++;
> +			if (metadata->mask & FAN_MODIFY)
> +				(*modify)++;
> +		}
> +	}
> +
> +	if (len < 0 && errno != EAGAIN)
> +		tst_brk(TBROK | TERRNO, "read(fanotify_fd) failed");
> +}
> +
> +static void setup(void)
> +{
> +	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_REPORT_FID,
> +		FAN_MARK_FILESYSTEM, FAN_DELETE_SELF, MOUNT_PATH);
> +
> +	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
> +					 FAN_NONBLOCK | FAN_CLOEXEC,
> +					 O_RDONLY | O_LARGEFILE);
> +	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +			   FAN_DELETE_SELF, AT_FDCWD, MOUNT_PATH);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (file_fd >= 0)
> +		SAFE_CLOSE(file_fd);
> +	if (fanotify_fd >= 0)
> +		SAFE_CLOSE(fanotify_fd);
> +}
> +
> +static void run(void)
> +{
> +	unsigned int delete_self, modify;
> +
> +	SAFE_TOUCH(FILE_A, 0600, NULL);
> +	memset(&victim_fid, 0, sizeof(victim_fid));
> +	fanotify_save_fid(FILE_A, &victim_fid);
> +	SAFE_LINK(FILE_A, FILE_B);
> +	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_MODIFY,
> +			   AT_FDCWD, FILE_A);
> +
> +	file_fd = SAFE_OPEN(FILE_B, O_WRONLY);
> +	SAFE_UNLINK(FILE_B);
> +	SAFE_UNLINK(FILE_A);
> +
> +	read_events(&delete_self, &modify);
> +	if (delete_self)
> +		tst_res(TFAIL, "Got FAN_DELETE_SELF while file is still open");
> +	else
> +		tst_res(TPASS, "No FAN_DELETE_SELF while file is still open");
> +
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, "x", 1);
> +	read_events(&delete_self, &modify);
> +	if (modify != 1)
> +		tst_res(TFAIL, "Got %u FAN_MODIFY events on unlinked open file, expected 1",
> +			modify);
> +	else
> +		tst_res(TPASS, "Inode mark still alive on unlinked open file");
> +
> +	SAFE_CLOSE(file_fd);
> +	read_events(&delete_self, &modify);
> +	if (delete_self != 1)
> +		tst_res(TFAIL, "Got %u FAN_DELETE_SELF events on last close, expected 1",
> +			delete_self);
> +	else
> +		tst_res(TPASS, "Got one FAN_DELETE_SELF event on last close");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MOUNT_PATH,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "669bb5af15d41a21359d00a441490f87a88eb52a"},
> +		{}
> +	}
> +};
> +
> +#else
> +	TST_TEST_TCONF("System does not have required name_to_handle_at() support");
> +#endif
> +#else
> +	TST_TEST_TCONF("System does not have required fanotify support");
> +#endif
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
