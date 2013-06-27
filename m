Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UsF0x-0006yY-8m
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 16:25:43 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsF0v-000539-5u
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 16:25:43 +0000
Date: Thu, 27 Jun 2013 12:25:34 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <538407137.757498.1372350334215.JavaMail.root@redhat.com>
In-Reply-To: <1372146532-3182-1-git-send-email-liuhangbin@gmail.com>
References: <1372146532-3182-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] networking/stress/tcp: make sure we will kill
	the	test case after timeout
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

----- Original Message -----
> From: "Hangbin Liu" <liuhangbin@gmail.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, 25 June, 2013 9:48:52 AM
> Subject: [LTP] [PATCH] networking/stress/tcp: make sure we will kill the	test case after timeout
> 
> In some old machines or guests, the system may not have the ability to set up
> all the connections, e.g. 4000 tcp connections, quickly. Then the system will
> take lots of time to try setup the connections or just huang there.
> 
> I think we should just kill all the connections after testing timeout, no
> matter how many connections we have setup. So mv the connecting setup while
> loop into whatchdog while loop.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Hi,

correct me if I'm reading this wrong.

By moving it to watchdog loop you allow only 1 connection per second,
then taking your example number (4000), it is going to take 4000 seconds.
Should we also lower that sleep?

Regards,
Jan

