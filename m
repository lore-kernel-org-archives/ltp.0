Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sf9Un-00055e-3Z
	for ltp-list@lists.sourceforge.net; Thu, 14 Jun 2012 12:49:53 +0000
Date: Thu, 14 Jun 2012 14:05:50 +0200
From: chrubis@suse.cz
Message-ID: <20120614120550.GA16073@saboteur.suse.cz>
References: <4a17ab14caea979b15264705158a639e0879cb96.1339645403.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a17ab14caea979b15264705158a639e0879cb96.1339645403.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] lib/mem.c: add _wait_ksmd_done func to wait
 ksmd finish his job
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Cai Qian <caiqian@redhat.com>

Hi!
> This failure is because of ksm daemon can't finish to scan all

Just to have correct commit log, I think that you are speaking about KSM
kernel thread not userspace daemon process.

> mergeable pages, especially occurred in a small/dull system,
> and commit 366a92805fc9a5b0 ever did partially repair, but
> can't completely fix the issue, so I added _wait_ksmd_done
> function, which can give enough time to ksmd scan all mergeable
> pages.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/mem/lib/mem.c |   72 +++++++++++++++++++++++++++++++---------
>  1 file changed, 57 insertions(+), 15 deletions(-)
> 
> Hi, Wanlong
> 
> I have tested the patch set in my lab, and I can't find the issue again:
>  http://sourceforge.net/mailarchive/message.php?msg_id=29088640 
> could you test/have a look at the patch?
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index b031184..5ead938 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -147,27 +147,69 @@ static void _check(char *path, long int value)
>  		tst_resm(TFAIL, "%s is not %ld.", path, value);
>  }
>  
> -static void _group_check(int run, int pages_shared, int pages_sharing,
> -		int pages_volatile, int pages_unshared,
> -		int sleep_millisecs, int pages_to_scan)
> +static void _wait_ksmd_done(void)
>  {
>  	char buf[BUFSIZ];
> -	long old_num, new_num;
> +	long run, pages_shared, pages_sharing, pages_volatile, pages_unshared;
> +	long old_run = 0, old_pages_shared = 0, old_pages_sharing = 0,
> +	     old_pages_volatile = 0, old_pages_unshared = 0;
> +	long tmp;
> +	int changed = 1, count = 0;
> +
> +	while(changed) {
> +		while(sleep(5))
> +			continue;
> +
> +		changed = 0;
> +		count++;
> +
> +		read_file(PATH_KSM "run", buf);
> +		run = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> +		if (run != old_run) {
> +			old_run = run;
> +			changed = 1;
> +		}
>  
> -	/* 1 seconds for ksm to scan pages. */
> -	while (sleep(1) == 1)
> -		continue;
> +		read_file(PATH_KSM "pages_shared", buf);
> +		pages_shared = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> +		if (pages_shared != old_pages_shared) {
> +			old_pages_shared = pages_shared;
> +			changed = 1;
> +		}
> +
> +		read_file(PATH_KSM "pages_sharing", buf);
> +		pages_sharing = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> +		if (pages_sharing != old_pages_sharing) {
> +			old_pages_sharing = pages_sharing;
> +			changed = 1;
> +		}
> +
> +		read_file(PATH_KSM "pages_volatile", buf);
> +		pages_volatile = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> +		if (pages_volatile != old_pages_volatile) {
> +			old_pages_volatile = pages_volatile;
> +			changed = 1;
> +		}
>  
> -	read_file(PATH_KSM "full_scans", buf);
> -	/* wait 3 increments of full_scans */
> -	old_num = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> -	new_num = old_num;
> -	while (new_num < old_num * 3) {
> -		sleep(1);
> -		read_file(PATH_KSM "full_scans", buf);
> -		new_num = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> +		read_file(PATH_KSM "pages_unshared", buf);
> +		pages_unshared = SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> +		if (pages_unshared != old_pages_unshared) {
> +			old_pages_unshared = pages_unshared;
> +			changed = 1;
> +		}
>  	}
>  
> +	tst_resm(TINFO, "ksm daemon takes %ds to scan all "
> +		    "mergeable pages", count * 5);
> +}
> +
> +static void _group_check(int run, int pages_shared, int pages_sharing,
> +		int pages_volatile, int pages_unshared,
> +		int sleep_millisecs, int pages_to_scan)
> +{
> +	/* wait for ksm daemon to scan all mergeable pages. */
> +	_wait_ksmd_done();
> +
>  	tst_resm(TINFO, "check!");
>  	_check("run", run);
>  	_check("pages_shared", pages_shared);
> -- 
> 1.7.10.2
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
