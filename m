Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wf7xl-0003wa-2Q
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 13:20:45 +0000
Date: Tue, 29 Apr 2014 15:19:50 +0200
From: chrubis@suse.cz
Message-ID: <20140429131950.GB12523@rei>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395928590-28408-5-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395928590-28408-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 4/7] rpc-tirpc: the "bottom level" fixes
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> The functions from the "bottom level" TI-RPC API:
>  * svc_dg_create
>  * svc_vc_create
>  * clnt_dg_create
>  * clnt_vc_create
> do not accept RPC_ANYFD parameter. This parameter is for the "expert level" API.
> 
> These functions should be passed with a bound socket.
> 
> Implemented it using bound_socket() function.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  .../tirpc_bottomlevel_clnt_call.c                  |   18 ++++++++++++++--
>  .../tirpc_clnt_dg_create.c                         |   16 ++++++++++++++-
>  .../tirpc_clnt_vc_create.c                         |   18 +++++++++++++++-
>  .../tirpc_svc_dg_create.c                          |   16 ++++++++++++++-
>  .../tirpc_svc_vc_create.c                          |   21 +++++++++++++++++++-
>  5 files changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
> index 2498965..28d14ff 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call.c
> @@ -32,6 +32,8 @@
>  #include <netinet/in.h>
>  #include <tirpc/rpc/svc.h>
>  #include <errno.h>
> +#include <unistd.h>
> +#include "librpc-tirpc.h"
>  
>  #define PROCNUM 1
>  #define VERSNUM 1
> @@ -54,9 +56,10 @@ int main(int argn, char *argc[])
>  	int var_snd = 10;
>  	int var_rec = -1;
>  	struct timeval tv;
> +	int sock;
>  
> -	tv.tv_sec = 0;
> -	tv.tv_usec = 100;
> +	tv.tv_sec = 1;
> +	tv.tv_usec = 0;

You also modify timeout here, this should be mentioned in the commit
message as well.

>  	if (nconf == (struct netconfig *)NULL) {

I would also remove this useless casts (in a cleanup patch).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
