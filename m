Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxj3q-0001i2-Cq
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 15:13:14 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxj3m-0003i3-Mj
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 15:13:14 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DF5rbf012163
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:05:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DFD5UY250814
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:13:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DF7ssP027454
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:09:38 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910112034u423458afxd6242fb2d50eaa59@mail.gmail.com>
References: <364299f40910112034u423458afxd6242fb2d50eaa59@mail.gmail.com>
Date: Tue, 13 Oct 2009 20:14:12 +0530
Message-Id: <1255445052.8438.78.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Solve some netns app issues w/ missing utils,
	build-tree 	relative path to smount, and some other QA concerns
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

patching file childns.sh
Hunk #1 FAILED at 32.
1 out of 1 hunk FAILED -- saving rejects to file childns.sh.rej
patching file initialize.sh
patching file nw_under_ns.sh

You can make changes for this to the CVS.

Regards--
Subrata

On Sun, 2009-10-11 at 20:34 -0700, Garrett Cooper wrote: 
> 1. My Gentoo system lacks the ip utility, which is required for this
> test. So I took care of that issue by integrating this script in with
> the `cmdlib.sh' script's exist function.
> 2. Several variables were either improperly quoted, or incorrectly
> used. -eq, -lt, -ne, etc should be used for integers, = and != for
> strings.
> 3. When using ps | {awk,grep}, one must do filter out awk or grep,
> respectively, or the script will accidentally grab a false positive
> from the output, like so:
> 
> gcooper@orangebox ~ $ ps ax | grep ps | egrep -v 'mice|mouse'
> 21057 pts/4    R+     0:00 ps ax
> 21058 pts/4    S+     0:00 grep --colour=auto ps
> 
> 4. Block off the rest of the testcases if one of the prerequisite
> steps fails to initialize properly.
> 5. Fix up a build-tree dependent pathname to the smount script in the
> fs_bind directory.
> 
> Index: childns.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/netns/childns.sh,v
> retrieving revision 1.5
> diff -u -r1.5 childns.sh
> --- childns.sh	8 Jul 2009 17:53:47 -0000	1.5
> +++ childns.sh	12 Oct 2009 03:33:07 -0000
> @@ -32,59 +32,58 @@
>  # set -x
>  # The test case ID, the test case count and the total number of test case
> 
> -TCID=${TCID:-childns.sh}
> -TST_TOTAL=1
> -TST_COUNT=1
> -export TCID
> -export TST_COUNT
> -export TST_TOTAL
> -.  initialize.sh
> +export TCID=${TCID:-childns.sh}
> +. cmdlib.sh
> +exists awk grep ip ping sshd
> +. initialize.sh
>  status=0
> 
> -    if [ $# = 1 ] ; then
> -        childscrpt=$1
> -        debug "INFO: The script to be executed in child NS is $childscrpt"
> -    fi
> -
> -    # Passing the PID of child
> -    echo "child ready" > /tmp/FIFO1;
> -
> -    # waiting for the device name from parent
> -    vnet1=`cat /tmp/FIFO2`;
> -    debug "INFO: network dev name received $vnet1";
> -    # Assigning the dev addresses
> -    ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1
> -	if [ $? -ne 0 ]; then
> -		debug "Failed to make interface $vnet1 up in child....."
> -	fi
> +if [ $# -eq 1 ] ; then
> +    childscrpt=$1
> +    debug "INFO: The script to be executed in child NS is $childscrpt"
> +fi
> +
> +# Passing the PID of child
> +echo "child ready" > /tmp/FIFO1;
> +
> +# waiting for the device name from parent
> +vnet1=`cat /tmp/FIFO2`;
> +debug "INFO: network dev name received $vnet1";
> +# Assigning the dev addresses
> +if ! ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1 ; then
> +    debug "Failed to make interface $vnet1 up in child....."
> +fi
> +
> +ifconfig lo up
> +sleep 2
> +
> +#starting the sshd inside the child NS
> +if ! sshd -p $PORT; then
> +    debug "INFO: started the sshd @ port no $PORT"
> +    sshpid=`ps -ef | grep "sshd -p $PORT" | grep -v grep | awk '{
> print $2 ; exit 0} ' `
> +else
> +    tst_resm TFAIL "Failed in starting ssh @ port $PORT"
> +    cleanup $vnet1
> +    status=1
> +fi
> +
> +if [ $status -eq 0 ] ; then
> 
> -    ifconfig lo up ;
> -    sleep 2
> -
> -    #starting the sshd inside the child NS
> -    /usr/sbin/sshd -p $PORT
> -    if [ $? = 0 ]; then
> -        debug "INFO: started the sshd @ port no $PORT"
> -        sshpid=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `
> -    else
> -        tst_resm TFAIL "Failed in starting ssh @ port $PORT"
> -        status=1
> -    fi
> -
>      # checking if parent ns responding
> -    ping -q -c 2 $IP1 > /dev/null
> -    if [ $? != 0 ] ; then
> +    if ! ping -q -c 2 $IP1 > /dev/null ; then
>          tst_resm TFAIL "FAIL: ParentNS not responding"
>          status=1
>          cleanup $sshpid $vnet1
>          exit $status
>      fi
> -
> -    if [ -f  $childscrpt ]; then
> -        . $childscrpt
> +
> +    if [ -f "$childscrpt" ]; then
> +        . "$childscrpt"
>      fi
> -
> +
>      cleanup $sshpid $vnet1
>      debug "INFO: Done with executing child script $0, status is $status"
> -
> -    exit $status
> +
> +fi
> +
> +exit $status
> Index: initialize.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/netns/initialize.sh,v
> retrieving revision 1.5
> diff -u -r1.5 initialize.sh
> --- initialize.sh	23 Jun 2009 14:09:10 -0000	1.5
> +++ initialize.sh	12 Oct 2009 03:33:07 -0000
> @@ -25,60 +25,63 @@
>  # to be used and cleanup functions.
>  # set -x
> 
> -TCID=${TCID:-initialize}
> -TST_TOTAL=1
> -TST_COUNT=1
> -export TCID
> -export TST_COUNT
> -export TST_TOTAL
> -
> -IP1='192.168.0.181'
> -IP2='192.168.0.182'
> -IP3='192.168.0.183'
> -IP4='192.168.0.184'
> +export TCID=${TCID:-initialize}
> +export TST_TOTAL=1
> +export TST_COUNT=1
> +
> +TEST_SUBNET=${TEST_SUBNET:=192.168.0}
> +i=0
> +while [ $i -lt 4 ] ; do
> +    eval "IP${i}=\"$TEST_SUBNET.181\""
> +    (( i++ ))
> +done
>  mask=/24
>  PORT=7890
>  PORT2=9876
>  DEBUG=0
> 
> -    # set the LTPROOT directory
> -    cd `dirname $0`
> -    env | grep -q LTPROOT
> -    if [ $? -eq 0 ]; then
> -        FS_BIND=${LTPROOT}/testcases/kernel/fs/fs_bind/bin/smount
> -        if [ -f $FS_BIND ] ; then
> -            smount=$FS_BIND
> -        fi
> -    else
> -        tst_resm TFAIL "Please set the LTP root env variable, and retry again"
> -        exit -1
> -    fi
> -
> -    IPver=`ip -V | awk  -F"-" ' {  print $2 } '` ;
> -    if ! printf "%s\n%s\n" "ss080417" "$IPver" | sort -c ; then
> -        tst_resm  TINFO "ip version should be atleast ss080417"
> -        exit -1
> -    fi
> -    mkfifo /tmp/FIFO1 /tmp/FIFO2 /tmp/FIFO3 /tmp/FIFO4 /tmp/FIFO5
> /tmp/FIFO6 2> /dev/null
> +# set the LTPROOT directory
> +cd "${0##*/}"
> +if [ -n "${LTPROOT:-}" ]; then
> +    FS_BIND=${LTPROOT}/testcases/bin/smount
> +    if [ -f $FS_BIND ] ; then
> +        smount=$FS_BIND
> +    fi
> +else
> +    tst_resm TFAIL "Please set the LTP root env variable, and retry again"
> +    exit -1
> +fi
> +
> +IPver=`ip -V | awk  -F"-" ' { print $2 } '` ;
> +if ! printf "%s\n%s\n" "ss080417" "$IPver" | sort -c ; then
> +    tst_resm  TINFO "ip version should be atleast ss080417"
> +    exit -1
> +fi
> +i=1
> +while [ $i -le 6 ] ; do
> +    mkfifo /tmp/FIFO$i 2> /dev/null
> +    (( i++ ))
> +done
> +
> +netdev=`ip addr show | awk '/^[0-9]*:.*UP/ { a=$2 } /inet / { b=$2 ; \
> +        if ( a !~ /lo/  && b ! NULL ) {  print a ; exit 0 } } ' `
> +netdev=`basename $netdev ":"`
> +if [ -z "$netdev" ] ; then
> +    tst_resm  TINFO "Not able to determine the ethernet dev name"
> +    exit -1
> +fi
> +
> +# copying the values for restoring it later.
> +ipfwd=`cat /proc/sys/net/ipv4/ip_forward`
> +if [ -f "/proc/sys/net/ipv4/conf/$netdev/proxy_arp" ] ; then
> +    arpproxy=`cat /proc/sys/net/ipv4/conf/$netdev/proxy_arp`
> +else
> +    arpproxy=0
> +fi
> 
> -    netdev=`ip addr show | awk '/^[0-9]*:.*UP/ { a=$2 } /inet / { b=$2 ; \
> -            if ( a !~ /lo/  && b ! NULL ) {  print a ; exit 0 } } ' `
> -    netdev=`basename $netdev ":"`
> -    if [ -z $netdev ] ; then
> -        tst_resm  TINFO "Not able to determine the ethernet dev name"
> -        exit -1
> -    fi
> -
> -    # copying the values for restoring it later.
> -    ipfwd=`cat /proc/sys/net/ipv4/ip_forward`
> -    if [ -f /proc/sys/net/ipv4/conf/$netdev/proxy_arp ] ; then
> -        arpproxy=`cat /proc/sys/net/ipv4/conf/$netdev/proxy_arp`
> -    else
> -	arpproxy=0
> -    fi
>  cleanup()
>  {
> -   if [ $# = 2 ]; then
> +    if [ $# -eq 2 ]; then
>          pid=$1
>          netdev=$2
>      fi
> @@ -89,7 +92,7 @@
>      sleep 1
> 
>      #Restoring the orignial values .
> -    echo $ipfwd > /proc/sys/net/ipv4/ip_forward
> +    echo "$ipfwd" > /proc/sys/net/ipv4/ip_forward
>      if [ -f /proc/sys/net/ipv4/conf/$netdev/proxy_arp ] ; then
>      	echo $arpproxy > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
>      fi
> @@ -100,10 +103,7 @@
> 
>  debug()
>  {
> -    if [ "$DEBUG" = 1 ]
> -    then
> -        echo $1;
> -    fi
> +    [ "$DEBUG" = 1 ] && echo $1
>  }
> 
>  create_veth()
> @@ -112,8 +112,5 @@
>      ip link add type veth
>      sleep 1
>      ip link show > /tmp/net2
> -    eval `diff /tmp/net1 /tmp/net2 | awk -F": "  ' /^> [0-9]*:/ {
> print "dev" i+0 "=" $2; i++  }  '`
> +    eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ {
> print "dev" i+0 "=" $2; i++  }'`
>  }
> -
> -
> -
> Index: nw_under_ns.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/netns/nw_under_ns.sh,v
> retrieving revision 1.1
> diff -u -r1.1 nw_under_ns.sh
> --- nw_under_ns.sh	30 Dec 2008 06:25:50 -0000	1.1
> +++ nw_under_ns.sh	12 Oct 2009 03:33:07 -0000
> @@ -29,8 +29,7 @@
>  echo "*****************************************************"
>  echo "Running network testcases under containers..."
> 
> -create_container;
> -if [ $? -ne 0 ]; then
> -	echo "some of the network testcases under netns failled"
> +if ! create_container; then
> +	echo "some of the network testcases under netns failed"
>  	exit 1;
>  fi
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
