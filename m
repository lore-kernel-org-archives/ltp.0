From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Sep 2015 03:41:51 -0400 (EDT)
Subject: [LTP] [PATCH] lib/test_net.sh: add waiting loop to netload()
In-Reply-To: <1442396622-29765-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396622-29765-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <675138819.13128994.1442475711763.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp@lists.linux.it
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Wednesday, 16 September, 2015 11:43:42 AM
> Subject: [LTP] [PATCH] lib/test_net.sh: add waiting loop to netload()
> 
> After starting background TCP server on remote host, check that
> it assigned specified port.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test_net.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 9df49d2..b42337a 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -282,6 +282,17 @@ tst_netload()
>  		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
>  		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
>  
> +		# check that tcp_fastopen on rhost in 'Listening' state
> +		local sec_waited=
> +		for sec_waited in $(seq 1 60); do
> +			tst_rhost_run -c "ss -ln | grep -q $port" && break

Isn't this too generic match? Can we add "-t" to ss parameters?
"ss -ln" gives me also unix sockets along with their inode numbers on output,
which seems they could easily match any port number.

Regards,
Jan

> +			if [ $sec_waited -eq 60 ]; then
> +				tst_resm TINFO "rhost not in LISTEN state"
> +				return 1
> +			fi
> +			sleep 1
> +		done
> +
>  		# run local tcp client
>  		tcp_fastopen -a $clients_num -r $client_requests -l \
>  			-H $ip_addr -g $port -d $rfile > /dev/null || ret=1
> --
> 1.7.1
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
