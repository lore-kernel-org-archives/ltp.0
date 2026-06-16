Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA2CD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65A893E5971
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:46:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 463D83E2238
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:46:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6B8B1000A10
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:46:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F23D66C801;
 Tue, 16 Jun 2026 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781595975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hnyG58t1xInJLG9gz9Z/JBh2YqFgovzbYEYQT0lg=;
 b=sZGogLa6U3OoWzMq/vPWqbkKkm7oBSpQLu/s4hbQrR+O5sxkJieJyaJZQqaCQ07lyv7Qel
 mkrzzfa0lL1HoKeFt2IzfWt09myAyTlZM+2qC2LGhMbc8By/45qX8xFYPurw2gJjYTjtCH
 2hsOokt3NMVS98uyMvP+XWCliOiPfSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781595975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hnyG58t1xInJLG9gz9Z/JBh2YqFgovzbYEYQT0lg=;
 b=sxRaMZWX7RSYidx9OCjc/tLtIHuoILVMGnGgLe6A5SDzwkWyvN5wjUxztVihpl5dCkar3z
 uM2shmme/Mxw8jBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/+EvaqF";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TGvNHLpd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781595974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hnyG58t1xInJLG9gz9Z/JBh2YqFgovzbYEYQT0lg=;
 b=f/+EvaqFEtN0yRhPRwvtZKBewfAhM/efMQ3gn+E5hjDpGCYAS5oPwIFeFSXIge6Fbd33QP
 iI18jIMxjOWocke5snTU6HfON9pqn1rNCtEJVTiMrfC7cUdX3BGygm5O4JHMiPUSIlXktV
 v2qQgQHlonTnxFSXqAUv94PAI/i/8rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781595974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JK5hnyG58t1xInJLG9gz9Z/JBh2YqFgovzbYEYQT0lg=;
 b=TGvNHLpdeq4Bwa+9+Nm2j1i6ZG0TFSjVM1p8ah39LKrFd4KAAduvgXbvOqGfzefnXgneer
 gpGz16FZO7Zpl1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC217779A8;
 Tue, 16 Jun 2026 07:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LzW8NUX/MGpNTgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 07:46:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 8A59BA12D3; Tue, 16 Jun 2026 09:46:13 +0200 (CEST)
