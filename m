Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32ACD6E71
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 14:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E3973CF7DC
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 15:37:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9D83CF7BE
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 15:37:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE9F5600742
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 15:37:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 080B721260;
 Thu, 13 Nov 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763044644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdLllQbc1DntC5ixhtu1d53tQAaDP9qfzk6gtxQCWlI=;
 b=hC6l/u/dPO9gUq2gEG6Olo7opY+rYGnuhryhMkblkl2PTnocbJnUS8zn7K0LojtM4hvKsv
 6o/RdaD1RmUNHmneNOVaLAH9g4wY7ySJ0uuwj9WmuRb5Je8MzZanW4gBklY9Q7jLg+k8fA
 V6MgvKxqZBGSHz4rMhk/mxHFLapk6Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763044644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdLllQbc1DntC5ixhtu1d53tQAaDP9qfzk6gtxQCWlI=;
 b=Aemrhsh1gsHCTR97q7sunsqOPol6NdPuh2KBULqGLukWOzW4nnnYVE6Iroi0yWWFQunbfj
 MkXH+ciCowe/lKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763044643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdLllQbc1DntC5ixhtu1d53tQAaDP9qfzk6gtxQCWlI=;
 b=wJwpnyAZcptVoChw7hD+tAYTWS0sVnKz6yUrfTiW6D65EPCSSTS4tQ3211c60TCn/2eMry
 KkxFPm+EjbCyvQ5eNNebQoWLX57dsssd4tJVXaXYEATTL8Mbvnrcm9MsGiy3fDwY+mgNN2
 S/yVmqaWx8In/GMRi2hv5rrjuqhkJhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763044643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdLllQbc1DntC5ixhtu1d53tQAaDP9qfzk6gtxQCWlI=;
 b=PWEu9myP5O5HKpOd/ZtqO5bYvP6Na6FRkbVFV1szJtxbu9Lyx2wlk6Igjf0x3kj2hfgzCO
 kq/8wfi77DzFcJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC9EB3EA61;
 Thu, 13 Nov 2025 14:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 54+LOCLtFWkKLQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Nov 2025 14:37:22 +0000
