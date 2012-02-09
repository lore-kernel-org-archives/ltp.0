Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RvWHe-0004ID-MT
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 15:51:42 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RvWHa-00031S-Dd
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 15:51:42 +0000
Message-ID: <4F33EB81.3010905@imgtec.com>
Date: Thu, 9 Feb 2012 15:51:29 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1328184278-19777-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1328184278-19777-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH] {tcp_cmds/echo,
 math/float}: Include missing usctest.h header
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
To: ltp-list@lists.sourceforge.net

On 02/02/2012 12:04 PM, Markos Chandras wrote:

> The tst_print function is using the TEST_ERRNO symbol which is declared
> as 'extern int' on usctest.h header when _USC_LIB_ macro is used and as 'int'
> when this macro is not defined. We need to include this header on float and
> echoes tests to ensure that TEST_ERRNO has been defined before calling
> the tst_print function. Without this header, the compilation will fail with
> an undefined symbol error.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  testcases/misc/math/float/main.c         |    1 +
>  testcases/network/tcp_cmds/echo/echoes.c |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
> index 8998c33..870661b 100644
> --- a/testcases/misc/math/float/main.c
> +++ b/testcases/misc/math/float/main.c
> @@ -26,6 +26,7 @@
>  #include "tfloat.h"
> 
>  #include "test.h"
> +#include "usctest.h"
> 
>  #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
>  /* LTP status reporting */
> diff --git a/testcases/network/tcp_cmds/echo/echoes.c b/testcases/network/tcp_cmds/echo/echoes.c
> index 877cfa5..2ce7968 100644
> --- a/testcases/network/tcp_cmds/echo/echoes.c
> +++ b/testcases/network/tcp_cmds/echo/echoes.c
> @@ -29,6 +29,7 @@
>  #include <fcntl.h>
>  #include "test.h"
>  #include "netdefs.h"
> +#include "usctest.h"
> 
>  #if INET6
>  char *TCID = "echoes6";
> @@ -372,4 +373,4 @@ void
>  cleanup(int s)
>  {
>  	close(s);
> -}
> \ No newline at end of file
> +}
> --
> 1.7.1
> 


Ping? Just making sure this patch reached the list this time.

-- 
markos


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
