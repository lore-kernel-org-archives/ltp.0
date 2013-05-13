Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UbqAO-0005vL-Pj
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 10:39:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UbqAL-0000If-S6
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 10:39:40 +0000
Message-ID: <5190C255.2090402@cn.fujitsu.com>
Date: Mon, 13 May 2013 18:37:09 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <519052E3.9040801@cn.fujitsu.com>
	<20130513082625.GL2460@eguan-t400.nay.redhat.com>
In-Reply-To: <20130513082625.GL2460@eguan-t400.nay.redhat.com>
Subject: Re: [LTP] [PATCH 1/2]mount/mount03.c: cleanup
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
To: Eryu Guan <eguan@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/13/2013 04:26 PM, Eryu Guan wrote:
> On Mon, May 13, 2013 at 10:41:39AM +0800, DAN LI wrote:
>>
>> 1. Remove useless comments
>>
>> 2. Revise code to follow ltp-code-style
>>
>> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/mount/mount03.c | 208 +++++++++++++-----------------
>>  1 file changed, 89 insertions(+), 119 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
>> index 04570b9..ea4b0e9 100644
>> --- a/testcases/kernel/syscalls/mount/mount03.c
>> +++ b/testcases/kernel/syscalls/mount/mount03.c
>> @@ -14,10 +14,8 @@
>>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>   *
>>   */
>> -/**************************************************************************
>> - *
>> - *    TEST IDENTIFIER	: mount03
>> - *
>> +
>> +/*
>>   *    EXECUTED BY	: root / superuser
>>   *
>>   *    TEST TITLE	: Test for checking mount(2) flags
>> @@ -26,10 +24,6 @@
>>   *
>>   *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
>>   *
>> - *    SIGNALS
>> - * 	Uses SIGUSR1 to pause before test if option set.
>> - * 	(See the parse_opts(3) man page).
>> - *
>>   *    DESCRIPTION
>>   *	Check for basic mount(2) system call flags.
>>   *
>> @@ -42,13 +36,13 @@
>>   *	5) MS_REMOUNT - alter flags of a mounted FS.
>>   *	6) MS_NOSUID - ignore suid and sgid bits.
>>   *
>> - * 	Setup:
>> + *	Setup:
>>   *	  Setup signal handling.
>>   *	  Create a mount point.
>>   *	  Pause for SIGUSR1 if option specified.
>>   *
>> - * 	Test:
>> - *	 Loop if the proper options are given.
>> + *	Test:
>> + *	  Loop if the proper options are given.
>>   *	  Execute mount system call for each flag
>>   *	  Validate each flag setting. if validation fails
>>   *		Delete the mount point.
>> @@ -56,22 +50,10 @@
>>   *	  Delete the mount point.
>>   *	  Otherwise, Issue a PASS message.
>>   *
>> - * 	Cleanup:
>> - * 	  Print errno log and/or timing stats if options given
>> + *	Cleanup:
>> + *	  Print errno log and/or timing stats if options given
>>   *	  Delete the temporary directory(s)/file(s) created.
>>   *
>> - * USAGE:  <for command-line>
>> - *  mount03 [-T type] -D device [-e] [-i n] [-I x] [-p x] [-t]
>> - *			where,  -T type : specifies the type of filesystem to
>> - *					  be mounted. Default ext2.
>> - *				-D device : device to be mounted.
>> - *				-e   : Turn on errno logging.
>> - *				-i n : Execute test n times.
>> - *				-I x : Execute test for x seconds.
>> - *				-p   : Pause for SIGUSR1 before starting
>> - *				-P x : Pause for x seconds between iterations.
>> - *				-t   : Turn on syscall timing.
>> - *
>>   * RESTRICTIONS
>>   *	test must run with the -D option
>>   *	test doesn't support -c option to run it in parallel, as mount
>> @@ -102,30 +84,29 @@ static int setup_uid(void);
>>
>>  char *TCID = "mount03";
>>  int TST_TOTAL = 6;
>> -extern char **environ;		/* pointer to this processes env */
>>
>>  #define DEFAULT_FSTYPE	"ext2"
>>  #define TEMP_FILE	"temp_file"
>>  #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
>> -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)
>> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|\
> 						       ^^^^ I'd like a space here, | \

