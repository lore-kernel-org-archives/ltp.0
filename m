Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D3AC36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 15:08:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BEB33C06A7
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 16:08:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F05B3C0565
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 16:08:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8CDE820004D
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 16:08:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09D9821188;
 Wed, 26 Mar 2025 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743001700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZQi4UECReVkJ08ViEGZRMbMODWzbBFJecck0hF8Rsw=;
 b=XOB4TNUIw7jObpUMU2GoUziqhkF/fDj4WLzV3t2WM6ED+LzmPZRLUcgkU7LxHkuFlqNeRQ
 M/77qj1AEkqTr0ICwyFVebub00t84UUysAo/jicKxPrlXG+Q7lE3KZ3T79/d44Nmxb7WnZ
 veowcAdWm9Ex3USdkSCVIBJ48wfU2v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743001700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZQi4UECReVkJ08ViEGZRMbMODWzbBFJecck0hF8Rsw=;
 b=yYF/2RdSdpv0ABbz4Lj9162yXuuYWJycYZGDduIaHZpr5FtGM5u6iYLvr0IeVjaDHKtUUG
 gUlOdFvy/ZqqULAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XOB4TNUI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="yYF/2RdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743001700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZQi4UECReVkJ08ViEGZRMbMODWzbBFJecck0hF8Rsw=;
 b=XOB4TNUIw7jObpUMU2GoUziqhkF/fDj4WLzV3t2WM6ED+LzmPZRLUcgkU7LxHkuFlqNeRQ
 M/77qj1AEkqTr0ICwyFVebub00t84UUysAo/jicKxPrlXG+Q7lE3KZ3T79/d44Nmxb7WnZ
 veowcAdWm9Ex3USdkSCVIBJ48wfU2v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743001700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZQi4UECReVkJ08ViEGZRMbMODWzbBFJecck0hF8Rsw=;
 b=yYF/2RdSdpv0ABbz4Lj9162yXuuYWJycYZGDduIaHZpr5FtGM5u6iYLvr0IeVjaDHKtUUG
 gUlOdFvy/ZqqULAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1E4513927;
 Wed, 26 Mar 2025 15:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1cALO2MY5GeWVQAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 26 Mar 2025 15:08:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 91E31A082A; Wed, 26 Mar 2025 16:08:19 +0100 (CET)
Date: Wed, 26 Mar 2025 16:08:19 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <xihzsgfa7ahifbmlgm6tknqhphp6k2aqxhlnrehna4uij7vx7k@piyczbmai6wd>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319192742.999506-4-amir73il@gmail.com>
X-Rspamd-Queue-Id: 09D9821188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_COUNT_THREE(0.00)[3]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify24: add mmap() and user page fault to
 test
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

On Wed 19-03-25 20:27:42, Amir Goldstein wrote:
> Commit 066e053fe208a ("fsnotify: add pre-content hooks on mmap()")
> in 6.14-rc7 added a pre-content hooh in mmap() before the final release
> of the fsnotify pre-content event feature.
> 
> To test pre-content hook on mmap(), increase the size of the test file
> to 101 pages use mmap() to setup a buffer from the end of the test file.
> 
> Change some of the test cases to allow the write() and use this buffer
> as the input buffer to write(), which tests deadlock avoidance by
> suppresing pre-content hook on user page faults.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify24.c     | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index 2d2479b39..3a76f2c1b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -46,6 +46,7 @@
>  static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static volatile int fd_notify;
> +static size_t page_sz;
>  
>  static pid_t child_pid;
>  
> @@ -68,7 +69,8 @@ static struct tcase {
>  		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_DENY},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
>  		}
> @@ -78,6 +80,7 @@ static struct tcase {
>  		INIT_FANOTIFY_MARK_TYPE(INODE),
>  		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
> @@ -89,7 +92,8 @@ static struct tcase {
>  		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_DENY},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
>  		}
> @@ -99,6 +103,7 @@ static struct tcase {
>  		INIT_FANOTIFY_MARK_TYPE(MOUNT),
>  		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
> @@ -110,7 +115,8 @@ static struct tcase {
>  		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_DENY},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
>  		}
> @@ -120,6 +126,7 @@ static struct tcase {
>  		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
>  		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
>  		{
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
>  			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
> @@ -130,6 +137,7 @@ static struct tcase {
>  		INIT_FANOTIFY_MARK_TYPE(PARENT),
>  		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD,
>  		{
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_PRE_ACCESS, FAN_DENY},
>  			{FAN_OPEN_EXEC_PERM, FAN_DENY}
> @@ -169,6 +177,7 @@ static int expected_errno(unsigned int response)
>  static void generate_events(struct tcase *tc)
>  {
>  	int fd;
> +	char *addr;
>  	char *const argv[] = {FILE_EXEC_PATH, NULL};
>  	struct event *event = tc->event_set;
>  	int exp_ret, exp_errno = 0;
> @@ -186,8 +195,25 @@ static void generate_events(struct tcase *tc)
>  
>  	exp_ret = exp_errno ? -1 : 1;
>  	errno = 0;
> -	/* FAN_PRE_ACCESS events are reported also on write */
> -	if (write(fd, fname, 1) != exp_ret || errno != exp_errno) {
> +	/*
> +	 * FAN_PRE_ACCESS events are reported on map() and write(), but should
> +	 * not be reported when faulting in the user page at offset page_sz*100
> +	 * that is used as an input buffer to the write() syscall.
> +	 */
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
> +	if (!addr || errno != exp_errno) {
> +		tst_res(TFAIL, "mmap() got errno %d (expected %d)", errno, exp_errno);
> +		exit(3);
> +	} else if (errno == exp_errno) {
> +		tst_res(TINFO, "mmap() got errno %d as expected", errno);
> +	}
> +
> +	exp_errno = expected_errno(event->response);
> +	event++;
> +
> +	exp_ret = exp_errno ? -1 : 1;
> +	errno = 0;
> +	if (write(fd, addr, 1) != exp_ret || errno != exp_errno) {
>  		tst_res(TFAIL, "write() got errno %d (expected %d)", errno, exp_errno);
>  		exit(3);
>  	} else if (errno == exp_errno) {
> @@ -199,7 +225,7 @@ static void generate_events(struct tcase *tc)
>  	exp_errno = expected_errno(event->response);
>  	event++;
>  
> -	exp_ret = exp_errno ? -1 : 1;
> +	exp_ret = exp_errno ? -1 : BUF_SIZE;
>  	errno = 0;
>  	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
>  		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
> @@ -449,8 +475,11 @@ static void test_fanotify(unsigned int n)
>  
>  static void setup(void)
>  {
> +	page_sz = getpagesize();
> +
>  	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
> +	SAFE_TRUNCATE(fname, page_sz*101);
>  
>  	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_PRE_CONTENT, FAN_MARK_FILESYSTEM,
>  						FAN_PRE_ACCESS, fname);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
