From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 11:27:17 +0200
Subject: [LTP] [PATCH] netns_helper.sh: use 'ping -6' when ping6 is not
 avaliable
In-Reply-To: <1535514684-26111-1-git-send-email-Lei.Yang@windriver.com>
References: <1535514684-26111-1-git-send-email-Lei.Yang@windriver.com>
Message-ID: <20180831092717.GA13058@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lei,

> ping6 has been merged into ping since 2015 by using "ping -6"
> in some distrubiton like open embeded, they droped ping6 completely
> this patch will let both "ping -6" and ping6 work

I raised similar patch for tst_ping() (tst_net.sh) in the past [1]
(it wasn't accepted and I wouldn't be for accepting it now).

ping is used in many scripts (most of them are "network tests", which use
tst_net.sh, netns_helper.sh is the only exception), so it'd be good to have
general solution.

Old iputils versions (before s20150815) didn't have -4/-6 switches, new ones
leave creating ping6 symlink to distros (see [2]).  We could use simple
solution: just to require ping6 (tst_test_cmds ping6), as symlink can be done by
user anywhere in the path (even with root access, which is expected anyway for
many tests) + document it in testcases/network/README.md.
I'd prefer this solution.

Or we can create some helper, which does this check (not sure the name,
tst_ping() is already used).


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2016-December/003312.html
[2] https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  testcases/kernel/containers/netns/netns_helper.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index 6aea10b..e3f60e1 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -168,7 +168,12 @@ netns_setup()
>  	ipv6)
>  		IFCONF_IN6_ARG="inet6 add"
>  		IP0=$6; IP1=$7;
> -		tping="ping6"; NETMASK=64
> +		if which ping6 >/dev/null 2>&1; then
FYI: There is a helper tst_cmd_available(), but it's just for new shell API (tst_test.sh).

> +		    tping="ping6" 
> +		else
> +		    tping="ping -6"
> +		fi
> +		NETMASK=64
>  		;;
>  	*)
>  		tst_brkm TBROK "second argument must be an ip version (ipv4|ipv6)"
