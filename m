From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 16 Feb 2018 12:49:44 +0300
Subject: [LTP] [RFC PATCH v2 3/3] test_net.sh: Add checks for external
	commands
In-Reply-To: <20180215204714.14597-3-pvorel@suse.cz>
References: <20180215204714.14597-1-pvorel@suse.cz>
 <20180215204714.14597-3-pvorel@suse.cz>
Message-ID: <913e5d05-a499-a1dc-6551-c07663b0c6ef@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15.02.2018 23:47, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
...
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index fa06e0991..ffb646d87 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -472,8 +472,10 @@ tst_netload()
>  
>  	local sock_cmd=
>  	if [ "$type" = "sctp" ]; then
> +		tst_check_cmds netstat
>  		sock_cmd="netstat -naS | grep $port | grep -q LISTEN"
>  	else
> +		tst_check_cmds ss
>  		sock_cmd="ss -ln$(echo $type | head -c1) | grep -q $port"
>  	fi

Hi Petr,

The changes looks good, I also have a draft patch that removes the
need for a socket checks in tst_netload(), so it should fix the problem
with netstat as well. I will send it soon.

Thanks,
Alexey