Date: Tue, 16 Jun 2026 09:46:13 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <pq5gjfzjz3mlkvbelt5zcufkubgy7qu2lcbn63savqdrkvrrqs@j4otz4oho2es>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-4-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615180629.7148-4-anonymemeow@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F23D66C801
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] fanotify21: Simplify read_pidfd_fdinfo()
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-06-26 02:06:27, AnonymeMeow wrote:
> Let callers provide storage for struct pidfd_fdinfo_t instead of
> allocating it in read_pidfd_fdinfo() every time. This removes
> unnecessary allocation/free paths and the NULL checks after
> read_pidfd_fdinfo() and simplifies the code.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 61 ++++++-------------
>  1 file changed, 20 insertions(+), 41 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index bd1a43513..22f9767db 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -64,7 +64,7 @@ static struct test_case_t {
>  
>  static int fanotify_fd;
>  static char event_buf[BUF_SZ];
> -static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
> +static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
>  
>  static int fd_error_unsupported;
>  
> @@ -73,12 +73,9 @@ static struct tst_clone_args clone_args = {
>  	.exit_signal = SIGCHLD,
>  };
>  
> -static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
> +static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
>  {
>  	char *fdinfo_path;
> -	struct pidfd_fdinfo_t *pidfd_fdinfo;
> -
> -	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
>  
>  	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
>  	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
> @@ -88,8 +85,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
>  	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
>  
>  	free(fdinfo_path);
> -
> -	return pidfd_fdinfo;
>  }
>  
>  static void generate_event(void)
> @@ -133,12 +128,9 @@ static void do_setup(void)
>  
>  	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
>  
> -	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
> -	if (self_pidfd_fdinfo == NULL) {
> -		tst_brk(TBROK,
> -			"pidfd=%d, failed to read pidfd fdinfo",
> -			pidfd);
> -	}
> +	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
> +
> +	SAFE_CLOSE(pidfd);
>  }
>  
>  static void do_test(unsigned int num)
> @@ -195,7 +187,7 @@ static void do_test(unsigned int num)
>  	while (i < len) {
>  		struct fanotify_event_metadata *event;
>  		struct fanotify_event_info_pidfd *info;
> -		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
> +		struct pidfd_fdinfo_t event_pidfd_fdinfo;
>  
>  		event = (struct fanotify_event_metadata *)&event_buf[i];
>  		info = (struct fanotify_event_info_pidfd *)(event + 1);
> @@ -275,39 +267,32 @@ static void do_test(unsigned int num)
>  		 * No pidfd errors occurred, continue with verifying pidfd
>  		 * fdinfo validity.
>  		 */
> -		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
> -		if (event_pidfd_fdinfo == NULL) {
> -			tst_brk(TBROK,
> -				"reading fdinfo for pidfd: %d "
> -				"describing pid: %u failed",
> -				info->pidfd,
> -				(unsigned int)event->pid);
> -			goto next_event;
> -		} else if (event_pidfd_fdinfo->pid != event->pid) {
> +		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
> +		if (event_pidfd_fdinfo.pid != event->pid) {
>  			tst_res(TFAIL,
>  				"pidfd provided for incorrect pid "
>  				"(expected pidfd for pid: %u, got pidfd for "
>  				"pid: %u)",
>  				(unsigned int)event->pid,
> -				(unsigned int)event_pidfd_fdinfo->pid);
> +				(unsigned int)event_pidfd_fdinfo.pid);
>  			goto next_event;
> -		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
> +		} else if (memcmp(&event_pidfd_fdinfo, &exp_pidfd_fdinfo,
>  				  sizeof(struct pidfd_fdinfo_t))) {
>  			tst_res(TFAIL,
>  				"pidfd fdinfo values for self and event differ "
>  				"(expected pos: %d, flags: %x, mnt_id: %d, "
>  				"pid: %d, ns_pid: %d, got pos: %d, "
>  				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
> -				self_pidfd_fdinfo->pos,
> -				self_pidfd_fdinfo->flags,
> -				self_pidfd_fdinfo->mnt_id,
> -				self_pidfd_fdinfo->pid,
> -				self_pidfd_fdinfo->ns_pid,
> -				event_pidfd_fdinfo->pos,
> -				event_pidfd_fdinfo->flags,
> -				event_pidfd_fdinfo->mnt_id,
> -				event_pidfd_fdinfo->pid,
> -				event_pidfd_fdinfo->ns_pid);
> +				exp_pidfd_fdinfo.pos,
> +				exp_pidfd_fdinfo.flags,
> +				exp_pidfd_fdinfo.mnt_id,
> +				exp_pidfd_fdinfo.pid,
> +				exp_pidfd_fdinfo.ns_pid,
> +				event_pidfd_fdinfo.pos,
> +				event_pidfd_fdinfo.flags,
> +				event_pidfd_fdinfo.mnt_id,
> +				event_pidfd_fdinfo.pid,
> +				event_pidfd_fdinfo.ns_pid);
>  			goto next_event;
>  		} else {
>  			tst_res(TPASS,
> @@ -329,9 +314,6 @@ next_event:
>  
>  		if (info && info->pidfd >= 0)
>  			SAFE_CLOSE(info->pidfd);
> -
> -		if (event_pidfd_fdinfo)
> -			free(event_pidfd_fdinfo);
>  	}
>  
>  	if (tc->want_pidfd_err)
> @@ -343,9 +325,6 @@ static void do_cleanup(void)
>  	if (fanotify_fd >= 0)
>  		SAFE_CLOSE(fanotify_fd);
>  
> -	if (self_pidfd_fdinfo)
> -		free(self_pidfd_fdinfo);
> -
>  	/* Unmount the bind mount */
>  	SAFE_UMOUNT(MOUNT_PATH);
>  }
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
