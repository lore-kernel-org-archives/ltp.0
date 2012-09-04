Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T8lo7-0007eK-S0
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 05:36:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T8lo6-0001Y4-Ea
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 05:36:15 +0000
Message-ID: <504592C6.8060100@cn.fujitsu.com>
Date: Tue, 04 Sep 2012 13:33:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
	<1344508258-25054-3-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344508258-25054-3-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH 2/3] mq_open/16-1: use tmp file to share info
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

On 08/09/2012 06:30 PM, Kang Kai wrote:
> In this test case, it uses a variable to share data between child and
> parent processes. But after fork there is a copy of the variable in
> child process and modify it will not affect the variable in the parent
> process. Then when the child process call mq_open() before parent process,
> the case will fail.
> 
> Use tmp file to replace the variable. Any modification in child process
> can be seen in parent process.
> 

Looks Ok in general.
A bit comment below.

> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/mq_open/16-1.c          |   38 +++++++++++++++++--
>  1 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
> index b9a3215..ebd697b 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
> @@ -20,9 +20,11 @@
>   * this is fine (will have some false positives, but no false negatives).
>   */
>  
> +#include <sys/mman.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <mqueue.h>
>  #include <signal.h>
> @@ -32,11 +34,15 @@
>  #include "posixtest.h"
>  
>  #define NAMESIZE 50
> +#define TNAME "mq_open/16-1.c"
>  
>  int main()
>  {
>         	char qname[NAMESIZE];
> +	char fname[NAMESIZE];
>  	int pid, succeeded=0;
> +	int fd;
> +	void *pa = NULL;
>  	mqd_t childqueue, queue;
>  
>  	/*
> @@ -47,6 +53,26 @@ int main()
>  
>         	sprintf(qname, "/mq_open_16-1_%d", getpid());
>  
> +	sprintf(fname, "/tmp/pts_mq_open_16_1_%d", getpid());
> +	unlink(fname);
> +	fd = open(fname, O_CREAT | O_RDWR | O_EXCL,
> +		 S_IRUSR | S_IWUSR);
> +	if (fd == -1) {
> +		printf(TNAME " Error at open(): %s\n", strerror(errno));
> +		exit(PTS_UNRESOLVED);
> +	}
> +	/* file is empty now, will cause "Bus error" */
> +	write(fd, "\0", 1);
> +	unlink(fname);
> +
> +	pa = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

Why not use anonymous map? in that case you will not need to create a file.


Thanks,
Wanlong Gao


> +	if (pa == MAP_FAILED) {
> +		printf(TNAME " Error at mmap: %s\n", strerror(errno));
> +		close(fd);
> +		exit(PTS_FAIL);
> +	}
> +	*(int *)pa = 0;
> +
>  	if ((pid = fork()) == 0) {
>  		sigset_t mask;
>  		int sig;
> @@ -62,7 +88,7 @@ int main()
>          	childqueue = mq_open(qname, O_CREAT|O_EXCL|O_RDWR,
>  				S_IRUSR | S_IWUSR, NULL);
>          	if (childqueue != (mqd_t)-1) {
> -			succeeded++;
> +			++*(int *)pa;
>  #ifdef DEBUG
>  			printf("mq_open() in child succeeded\n");
>  		} else {
> @@ -79,7 +105,7 @@ int main()
>          	queue = mq_open(qname, O_CREAT | O_EXCL |O_RDWR,
>  				S_IRUSR | S_IWUSR, NULL);
>          	if (queue != (mqd_t)-1) {
> -			succeeded++;
> +			++*(int *)pa;
>  #ifdef DEBUG
>  			printf("mq_open() in parent succeeded\n");
>  		} else {
> @@ -93,13 +119,15 @@ int main()
>  			mq_close(queue);
>  			mq_close(childqueue);
>  			mq_unlink(qname);
> +			close(fd);
> +			munmap(pa, sizeof(int));
>  			return PTS_UNRESOLVED;
>  		}
>  
>  		mq_close(queue);
>  		mq_close(childqueue);
>  		mq_unlink(qname);
> -
> +		succeeded = *(int *)pa;
>  		if (succeeded==0) {
>  			printf("Test FAILED - mq_open() never succeeded\n");
>  			return PTS_FAIL;
> @@ -111,8 +139,10 @@ int main()
>  		}
>  
>          	printf("Test PASSED\n");
> +		close(fd);
> +		munmap(pa, sizeof(int));
>          	return PTS_PASS;
>  	}
>  
>  	return PTS_UNRESOLVED;
> -}
> \ No newline at end of file
> +}
> 


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
