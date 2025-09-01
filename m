Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D5CA0FF0
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 15:07:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD31E3CD365
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 17:07:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4E03CCE35
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 17:07:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E5F06003AB
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 17:07:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EB731F387;
 Mon,  1 Sep 2025 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756739247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RN0ZJtaiVZWzOE2T9WOy3pzzyv7oou3KQYtEq7Ub898=;
 b=CTwRAPwkO/0N/lXFTThnPPjdSXffeZeTorvyTCYHGIpDmSlRvUYvJMd46B9NjA0M3NO7WH
 xr4JKiNfA6Y1mBjFezM75H2NKC1SoiA4LIE6AuyHyL5o5zQcLf8blgLK3B1h8I1yWG5gWp
 SydHeVr+90tbCgoMM26XVEb1w90TpeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756739247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RN0ZJtaiVZWzOE2T9WOy3pzzyv7oou3KQYtEq7Ub898=;
 b=EDGtwZzF06r8r0jUi4pUx1f/ehlMAILHNHU8zNPUMrCaGvrhhCqbix4ihMpYyr023GksPL
 rgLctegRwgeTWeAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756739247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RN0ZJtaiVZWzOE2T9WOy3pzzyv7oou3KQYtEq7Ub898=;
 b=CTwRAPwkO/0N/lXFTThnPPjdSXffeZeTorvyTCYHGIpDmSlRvUYvJMd46B9NjA0M3NO7WH
 xr4JKiNfA6Y1mBjFezM75H2NKC1SoiA4LIE6AuyHyL5o5zQcLf8blgLK3B1h8I1yWG5gWp
 SydHeVr+90tbCgoMM26XVEb1w90TpeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756739247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RN0ZJtaiVZWzOE2T9WOy3pzzyv7oou3KQYtEq7Ub898=;
 b=EDGtwZzF06r8r0jUi4pUx1f/ehlMAILHNHU8zNPUMrCaGvrhhCqbix4ihMpYyr023GksPL
 rgLctegRwgeTWeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F4991378C;
 Mon,  1 Sep 2025 15:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vv9eCq+2tWi0XQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 01 Sep 2025 15:07:27 +0000
Date: Mon, 1 Sep 2025 17:08:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aLW2083hqYqd4npE@yuki.lan>
References: <20250521141655.3202240-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250521141655.3202240-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
> Using sprintf without length checking in tst_tmpdir may lead to buffer overflow.
> So in this patch use openat() instead of open().
> 
> Fixs:1241
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_tmpdir.c | 119 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 111 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 6ed2367b9..7bd55022d 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -102,6 +102,7 @@ static char test_start_work_dir[PATH_MAX];
>  extern futex_t *tst_futexes;
>  
>  static int rmobj(const char *obj, char **errmsg);

We shouldn't keep the old rmobj() purge_dir() calls, these should be
replaced by rmobjat() and purge_dirat(). Hint: use AT_FDCWD when there
is no dir_fd to pass.

