Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wf7kY-00025O-BY
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 13:07:06 +0000
Date: Tue, 29 Apr 2014 15:06:10 +0200
From: chrubis@suse.cz
Message-ID: <20140429130610.GA11902@rei>
References: <1395801143-29038-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395801143-29038-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] direct_io/dma_thread_diotest7.c: cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void dma_thread_diotest_verify(void)
> +{
> +	int n, j, offset, rc;
> +	void *retval;
> +	char filename[PATH_MAX];
> +	pthread_t fork_tid;
>  
> -	printf("Using alignment %d.\n", align);
> +	tst_result = 0;
>  
> -	posix_memalign((void *)&buffer, PAGE_SIZE, READSIZE + align);
> -	printf("Read buffer: %p.\n", buffer);
>  	for (n = 1; n <= FILECOUNT; n++) {
> -
>  		sprintf(filename, FILENAME, n);
>  		for (j = 0; j < workers; j++) {
> -			if ((worker[j].fd =
> -			     open(filename, O_RDONLY | O_DIRECT)) < 0) {
> -				fprintf(stderr, "Failed to open %s: %s.\n",
> -					filename, strerror(errno));
> -				exit(1);
> -			}
> -
> +			worker[j].fd = SAFE_OPEN(cleanup, filename,
> +						 O_RDONLY | O_DIRECT);
>  			worker[j].pattern = n;
>  		}
>  
> -		printf("Reading file %d.\n", n);
> +		tst_resm(TINFO, "Reading file %d.", n);
>  
>  		for (offset = 0; offset < FILESIZE; offset += READSIZE) {
>  			memset(buffer, PATTERN, READSIZE + align);
> @@ -344,51 +280,143 @@ int main(int argc, char *argv[])
>  
>  			rc = pthread_create(&fork_tid, NULL, fork_thread, NULL);
>  			if (rc != 0) {
> -				fprintf(stderr,
> -					"Can't create fork thread: %s.\n",
> -					strerror(rc));
> -				exit(1);
> +				tst_brkm(TBROK, cleanup, "pthread_create "
> +					 "failed: %s", strerror(rc));
>  			}
>  
>  			for (j = 0; j < workers; j++) {
> -				rc = pthread_create(&worker[j].tid,
> -						    NULL,
> +				rc = pthread_create(&worker[j].tid, NULL,
>  						    worker_thread, worker + j);
>  				if (rc != 0) {
> -					fprintf(stderr,
> -						"Can't create worker thread %d: %s.\n",
> -						j, strerror(rc));
> -					exit(1);
> +					tst_brkm(TBROK, cleanup, "Can't create"
> +						 "worker thread %d: %s",
> +						 j, strerror(rc));
>  				}
>  			}
>  
>  			for (j = 0; j < workers; j++) {
> -				rc = pthread_join(worker[j].tid, NULL);
> +				retval = 0;
                                ^
				This should be retval = NULL;
				Moreover it does not need to be
				initialized because it's set by
				the pthread_join()

> +				rc = pthread_join(worker[j].tid, &retval);
>  				if (rc != 0) {
> -					fprintf(stderr,
> -						"Failed to join worker thread %d: %s.\n",
> -						j, strerror(rc));
> -					exit(1);
> +					tst_brkm(TBROK, cleanup, "Failed to "
> +						 "join worker thread %d: %s.",
> +						 j, strerror(rc));
> +				}
> +				if ((intptr_t)retval != 0) {
> +					tst_brkm(TBROK, cleanup, "there is"
> +						 "some errors in worker[%d],"
> +						 "return value: %ld",
> +						 j, (intptr_t)retval);
>  				}
>  			}
>  
>  			/* Let the fork thread know it's ok to exit */
>  			done = 1;
>  
> -			rc = pthread_join(fork_tid, NULL);
> +			rc = pthread_join(fork_tid, &retval);
>  			if (rc != 0) {
> -				fprintf(stderr,
> -					"Failed to join fork thread: %s.\n",
> -					strerror(rc));
> -				exit(1);
> +				tst_brkm(TBROK, cleanup,
> +					 "Failed to join fork thread: %s.",
> +					 strerror(rc));
> +			}
> +			if ((intptr_t)retval != 0) {
> +				tst_brkm(TBROK, cleanup,
> +					 "fork() failed in fork thread:"
> +					 "return value: %ld", (intptr_t)retval);
>  			}
>  		}
>  
>  		/* Close the fd's for the next file. */
> -		for (j = 0; j < workers; j++) {
> -			close(worker[j].fd);
> +		for (j = 0; j < workers; j++)
> +			SAFE_CLOSE(cleanup, worker[j].fd);
> +		if (tst_result)
> +			break;
> +	}
> +
> +	if (tst_result)
> +		tst_resm(TINFO, "data corruption is detected");
> +	else
> +		tst_resm(TINFO, "data corruption is not detected");

Hmm shouldn't the first tst_resm be TFAIL and the second TPASS?
(and the TPASS below removed...)

> +	tst_resm(TPASS, "dma_thread_diotest test completed");
> +}
> +
> +static void setup(void)
> +{
> +	char filename[PATH_MAX];
> +	int n, j;
> +
> +	if (align_str) {
> +		align = atoi(align_str);
> +		if (align < 0 || align > PAGE_SIZE)
> +			tst_brkm(TCONF, NULL, "Bad alignment %d.", align);
> +	}
> +	tst_resm(TINFO, "using alignment %d", align);
> +
> +	if (workers_str) {
> +		workers = atoi(workers_str);
> +		if (workers < MIN_WORKERS || workers > MAX_WORKERS) {
> +			tst_brkm(TCONF, NULL, "Worker count %d not between "
> +				 "%d and %d, inclusive",
> +				 workers, MIN_WORKERS, MAX_WORKERS);
> +		}
> +	}
> +	tst_resm(TINFO, "using %d workers.", workers);
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	tst_require_root(NULL);
> +
> +	device = getenv("LTP_BIG_DEV");
> +	if (device == NULL) {
> +		tst_brkm(TCONF, NULL,
> +			 "you must specify a big blockdevice(>1.2G)");

What about we check free space in test temporary directory and proceed
without mounting the device if there is enough space there?

All that should be needed in the rest of the test is to set mount_flag
only if we really mounted the device...

> +	} else {
> +		tst_mkfs(NULL, device, "ext3", NULL);
> +	}
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
> +
> +	worker = SAFE_MALLOC(cleanup, workers * sizeof(worker_t));
> +
> +	for (j = 0; j < workers; j++)
> +		worker[j].worker_number = j;
> +
> +	if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +
> +	for (n = 1; n <= FILECOUNT; n++) {
> +		sprintf(filename, FILENAME, n);
> +
> +		if (tst_fill_file(filename, n, FILESIZE, 1)) {
> +			tst_brkm(TBROK, cleanup, "failed to create file: %s",
> +				 filename);
>  		}
>  	}
>  
> -	return 0;
> +	if (posix_memalign((void *)&buffer, PAGE_SIZE, READSIZE + align) != 0)
> +		tst_brkm(TBROK, cleanup, "call posix_memalign failed");

Is the void * cast to the buffer needed?

Man page says that posix_memalign first parameter is void **, which
should be correct just with &buffer, given that buffer is void *.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
