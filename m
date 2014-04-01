Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WV1Ku-0003AL-Ns
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 16:14:52 +0000
Date: Tue, 1 Apr 2014 18:14:14 +0200
From: chrubis@suse.cz
Message-ID: <20140401161414.GA13696@rei.suse.cz>
References: <1394352758.2346.2.camel@G08JYZSD130126>
	<1394352845.2346.4.camel@G08JYZSD130126>
	<20140311154349.GF10778@rei>
	<1394716096.2087.10.camel@G08JYZSD130126>
	<1394716306.2087.14.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394716306.2087.14.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 4/4] open/open12.c: add new tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +static void setup(void)
> +{
> +       tst_require_root(NULL);
> +
> +       TEST_PAUSE;
> +        
> +       tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +       if (test_subexe[0] != '/') {
> +               sprintf(test_path, "%s/%s", get_current_dir_name(),
> +                       basename(test_subexe));
> +               test_subexe = test_path;
> +       }

This is plain wrong. The path to the test helpers MUST be in $PATH so
the test can do just:

	if (execl("open12_cloexec", "open12_cloexec", buf, NULL)) {
		...
	}

If you wan't to run the test from git checkout do:

PATH="$PATH:$PWD" ./test

(It's all written in the Test-Writing-Guidelines)

> +       if (device != NULL && device[0] != '/') {
> +               sprintf(test_path2, "%s/%s", get_current_dir_name(),
> +                       basename(device));
> +               device = test_path2;
> +       }

This is wrong too. If you need a big device you should utilize path
stored in LTP_BIG_DEV env variable. And ideally skip particular testcase
if it's not set.

> +static void test_noatime(void)
> +{
> +	FILE *mtab_f;
> +	struct mntent *entry;
> +	char read_buf;
> +	struct stat orignal, flag, no_flag;
> +
> +	if ((tst_kvercmp(2, 6, 9)) < 0) {
> +		tst_resm(TCONF,
> +			 "O_NOATIME flags test for open(2) needs kernel 2.6.9 "
> +			 "or higher");
> +		return;
> +	}
> +
> +	mtab_f = setmntent("/etc/mtab", "r");
> +	entry = getmntent(mtab_f);
> +	if (hasmntopt(entry, "noatime") != NULL ||
> +	    hasmntopt(entry, "relatime") != NULL) {
> +		tst_resm(TCONF,
> +			 "O_NOATIME flags test for open(2) needs filesystems "
> +			 "which are mounted without noatime and relatime");
> +		return;
> +	}
> +	endmntent(mtab_f);

This part should use the library function I've proposed for the openat()
testcase.

Also note that this snippet is not corret because it check first entry
in mtab which may not be mountpoint the LTP tmp is mounted to. You have
to find the right one first.

> +	SAFE_STAT(cleanup, TEST_FILE, &orignal);
> +
> +	sleep(1);
> +
> +	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY | O_NOATIME);
> +	SAFE_READ(cleanup, 1, fd, &read_buf, 1);
> +	SAFE_CLOSE(cleanup, fd);
> +	SAFE_STAT(cleanup, TEST_FILE, &flag);
> +
> +	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
> +	SAFE_READ(cleanup, 1, fd, &read_buf, 1);
> +	SAFE_CLOSE(cleanup, fd);
> +	SAFE_STAT(cleanup, TEST_FILE, &no_flag);
> +
> +	if (orignal.st_atime == flag.st_atime &&
> +	    orignal.st_atime != no_flag.st_atime)
> +		tst_resm(TPASS, "open(%s, O_NOATIME) test success", TEST_FILE);
> +	else
> +		tst_resm(TFAIL, "open(%s, O_NOATIME) test failed", TEST_FILE);
> +}
> +
> +static void test_cloexec(void)
> +{
> +	int fd2;
> +	pid_t pid;
> +	int status;
> +	char buf[20];
> +
> +	if ((tst_kvercmp(2, 6, 24)) < 0) {
> +		tst_resm(TCONF,
> +			 "O_CLOEXEC flags test for open(2) needs kernel 2.6.24 "
> +			 "or higher");
> +		return;
> +	}
> +
> +	fd2 = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_APPEND | O_CLOEXEC);
> +
> +	sprintf(buf, "%d", fd2);
> +	pid = tst_fork();
> +	if (pid < 0)
> +		tst_brkm(TBROK, cleanup, "fork() failed");
> +
> +	if (pid == 0) {
> +		if (execl(test_subexe, "open12_cloexec", buf, NULL)) {
> +			printf("execl error\n");
> +			exit(-2);
> +		}
> +	}
> +
> +	SAFE_CLOSE(cleanup, fd2);
> +
> +	if (wait(&status) != pid)
> +		printf("wait error\n");
> +
> +	if (WIFEXITED(status) && (char)WEXITSTATUS(status) == -1)

The cast to char is suspicious, did you get warnings without it?

Note that char may or may not be signed (accordingly to C standard), for
unsigned char the value, after the case, could not be negative.

> +		tst_resm(TPASS, "open(%s, O_CLOEXEC) test success", TEST_FILE);
> +	else
> +		tst_resm(TFAIL, "open(%s, O_CLOEXEC) test failed", TEST_FILE);
> +}
> +
> +static void test_largefile(void)
> +{
> +	struct stat buf;
> +
> +	if (!device) {
> +		tst_resm(TCONF,
> +			 "O_LARGEFILE flags test for open(2) needs specify the "
> +			 "-D option.");
> +		return;
> +	}
> +
> +	SAFE_STAT(cleanup, device, &buf);
> +	if (buf.st_size < 4L * 1024 * 1024 * 1024) {
> +		tst_resm(TCONF,
> +			 "O_LARGEFILE flags test for open(2) needs the file "
> +			 "which size is more than 4G.");
> +		return;
> +	}
> +
> +	TEST(open(device, O_RDONLY | O_LARGEFILE));
> +	SAFE_CLOSE(cleanup, TEST_RETURN);
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TPASS, "open(%s, O_LARGEFILE) test success", device);
> +	} else {
> +		tst_resm(TFAIL | TTERRNO,
> +			 "open(%s, O_LARGEFILE) failed unexpectedly", device);
> +	}
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
