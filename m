Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9j9H-0003c2-JA
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:16:43 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9j9F-0004cS-7Y
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:16:43 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o45IESqN019280
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 14:14:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o45IGYIA082562
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 14:16:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o45IGVZs031208
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 15:16:31 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1273081434-22034-1-git-send-email-danms@us.ibm.com>
References: <1273081434-22034-1-git-send-email-danms@us.ibm.com>
Date: Wed, 05 May 2010 23:46:24 +0530
Message-Id: <1273083384.13463.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] NetNS test fixes
Reply-To: subrata@linux.vnet.ibm.com
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
To: Dan Smith <danms@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Serge Hallyn <serue@linux.vnet.ibm.com>

On Wed, 2010-05-05 at 10:43 -0700, Dan Smith wrote:
> This patch fixes a couple of netns test issues that cause invalid failures
> relating to exiting with a status variable that doesn't exist.  It also
> fixes an instance of inverted logic and a failure to exec sshd with the
> full path (as required).
> 
> Additionally, it makes the common child exec function more descriptive of
> what it tried to do and why it failed to ease debugging.
> 
> Signed-off-by: Dan Smith <danms@us.ibm.com>

Thanks Dan. Hope it helps(coupled with other fix from Serge) to fix
those netns issues i found on my F13 system.

Regards--
Subrata

> ---
>  testcases/kernel/containers/netns/child_1.sh  |    1 +
>  testcases/kernel/containers/netns/child_2.sh  |    1 +
>  testcases/kernel/containers/netns/childns.sh  |    4 +++-
>  testcases/kernel/containers/netns/common.c    |    3 +--
>  testcases/kernel/containers/netns/par_ftp.sh  |    3 +++
>  testcases/kernel/containers/netns/parent_1.sh |    2 +-
>  testcases/kernel/containers/netns/parent_2.sh |    2 +-
>  7 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/child_1.sh b/testcases/kernel/containers/netns/child_1.sh
> index 1fa71a7..7fb9a4f 100755
> --- a/testcases/kernel/containers/netns/child_1.sh
> +++ b/testcases/kernel/containers/netns/child_1.sh
> @@ -68,6 +68,7 @@ export TST_TOTAL
>          if [ $? = 0 ];
>          then
>              tst_resm TINFO "PASS: Child2 is pinging from CHILD1 !" 
> +	    status=0
>          else 
>              tst_resm TFAIL "FAIL: Unable to Ping Child2 from CHILD1 !"
>              status=-1
> diff --git a/testcases/kernel/containers/netns/child_2.sh b/testcases/kernel/containers/netns/child_2.sh
> index d73b785..3098028 100755
> --- a/testcases/kernel/containers/netns/child_2.sh
> +++ b/testcases/kernel/containers/netns/child_2.sh
> @@ -66,6 +66,7 @@ status=0
>          # Using /tmp/FIFO5 to synchronize with CHILD1
>          echo 0 > /tmp/FIFO5
>          sleep 2
> +	status=0
>      else
>          tst_resm TFAIL "FAIL: Unable to ping Child1NS from Child2NS !"
>          echo 1 > /tmp/FIFO5
> diff --git a/testcases/kernel/containers/netns/childns.sh b/testcases/kernel/containers/netns/childns.sh
> index 3634d81..16fc7e8 100755
> --- a/testcases/kernel/containers/netns/childns.sh
> +++ b/testcases/kernel/containers/netns/childns.sh
> @@ -38,6 +38,8 @@ exists awk grep ip ping sshd
>  . initialize.sh
>  status=0
>      
> +SSHD=`which sshd`
> +
>  if [ $# -eq 1 ] ; then
>      childscrpt=$1
>      debug "INFO: The script to be executed in child NS is $childscrpt"
> @@ -58,7 +60,7 @@ ifconfig lo up
>  sleep 2
> 
>  #starting the sshd inside the child NS
> -if ! sshd -p $PORT; then
> +if $SSHD -p $PORT; then
>      debug "INFO: started the sshd @ port no $PORT"
>      sshpid=`ps -ef | grep "sshd -p $PORT" | grep -v grep | awk '{ print $2 ; exit 0} ' `
>  else
> diff --git a/testcases/kernel/containers/netns/common.c b/testcases/kernel/containers/netns/common.c
> index 22d0e99..6d3b02e 100644
> --- a/testcases/kernel/containers/netns/common.c
> +++ b/testcases/kernel/containers/netns/common.c
> @@ -48,8 +48,7 @@ int crtchild(char *s1 , char *s2)
>  {
>  	char *cmd[] = { "--", s1, s2, (char *)0 };
>  	execve("/bin/sh", cmd, __environ);
> -	printf("The code would not reach here on success\n");
> -	perror("execve");
> +	fprintf(stderr, "Failed to execve(%s, %s): %m\n", s1, s2);
>  	return 1;
>  }
> 
> diff --git a/testcases/kernel/containers/netns/par_ftp.sh b/testcases/kernel/containers/netns/par_ftp.sh
> index 3bfb47b..bb65db4 100755
> --- a/testcases/kernel/containers/netns/par_ftp.sh
> +++ b/testcases/kernel/containers/netns/par_ftp.sh
> @@ -37,6 +37,7 @@ export TST_TOTAL
>      
>      if [ $? = 0 ] ; then
>          tst_resm TINFO "Pinging ChildNS from ParentNS"
> +	status=0
>      else
>          tst_resm TFAIL "Error: Unable to ping ChildNS from ParentNS"
>          status=-1
> @@ -45,3 +46,5 @@ export TST_TOTAL
>      if [ $stat != 0 ] ; then
>          status=$stat
>      fi
> +
> +    exit $status
> diff --git a/testcases/kernel/containers/netns/parent_1.sh b/testcases/kernel/containers/netns/parent_1.sh
> index 8577bf2..32f1a47 100755
> --- a/testcases/kernel/containers/netns/parent_1.sh
> +++ b/testcases/kernel/containers/netns/parent_1.sh
> @@ -55,4 +55,4 @@ export TST_TOTAL
>      echo $vnet1 > /tmp/FIFO1
> 
>      debug "INFO: PARENT_1: End of $0"
> -    exit $status
> +    exit 0
> diff --git a/testcases/kernel/containers/netns/parent_2.sh b/testcases/kernel/containers/netns/parent_2.sh
> index 57d3974..f72c16d 100755
> --- a/testcases/kernel/containers/netns/parent_2.sh
> +++ b/testcases/kernel/containers/netns/parent_2.sh
> @@ -51,4 +51,4 @@ export TST_TOTAL
>      echo $vnet3 > /tmp/FIFO3
> 
>      debug "INFO: PARENT-2: End of $0"
> -    exit $status
> +    exit 0


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
