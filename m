Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwZ5t-0000Mq-8Y
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 14:40:41 +0000
Date: Tue, 9 Jul 2013 16:42:18 +0200
From: chrubis@suse.cz
Message-ID: <20130709144218.GA516@rei.Home>
References: <51D27187.2060003@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D27187.2060003@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] mount/mount03.c: clean up
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Clean up mount03.c:
>     xxx func() -> xxx func(void)
> 
>     clean up setup()
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Sorry it took longer than usuall.

>  testcases/kernel/syscalls/mount/mount03.c | 47 ++++++++++---------------------
>  1 file changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
> index b1aa71f..8b2d3e4 100644
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -85,6 +85,7 @@ static int setup_uid(void);
>  char *TCID = "mount03";
>  int TST_TOTAL = 6;
> 
> +#define EXEC_COMMAND	"cp"
>  #define DEFAULT_FSTYPE	"ext2"
>  #define TEMP_FILE	"temp_file"
>  #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
> @@ -106,7 +107,6 @@ static char read_buffer[BUFSIZ];
>  static char path_name[PATH_MAX];
>  static char testhome_path[PATH_MAX];
>  static char file[PATH_MAX];
> -static char *cmd = "cp";
> 
>  long rwflags[] = {
>  	MS_RDONLY,
> @@ -375,7 +375,7 @@ int test_rwflag(int i, int cnt)
>  }
> 
>  /* setup_uid() - performs setup for NOUID test */
> -int setup_uid()
> +int setup_uid(void)
>  {
>  	int pid, status;
>  	char command[PATH_MAX];
> @@ -387,7 +387,8 @@ int setup_uid()
>  		return 1;
>  	case 0:
>  		/* Put command into string */
> -		sprintf(command, "%s %s %s", cmd, testhome_path, path_name);
> +		sprintf(command, "%s %s %s",
> +			EXEC_COMMAND, testhome_path, path_name);
> 
>  		/* Run command to cp file to right spot */
>  		if (system(command) == 0)

What about using SAFE_CP() from safe_file_ops.h?

> @@ -410,25 +411,17 @@ int setup_uid()
>  	}
>  }
> 
> -void setup()
> +void setup(void)
>  {
> -	int fd;
>  	char path[PATH_MAX];
> -	char *test_home;
>  	struct stat setuid_test_stat;
> 
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> 
> -	/* Check whether we are root */
> -	if (geteuid() != 0) {
> -		free(fs_type);
> -		tst_brkm(TBROK, NULL, "Test must be run as root");
> -	}
> +	tst_require_root(NULL);
> 
>  	tst_tmpdir();
> 
> -	test_home = get_current_dir_name();
> -
>  	sprintf(mntpoint, "mnt_%d", getpid());

This getpid() shouldn't be needed as we are in the test tmpdir anyway.

>  	if (mkdir(mntpoint, DIR_MODE))
> @@ -444,38 +437,28 @@ void setup()
>  			 path_name, DIR_MODE);
> 
>  	snprintf(file, PATH_MAX, "%s/setuid_test", path_name);
> -	fd = open(file, O_CREAT | O_TRUNC, S_IRWXU);
> -	if (fd == -1)
> +	if (open(file, O_CREAT | O_TRUNC, S_IRWXU) == -1)
>  		tst_brkm(TBROK, cleanup, "open file failed");
> -	close(fd);

Why removing the close(fd)?

> -	if (stat(file, &setuid_test_stat) < 0) {
> +	if (stat(file, &setuid_test_stat) < 0)
>  		tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
> -	} else {
> -		if ((setuid_test_stat.st_uid || setuid_test_stat.st_gid) &&
> -		    chown(file, 0, 0) < 0)
> -			tst_brkm(TBROK, cleanup,
> -				 "chown for setuid_test failed");
> -
> -		if (setuid_test_stat.st_mode != SUID_MODE &&
> -		    chmod(file, SUID_MODE) < 0)
> -			tst_brkm(TBROK, cleanup,
> -				 "setuid for setuid_test failed");
> -	}
> +
> +	if (setuid_test_stat.st_mode != SUID_MODE && chmod(file, SUID_MODE) < 0)
> +		tst_brkm(TBROK, cleanup,
> +			 "setuid for setuid_test failed");
                            ^
			    This could now be one line statement if I'm
			    not mistaken

>  	/*
>  	 * under temporary directory
>  	 */
> +	strcpy(testhome_path, file);
>  	strncpy(path, path_name, PATH_MAX);
>  	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
> -	strcpy(testhome_path, test_home);
> -	strcat(testhome_path, "/setuid_test");
> 
>  	TEST_PAUSE;
> 
>  }
> 
> -void cleanup()
> +void cleanup(void)
>  {
>  	free(fs_type);
> 
> @@ -487,7 +470,7 @@ void cleanup()
>  /*
>   * issue a help message
>   */
> -void help()
> +void help(void)
>  {
>  	printf("-T type	  : specifies the type of filesystem to be mounted."
>  	       " Default ext2.\n");
> -- 

Also please make all internal functions static.

And pretty please remove the absurd fs_type flag allocation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
