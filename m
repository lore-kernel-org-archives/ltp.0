Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W8pkk-0003Bs-8M
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 11:25:50 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W8pki-0006tv-0N
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 11:25:50 +0000
Date: Thu, 30 Jan 2014 06:25:41 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <40442898.1671972.1391081141624.JavaMail.root@redhat.com>
In-Reply-To: <52DDD101.1020106@oracle.com>
References: <1387435409-557-1-git-send-email-xu.simon@oracle.com>
	<52BA38AD.7050500@oracle.com> <52DDD101.1020106@oracle.com>
MIME-Version: 1.0
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Simon Xu" <xu.simon@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 21 January, 2014 2:44:33 AM
> Subject: Re: [LTP] [PATCH] rwho01: fix mistakes
> 
> Could anyone help to review this?
> 
> Thanks
> Simon

Hi,

I tested your patch on RHEL5.3 and didn't come across any issues.

Tested-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

> 
> On 2013/12/25 9:45, Simon Xu wrote:
> > Could anyone help to review this?
> >
> > Thanks
> > Simon
> >
> > On 2013/12/19 14:43, Simon Xu wrote:
> >> 1) fix the way it checks whether rwhod is running
> >> 2) fix the way it checks whether rwhod is started on remote host
> >> 3) fix do_cleanup, and no need to call tst_cleanup() in do_cleanup()
> >>      because it's called in end_testcase anyways
> >> 4) call do_cleanup() after do_test()
> >> 5) shorten sleep time to 5 seconds as 20 seconds are not necessary
> >>
> >> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> >> ---
> >>    testcases/network/tcp_cmds/rwho/rwho01 | 31
> >>    ++++++++++++-------------------
> >>    1 file changed, 12 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/testcases/network/tcp_cmds/rwho/rwho01
> >> b/testcases/network/tcp_cmds/rwho/rwho01
> >> index eb31642..5f507ea 100755
> >> --- a/testcases/network/tcp_cmds/rwho/rwho01
> >> +++ b/testcases/network/tcp_cmds/rwho/rwho01
> >> @@ -48,14 +48,14 @@
> >>    #
> >>    #-----------------------------------------------------------------------
> >>    
> >> +LHOST_PID=""
> >> +RHOST_PID=""
> >> +
> >>    do_setup()
> >>    {
> >> -
> >>        TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
> >>    
> >> -    PID=0
> >> -    RHOST_PID=0
> >> -    SLEEPTIME=${SLEEPTIME:-20}
> >> +    SLEEPTIME=${SLEEPTIME:-5}
> >>        NUMLOOPS=${NUMLOOPS:-25}
> >>        OUTFILE=${OUTFILE:-$TCtmp/${TC}.out}
> >>    
> >> @@ -68,21 +68,18 @@ do_setup()
> >>    
> >>        trap do_cleanup EXIT
> >>    
> >> -    if ! ps -ef | awk '/rwhod/ && $0 !~ /awk/'; then
> >> +    if ! pgrep -x rwhod > /dev/null; then
> >>            tst_resm TINFO "Starting rwhod on $LHOST"
> >>            rwhod || end_testcase "Unable to start rwhod on $LHOST"
> >> -        PID=1
> >> +        LHOST_PID=$(pgrep -x rwhod)
> >>            sleep $SLEEPTIME
> >>        fi
> >>    
> >> -    if ! rsh -n -l root $RHOST ps -ef | awk '/rwhod/ && $0 !~ /awk/';
> >> then
> >> +    if [ "$(rsh -n -l root $RHOST pgrep -x rwhod)" == "" ]; then
> >>            tst_resm TINFO "Starting rwhod on $RHOST"
> >> -        if ! rsh -n -l root $RHOST /usr/sbin/rwhod; then
> >> -            end_testcase "Unable to start rwhod on $RHOST"
> >> -        fi
> >> -        RHOST_PID=$(rsh -n -l root $RHOST ps -ef | awk '/rwhod/ && $0 !~
> >> /awk/ {print $2 ; exit}')
> >> +        rsh -n -l root $RHOST /usr/sbin/rwhod
> >> +        RHOST_PID=$(rsh -n -l root $RHOST pgrep -x rwhod)
> >>            if [ -z "$RHOST_PID" ]; then
> >> -            RHOST_PID=0
> >>                end_testcase "Unable to start rwhod on $RHOST"
> >>            fi
> >>            sleep $SLEEPTIME
> >> @@ -92,7 +89,6 @@ do_setup()
> >>        if [ -z "$RHOSTNAME" ]; then
> >>            end_testcase "Unable to determine RHOSTNAME"
> >>        fi
> >> -
> >>    }
> >>    
> >>    #-----------------------------------------------------------------------
> >> @@ -103,7 +99,6 @@ do_setup()
> >>    
> >>    do_test()
> >>    {
> >> -
> >>        while [ $TST_COUNT -le $NUMLOOPS ]; do
> >>            rwho -a > $OUTFILE
> >>            HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
> >> @@ -130,18 +125,15 @@ do_test()
> >>    
> >>    do_cleanup()
> >>    {
> >> -    if [ $PID -ne 0 ]; then
> >> +    if [ -n "$LHOST_PID" ]; then
> >>            tst_resm TINFO "Stopping rwhod on $LHOST"
> >>            killall rwhod
> >>        fi
> >>    
> >> -    if [ $RHOST_PID -ne 0 ]; then
> >> +    if [ -n "$RHOST_PID" ]; then
> >>            tst_resm TINFO "Stopping rwhod on $RHOST"
> >>            rsh -n -l root $RHOST "killall rwhod"
> >>        fi
> >> -
> >> -    tst_cleanup
> >> -
> >>    }
> >>    
> >>    #-----------------------------------------------------------------------
> >> @@ -154,4 +146,5 @@ do_cleanup()
> >>    read_opts $*
> >>    do_setup
> >>    do_test
> >> +do_cleanup
> >>    end_testcase
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
