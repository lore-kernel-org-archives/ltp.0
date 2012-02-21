Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1RzhbH-0007i6-AR
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 04:45:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RzhbG-0007xA-3C
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 04:45:15 +0000
Message-ID: <4F432127.3080100@redhat.com>
Date: Tue, 21 Feb 2012 12:44:23 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4F4315C1.3080302@cn.fujitsu.com>
	<4F431666.9060601@casparzhang.com>
	<4F431D1E.4050201@cn.fujitsu.com>
In-Reply-To: <4F431D1E.4050201@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] shmem_2nstest.c: coding style cleanups
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 02/21/2012 12:27 PM, Peng Haitao wrote:
> 
> Caspar Zhang said the following on 2012-2-21 11:58:
>> On 02/21/2012 11:55 AM, Peng Haitao wrote:
>>> -		tst_exit();
>>> -		return 0;
>>> +	tst_exit();
>>> +	return 0;
>>
>> seems there's still something wrong here.. return 0 would never be reached.
>>
> 
> Thanks.

please put some dashes here next time, or the commit message will
include comments above.

Committed.

Thanks,
Caspar

> 
> 
> cleanup the coding style
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  .../kernel/containers/sysvipc/shmem_2nstest.c      |   86 +++++++++-----------
>  1 files changed, 38 insertions(+), 48 deletions(-)
> 
> diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
> index 6033991..7a468ad 100644
> --- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
> +++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
> @@ -64,18 +64,14 @@ int check_shmem1(void *vtest)
>  	int id1;
>  	close(p1[0]);
>  
> -		/* first create the key */
> -		id1 = shmget(TESTKEY, 100, IPC_CREAT);
> -		if (id1 == -1) {
> -			perror("shmget");
> -			tst_resm(TFAIL, "shmget failed\n");
> -			tst_exit();
> -		}
> +	/* first create the key */
> +	id1 = shmget(TESTKEY, 100, IPC_CREAT);
> +	if (id1 == -1)
> +		tst_brkm(TFAIL|TERRNO, NULL, "shmget failed");
>  
>  	tst_resm(TINFO, "Cont1: Able to create shared mem segment");
>  	write(p1[1], "done", 5);
>  	tst_exit();
> -	return 0;
>  }
>  
>  /*
> @@ -83,29 +79,26 @@ int check_shmem1(void *vtest)
>   */
>  int check_shmem2(void *vtest)
>  {
> -		char buf[3];
> -		int id2;
> -		close(p1[1]);
> -		close(p2[0]);
> -
> -		read(p1[0], buf, 3);
> -		/* Trying to access shmem, if not existing create new shmem */
> -		id2 = shmget(TESTKEY, 100, 0);
> -		if (id2 == -1) {
> -			id2 = shmget(TESTKEY, 100, IPC_CREAT);
> -			if (id2 == -1) {
> -				perror("shmget");
> -				tst_resm(TFAIL, "shmget failed\n");
> -			} else
> -				tst_resm(TINFO, "Cont2: Able to allocate shmem seg with "
> -								"the same key");
> -			write(p2[1], "notfnd", 7);
> -
> -		} else
> -			write(p2[1], "exists", 7);
> +	char buf[3];
> +	int id2;
> +	close(p1[1]);
> +	close(p2[0]);
> +
> +	read(p1[0], buf, 3);
> +	/* Trying to access shmem, if not existing create new shmem */
> +	id2 = shmget(TESTKEY, 100, 0);
> +	if (id2 == -1) {
> +		id2 = shmget(TESTKEY, 100, IPC_CREAT);
> +		if (id2 == -1)
> +			tst_resm(TFAIL|TERRNO, "shmget failed");
> +		else
> +			tst_resm(TINFO, "Cont2: Able to allocate shmem seg with "
> +					"the same key");
> +		write(p2[1], "notfnd", 7);
> +	} else
> +		write(p2[1], "exists", 7);
>  
> -		tst_exit();
> -		return 0;
> +	tst_exit();
>  }
>  
>  int main(int argc, char *argv[])
> @@ -118,13 +111,15 @@ int main(int argc, char *argv[])
>  	if (argc != 2) {
>  		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
>  		tst_resm(TINFO, " where clone, unshare, or fork specifies"
> -				" unshare method.\n");
> +				" unshare method.");
>  		tst_exit();
>  	}
>  
>  	/* Using PIPE's to sync between containers and Parent */
> -	if (pipe(p1) == -1) { tst_resm(TBROK, "pipe1 error"); tst_exit(); }
> -	if (pipe(p2) == -1) { tst_resm(TBROK, "pipe2 error"); tst_exit(); }
> +	if (pipe(p1) == -1)
> +		tst_brkm(TBROK|TERRNO, NULL, "pipe1 error");
> +	if (pipe(p2) == -1)
> +		tst_brkm(TBROK|TERRNO, NULL, "pipe2 error");
>  
>  	if (strcmp(argv[1], "clone") == 0) {
>  		use_clone = T_CLONE;
> @@ -138,39 +133,34 @@ int main(int argc, char *argv[])
>  
>  	/* Create 2 containers */
>  	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
> -	if (ret < 0) {
> -		tst_resm(TFAIL, "clone/unshare failed\n");
> -		tst_exit();
> -	}
> +	if (ret < 0)
> +		tst_brkm(TFAIL, NULL, "clone/unshare failed");
>  
>  	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
> -	if (ret < 0) {
> -		tst_resm(TFAIL, "clone/unshare failed\n");
> -		tst_exit();
> -	}
> -	close(p2[1]);
> +	if (ret < 0)
> +		tst_brkm(TFAIL, NULL, "clone/unshare failed");
>  
> +	close(p2[1]);
>  	read(p2[0], buf, 7);
>  
>  	if (strcmp(buf, "exists") == 0) {
>  		if (use_clone == T_NONE)
>  			tst_resm(TPASS, "Plain cloned process able to access shmem "
> -							"segment created\n");
> +					"segment created");
>  		else
>  			tst_resm(TFAIL, "%s : In namespace2 found the shmem segment "
> -							"created in Namespace1\n", tsttype);
> +					"created in Namespace1", tsttype);
>  	} else {
>  		if (use_clone == T_NONE)
> -			tst_resm(TFAIL, "Plain cloned process didn't find shmem seg\n");
> +			tst_resm(TFAIL, "Plain cloned process didn't find shmem seg");
>  		else
>  			tst_resm(TPASS, "%s : In namespace2 unable to access the shmem seg "
> -							"created in Namespace1\n", tsttype);
> +					"created in Namespace1", tsttype);
>  	}
>  	/* destroy the key */
>  
>  	id = shmget(TESTKEY, 100, 0);
>  	shmctl(id, IPC_RMID, NULL);
> -	tst_exit();
>  
>  	tst_exit();
> -}
> \ No newline at end of file
> +}


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
