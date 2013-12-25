Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VvdXN-0002sN-2j
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:45:29 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VvdXM-0002hY-6K
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:45:28 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBP1jMHK028283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:45:22 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1jLsD027949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:45:21 GMT
Received: from ubhmt110.oracle.com (ubhmt110.oracle.com [156.151.24.15])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1jLZl027930
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:45:21 GMT
Message-ID: <52BA38AD.7050500@oracle.com>
Date: Wed, 25 Dec 2013 09:45:17 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1387435409-557-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1387435409-557-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] rwho01: fix mistakes
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
To: ltp-list@lists.sourceforge.net

Could anyone help to review this?

Thanks
Simon

On 2013/12/19 14:43, Simon Xu wrote:
> 1) fix the way it checks whether rwhod is running
> 2) fix the way it checks whether rwhod is started on remote host
> 3) fix do_cleanup, and no need to call tst_cleanup() in do_cleanup()
>     because it's called in end_testcase anyways
> 4) call do_cleanup() after do_test()
> 5) shorten sleep time to 5 seconds as 20 seconds are not necessary
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/network/tcp_cmds/rwho/rwho01 | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
> index eb31642..5f507ea 100755
> --- a/testcases/network/tcp_cmds/rwho/rwho01
> +++ b/testcases/network/tcp_cmds/rwho/rwho01
> @@ -48,14 +48,14 @@
>   #
>   #-----------------------------------------------------------------------
>   
> +LHOST_PID=""
> +RHOST_PID=""
> +
>   do_setup()
>   {
> -
>       TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
>   
> -    PID=0
> -    RHOST_PID=0
> -    SLEEPTIME=${SLEEPTIME:-20}
> +    SLEEPTIME=${SLEEPTIME:-5}
>       NUMLOOPS=${NUMLOOPS:-25}
>       OUTFILE=${OUTFILE:-$TCtmp/${TC}.out}
>   
> @@ -68,21 +68,18 @@ do_setup()
>   
>       trap do_cleanup EXIT
>   
> -    if ! ps -ef | awk '/rwhod/ && $0 !~ /awk/'; then
> +    if ! pgrep -x rwhod > /dev/null; then
>           tst_resm TINFO "Starting rwhod on $LHOST"
>           rwhod || end_testcase "Unable to start rwhod on $LHOST"
> -        PID=1
> +        LHOST_PID=$(pgrep -x rwhod)
>           sleep $SLEEPTIME
>       fi
>   
> -    if ! rsh -n -l root $RHOST ps -ef | awk '/rwhod/ && $0 !~ /awk/'; then
> +    if [ "$(rsh -n -l root $RHOST pgrep -x rwhod)" == "" ]; then
>           tst_resm TINFO "Starting rwhod on $RHOST"
> -        if ! rsh -n -l root $RHOST /usr/sbin/rwhod; then
> -            end_testcase "Unable to start rwhod on $RHOST"
> -        fi
> -        RHOST_PID=$(rsh -n -l root $RHOST ps -ef | awk '/rwhod/ && $0 !~ /awk/ {print $2 ; exit}')
> +        rsh -n -l root $RHOST /usr/sbin/rwhod
> +        RHOST_PID=$(rsh -n -l root $RHOST pgrep -x rwhod)
>           if [ -z "$RHOST_PID" ]; then
> -            RHOST_PID=0
>               end_testcase "Unable to start rwhod on $RHOST"
>           fi
>           sleep $SLEEPTIME
> @@ -92,7 +89,6 @@ do_setup()
>       if [ -z "$RHOSTNAME" ]; then
>           end_testcase "Unable to determine RHOSTNAME"
>       fi
> -
>   }
>   
>   #-----------------------------------------------------------------------
> @@ -103,7 +99,6 @@ do_setup()
>   
>   do_test()
>   {
> -
>       while [ $TST_COUNT -le $NUMLOOPS ]; do
>           rwho -a > $OUTFILE
>           HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
> @@ -130,18 +125,15 @@ do_test()
>   
>   do_cleanup()
>   {
> -    if [ $PID -ne 0 ]; then
> +    if [ -n "$LHOST_PID" ]; then
>           tst_resm TINFO "Stopping rwhod on $LHOST"
>           killall rwhod
>       fi
>   
> -    if [ $RHOST_PID -ne 0 ]; then
> +    if [ -n "$RHOST_PID" ]; then
>           tst_resm TINFO "Stopping rwhod on $RHOST"
>           rsh -n -l root $RHOST "killall rwhod"
>       fi
> -
> -    tst_cleanup
> -
>   }
>   
>   #-----------------------------------------------------------------------
> @@ -154,4 +146,5 @@ do_cleanup()
>   read_opts $*
>   do_setup
>   do_test
> +do_cleanup
>   end_testcase


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
