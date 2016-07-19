From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 13:49:53 +0200
Subject: [LTP] [PATCH] syscalls/access02: reconstruct and convert to new
 API
In-Reply-To: <1466755683-30036-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1466755683-30036-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160719114953.GC6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	char c, command[64];
> +	const char *filename;
> +
> +	if (tc->is_symlink == 1) {
> +		SAFE_SYMLINK(tc->targetname, tc->pathname);
> +		filename = tc->targetname;
> +	} else {
> +		filename = tc->pathname;
> +	}

Is there a reason why we don't create all the symlinks in the test setup
instead?

> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "access(%s, %#o) failed",
> -					 file_name, access_mode);
> -				continue;
> -			}
> +	TEST(access(tc->pathname, tc->mode));
>  
> -			access_verify(i);
> -		}
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "access(%s, %s) as %s failed",
> +			tc->pathname, tc->name, user);
> +		return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	switch (tc->mode) {
> +	case R_OK:
> +		/*
> +		 * The specified file(or pointed to by symbolic link)
> +		 * has read access, attempt to read data from the file,
> +		 * if successful, access() behaviour is correct.
> +		 */
> +		TEST(read(fds[0], &c, 1));

If we really want to test that access() works we have to try to open the
file here. The actuall file descriptor does not correspond to the file
access mode at all, once it was opened with O_RDWR in the setup it will
stay that way until we close it.

What we should do here instead to try to open the file for reading with
open and we should expect to get a valid fd.

> -static void setup(void)
> -{
> -	int i;
> +		if (TEST_RETURN == -1) {
> +			tst_res(TFAIL | TTERRNO, "read %s as %s failed",
> +				filename, user);
> +			return;
> +		}
>  
> -	tst_require_root();
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +		break;
> +	case W_OK:
> +		/*
> +		 * The specified file(or pointed to by symbolic link)
> +		 * has write access, attempt to write data to the file,
> +		 * if successful, access() behaviour is correct.
> +		 */
> +		TEST(write(fds[1], "A", 1));

Same here, we should rather try to open the file for writing.

> -	ltpuser = getpwnam(nobody_uid);
> -	if (ltpuser == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
> -	if (setuid(ltpuser->pw_uid) == -1)
> -		tst_brkm(TINFO | TERRNO, NULL, "setuid failed");
> +		if (TEST_RETURN == -1) {
> +			tst_res(TFAIL | TTERRNO, "write %s as %s failed",
> +				filename, user);
> +			return;
> +		}
>  
> -	TEST_PAUSE;
> -	tst_tmpdir();
> +		break;
> +	case X_OK:
> +		/*
> +		 * The specified file(or pointed to by symbolic link)
> +		 * has execute access, attempt to execute the executable
> +		 * file, if successful, access() behaviour is correct.
> +		 */
> +		sprintf(command, "./%s", filename);

...

> +static void setup(void)
>  {
> -	int fd3;
> +	struct passwd *pw;
>  #ifdef UCLINUX
>  	char exechead[] = "#!/bin/sh\n";
>  #endif

Just drop the UCLINUX ifdefs, we can write the shebang to the file
unconditionally.

> -	fd3 = open(TEST_FILE3, O_RDWR | O_CREAT, FILE_MODE);
> -	if (fd3 == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
> -			 TEST_FILE3, FILE_MODE);
> -	}
> -#ifdef UCLINUX
> -	if (write(fd3, exechead, sizeof(exechead)) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "write(%s) failed",
> -			 TEST_FILE3);
> -	}
> -#endif
> -
> -	/* Close the test file created above */
> -	if (close(fd3) == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
> -			 TEST_FILE3);
> -	}
> -
> -	/* Set execute permission bits on the test file. */
> -	if (chmod(TEST_FILE3, EXE_MODE) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, %#o) failed",
> -			 TEST_FILE3, EXE_MODE);
> -	}
> +	pw = SAFE_GETPWNAM("nobody");
>  
> -	return 0;
> -}
> +	uid = pw->pw_uid;
>  
> -/*
> - * setup4() - Setup function to test the functionality of access() for
> - *	      symbolic link file.
> - *
> - *   Creat/open a temporary file and close it.
> - *   Creat a symbolic link of temporary file.
> - *   This function returns 0.
> - */
> -static int setup4(void)
> -{
> -	fd4 = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE);
> -	if (fd4 == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
> -			 TEMP_FILE, FILE_MODE);
> -	}
> -
> -	/* Creat a symbolic link for temporary file */
> -	if (symlink(TEMP_FILE, SYM_FILE) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "symlink(%s, %s) failed", TEMP_FILE, SYM_FILE);
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * access_verify(i) -
> - *
> - *	This function verify the accessibility of the
> - *	the testfile with the one verified by access().
> - */
> -static int access_verify(int i)
> -{
> -	char write_buf[] = "abc";
> -	char read_buf[BUFSIZ];
> -	int rval;
> +	fds[0] = SAFE_OPEN(FNAME_R, O_RDWR | O_CREAT, 0777);
> +	fds[1] = SAFE_OPEN(FNAME_W, O_RDWR | O_CREAT, MODE_W);
> +	fds[2] = SAFE_OPEN(FNAME_X, O_RDWR | O_CREAT, 0777);
>  
> -	rval = 0;
> +	SAFE_WRITE(1, fds[0], "A", 1);
> +#ifdef UCLINUX
> +	SAFE_WRITE(1, fds[2], exechead, sizeof(exechead));
> +#endif

Here as well.

> -	switch (i) {
> -	case 0:
> -		/*
> -		 * The specified file has read access.
> -		 * Attempt to read some data from the testfile
> -		 * and if successful, access() behaviour is
> -		 * correct.
> -		 */
> -		rval = read(fd1, &read_buf, sizeof(read_buf));
> -		if (rval == -1)
> -			tst_resm(TFAIL | TERRNO, "read(%s) failed", TEST_FILE1);
> -		break;
> -	case 1:
> -		/*
> -		 * The specified file has write access.
> -		 * Attempt to write some data to the testfile
> -		 * and if successful, access() behaviour is correct.
> -		 */
> -		rval = write(fd2, write_buf, strlen(write_buf));
> -		if (rval == -1)
> -			tst_resm(TFAIL | TERRNO, "write(%s) failed",
> -				 TEST_FILE2);
> -		break;
> -	case 2:
> -		/*
> -		 * The specified file has execute access.
> -		 * Attempt to execute the specified executable
> -		 * file, if successful, access() behaviour is correct.
> -		 */
> -		rval = system("./" TEST_FILE3);
> -		if (rval != 0)
> -			tst_resm(TFAIL, "Fail to execute the %s", TEST_FILE3);
> -		break;
> -	case 3:
> -		/*
> -		 * The file pointed to by symbolic link has
> -		 * write access.
> -		 * Attempt to write some data to this temporary file
> -		 * pointed to by symlink. if successful, access() bahaviour
> -		 * is correct.
> -		 */
> -		rval = write(fd4, write_buf, strlen(write_buf));
> -		if (rval == -1)
> -			tst_resm(TFAIL | TERRNO, "write(%s) failed", TEMP_FILE);
> -		break;
> -	default:
> -		break;
> -	}
> +	SAFE_CLOSE(fds[2]);
> +	fds[2] = 0;

You don't have to set the fd to 0 here. The SAFE_CLOSE() sets it to -1
upon return.

> -	return rval;
> +	SAFE_CHMOD(FNAME_R, MODE_R);
> +	SAFE_CHMOD(FNAME_X, MODE_X);
>  }

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
