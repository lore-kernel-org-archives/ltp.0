From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 8 Jun 2017 13:53:16 +0300
Subject: [LTP] [RFC PATCH v6 08/11] lib/test_net.sh: reset_ltp_netspace()
In-Reply-To: <20170603120022.13415-9-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-9-pvorel@suse.cz>
Message-ID: <056a189d-c0d0-1dfa-f4a3-76917de949e7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/03/2017 03:00 PM, Petr Vorel wrote:
> This function is useful when we know we broke netns (e.g. unloading
> network driver).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 9 ++++++++-

Looks like it's not the right place for this function. Is it going to be
used in tests somehow?

What about adding it to network.sh with special option?

>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index f93f67411..91a62f9f6 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -42,12 +42,19 @@ init_ltp_netspace()
>  	tst_wait_ipv6_dad
>  }
>  
> +# Force to reset netns.
> +reset_ltp_netspace()
> +{
> +	[ -n "$TST_USE_NETNS" ] || return
> +	ip net del ltp_ns

With this patch
  3fb501e net: use LTP ns_create/ns_exec

rm -f /var/run/netns/ltp_ns
pkill ns_create


Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170608/40dd2380/attachment.html>
