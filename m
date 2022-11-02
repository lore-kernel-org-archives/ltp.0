Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8966C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 13:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFEF43CAD63
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 14:06:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ADA23CA768
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 14:06:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E00410007EF
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 14:06:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AD5D1F855;
 Wed,  2 Nov 2022 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667394372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Cv++I2QVyYUH/xPxF9nlk5SBIAiJIIz0eYrG9R87GA=;
 b=VQ+CeL7XGXuBCn8acRCc3xNYVB0MGFSV1DCiRnwbtkMbYcGbGj/xIiVrRhkWOIxE+ke3f7
 iFPWjmX9da/kZDK+e+k1J9altfaIu/n1iOFX27GfLIqcnBCLiaTcvEvfe/jwXb7+bhr2hz
 hqS22uBAk3FAidu7VDpAP5hu7u9MiUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667394372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Cv++I2QVyYUH/xPxF9nlk5SBIAiJIIz0eYrG9R87GA=;
 b=G3UOvES4sEIRghS6RcnaPTgVH+FKzECVpIj9j3Lunox0YOUh5B+xqgu1hNMymu3wXJSIOY
 s0V3mkJipUU9ZiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD5C313AE0;
 Wed,  2 Nov 2022 13:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a3X2NENrYmMJKwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Nov 2022 13:06:11 +0000
