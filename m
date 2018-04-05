From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Apr 2018 15:43:17 +0200
Subject: [LTP] [PATCH 2/2] nfs06: decrease number of processes per
 fsstress run
In-Reply-To: <1522926355-18029-2-git-send-email-alexey.kodanev@oracle.com>
References: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
 <1522926355-18029-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180405134317.4ulzxuz2lfk36zfr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> From 50 to 10. It multiplies by number of mounts and
> can slow test execution significantly.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/network/nfs/nfs_stress/nfs06 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
> index eb35157..33c2d5a 100755
> --- a/testcases/network/nfs/nfs_stress/nfs06
> +++ b/testcases/network/nfs/nfs_stress/nfs06
> @@ -34,7 +34,7 @@ do_test()
>  	local n=0
>  	local pids
>  	for i in $VERSION; do
> -		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 50 -r -c > /dev/null &
> +		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 10 -r -c > /dev/null &
>  		pids="$pids $!"
>  		n=$(( n + 1 ))
>  	done

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
