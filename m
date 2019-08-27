From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Aug 2019 15:22:05 +0300
Subject: [LTP] [PATCH] tst_net.sh: Fix root detection on netns on new
 shell API
In-Reply-To: <20190826141101.10144-1-pvorel@suse.cz>
References: <20190826141101.10144-1-pvorel@suse.cz>
Message-ID: <888e8f74-278c-ae3f-c8c5-3b8790f634d3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 26.08.2019 17:11, Petr Vorel wrote:
> When using LTP with netns ("Single Host Configuration"),
> init_ltp_netspace before running test which performs checking for
> TST_NEEDS_ROOT=1, therefore adding it is not enough.
> It fails on adding netns:
> 
> RTNETLINK answers: Operation not permitted
> sctp01 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed
> 
> NOTE: tst_restore_ipaddr is called before running tests only on netns,
> in init_ltp_netspace, therefore tst_require_root_ as a check is enough.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Alexey,
> 
> I also wanted to move variable setup (everything after
> tst_default_max_pkt() definition) to separate function and call it
> inside tst_net_setup() for new shell API, but all TST_* setup
> (currently at least TST_TMPDIR_RHOST=1 and TST_NEEDS_ROOT=1)
> would not work (we'd need to use tst_cleanup_rhost and _tst_require_root
> directly, which is IMHO not good).> 
> + We might want to cleanup variables (prefix library internal variables
> with _tst_net, use lower case), at least these two:
> s/ping6_warn_printed/_tst_net_ping6_warn_printed/g
> s/TST_PARSE_VARIABLES/_tst_net_parse_variables/g
> 

Agree

>  testcases/lib/tst_net.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 1678bcfda..5a149530c 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -105,7 +105,7 @@ tst_require_root_()
>  init_ltp_netspace()
>  {
>  	tst_test_cmds ip
> -	tst_require_root_
> +	[ -z "$TST_USE_LEGACY_API" ] && _tst_require_root || tst_require_root

Can we fix tst_require_root_() instead?

>  
>  	local pid=
>  
> 