Date: Wed, 2 Nov 2022 14:07:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Y2JroRqqpxZyJpii@yuki>
References: <20221101000841.1207999-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221101000841.1207999-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: add TST_GET_TMPDIR_ROOT() to get
 the TMPDIR env var
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/include/old/old_tmpdir.h b/include/old/old_tmpdir.h
> index 9c61172fd..b1cf79344 100644
> --- a/include/old/old_tmpdir.h
> +++ b/include/old/old_tmpdir.h
> @@ -45,6 +45,11 @@ void tst_rmdir(void);
>   */
>  char *tst_get_tmpdir(void);
>  
> +/*
> + * Returns path to the test temporary directory root.
> + */
> +const char *tst_get_tmpdir_root(void);
> +
>  /*
>   * Returns 1 if temp directory was created.
>   */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index a69965b95..26a5ec752 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -362,6 +362,11 @@ void tst_set_max_runtime(int max_runtime);
>   */
>  char *tst_get_tmpdir(void);
>  
> +/*
> + * Returns path to the test temporary directory root.
> + */
> +const char *tst_get_tmpdir_root(void);
> +
>  /*
>   * Validates exit status of child processes
>   */
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 6642d6be4..50699bc63 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -645,10 +645,7 @@ static void cgroup_mount_v2(void)
>  {
>  	int ret;
>  	char mnt_path[PATH_MAX];
> -	const char *tmpdir = getenv("TMPDIR");
> -
> -	if (!tmpdir)
> -		tmpdir = "/tmp";
> +	const char *tmpdir = tst_get_tmpdir_root();
>  
>  	sprintf(mnt_path, "%s/%s%s",
>  		tmpdir, cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
> @@ -698,10 +695,7 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
>  {
>  	char mnt_path[PATH_MAX];
>  	int made_dir = 0;
> -	const char *tmpdir = getenv("TMPDIR");
> -
> -	if (!tmpdir)
> -		tmpdir = "/tmp";
> +	const char *tmpdir = tst_get_tmpdir_root();
>  
>  	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
>  		tst_res(TCONF,
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 7781f94c3..d4911fa3b 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -74,14 +74,11 @@ int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
>  static enum tst_fs_impl has_kernel_support(const char *fs_type)
>  {
>  	static int fuse_supported = -1;
> -	const char *tmpdir = getenv("TMPDIR");
> +	const char *tmpdir = tst_get_tmpdir_root();
>  	char buf[128];
>  	char template[PATH_MAX];
>  	int ret;
>  
> -	if (!tmpdir)
> -		tmpdir = "/tmp";
> -
>  	snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
>  	if (!mkdtemp(template))
>  		tst_brk(TBROK | TERRNO, "mkdtemp(%s) failed", template);
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 6e38ae977..9c90f481a 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -122,6 +122,28 @@ char *tst_get_tmpdir(void)
>  	return ret;
>  }
>  
> +const char *tst_get_tmpdir_root(void)
> +{
> +	char *c;
> +	const char *env_tmpdir = getenv("TMPDIR");
> +
> +	if (!env_tmpdir)
> +		env_tmpdir = TEMPDIR;
> +
> +	c = strchr(env_tmpdir, '/');
> +	/*
> +	 * We force environment variable TMPDIR to be an absolute pathname,
> +	 * which does not make much sense, but it will greatly simplify code in
> +	 * tst_rmdir().
> +	 */

This looks more like user documentation that anything else. I guess that
it would make sense to remove this comment from here and add a note
about absolute pathname to doc/user-guide.txt where we describe all the
environment variables.

> +	if (c != env_tmpdir) {
> +		tst_brkm(TBROK, NULL, "You must specify an absolute "
> +				"pathname for environment variable TMPDIR");
> +		return NULL;
> +	}

	Isn't this just overly complicated way how to write:

	if (env_tmpdir[0] != '/') {
		tst_brkm(...);
		...
	}

> +	return env_tmpdir;
> +}
> +
>  const char *tst_get_startwd(void)
>  {
>  	return test_start_work_dir;
> @@ -245,31 +267,16 @@ static int rmobj(const char *obj, char **errmsg)
>  void tst_tmpdir(void)
>  {
>  	char template[PATH_MAX];
> -	char *env_tmpdir;
> -	char *errmsg, *c;
> +	const char *env_tmpdir;
> +	char *errmsg;
>  
>  	/*
>  	 * Create a template for the temporary directory.  Use the
>  	 * environment variable TMPDIR if it is available, otherwise
>  	 * use our default TEMPDIR.
>  	 */
> -	env_tmpdir = getenv("TMPDIR");
> -	if (env_tmpdir) {
> -		c = strchr(env_tmpdir, '/');
> -		/*
> -		 * Now we force environment variable TMPDIR to be an absolute
> -		 * pathname, which dose not make much sense, but it will
> -		 * greatly simplify code in tst_rmdir().
> -		 */
> -		if (c != env_tmpdir) {
> -			tst_brkm(TBROK, NULL, "You must specify an absolute "
> -				 "pathname for environment variable TMPDIR");
> -			return;
> -		}
> -		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
> -	} else {
> -		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", TEMPDIR, TCID);
> -	}
> +	env_tmpdir = tst_get_tmpdir_root();
> +	snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
>  
>  	/* Make the temporary directory in one shot using mkdtemp. */
>  	if (mkdtemp(template) == NULL) {
> diff --git a/testcases/kernel/security/filecaps/filecaps_common.h b/testcases/kernel/security/filecaps/filecaps_common.h
> index 920f6ac6a..0f011868e 100644
> --- a/testcases/kernel/security/filecaps/filecaps_common.h
> +++ b/testcases/kernel/security/filecaps/filecaps_common.h
> @@ -1,5 +1,6 @@
>  #include <limits.h>
>  #include <stdlib.h>
> +#include <old_tmpdir.h>
>  
>  static char *fifofile;
>  
> @@ -9,10 +10,8 @@ static const char *get_caps_fifo(void)
>  		fifofile = getenv("FIFOFILE");
>  
>  		if (!fifofile) {
> -			const char *tmpdir = getenv("TMPDIR");
> +			const char *tmpdir = tst_get_tmpdir_root();
>  
> -			if (!tmpdir)
> -				tmpdir = "/tmp";
>  			fifofile = malloc(PATH_MAX);
>  			snprintf(fifofile, PATH_MAX, "%s/caps_fifo", tmpdir);
>  		}
> diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
> index e843a4896..cb111a698 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd02.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
> @@ -42,28 +42,6 @@ static int dir_exists(const char *dirpath)
>  	return 0;
>  }
>  
> -static const char *get_tmpdir_path(void)
> -{
> -	char *tmpdir = "/tmp";
> -
> -	if (dir_exists(tmpdir))
> -		goto done;
> -
> -	/* fallback to $TMPDIR */
> -	tmpdir = getenv("TMPDIR");
> -	if (!tmpdir)
> -		tst_brk(TBROK | TERRNO, "Failed to get $TMPDIR");
> -
> -	if (tmpdir[0] != '/')
> -		tst_brk(TBROK, "$TMPDIR must be an absolute path");
> -
> -	if (!dir_exists(tmpdir))
> -		tst_brk(TBROK | TERRNO, "TMPDIR '%s' doesn't exist", tmpdir);
> -
> -done:
> -	return tmpdir;
> -}
> -
>  static void verify_getcwd(unsigned int n)
>  {
>  	struct t_case *tc = &tcases[n];
> @@ -92,7 +70,10 @@ end:
>  
>  static void setup(void)
>  {
> -	const char *tmpdir = get_tmpdir_path();
> +	const char *tmpdir = tst_get_tmpdir_root();
> +
> +	if (!dir_exists(tmpdir))
> +		tst_brk(TBROK | TERRNO, "TMPDIR '%s' doesn't exist", tmpdir);
>  
>  	SAFE_CHDIR(tmpdir);
>  
> diff --git a/testcases/open_posix_testsuite/include/tempfile.h b/testcases/open_posix_testsuite/include/tempfile.h
> index 0fd27cee3..63e179baf 100644
> --- a/testcases/open_posix_testsuite/include/tempfile.h
> +++ b/testcases/open_posix_testsuite/include/tempfile.h
> @@ -6,14 +6,8 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <limits.h>
> +#include <old_tmpdir.h>
>  
>  #define PTS_GET_TMP_FILENAME(target, prefix) \
>      snprintf(target, sizeof(target), \
> -    "%s/" prefix "_pid-%d", pts_get_tmpdir(), getpid());
> -
> -static inline const char *pts_get_tmpdir(void)
> -{
> -    const char *tmpdir_env;
> -    tmpdir_env = getenv("TMPDIR");
> -    return tmpdir_env ? tmpdir_env : "/tmp";
> -}
> +    "%s/" prefix "_pid-%d", tst_get_tmpdir_root(), getpid());

NACK to this part. The Open Posix Testsuite is not integrated into LTP
and does not use the test library. I doubt that this will even compile
correctly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
