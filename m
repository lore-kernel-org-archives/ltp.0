Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FDC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 12:38:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FAB60F93
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 12:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5FAB60F93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E9E83C9F48
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 14:38:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25083C1C56
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 14:38:07 +0200 (CEST)
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A7B51401431
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 14:38:04 +0200 (CEST)
X-QQ-mid: bizesmtp41t1633696679to9age7l
Received: from [10.4.23.19] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 08 Oct 2021 20:37:58 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00C0000000
X-QQ-FEAT: xTOTECUEGExAFEG97vZ7w+LOWZpFg037ol5oLcrtL02Ib5Y2YqfhXQK0BuZcf
 z2IT1d829ZbhSAAUa9Ei4PAKGvnvUXsM10fEqOHZ+VhxzWL9M4famOp+aX5K3Gr6T9JtFaZ
 VLB31DfBjMQKfybf2fgFW2n8RpKoyYgjbnOfFKfJMkocSJHiuXcmXbR0KsFszrWcmjI82Ec
 02TfO/TBTAjtJ0D4tv5LDTu/aUi2PuE+N933VSLUrCm8iKpOvUkyTu7m6n032ZP2aG+xk+k
 rLdMMpPXu1vGQiYVWTWBooRfgHbrhAnR7bzJKEGV2wJWEEu2vOAaAfYgxxpnbE4q6AcZJXv
 +juUdaiPZCWmW2WmzY=
X-QQ-GoodBg: 2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210929083249.22320-1-zhanglianjie@uniontech.com>
 <YV7bfgmBT+1unI3j@yuki>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <a797af52-606f-a0fe-21b5-ea44405092f4@uniontech.com>+ACC1DB4CE74E9110
Date: Fri, 8 Oct 2021 20:37:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YV7bfgmBT+1unI3j@yuki>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/readdir01: Convert to new API
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

Hi,
I will resubmit after revision, thank you for your review.