Agreed.

>> +			 S_IXGRP|S_IROTH|S_IXOTH)
>>  #define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)
>>
>> -static char *Fstype;
>> +static char *fs_type;
>>
>>  static char mntpoint[20];
>>  static char *fstype;
>>  static char *device;
>> -static int Tflag = 0;
>> -static int Dflag = 0;
>> -
>> -static char write_buffer[BUFSIZ];	/* buffer used to write data to file */
>> -static char read_buffer[BUFSIZ];	/* buffer used to read data from file */
>> -static int fildes;		/* file descriptor for temporary file */
>> -static char *Cmd_buffer[3];	/* Buffer to hold command string */
>> -static char Path_name[PATH_MAX];	/* Buffer to hold command string */
>> -static char testhome_path[PATH_MAX];	/* Test home Path                */
>> -static char file[PATH_MAX];	/* Temporary file                */
>> -static char cmd[] = "cp";
>> +static int tflag;
>> +static int dflag;
>> +
>> +static char write_buffer[BUFSIZ];
>> +static char read_buffer[BUFSIZ];
>> +static int fildes;
> 
> move this up and put all int vars together?

Agreed.

>> +static char path_name[PATH_MAX];
>> +static char testhome_path[PATH_MAX];
>> +static char file[PATH_MAX];
>> +static char *cmd = "cp";
>>
>>  long rwflags[] = {
>>  	MS_RDONLY,
>> @@ -136,41 +117,41 @@ long rwflags[] = {
>>  	MS_NOSUID,
>>  };
>>
>> -static option_t options[] = {	/* options supported by mount03 test */
>> -	{"T:", &Tflag, &fstype},	/* -T type of filesystem        */
>> -	{"D:", &Dflag, &device},	/* -D device used for mounting  */
>> +static option_t options[] = {
>> +	{"T:", &tflag, &fstype},
>> +	{"D:", &dflag, &device},
>>  	{NULL, NULL, NULL}
>>  };
>>
>> -int main(int ac, char **av)
>> +int main(int argc, char *argv[])
>>  {
>>  	int lc, i;
>>  	char *msg;
>>
>> -	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
>> +	msg = parse_opts(argc, argv, options, &help);
>> +	if (msg != NULL)
>>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>>
>>  	/* Check for mandatory option of the testcase */
>> -	if (!Dflag) {
>> +	if (!dflag)
>>  		tst_brkm(TBROK, NULL,
>>  			 "you must specify the device used for mounting with -D "
>>  			 "option");
>> -	}
>>
>> -	if (Tflag) {
>> -		Fstype = (char *)malloc(strlen(fstype) + 1);
>> -		if (Fstype == NULL) {
>> +	if (tflag) {
>> +		fs_type = (char *)malloc(strlen(fstype) + 1);
>                           ^^^^^^^^ not sure if we really need a cast for malloc
> 

It's a watch point in C++, but for C, maybe better to cut the cast.

>> +		if (fs_type == NULL)
>>  			tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
>> -		}
>> -		Fstype[strlen(fstype)] = '\0';
>> -		strncpy(Fstype, fstype, strlen(fstype));
>> +
>> +		fs_type[strlen(fstype)] = '\0';
>> +		strncpy(fs_type, fstype, strlen(fstype));
>>  	} else {
>> -		Fstype = (char *)malloc(strlen(DEFAULT_FSTYPE) + 1);
>> -		if (Fstype == NULL) {
>> +		fs_type = (char *)malloc(strlen(DEFAULT_FSTYPE) + 1);
>> +		if (fs_type == NULL)
>>  			tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
>> -		}
>> -		strncpy(Fstype, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE));
>> -		Fstype[strlen(DEFAULT_FSTYPE)] = '\0';
>> +
>> +		strncpy(fs_type, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE));
>> +		fs_type[strlen(DEFAULT_FSTYPE)] = '\0';
>>  	}
>>
>>  	if (STD_COPIES != 1) {
>> @@ -189,7 +170,8 @@ int main(int ac, char **av)
>>  		for (i = 0; i < TST_TOTAL; ++i) {
>>
>>  			/* Call mount(2) */
>> -			TEST(mount(device, mntpoint, Fstype, rwflags[i], NULL));
>> +			TEST(mount(device, mntpoint, fs_type,
>> +						rwflags[i], NULL));
> indent like this?
>   			TEST(mount(device, mntpoint, fs_type, rwflags[i],
> 				   NULL));

Agreed.

>>
>>  			/* check return code */
>>  			if (TEST_RETURN != 0) {
>> @@ -198,22 +180,20 @@ int main(int ac, char **av)
>>  			}
>>
>>  			/* Validate the rwflag */
>> -			if (test_rwflag(i, lc) == 1) {
>> +			if (test_rwflag(i, lc) == 1)
>>  				tst_resm(TFAIL, "mount(2) failed while"
>>  					 " validating %ld", rwflags[i]);
>> -			} else {
>> +			else
>>  				tst_resm(TPASS, "mount(2) passed with "
>>  					 "rwflag = %ld", rwflags[i]);
>> -			}
>> +
>>  			TEST(umount(mntpoint));
>> -			if (TEST_RETURN != 0) {
>> +			if (TEST_RETURN != 0)
>>  				tst_brkm(TBROK | TTERRNO, cleanup,
>>  					 "umount(2) failed for %s", mntpoint);
>> -			}
>>  		}
>>  	}
>>
>> -	/* cleanup and exit */
>>  	cleanup();
>>
>>  	tst_exit();
>> @@ -234,8 +214,9 @@ int test_rwflag(int i, int cnt)
>>  	case 0:
>>  		/* Validate MS_RDONLY flag of mount call */
>>
>> -		snprintf(file, PATH_MAX, "%stmp", Path_name);
>> -		if ((fd = open(file, O_CREAT | O_RDWR, S_IRWXU)) == -1) {
>> +		snprintf(file, PATH_MAX, "%stmp", path_name);
>> +		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
>> +		if (fd == -1) {
>>  			if (errno == EROFS) {
>>  				return 0;
>>  			} else {
>> @@ -249,10 +230,11 @@ int test_rwflag(int i, int cnt)
>>  	case 1:
>>  		/* Validate MS_NODEV flag of mount call */
>>
>> -		snprintf(file, PATH_MAX, "%smynod_%d_%d", Path_name, getpid(),
>> +		snprintf(file, PATH_MAX, "%smynod_%d_%d", path_name, getpid(),
>>  			 cnt);
>>  		if (mknod(file, S_IFBLK | 0777, 0) == 0) {
>> -			if ((fd = open(file, O_RDWR, S_IRWXU)) == -1) {
>> +			fd = open(file, O_RDWR, S_IRWXU);
>> +			if (fd == -1) {
>>  				if (errno == EACCES) {
>>  					return 0;
>>  				} else {
>> @@ -271,8 +253,9 @@ int test_rwflag(int i, int cnt)
>>  	case 2:
>>  		/* Validate MS_NOEXEC flag of mount call */
>>
>> -		snprintf(file, PATH_MAX, "%stmp1", Path_name);
>> -		if ((fd = open(file, O_CREAT | O_RDWR, S_IRWXU)) == -1) {
>> +		snprintf(file, PATH_MAX, "%stmp1", path_name);
>> +		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
>> +		if (fd == -1) {
>>  			tst_resm(TWARN | TERRNO, "opening %s failed", file);
>>  		} else {
>>  			close(fd);
>> @@ -288,9 +271,9 @@ int test_rwflag(int i, int cnt)
>>  		strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
>>
>>  		/* Creat a temporary file under above directory */
>> -		snprintf(file, PATH_MAX, "%s%s", Path_name, TEMP_FILE);
>> -		if ((fildes = open(file, O_RDWR | O_CREAT, FILE_MODE))
>> -		    == -1) {
>> +		snprintf(file, PATH_MAX, "%s%s", path_name, TEMP_FILE);
>> +		fildes = open(file, O_RDWR | O_CREAT, FILE_MODE);
>> +		if (fildes == -1) {
>>  			tst_resm(TWARN | TERRNO,
>>  				 "open(%s, O_RDWR|O_CREAT, %#o) failed",
>>  				 file, FILE_MODE);
>> @@ -333,14 +316,14 @@ int test_rwflag(int i, int cnt)
>>  	case 4:
>>  		/* Validate MS_REMOUNT flag of mount call */
>>
>> -		TEST(mount(device, mntpoint, Fstype, MS_REMOUNT, NULL));
>> +		TEST(mount(device, mntpoint, fs_type, MS_REMOUNT, NULL));
>>  		if (TEST_RETURN != 0) {
>>  			tst_resm(TWARN | TTERRNO, "mount(2) failed to remount");
>>  			return 1;
>>  		} else {
>> -			snprintf(file, PATH_MAX, "%stmp2", Path_name);
>> -			if ((fd = open(file, O_CREAT | O_RDWR, S_IRWXU))
>> -			    == -1) {
>> +			snprintf(file, PATH_MAX, "%stmp2", path_name);
>> +			fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
>> +			if (fd == -1) {
>>  				tst_resm(TWARN, "open(%s) on readonly "
>>  					 "filesystem passed", file);
>>  				return 1;
>> @@ -356,23 +339,23 @@ int test_rwflag(int i, int cnt)
>>  			tst_resm(TBROK | TERRNO, "setup_uid failed");
>>  			return 1;
>>  		}
>> -		switch (pid = fork()) {
>> +		pid = fork();
>> +		switch (pid) {
>>  		case -1:
>>  			tst_resm(TBROK | TERRNO, "fork failed");
>>  			return 1;
>>  		case 0:
>> -			snprintf(file, PATH_MAX, "%ssetuid_test", Path_name);
>> -			if (chmod(file, SUID_MODE) != 0) {
>> +			snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
>> +			if (chmod(file, SUID_MODE) != 0)
>>  				tst_resm(TWARN, "chmod(%s, %#o) failed",
>>  					 file, SUID_MODE);
>> -			}
>>
>>  			ltpuser = getpwnam(nobody_uid);
>> -			if (setreuid(ltpuser->pw_uid, ltpuser->pw_uid) == -1) {
>> +			if (setreuid(ltpuser->pw_uid, ltpuser->pw_uid) == -1)
>>  				tst_resm(TWARN | TERRNO,
>>  					 "seteuid() failed to change euid to %d",
>>  					 ltpuser->pw_uid);
>> -			}
>> +
>>  			execlp(file, basename(file), NULL);
>>  			exit(1);
>>  		default:
>> @@ -395,24 +378,21 @@ int setup_uid()
>>  	int pid, status;
>>  	char command[PATH_MAX];
>>
>> -	switch (pid = fork()) {
>> +	pid = fork();
>> +	switch (pid) {
>>  	case -1:
>>  		tst_resm(TWARN | TERRNO, "fork failed");
>>  		return 1;
>>  	case 0:
>> -		Cmd_buffer[0] = cmd;
>> -		Cmd_buffer[1] = testhome_path;
>> -		Cmd_buffer[2] = Path_name;
>> -
>>  		/* Put command into string */
>> -		sprintf(command, "%s %s %s", cmd, testhome_path, Path_name);
>> +		sprintf(command, "%s %s %s", cmd, testhome_path, path_name);
>>
>>  		/* Run command to cp file to right spot */
>> -		if (system(command) == 0) {
>> +		if (system(command) == 0)
>>  			execlp(file, basename(file), NULL);
>> -		} else {
>> +		else
>>  			printf("call to %s failed\n", command);
>> -		}
>> +
>>  		exit(1);
>>  	default:
>>  		waitpid(pid, &status, 0);
>> @@ -428,17 +408,16 @@ int setup_uid()
>>  	}
>>  }
>>
>> -/* setup() - performs all ONE TIME setup for this test */
>>  void setup()
>>  {
>> -	char *test_home;	/* variable to hold TESTHOME env */
>> +	char *test_home;
>>  	struct stat setuid_test_stat;
>>
>>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>>
>>  	/* Check whether we are root */
>>  	if (geteuid() != 0) {
>> -		free(Fstype);
>> +		free(fs_type);
>>  		tst_brkm(TBROK, NULL, "Test must be run as root");
>>  	}
>>
>> @@ -451,38 +430,37 @@ void setup()
>>  	/* Unique mount point */
>>  	(void)sprintf(mntpoint, "mnt_%d", getpid());
>>
>> -	if (mkdir(mntpoint, DIR_MODE)) {
>> +	if (mkdir(mntpoint, DIR_MODE))
>>  		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
>>  			 mntpoint, DIR_MODE);
>> -	}
>> +
>>  	/* Get the current working directory of the process */
>> -	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
>> +	if (getcwd(path_name, sizeof(path_name)) == NULL)
>>  		tst_brkm(TBROK, cleanup, "getcwd failed");
>> -	}
>> -	if (chmod(Path_name, DIR_MODE) != 0) {
>> +
>> +	if (chmod(path_name, DIR_MODE) != 0)
>>  		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
>> -			 Path_name, DIR_MODE);
>> -	}
>> -	snprintf(file, PATH_MAX, "%ssetuid_test", Path_name);
>> +			 path_name, DIR_MODE);
>> +
>> +	snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
>>  	if (stat(file, &setuid_test_stat) < 0) {
>>  		tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
>>  	} else {
>>  		if ((setuid_test_stat.st_uid || setuid_test_stat.st_gid) &&
>> -		    chown(file, 0, 0) < 0) {
>> +		    chown(file, 0, 0) < 0)
>>  			tst_brkm(TBROK, cleanup,
>>  				 "chown for setuid_test failed");
>> -		}
>> +
>>  		if (setuid_test_stat.st_mode != SUID_MODE &&
>> -		    chmod(file, SUID_MODE) < 0) {
>> +		    chmod(file, SUID_MODE) < 0)
>>  			tst_brkm(TBROK, cleanup,
>>  				 "setuid for setuid_test failed");
>> -		}
>>  	}
>>
>>  	/*
>>  	 * under temporary directory
>>  	 */
>> -	snprintf(Path_name, PATH_MAX, "%s/%s/", Path_name, mntpoint);
>> +	snprintf(path_name, PATH_MAX, "%s/%s/", path_name, mntpoint);
>>
>>  	strcpy(testhome_path, test_home);
>>  	strcat(testhome_path, "/setuid_test");
>> @@ -491,18 +469,10 @@ void setup()
>>
>>  }
>>
>> -/*
>> - *cleanup() -  performs all ONE TIME cleanup for this test at
>> - *		completion or premature exit.
>> - */
>>  void cleanup()
>>  {
>> -	free(Fstype);
>> +	free(fs_type);
>>
>> -	/*
>> -	 * print timing stats if that option was specified.
>> -	 * print errno log if that option was specified.
>> -	 */
>>  	TEST_CLEANUP;
>>
>>  	tst_rmdir();
>> @@ -514,6 +484,6 @@ void cleanup()
>>  void help()
>>  {
>>  	printf("-T type	  : specifies the type of filesystem to be mounted."
>> -	       " Default ext2. \n");
>> -	printf("-D device : device used for mounting \n");
>> +	       "Default ext2.\n");
>                ^^ we need a space here otherwise the output will be:
> 	       "... to be mounted.Default ext2."
> 	                       ^^^^^ no space
> 

But it seems that checkpatch.pl do not agree it.
I'will check it.

Thanks for reviewing.
DAN LI

> Thanks for the cleanup!
> 
> Eryu Guan
>> +	printf("-D device : device used for mounting\n");
>>  }
>> -- 
>> 1.8.3
>>
>> ------------------------------------------------------------------------------
>> Learn Graph Databases - Download FREE O'Reilly Book
>> "Graph Databases" is the definitive new guide to graph databases and 
>> their applications. This 200-page book is written by three acclaimed 
>> leaders in the field. The early access version is available now. 
>> Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
