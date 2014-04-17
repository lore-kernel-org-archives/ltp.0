Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WalmG-0006X2-OH
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 12:50:52 +0000
Date: Thu, 17 Apr 2014 14:50:04 +0200
From: chrubis@suse.cz
Message-ID: <20140417125003.GA949@rei>
References: <534FA1A9.10902@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534FA1A9.10902@oracle.com>
Subject: Re: [LTP] [PATCH v2] containers/netns:parameters are not correct
 when calling, crtchild() function
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
To: Shuang Qiu <shuang.qiu@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The numbers of parameters for crtchild() function which called in
> two_children_ns.c and par_chld_ipv6.c is not correct.And it will make
> the child process to be a zombie process.
> And also move the definition of the function to the header file(common.h)
> 
> Signed-off-by: shuang.qiu@oracle.com
> ---
>   testcases/kernel/containers/libclone/libclone.h    |    2 -
>   testcases/kernel/containers/netns/common.c         |   18 +-------
>   testcases/kernel/containers/netns/common.h         |   47 
> ++++++++++++++++++++
>   .../kernel/containers/netns/create_container.c     |    2 +-
>   testcases/kernel/containers/netns/crtchild.c       |    2 +-
>   .../kernel/containers/netns/crtchild_delchild.c    |    2 +-
>   testcases/kernel/containers/netns/par_chld_ftp.c   |    2 +-
>   testcases/kernel/containers/netns/par_chld_ipv6.c  |    5 +--
>   testcases/kernel/containers/netns/sysfsview.c      |    2 +-
>   .../kernel/containers/netns/two_children_ns.c      |    5 +--
>   10 files changed, 57 insertions(+), 30 deletions(-)
>   create mode 100644 testcases/kernel/containers/netns/common.h
> 
> diff --git a/testcases/kernel/containers/libclone/libclone.h 
> b/testcases/kernel/containers/libclone/libclone.h
> index 9380cec..6a2d66d 100644
> --- a/testcases/kernel/containers/libclone/libclone.h
> +++ b/testcases/kernel/containers/libclone/libclone.h
> @@ -77,8 +77,6 @@
>   #define CLONE_NEWNET        0x40000000
>   #endif
> 
> -extern int create_net_namespace(char *, char *);
> -
>   /*
>    * Run fn1 in a unshared environmnent, and fn2 in the original context
>    * Fn2 may be NULL.
> diff --git a/testcases/kernel/containers/netns/common.c 
> b/testcases/kernel/containers/netns/common.c
> index 291aeb7..67e1a2e 100644
> --- a/testcases/kernel/containers/netns/common.c
> +++ b/testcases/kernel/containers/netns/common.c
> @@ -26,23 +26,7 @@
> 
>   #define _GNU_SOURCE
> 
> -#include <sys/utsname.h>
> -#include <sched.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/syscall.h>
> -#include <unistd.h>
> -#include <signal.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <libgen.h>
> -#include <fcntl.h>
> -#include <inttypes.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include "libclone.h"
> -#include "test.h"
> -#include "config.h"

These should have stayed here, only headers that are needed for types
used in the common.h header should be moved there (if I'm looking right
theare are none in this case).

> +#include "common.h"
> 
>   static int child_fn(void *c1);
> 
> diff --git a/testcases/kernel/containers/netns/common.h 
> b/testcases/kernel/containers/netns/common.h
> new file mode 100644
> index 0000000..c769a7f
> --- /dev/null
> +++ b/testcases/kernel/containers/netns/common.h
> @@ -0,0 +1,47 @@
> +/*
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License as published by
> +* the Free Software Foundation; either version 2 of the License, or
> +* (at your option) any later version.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +* the GNU General Public License for more details.
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 
> 02110-1301 USA
> +*
> +***************************************************************************/
> +/*=========================================================================
> +* This testcase creates the network namespace.
> +* It creates veth pair veth8 & veth9. Also assigns IP addresses to the 
> childNS.
> +* Also it starts the sshd daemon @ port 7890
> +*
> +* Scripts Used: parentns.sh childns.sh
> +*
> +* Author:         Veerendra <veeren@linux.vnet.ibm.com>
> +=========================================================================*/

I would omit this comment, it does not add any usefull information, just
keep the license here.

> +#include <sys/utsname.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <libgen.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include "libclone.h"
> +#include "test.h"
> +#include "config.h"
> +
> +int crtchild(char *s1, char *s2);
> +
> +int create_net_namespace(char *p1, char *c1);

You shoud add include guards around the header includes and prototypes.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