> ---
>  .../stress/tcp/multi-diffip/tcp4-multi-diffip01    | 62
>  ++++++++++-----------
>  .../stress/tcp/multi-diffnic/tcp4-multi-diffnic01  | 28 +++++-----
>  .../tcp/multi-diffport/tcp4-multi-diffport01       | 64
>  +++++++++++-----------
>  .../tcp/multi-sameport/tcp4-multi-sameport01       | 33 +++++------
>  4 files changed, 94 insertions(+), 93 deletions(-)
> 
> diff --git a/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
> b/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
> index 8b9652c..58fdde7 100644
> --- a/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
> +++ b/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
> @@ -389,41 +389,41 @@ done
>  server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
>  rm -f $info_file
>  
> -# Make connections
>  connection_num=0
> -while [ $connection_num -lt $ipaddr_pair_num ]; do
> -    # IP addresses
> -    x=`expr $connection_num \/ 255 % 255`
> -    y=`expr $connection_num % 255`
> -
> -    case $IP_VER in
> -	4)
> -	lhost_addr="10.${x}.${y}.2"
> -	;;
> -
> -	6)
> -	hex_x=`printf %x $x`
> -	hex_y=`printf %x $y`
> -	lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
> -	;;
> -    esac
> -
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port' ; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	if [ $connection_num -eq 0 ]; then
> -	    tst_resm TFAIL "Failed to run any client"
> -		exit 1
> -	else
> -	    tst_resm TINFO "$connection_num seems the maximum number of the client"
> -	fi
> -	break
> -    fi
> -    connection_num=`expr $connection_num + 1`
> -done
> -
>  # Watch the TCP traffic server
>  start_epoc=`date +%s`
>  while true ; do
> +	# Make connections
> +	if [ $connection_num -lt $ipaddr_pair_num ]; then
> +		# IP addresses
> +		x=`expr $connection_num \/ 255 % 255`
> +		y=`expr $connection_num % 255`
> +
> +		case $IP_VER in
> +			4)
> +				lhost_addr="10.${x}.${y}.2"
> +				;;
> +
> +			6)
> +				hex_x=`printf %x $x`
> +				hex_y=`printf %x $y`
> +				lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
> +				;;
> +		esac
> +
> +		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port' ; echo $?'`
> +		if [ $ret -ne 0 ]; then
> +			if [ $connection_num -eq 0 ]; then
> +				tst_resm TFAIL "Failed to run any client"
> +				exit 1
> +			else
> +				tst_resm TINFO "$connection_num seems the maximum number of the client"
> +			fi
> +			break
> +		fi
> +		connection_num=`expr $connection_num + 1`
> +	fi
> +
>      current_epoc=`date +%s`
>      elapse_epoc=`expr $current_epoc - $start_epoc`
>  
> diff --git a/testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
> b/testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
> index dc9e784..6a5a72c 100644
> --- a/testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
> +++ b/testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
> @@ -340,24 +340,24 @@ done
>  server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
>  rm -f $info_file
>  
> -# Main loop
>  connection_num=0
> -while [ $connection_num -lt $link_total ]; do
> -    field=`expr $connection_num + 1`
> -    lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
> -
> -    # Run a client
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port'; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	tst_resm TFAIL "Failed to run client on Link${connection_num}"
> -	exit 1
> -    fi
> -    connection_num=`expr $connection_num + 1`
> -done
> -
>  # Watch the TCP traffic server
>  start_epoc=`date +%s`
>  while true ; do
> +	# Main loop
> +	if [ $connection_num -lt $link_total ]; then
> +		field=`expr $connection_num + 1`
> +		lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
> +
> +		# Run a client
> +		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port'; echo $?'`
> +		if [ $ret -ne 0 ]; then
> +			tst_resm TFAIL "Failed to run client on Link${connection_num}"
> +			exit 1
> +		fi
> +		connection_num=`expr $connection_num + 1`
> +	fi
> +
>      current_epoc=`date +%s`
>      elapse_epoc=`expr $current_epoc - $start_epoc`
>  
> diff --git
> a/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
> b/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
> index e260d35..1b9f342 100644
> --- a/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
> +++ b/testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
> @@ -320,44 +320,44 @@ fi
>  start_port=`echo $portbundle | cut -f 1 -d '-'`
>  end_port=`echo $portbundle | cut -f 2 -d '-'`
>  
> -# Making connections
>  connection_num=0
>  current_port=$start_port
> -while [ $current_port -le $end_port ]; do
> -    # Run a server
> -    ns-tcpserver -b -f $IP_VER -p $current_port
> -    if [ $? -ne 0 ]; then
> -	# Failed to start no server
> -	if [ $connection_num -eq 0 ]; then
> -	    tst_resm TFAIL "Failed to run a server"
> -	    exit 1
> -	fi
> -	# Failed to start a server
> -	tst_resm TINFO "$connection_num seems the maximum number of the server"
> -	break
> -    fi
> -
> -    # Run a clinet
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $current_port' ; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	# Failed to start any client
> -	if [ $connection_num -eq 0 ]; then
> -	    tst_resm TFAIL "Failed to run any client."
> -	    exit 1
> -	fi
> -	# Failed to start a client
> -	tst_resm TINFO "$connection_num seems the maximum number of the client"
> -	break
> -    fi
> -
> -    current_port=`expr $current_port + 1`
> -    connection_num=`expr $connection_num + 1`
> -done
> -
>  
>  # Watch the TCP traffic server
>  start_epoc=`date +%s`
>  while true ; do
> +	# Making connections
> +	if [ $current_port -le $end_port ]; then
> +		# Run a server
> +		ns-tcpserver -b -f $IP_VER -p $current_port
> +		if [ $? -ne 0 ]; then
> +			# Failed to start no server
> +			if [ $connection_num -eq 0 ]; then
> +				tst_resm TFAIL "Failed to run a server"
> +				exit 1
> +			fi
> +			# Failed to start a server
> +			tst_resm TINFO "$connection_num seems the maximum number of the server"
> +			break
> +		fi
> +
> +		# Run a clinet
> +		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $current_port' ; echo $?'`
> +		if [ $ret -ne 0 ]; then
> +			# Failed to start any client
> +			if [ $connection_num -eq 0 ]; then
> +				tst_resm TFAIL "Failed to run any client."
> +				exit 1
> +			fi
> +			# Failed to start a client
> +			tst_resm TINFO "$connection_num seems the maximum number of the client"
> +			break
> +		fi
> +
> +		current_port=`expr $current_port + 1`
> +		connection_num=`expr $connection_num + 1`
> +	fi
> +
>      current_epoc=`date +%s`
>      elapse_epoc=`expr $current_epoc - $start_epoc`
>      if [ $elapse_epoc -ge $NS_DURATION ]; then
> diff --git
> a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> index aff2481..206a0d1 100644
> --- a/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> +++ b/testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
> @@ -334,27 +334,28 @@ done
>  server_pid=`grep PID: $info_file | cut -f 2 -d ' '`
>  rm -f $info_file
>  
> -# Making connections
>  connection_num=0
> -while [ $connection_num -lt $CONNECTION_TOTAL ]; do
> -    # Run a client
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port' ; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	# Failed to start any client
> -	if [ $connection_num -eq 0 ]; then
> -	    tst_resm TFAIL "Failed to run any client"
> -	    exit 1
> -	fi
> -	# Failed to start a client
> -	tst_resm TINFO "$connection_num seems the maximum number of the client"
> -	break
> -    fi
> -    connection_num=`expr $connection_num + 1`
> -done
>  
>  # Watch the TCP traffic server
>  start_epoc=`date +%s`
>  while true ; do
> +	# Making connections
> +	if [ $connection_num -lt $CONNECTION_TOTAL ]; then
> +		# Run a client
> +		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-tcpclient -b -f $IP_VER
> -S $lhost_addr -p $server_port' ; echo $?'`
> +		if [ $ret -ne 0 ]; then
> +			# Failed to start any client
> +			if [ $connection_num -eq 0 ]; then
> +				tst_resm TFAIL "Failed to run any client"
> +				exit 1
> +			fi
> +			# Failed to start a client
> +			tst_resm TINFO "$connection_num seems the maximum number of the client"
> +			break
> +		fi
> +		connection_num=`expr $connection_num + 1`
> +	fi
> +
>      current_epoc=`date +%s`
>      elapse_epoc=`expr $current_epoc - $start_epoc`
>  
> --
> 1.8.1.4
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Windows:
> 
> Build for Windows Store.
> 
> http://p.sf.net/sfu/windows-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