On 2021-10-07 19:35, Cyril Hrubis wrote:
> Hi!
>> +static void setup(void)
>> +{
>> +	sprintf(prefix, "%s_%d.", "readdirfile", getpid());
> 
> Since the test runs in it's own temporary directory there is no need to
> prefix everything with the pid.
> 
>> +}
>>
>> -/***********************************************************************
>> - * Main
>> - ***********************************************************************/
>> -int main(int ac, char **av)
>> +static void verify_readdir(void)
>>   {
>> -	int lc;
>> -	int cnt;
>> -	int nfiles, fd;
>> +	int i;
>> +	int fd;
>> +	int cnt = 0;
>>   	char fname[255];
>>   	DIR *test_dir;
>>   	struct dirent *dptr;
>>
>> -	tst_parse_opts(ac, av, options, &help);
>> -
>> -	if (Nflag) {
>> -		if (sscanf(Nfilearg, "%i", &Nfiles) != 1) {
>> -			tst_brkm(TBROK, NULL, "--N option arg is not a number");
>> -		}
>> +	for (i = 0; i < nfiles; i++) {
>> +		sprintf(fname, "%s_%d", prefix, i);
>> +		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
>> +		SAFE_WRITE(1, fd, "hello\n", 6);
>> +		SAFE_CLOSE(fd);
>>   	}
> 
> This loop could be moved to the test setup, there is no need to
> re-create the files on each iteration.
> 
>>
>> -    /***************************************************************
>> -     * perform global setup for test
>> -     ***************************************************************/
>> -	/* Next you should run a setup routine to make sure your environment is
>> -	 * sane.
>> -	 */
>> -	setup();
>> -
>> -    /***************************************************************
>> -     * check looping state
>> -     ***************************************************************/
>> -	/* TEST_LOOPING() is a macro that will make sure the test continues
>> -	 * looping according to the standard command line args.
>> -	 */
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		if (Nfiles)
>> -			nfiles = Nfiles;
>> -		else
>> -			/* min of 10 links and max of a 100 links */
>> -			nfiles = (lc % 90) + 10;
>> -
>> -		/* create a bunch of files to look at */
>> -		for (cnt = 0; cnt < nfiles; cnt++) {
>> -
>> -			sprintf(fname, "%s%d", Basename, cnt);
>> -			if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
>> -				tst_brkm(TBROK, cleanup,
>> -					 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
>> -					 fname, errno, strerror(errno));
>> -			} else if (write(fd, "hello\n", 6) < 0) {
>> -				tst_brkm(TBROK, cleanup,
>> -					 "write(%s, \"hello\\n\", 6) Failed, errno=%d : %s",
>> -					 fname, errno, strerror(errno));
>> -			} else if (close(fd) < 0) {
>> -				tst_resm(TWARN,
>> -					"close(%s) Failed, errno=%d : %s",
>> -					fname, errno, strerror(errno));
>> -			}
>> -		}
>> -
>> -		if ((test_dir = opendir(".")) == NULL) {
>> -			tst_resm(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
>> -				 errno, strerror(errno));
>> -		} else {
>> -			/* count the entries we find to see if any are missing */
>> -			cnt = 0;
>> -			errno = 0;
>> -			while ((dptr = readdir(test_dir)) != 0) {
>> -				if (strcmp(dptr->d_name, ".")
>> -				    && strcmp(dptr->d_name, ".."))
>> -					cnt++;
>> -			}
>> -
>> -			if (errno != 0) {
>> -				tst_resm(TFAIL,
>> -					 "readir(test_dir) Failed on try %d, errno=%d : %s",
>> -					 cnt + 1, errno, strerror(errno));
>> -			}
>> -			if (cnt == nfiles) {
>> -				tst_resm(TPASS,
>> -					 "found all %d that were created",
>> -					 nfiles);
>> -			} else if (cnt > nfiles) {
>> -				tst_resm(TFAIL,
>> -					 "found more files than were created");
>> -				tst_resm(TINFO, "created: %d, found: %d",
>> -					 nfiles, cnt);
>> -			} else {
>> -				tst_resm(TFAIL,
>> -					 "found less files than were created");
>> -				tst_resm(TINFO, "created: %d, found: %d",
>> -					 nfiles, cnt);
>> -			}
>> -		}
>> -
>> -		/* Here we clean up after the test case so we can do another iteration.
>> -		 */
>> -		for (cnt = 0; cnt < nfiles; cnt++) {
>> -
>> -			sprintf(fname, "%s%d", Basename, cnt);
>> -
>> -			if (unlink(fname) == -1) {
>> -				tst_resm(TWARN,
>> -					"unlink(%s) Failed, errno=%d : %s",
>> -					Fname, errno, strerror(errno));
>> -			}
>> -		}
>> -
>> +	test_dir = SAFE_OPENDIR(".");
>> +	while ((dptr = SAFE_READDIR(test_dir)) != 0) {
>> +		if (strcmp(dptr->d_name, ".")
>> +			&& strcmp(dptr->d_name, ".."))
>> +			cnt++;
>>   	}
> 
> I would have probably written this as:
> 
> 	while ((ent = SAFE_READDIR(test_dir))) {
> 		if (!strcmp(ent->d_name, "." || !strcmp(ent->d_name, ".")
> 			continue;
> 
> 		cnt++;
> 	}
> 
> Also I guess that we can check that the filename is filled correctly as
> well, it has to start with prefix at least.
> 
>> -    /***************************************************************
>> -     * cleanup and exit
>> -     ***************************************************************/
>> -	cleanup();
>> -
>> -	tst_exit();
>> -}
>> -
>> -/***************************************************************
>> - * help
>> - ***************************************************************/
>> -/* The custom help() function is really simple.  Just write your help message to
>> - * standard out.  Your help function will be called after the standard options
>> - * have been printed
>> - */
>> -void help(void)
>> -{
>> -	printf("  -N #files : create #files files every iteration\n");
>> -}
>> -
>> -/***************************************************************
>> - * setup() - performs all ONE TIME setup for this test.
>> - ***************************************************************/
>> -void setup(void)
>> -{
>> -	/* You will want to enable some signal handling so you can capture
>> -	 * unexpected signals like SIGSEGV.
>> -	 */
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
>> -	 * fork the test with the -c option.  You want to make sure you do this
>> -	 * before you create your temporary directory.
>> -	 */
>> -	TEST_PAUSE;
>> -
>> -	/* If you are doing any file work, you should use a temporary directory.  We
>> -	 * provide tst_tmpdir() which will create a uniquely named temporary
>> -	 * directory and cd into it.  You can now create files in the current
>> -	 * directory without worrying.
>> -	 */
>> -	tst_tmpdir();
>> -
>> -	sprintf(Basename, "%s_%d.", BASENAME, getpid());
>> +	if (cnt == nfiles) {
>> +		tst_res(TPASS,
>> +				"found all %d that were created",
>> +				nfiles);
>> +	} else {
>> +		tst_res(TFAIL,
>> +				"found %s files than were created, created: %d, found: %d",
>> +				cnt > nfiles ? "more" : "less", nfiles, cnt);
>> +	}
> 
> Why the newline after TPASS, TFAIL, ? We indent the format string as if
> it continued after the TFAIL/TPASS anyways.
> 

-- 
Regards,
Zhang Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
