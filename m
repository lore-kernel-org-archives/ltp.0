Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z5v45-00033g-Iz
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 12:06:33 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5v44-00009y-NX
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 12:06:33 +0000
Message-ID: <55840688.1010202@oracle.com>
Date: Fri, 19 Jun 2015 15:09:44 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <144413988.54651434713150877.JavaMail.weblogic@ep2mlwas06b>
In-Reply-To: <144413988.54651434713150877.JavaMail.weblogic@ep2mlwas06b>
Subject: Re: [LTP] [PATCH]: Fix memory leak by freeing buf
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
To: manjeet.p@samsung.com, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, AKHILESH KUMAR <akhilesh.k@samsung.com>

Hi!
On 06/19/2015 02:25 PM, Manjeet Pawar wrote:
> From: Manjeet Pawar <manjeet.p@samsung.com>
> Date: Fri, 19 Jun 2015 16:45:54 +0530
> Subject: [PATCH] testcases/open_posix_testsuite/functional/semaphores: Fix memory leak by freeing buf
>
> This patch fix memory leak by freeing memory leak before function return
>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> ---
>   .../functional/semaphores/sem_conpro.c             |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
> index f5f1abf..f3a4cfb 100644
> --- a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
> +++ b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
> @@ -106,19 +106,23 @@ int main(int argc, char *argv[])
>   
>   #ifndef  _POSIX_SEMAPHORES
>   	printf("_POSIX_SEMAPHORES is not defined \n");
> +	free(buf);
>   	return PTS_UNRESOLVED;
>   #endif
>   	if (-1 == sem_init(&(buf->occupied), shared, occupied_value)) {
>   		perror("sem_init didn't return success \n");
>   		printf("hello \n");
> +		free(buf);
>   		return PTS_UNRESOLVED;
>   	}
>   	if (-1 == sem_init(&buf->empty, shared, empty_value)) {
>   		perror("sem_init didn't return success \n");
> +		free(buf);
>   		return PTS_UNRESOLVED;
>   	}
>   	if (-1 == sem_init(&buf->lock, shared, lock_value)) {
>   		perror("sem_init didn't return success \n");
> +		free(buf);
>   		return PTS_UNRESOLVED;
>   	}
>   	in = out = 0;
> @@ -129,5 +133,6 @@ int main(int argc, char *argv[])
>   	pthread_join(pro, NULL);
>   	sem_destroy(&buf->occupied);
>   	sem_destroy(&buf->empty);
> +	free(buf);
>   	return PTS_PASS;
>   }

The program terminating after free() so it will be freed in any case, I 
don't see memory leak here.

I think the better change would be to check the return value from 
malloc() (e.g. using SAFE_MALLOC) or allocate 'buf' on the stack.

Thanks,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
