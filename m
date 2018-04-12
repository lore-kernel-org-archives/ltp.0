From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Apr 2018 19:45:25 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: don't init ltp_ns if custom
	is used
In-Reply-To: <1523549352-1794-1-git-send-email-alexey.kodanev@oracle.com>
References: <1523549352-1794-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <063172db-a8e0-c68a-0aa9-b430000ebc62@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12.04.2018 19:09, Alexey Kodanev wrote:
> We can define our own LTP_NETNS with custom setup, don't setup
> the default one in that particular case.
> 
...
> -	if [ ! -f /var/run/netns/ltp_ns ]; then
> +	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
>  		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
>  		pid="$(ROD ns_create net,mnt)"
>  		mkdir -p /var/run/netns
> @@ -112,6 +112,8 @@ init_ltp_netspace()
>  		ROD ns_exec $pid net,mnt mount -t sysfs none /sys
>  		ROD ns_ifmove ltp_ns_veth1 $pid
>  		ROD ns_exec $pid net,mnt ip li set lo up
> +	else

It should have been 'elif [ -n "$LTP_NETNS" ] ...' here instead.
Otherwise the info will be printed if "/var/run/netns/ltp_ns"
already exists.

> +		tst_res_ TINFO "using not default LTP netns: '$LTP_NETNS'"
>  	fi
>  
>  	LHOST_IFACES="${LHOST_IFACES:-ltp_ns_veth2}"
> 

