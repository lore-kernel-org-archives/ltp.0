Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24301C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 07:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FD563C9EDD
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 08:49:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 669C73C3206
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:49:18 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89BB42003AB
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:49:14 +0100 (CET)
X-QQ-mid: bizesmtp66t1644997750tff4n1aa
Received: from [10.4.23.188] (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 16 Feb 2022 15:49:07 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000C00A0000000
X-QQ-FEAT: +dJSz0EskzsXbMGxwo8HWbfYygmjzHM2mnZufouz46DuXc4vH4xSA5+jjZHYR
 LGnuzKuf6vqjjRC1j+vPDdpVLINSMrirQwAb8HOmMCiN/NCzLoimf4au5hPW0rmtO5aKXUh
 0d1ev9cVgFbaWDi84bP1wzyRnhHmIquwEJdMnAIFpJ5XUtwmX20FFB298ekLUJc+oTKyfgP
 iqkxNEAqDsVzpNpVSR8bT259XDoNT0EOTyHTJ/16GnS6NTfJkjBL79yt2Iw0c28CE2xASRx
 btxSQtgz0/IMywoFmb2t2+uqnfL8AKrW35uqjV3Jy4R9JnuTXgn86K8cojBexqxw6g1/2Hf
 mywc0OPPBbH+r6fH4ZyWZxL+VW/rg==
X-QQ-GoodBg: 2
Message-ID: <7b228343-07e0-26f8-cc57-26940da9b156@uniontech.com>+A2A6D7B75680253E
Date: Wed, 16 Feb 2022 15:49:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211119071723.19836-1-tangmeng@uniontech.com>
 <YfQQqOyJ6zW3fo+F@yuki>
From: tangmeng <tangmeng@uniontech.com>
In-Reply-To: <YfQQqOyJ6zW3fo+F@yuki>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fchmodat_01: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 2022/1/28 23:50, Cyril Hrubis wrote:
> Hi!
> 
> We usually pack the syscall parameters into a tcase structure, which is
> much easier to read and modify:
> 
> ...
> static int dir_at_fdcwd = AT_FDCWD;
> static int file_fd;
> static char testfile1[PATH_MAX];
> 
> static struct tcase {
> 	int *dir_fd;
> 	char filename;
> 	mode_t mode;
> 	int exp_err;
> } tcases[] = {
> 	...
> 	{&file_fd, testfile1, 0600, ENOTDIR},
> 	...
> };
> 
>>   int myfchmodat(int dirfd, const char *filename, mode_t mode)
>>   {
>> -	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
>> +	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
>>   }
> 
> This function is now unused.
> 
>> -int main(int ac, char **av)
>> +static void verify_fchmodat(unsigned int i)
>>   {
>> -	int lc;
>> -	int i;
>> -
>> -	/* Disable test if the version of the kernel is less than 2.6.16 */
>> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
>> -		tst_resm(TWARN, "This test can only run on kernels that are ");
>> -		tst_resm(TWARN, "2.6.16 and higher");
>> -		exit(0);
>> -	}
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		for (i = 0; i < TST_TOTAL; i++) {
>> -			TEST(myfchmodat(fds[i], filenames[i], 0600));
>> -
>> -			if (TEST_ERRNO == expected_errno[i]) {
>> -				tst_resm(TPASS,
>> -					 "fchmodat() returned the expected  errno %d: %s",
>> -					 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			} else {
>> -				tst_resm(TFAIL,
>> -					 "fchmodat() Failed, errno=%d : %s",
>> -					 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			}
>> -		}
>> +	TEST(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600));
>> +
>> +	if (TST_ERR == expected_errno[i]) {
>> +		tst_res(TPASS,
>> +			 "fchmodat() returned the expected  errno %d: %s",
>> +			 TST_ERR, strerror(TST_ERR));
>> +	} else {
>> +		tst_res(TFAIL,
>> +			 "fchmodat() Failed, errno=%d : %s",
>> +			 TST_ERR, strerror(TST_ERR));
>>   	}
> 
> Ideally the test should be split into two testcases. One for the error
> tests and one for the functionality test so that we can use
> TST_EXP_PASS() and TST_EXP_FAIL().
> 
>> -	cleanup();
>> -	tst_exit();
>>   }
>>
>> -void setup(void)
>> +static void setup(void)
>>   {
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	tst_tmpdir();
>> -
>>   	/* Initialize test dir and file names */
>>   	char *abs_path = tst_get_tmpdir();
>>   	int p = getpid();
>> @@ -122,31 +65,36 @@ void setup(void)
>>
>>   	free(abs_path);
>>
>> -	SAFE_MKDIR(cleanup, pathname, 0700);
>> +	SAFE_MKDIR(pathname, 0700);
>>
>> -	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
>> +	fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
>>   	fds[1] = fds[4] = fds[0];
>>
>> -	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
>> -	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
>> +	SAFE_FILE_PRINTF(testfile, "%s", testfile);
>> +	SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
>>
>> -	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
>> +	fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
>>   	fds[3] = 100;
>>   	fds[5] = AT_FDCWD;
>>
>>   	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
>>   	filenames[1] = testfile2;
>>   	filenames[5] = testfile3;
>> -
>> -	TEST_PAUSE;
>>   }
>>
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>>   	if (fds[0] > 0)
>>   		close(fds[0]);
>>   	if (fds[2] > 0)
>>   		close(fds[2]);
>> -
>> -	tst_rmdir();
>>   }
>> +
>> +static struct tst_test test = {
>> +	.min_kver = "2.6.16",
>> +	.tcnt = ARRAY_SIZE(expected_errno),
>> +	.test = verify_fchmodat,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_tmpdir = 1,
>> +};
>> --
>> 2.20.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
Thanks for the heads up! I have handled it in patch v2.
Best regards




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
