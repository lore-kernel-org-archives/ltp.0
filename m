Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1PaR7d-0001o1-J6
	for ltp-list@lists.sourceforge.net; Wed, 05 Jan 2011 11:01:41 +0000
Received: from smtp.nokia.com ([147.243.1.47] helo=mgw-sa01.nokia.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PaR7b-0008Qg-RF
	for ltp-list@lists.sourceforge.net; Wed, 05 Jan 2011 11:01:41 +0000
Date: Wed, 5 Jan 2011 13:00:29 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20110105130029.GA18322@hannu-debian.research.nokia.com>
References: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
Subject: Re: [LTP] [Bug Fix] utimensat01 can't build
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
To: ext Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On 29/12/10 10:35 +0100, ext Vivi wrote:
> LTP test case utimensat01.c can't build without file usctest.h.
> 
> Bellow is the patch:
> --
> Index: testcases/kernel/syscalls/utimensat/utimensat01.c
> ===================================================================
> --- testcases/kernel/syscalls/utimensat/utimensat01.c   (revision 161)
> +++ testcases/kernel/syscalls/utimensat/utimensat01.c   (revision 183)
> @@ -40,6 +40,7 @@
>  #include <string.h>
>  #include <sys/stat.h>
>  #include <test.h>
> +#include "usctest.h"
>  #include "linux_syscall_numbers.h"
> 
>  char *TCID = "utimensat01";    /* Test program identifier.    */
> --
> 
> 
> 
> Best regards,
> Vivi Li

Hi,

for your patch emails, can you please you format like:

Subject: [LTP] [PATCH] ....

and if secondary patch:

Subject: [LTP] [PATCH v2] ....

etc.

Instead of using [Bug Fix] or similar keywords.

Btw, is this btw described in ltp web site? 

br,
Hannu

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