> +static int rmobjat(int dir_fd, const char *obj, char **errmsg);
>  
>  int tst_tmpdir_created(void)
>  {
> @@ -149,8 +150,8 @@ static int purge_dir(const char *path, char **errptr)
>  	int ret_val = 0;
>  	DIR *dir;
>  	struct dirent *dir_ent;
> -	char dirobj[PATH_MAX];
>  	static char err_msg[PATH_MAX + 1280];
> +	int dir_fd = -1;
>  
>  	/* Do NOT perform the request if the directory is "/" */
>  	if (!strcmp(path, "/")) {
> @@ -167,7 +168,7 @@ static int purge_dir(const char *path, char **errptr)
>  	/* Open the directory to get access to what is in it */
>  	if (!(dir = opendir(path))) {
>  		if (errptr) {
> -			sprintf(err_msg,
> +			snprintf(err_msg, sizeof(err_msg),
>  				"Cannot open directory %s; errno=%d: %s",
>  				path, errno, tst_strerrno(errno));
>  			*errptr = err_msg;
> @@ -175,6 +176,18 @@ static int purge_dir(const char *path, char **errptr)
>  		return -1;
>  	}
>  
> +	dir_fd = dirfd(dir);
> +	if (dir_fd == -1) {
> +		closedir(dir);
> +		if (errptr) {
> +			snprintf(err_msg, sizeof(err_msg),
> +				"Cannot get file descriptor for directory %s; errno=%d: %s",
> +				path, errno, tst_strerrno(errno));
> +			*errptr = err_msg;
> +		}
> +		return -1;
> +	}
> +
>  	/* Loop through the entries in the directory, removing each one */
>  	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
>  		/* Don't remove "." or ".." */
> @@ -183,8 +196,57 @@ static int purge_dir(const char *path, char **errptr)
>  			continue;
>  
>  		/* Recursively remove the current entry */
> -		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
> -		if (rmobj(dirobj, errptr) != 0)
> +		if (rmobjat(dir_fd, dir_ent->d_name, errptr) != 0)
> +			ret_val = -1;
> +	}

close(dir_fd) here?

> +	closedir(dir);
> +	return ret_val;
> +}
> +
> +static int purge_dirat(int dir_fd, const char *path, char **errptr)
> +{
> +	int ret_val = 0;
> +	DIR *dir;
> +	struct dirent *dir_ent;
> +	static char err_msg[PATH_MAX + 1280];
> +	int subdir_fd;
> +
> +	errno = 0;
> +
> +	/* Open the subdirectory using openat */
> +	subdir_fd = openat(dir_fd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
> +	if (subdir_fd < 0) {
> +		if (errptr) {
> +			snprintf(err_msg, sizeof(err_msg),
> +				 "Cannot open subdirectory %s (via fd %d); errno=%d: %s",
> +				 path, dir_fd, errno, tst_strerrno(errno));
> +			*errptr = err_msg;
> +		}
> +		return -1;
> +	}
> +
> +	dir = fdopendir(subdir_fd);
> +	if (!dir) {
> +		if (errptr) {
> +			snprintf(err_msg, sizeof(err_msg),
> +				 "Cannot open directory stream for %s (via fd %d); errno=%d: %s",
> +				 path, dir_fd, errno, tst_strerrno(errno));
> +			*errptr = err_msg;
> +		}
> +		close(subdir_fd);
> +		return -1;
> +	}
> +
> +	/* Loop through the entries in the directory, removing each one */
> +	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
> +		/* Don't remove "." or ".." */
> +		if (!strcmp(dir_ent->d_name, ".")
> +		    || !strcmp(dir_ent->d_name, ".."))
> +			continue;
> +
> +		/* Recursively remove the current entry */
> +		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
>  			ret_val = -1;
>  	}
>  
> @@ -212,7 +274,7 @@ static int rmobj(const char *obj, char **errmsg)
>  		/* Get the link count, now that all the entries have been removed */
>  		if (lstat(obj, &statbuf) < 0) {
>  			if (errmsg != NULL) {
> -				sprintf(err_msg,
> +				snprintf(err_msg, sizeof(err_msg),
>  					"lstat(%s) failed; errno=%d: %s", obj,
>  					errno, tst_strerrno(errno));
>  				*errmsg = err_msg;
> @@ -225,7 +287,7 @@ static int rmobj(const char *obj, char **errmsg)
>  			/* The directory is linked; unlink() must be used */
>  			if (unlink(obj) < 0) {
>  				if (errmsg != NULL) {
> -					sprintf(err_msg,
> +					snprintf(err_msg, sizeof(err_msg),
>  						"unlink(%s) failed; errno=%d: %s",
>  						obj, errno, tst_strerrno(errno));
>  					*errmsg = err_msg;
> @@ -236,7 +298,7 @@ static int rmobj(const char *obj, char **errmsg)
>  			/* The directory is not linked; remove() can be used */
>  			if (remove(obj) < 0) {
>  				if (errmsg != NULL) {
> -					sprintf(err_msg,
> +					snprintf(err_msg, sizeof(err_msg),
>  						"remove(%s) failed; errno=%d: %s",
>  						obj, errno, tst_strerrno(errno));
>  					*errmsg = err_msg;
> @@ -247,7 +309,7 @@ static int rmobj(const char *obj, char **errmsg)
>  	} else {
>  		if (unlink(obj) < 0) {
>  			if (errmsg != NULL) {
> -				sprintf(err_msg,
> +				snprintf(err_msg, sizeof(err_msg),
>  					"unlink(%s) failed; errno=%d: %s", obj,
>  					errno, tst_strerrno(errno));
>  				*errmsg = err_msg;
> @@ -259,6 +321,47 @@ static int rmobj(const char *obj, char **errmsg)
>  	return 0;
>  }
>  
> +static int rmobjat(int dir_fd, const char *obj, char **errmsg)
> +{
> +	int ret_val = 0;
> +	struct stat statbuf;
> +	static char err_msg[PATH_MAX + 1280];
> +	int fd;
> +
> +	fd = openat(dir_fd, obj, O_DIRECTORY | O_NOFOLLOW);
> +	if (fd >= 0) {
> +		close(fd);

We close the fd here just to open it in purge_dirat(), shouldn't we pass
it to the purge_dirat() function instead?

> +		ret_val = purge_dirat(dir_fd, obj, errmsg);
> +
> +		/* If there were problems removing an entry, don't attempt to
> +		   remove the directory itself */
> +		if (ret_val == -1)
> +			return -1;
> +
> +		if (unlinkat(dir_fd, obj, AT_REMOVEDIR) < 0) {
> +			if (errmsg != NULL) {
> +				snprintf(err_msg, sizeof(err_msg),
> +						"remove(%s) failed; errno=%d: %s",
> +						obj, errno, tst_strerrno(errno));
> +				*errmsg = err_msg;
> +			}
> +			return -1;
> +		}
> +	} else {
> +		if (unlinkat(dir_fd, obj, 0) < 0) {
> +			if (errmsg != NULL) {
> +				snprintf(err_msg, sizeof(err_msg),
> +					"unlinkat(%s) failed; errno=%d: %s", obj,
> +					errno, tst_strerrno(errno));
> +				*errmsg = err_msg;
> +			}
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  void tst_tmpdir(void)
>  {
>  	char template[PATH_MAX];
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