Date: Thu, 13 Nov 2025 15:38:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aRXtUIlkNP3aDReN@yuki.lan>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250523210950.1019560-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250523210950.1019560-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
> Fixes: https://github.com/linux-test-project/ltp/issues/1241
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_tmpdir.c | 122 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 78 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 6ed2367b9..bcb9534c5 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -101,7 +101,7 @@ static char test_start_work_dir[PATH_MAX];
>  /* lib/tst_checkpoint.c */
>  extern futex_t *tst_futexes;
>  
> -static int rmobj(const char *obj, char **errmsg);
> +static int rmobjat(int dir_fd, const char *obj, char **errmsg);
>  
>  int tst_tmpdir_created(void)
>  {
> @@ -149,8 +149,8 @@ static int purge_dir(const char *path, char **errptr)
>  	int ret_val = 0;
>  	DIR *dir;
>  	struct dirent *dir_ent;
> -	char dirobj[PATH_MAX];
>  	static char err_msg[PATH_MAX + 1280];
> +	int dir_fd = -1;
>  
>  	/* Do NOT perform the request if the directory is "/" */
>  	if (!strcmp(path, "/")) {
> @@ -167,7 +167,7 @@ static int purge_dir(const char *path, char **errptr)
>  	/* Open the directory to get access to what is in it */
>  	if (!(dir = opendir(path))) {

>  		if (errptr) {
> -			sprintf(err_msg,
> +			snprintf(err_msg, sizeof(err_msg),
>  				"Cannot open directory %s; errno=%d: %s",
>  				path, errno, tst_strerrno(errno));
>  			*errptr = err_msg;
> @@ -175,6 +175,68 @@ static int purge_dir(const char *path, char **errptr)
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
> +	/* Loop through the entries in the directory, removing each one */
> +	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
> +		/* Don't remove "." or ".." */
> +		if (!strcmp(dir_ent->d_name, ".")
> +		    || !strcmp(dir_ent->d_name, ".."))
> +			continue;
> +
> +		/* Recursively remove the current entry */
> +		if (rmobjat(dir_fd, dir_ent->d_name, errptr) != 0)
> +			ret_val = -1;
> +	}
> +
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
>  	/* Loop through the entries in the directory, removing each one */
>  	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
>  		/* Don't remove "." or ".." */
> @@ -183,8 +245,7 @@ static int purge_dir(const char *path, char **errptr)
>  			continue;
>  
>  		/* Recursively remove the current entry */
> -		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
> -		if (rmobj(dirobj, errptr) != 0)
> +		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
>  			ret_val = -1;
>  	}
>  
> @@ -192,63 +253,36 @@ static int purge_dir(const char *path, char **errptr)
>  	return ret_val;
>  }

Again, there shouldn't be two function for the same job. There should be
only purge_dirat() and the tst_purge_dir() should call purge_dirat()
with AT_FDCWD as the dirfd.

> -static int rmobj(const char *obj, char **errmsg)
> +static int rmobjat(int dir_fd, const char *obj, char **errmsg)
>  {
>  	int ret_val = 0;
> -	struct stat statbuf;
>  	static char err_msg[PATH_MAX + 1280];
>  	int fd;
>  
> -	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
> +	fd = openat(dir_fd, obj, O_DIRECTORY | O_NOFOLLOW);
>  	if (fd >= 0) {
>  		close(fd);
> -		ret_val = purge_dir(obj, errmsg);
> +		ret_val = purge_dirat(dir_fd, obj, errmsg);
>  
>  		/* If there were problems removing an entry, don't attempt to
>  		   remove the directory itself */
>  		if (ret_val == -1)
>  			return -1;
>  
> -		/* Get the link count, now that all the entries have been removed */
> -		if (lstat(obj, &statbuf) < 0) {
> +		if (unlinkat(dir_fd, obj, AT_REMOVEDIR) < 0) {
>  			if (errmsg != NULL) {
> -				sprintf(err_msg,
> -					"lstat(%s) failed; errno=%d: %s", obj,
> -					errno, tst_strerrno(errno));
> -				*errmsg = err_msg;
> -			}
> -			return -1;
> -		}
> -
> -		/* Remove the directory itself */
> -		if (statbuf.st_nlink >= 3) {
> -			/* The directory is linked; unlink() must be used */
> -			if (unlink(obj) < 0) {
> -				if (errmsg != NULL) {
> -					sprintf(err_msg,
> -						"unlink(%s) failed; errno=%d: %s",
> -						obj, errno, tst_strerrno(errno));
> -					*errmsg = err_msg;
> -				}
> -				return -1;
> -			}
> -		} else {
> -			/* The directory is not linked; remove() can be used */
> -			if (remove(obj) < 0) {
> -				if (errmsg != NULL) {
> -					sprintf(err_msg,
> +				snprintf(err_msg, sizeof(err_msg),
>  						"remove(%s) failed; errno=%d: %s",
>  						obj, errno, tst_strerrno(errno));
> -					*errmsg = err_msg;
> -				}
> -				return -1;
> +				*errmsg = err_msg;
>  			}
> +			return -1;
>  		}

I do not think that we can remove the part where we check the number of
links to the directory. I suppose that the new code should look like:

	int flags = AT_REMOVEDIR;

	if (lstatat(dir_fd, &statbuf)) {
		...
	}

	if (statbuf.st_nlink >= 3)
		flags = 0;

	if (unlinkat(dir_fd, obj, flags)) {
		...
	}


>  	} else {
> -		if (unlink(obj) < 0) {
> +		if (unlinkat(dir_fd, obj, 0) < 0) {
>  			if (errmsg != NULL) {
> -				sprintf(err_msg,
> -					"unlink(%s) failed; errno=%d: %s", obj,
> +				snprintf(err_msg, sizeof(err_msg),
> +					"unlinkat(%s) failed; errno=%d: %s", obj,
>  					errno, tst_strerrno(errno));
>  				*errmsg = err_msg;
>  			}
> @@ -305,7 +339,7 @@ void tst_tmpdir(void)
>  		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
>  
>  		/* Try to remove the directory */
> -		if (rmobj(TESTDIR, &errmsg) == -1) {
> +		if (rmobjat(0, TESTDIR, &errmsg) == -1) {
>  			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
>  				 __func__, TESTDIR, errmsg);
>  		}
> @@ -343,7 +377,7 @@ void tst_rmdir(void)
>  	/*
>  	 * Attempt to remove the "TESTDIR" directory, using rmobj().
>  	 */
> -	if (rmobj(TESTDIR, &errmsg) == -1) {
> +	if (rmobjat(0, TESTDIR, &errmsg) == -1) {
>  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
>  			 __func__, TESTDIR, errmsg);
>  	}

We should pass AT_FDCWD to the two rmobjat() here since it's possible to
pass relative path in the TMPDIR environment variable. Otherwise the
code will not work with e.g. TMPDIR="." ./test_foo

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
