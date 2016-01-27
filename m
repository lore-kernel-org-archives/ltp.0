From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jan 2016 15:02:53 +0300
Subject: [LTP] [PATCH] kernel/syscalls: add new test with 'open() +
 O_TMPFILE'
In-Reply-To: <20160126162442.GA21691@rei.lan>
References: <1451471611-17666-1-git-send-email-alexey.kodanev@oracle.com>
 <20160126162442.GA21691@rei.lan>
Message-ID: <56A8B1ED.3080205@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 01/26/2016 07:24 PM, Cyril Hrubis wrote:
> Hi!
>> +char *TCID = "open14";
>> +int TST_TOTAL = 1;
>> +static char *test_dir;
>> +static ssize_t size;
>> +static const ssize_t blocks_num = 4;
>> +static char *buf;
>> +static struct stat st;
>> +
>> +static void cleanup(void)
>> +{
>> +	tst_rmdir();
>> +	free(test_dir);
>> +	free(buf);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	tst_tmpdir();
>> +	test_dir = tst_get_tmpdir();
>> +
>> +	SAFE_STAT(cleanup, test_dir, &st);
>> +	size = st.st_blksize;
> Any reason why we cannot use relative path to the test directory, which
> sould be "." while the test runs?

Right, will change to ".", there is no reason for absolute path.

>> +	SAFE_FSTAT(cleanup, fd, &st);
>> +	tst_resm(TINFO, "file size is '%zu'", st.st_size);
>> +
>> +	if (st.st_size != blocks_num * size) {
>> +		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
>> +			 st.st_size, blocks_num * size);
>> +		SAFE_CLOSE(cleanup, fd);
>> +		return;
>> +	}
>> +
>> +	tst_resm(TINFO, "looking for the file in '%s'", test_dir);
>> +	if (dir_not_empty())
>> +		tst_brkm(TBROK, cleanup, "found a file, this is not expected");
>> +	tst_resm(TINFO, "file not found, OK");
>> +
>> +	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
>> +	if (readlink(path, tmp, PATH_MAX) == -1)
>> +		tst_brkm(TBROK | TERRNO, cleanup, "readlink() failed");
>> +
>> +	tst_resm(TINFO, "renaming '%s' -> '%s/tmpfile'",
>> +		 tmp, test_dir);
>> +	if (linkat(AT_FDCWD, path, AT_FDCWD, "tmpfile", AT_SYMLINK_FOLLOW))
>> +		tst_brkm(TBROK | TERRNO, cleanup, "linkat() failed");
> We may add SAFE_LINKAT().

Agree.

>
>> +
>> +static int dir_not_empty(void)
>> +{
>> +	struct dirent *entry;
>> +	DIR *dir = SAFE_OPENDIR(cleanup, test_dir);
>> +	int ret = 0;
>> +
>> +	while ((entry = SAFE_READDIR(cleanup, dir)) != NULL) {
>> +		const char *file = entry->d_name;
>> +
>> +		if (!strcmp(file, "..") || !strcmp(file, "."))
>> +			continue;
>> +
>> +		tst_resm(TINFO, "found a file: %s", file);
>> +		ret = 1;
>> +		break;
>> +	}
>> +
>> +	SAFE_CLOSEDIR(cleanup, dir);
>> +	return ret;
>> +}
> Maybe we should add this function to a library, since it's used at two
> places allready.

OK, tst_dir_is_empty(dir) is fine?

Thanks,
Alexey

