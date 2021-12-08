Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF5C433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 16:17:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67EDC3C7026
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 17:17:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C533C31DA
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:17:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F3FA1400262
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:17:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E4101FD56;
 Wed,  8 Dec 2021 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638980230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haCQai1WyvB1STMeAeJrc02198KSyG07u/yjY1AF4Wg=;
 b=3HLHpa8+ChCQq8a1haBtvbp3JD+LmcyC6SuRhW6eay/1Beg7pTFaIXXgIOrx7PSHpfl3tP
 jMHTNmDnDgmRIRTj1EjZNpHwX6e8NLeFqVM15ae/mmfEfGB0L+kuP8umjwepKTYVKX0umb
 mUHKhdTNNdTmKt2TxyyliUg9Bj6mZ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638980230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haCQai1WyvB1STMeAeJrc02198KSyG07u/yjY1AF4Wg=;
 b=2QDcCRS8YDHk5BjRAFW1hgG4lhXdQD8fwzEddKzCIk1WVjXykk4R18bcR2Hv5EVmwvSlp8
 fyzn21L+s3GTuoAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAF9413C9B;
 Wed,  8 Dec 2021 16:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n3akOIXasGEiagAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Dec 2021 16:17:09 +0000
Date: Wed, 8 Dec 2021 17:18:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YbDa1Hjl9c6cOSa9@yuki>
References: <20211117033951.16352-1-tangmeng@uniontech.com>
 <20211117033951.16352-2-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211117033951.16352-2-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fchownat/fchownat02: Convert to new API
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
Same comment apply here as well, 'make check' produces many warnings
that should have been fixed.

> +/*\
> + * [Description]
> + *
> + * Verify that,
> + * The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
> + * not be dereferenced if the pathname is a symbolic link.

This is a bit broken, at least the sentence should continue with
lowercase The on the second line as continuation of the sentence that
has started with 'Verify that,'.

But it would be better rewritten to something as:

Verify that fchownat() with AT_SYMLINK_NOFOLLOW does not dereference
symbolic links.

>   */
> 
>  #define _GNU_SOURCE
> 
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "fchownat.h"
>  #include "lapi/fcntl.h"
> 
>  #define TESTFILE	"testfile"
>  #define TESTFILE_LINK	"testfile_link"
> 
> -char *TCID = "fchownat02";
> -int TST_TOTAL = 1;
> -
>  static int dir_fd;
>  static uid_t set_uid = 1000;
>  static gid_t set_gid = 1000;
> -static void setup(void);
> -static void cleanup(void);
> -static void test_verify(void);
> -static void fchownat_verify(void);
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify();
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> 
>  static void setup(void)
>  {
>  	struct stat c_buf, l_buf;
> 
> -	if ((tst_kvercmp(2, 6, 16)) < 0)
> -		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
> -
> -	tst_require_root();
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
> 
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
> 
> -	TEST_PAUSE;
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
> 
> -	tst_tmpdir();
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> 
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> -
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> -
> -	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
> -
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> -
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
> 
>  	if (l_buf.st_uid == set_uid || l_buf.st_gid == set_gid) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> +		tst_brk(TBROK | TERRNO,
>  			 "link_uid(%d) == set_uid(%d) or link_gid(%d) == "
>  			 "set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
>  			 set_gid);
>  	}

I guess that it would be easier to set the set_uid and set_gid to
l_buf.st_uid + 1 and l_buf.st_gid + 1 that way we will be sure that it's
different.

>  }
> 
> -static void fchownat_verify(void)
> -{
> -	TEST(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
> -		      AT_SYMLINK_NOFOLLOW));
> -
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "fchownat() failed, errno=%d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -	} else {
> -		test_verify();
> -	}
> -}
> -
> -static void test_verify(void)
> +static void verify_fchownat(void)
>  {
>  	struct stat c_buf, l_buf;
> 
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> +	TST_EXP_PASS_SILENT(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
> +		      AT_SYMLINK_NOFOLLOW));
> +
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> 
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
> 
>  	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
>  	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
> -		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
> +		tst_res(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
>  	} else {
> -		tst_resm(TFAIL,
> +		tst_res(TFAIL,
>  			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
>  			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
>  			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
> @@ -136,5 +73,15 @@ static void test_verify(void)
> 
>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +       if (dir_fd > 0)
> +               close(dir_fd);

Here SAFE_CLOSE() as well.

>  }
> +
> +static struct tst_test test = {
> +        .min_kver = "2.6.16",
> +        .test_all = verify_fchownat,
> +        .setup = setup,
> +        .cleanup = cleanup,
> +        .needs_tmpdir = 1,
> +	.needs_root = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
