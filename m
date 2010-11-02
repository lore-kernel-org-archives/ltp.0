Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PD4tU-00077h-8e
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 00:38:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD4tR-0004DC-Ij
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 00:38:32 +0000
Message-ID: <4CCF5D84.3040709@cn.fujitsu.com>
Date: Tue, 02 Nov 2010 08:38:28 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CCE2C37.8050604@cn.fujitsu.com>
In-Reply-To: <4CCE2C37.8050604@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]fix a build error.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Bian Naimeng wrote:
> A build error is catched after applied commit da908058635ca58caf3e85814f2eba68febad1e1.
> 
> --------------
> Fix build error of kernel/syscalls/keyctl category.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

Hi Garrett,

Seems this patch has been applied, I think you'd better add the
"Signed-off-by" who posted this patch. ;)

Thanks,
Gui

> 
> ---
>  testcases/kernel/syscalls/keyctl/keyctl01.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
> index 0d3dc77..b8ab30e 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl01.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
> @@ -38,10 +38,13 @@
>  /*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
>  /******************************************************************************/
>  
> +#include <sys/types.h>
>  #include <linux/keyctl.h>
>  #include <errno.h>
>  #include <limits.h>
>  #include <stdio.h>
> +#include <keyutils.h>
> +
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
