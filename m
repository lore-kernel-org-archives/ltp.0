From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 18:10:50 +0200
Subject: [LTP] [PATCH] proc01: handle EOPNOTSUPP if
	!hugepages_supported()
In-Reply-To: <f4698e880d970a74fb613191748487183cf35e08.1465311184.git.jstancek@redhat.com>
References: <f4698e880d970a74fb613191748487183cf35e08.1465311184.git.jstancek@redhat.com>
Message-ID: <20160607161049.GB5810@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/kernel/fs/proc/proc01.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
> index 2825b51dff95..409d6f9e32fe 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -108,6 +108,8 @@ static const struct mapping known_issues[] = {
>  	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
>  	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
>  	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
> +	{"read", "/proc/sys/vm/nr_hugepages", EOPNOTSUPP},
> +	{"read", "/proc/sys/vm/nr_overcommit_hugepages", EOPNOTSUPP},
>  	{"", "", 0}

Looking at my bugzilla it suggests:

+ {"read", "/proc/sys/vm/nr_hugepages_mempolicy", EOPNOTSUPP}

as well.

-- 
Cyril Hrubis
chrubis@suse.cz
