Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RiOxL-00034j-9G
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 11:24:31 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiOxF-0003KC-Eb
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 11:24:31 +0000
Message-ID: <4F0436E2.1040800@imgtec.com>
Date: Wed, 4 Jan 2012 11:24:18 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1325676128-15770-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1325676128-15770-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to
 uintmax_t type
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

On 01/04/2012 11:22 AM, Markos Chandras wrote:
> st_nlink type is arch specific so it may not be a 32-bit integer everywhere.
> We cast it to uintmax_t which is defined on every arch and use the %ju modifier
> to print its value
>
> Signed-off-by: Markos Chandras<markos.chandras@imgtec.com>
> ---
>   testcases/kernel/syscalls/link/link02.c       |    7 ++++---
>   testcases/kernel/syscalls/link/link03.c       |   11 ++++++-----
>   testcases/kernel/syscalls/link/link05.c       |    9 +++++----
>   testcases/kernel/syscalls/symlink/symlink01.c |    6 +++---
>   4 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
> index 4ddd818..0092868 100644
> --- a/testcases/kernel/syscalls/link/link02.c
> +++ b/testcases/kernel/syscalls/link/link02.c
> @@ -115,6 +115,7 @@
>   #include<errno.h>
>   #include<string.h>
>   #include<signal.h>
> +#include<stdint.h>
>   #include "test.h"
>   #include "usctest.h"
>
> @@ -188,9 +189,9 @@ int main(int ac, char **av)
>   						 Fname, Lname, TEST_RETURN);
>   				else {
>   					tst_resm(TFAIL,
> -						 "link(%s, %s) returned %ld, stat link cnts do not match %d %d",
> +						 "link(%s, %s) returned %ld, stat link cnts do not match %ju %ju",
>   						 Fname, Lname, TEST_RETURN,
> -						 fbuf.st_nlink, lbuf.st_nlink);
> +						 (uintmax_t)fbuf.st_nlink, (uintmax_t)lbuf.st_nlink);
>   				}
>   			}
>   			if (unlink(Lname) == -1) {
> @@ -249,4 +250,4 @@ void cleanup()
>
>   	tst_rmdir();
>
> -}
> \ No newline at end of file
> +}
> diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
> index f2f85b5..f56b073 100644
> --- a/testcases/kernel/syscalls/link/link03.c
> +++ b/testcases/kernel/syscalls/link/link03.c
> @@ -116,6 +116,7 @@
>   #include<errno.h>
>   #include<string.h>
>   #include<signal.h>
> +#include<stdint.h>
>   #include "test.h"
>   #include "usctest.h"
>
> @@ -229,18 +230,18 @@ int main(int ac, char **av)
>   				    (fbuf.st_nlink != lbuf.st_nlink)) {
>
>   					tst_resm(TFAIL,
> -						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
> +						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %ju %ju",
>   						 Fname, Basename, nlinks,
>   						 TEST_RETURN, nlinks,
> -						 fbuf.st_nlink, lbuf.st_nlink);
> +						 (uintmax_t)fbuf.st_nlink, (uintmax_t)lbuf.st_nlink);
>   					break;
>   				}
>   			}
>   			if (cnt>= nlinks) {
>   				tst_resm(TPASS,
> -					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
> +					 "link(%s, %s[1-%d]) ret %ld for %ju files, stat linkcounts match %d",
>   					 Fname, Basename, nlinks, TEST_RETURN,
> -					 nlinks, fbuf.st_nlink);
> +					 nlinks, (uintmax_t)fbuf.st_nlink);
>   			}
>   		} else
>   			Tst_count++;
> @@ -313,4 +314,4 @@ void cleanup()
>
>   	tst_rmdir();
>
> -}
> \ No newline at end of file
> +}
> diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
> index 343db1b..91fb6c4 100644
> --- a/testcases/kernel/syscalls/link/link05.c
> +++ b/testcases/kernel/syscalls/link/link05.c
> @@ -115,6 +115,7 @@
>   #include<errno.h>
>   #include<string.h>
>   #include<signal.h>
> +#include<stdint.h>
>   #include "test.h"
>   #include "usctest.h"
>
> @@ -214,10 +215,10 @@ int main(int ac, char **av)
>   				    (fbuf.st_nlink != lbuf.st_nlink)) {
>
>   					tst_resm(TFAIL,
> -						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
> +						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %ju %ju",
>   						 Fname, Basename, nlinks,
>   						 TEST_RETURN, nlinks,
> -						 fbuf.st_nlink, lbuf.st_nlink);
> +						 (uintmax_t)fbuf.st_nlink, (uintmax_t)lbuf.st_nlink);
>   					break;
>   				}
>   			}
> @@ -225,7 +226,7 @@ int main(int ac, char **av)
>   				tst_resm(TPASS,
>   					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
>   					 Fname, Basename, nlinks, TEST_RETURN,
> -					 nlinks, fbuf.st_nlink);
> +					 nlinks, (int)fbuf.st_nlink);
>   			}
>   		} else
>   			Tst_count++;
> @@ -337,4 +338,4 @@ void cleanup()
>
>   	tst_rmdir();
>
> -}
> \ No newline at end of file
> +}
> diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
> index c7be331..f09a9df 100644
> --- a/testcases/kernel/syscalls/symlink/symlink01.c
> +++ b/testcases/kernel/syscalls/symlink/symlink01.c
> @@ -1555,9 +1555,9 @@ struct all_test_cases *tc_ptr;
>
>   						tst_resm(TFAIL,
>   							 "%slink(%s, %s) failed to adjust link count.\n\
> -		count for nick is %d, count for %s is %d, count for %s is %d.",
> -							 Buffer, tc_ptr->fn_arg[1], "nick", statter.st_nlink, tc_ptr->fn_arg[1], asymlink.st_nlink, tc_ptr->fn_arg[2],
> -							 stbuf.st_nlink);
> +		count for nick is %ju, count for %s is %ju, count for %s is %ju.",
> +							 Buffer, tc_ptr->fn_arg[1], "nick", (uintmax_t)statter.st_nlink, tc_ptr->fn_arg[1], (uintmax_t)asymlink.st_nlink, tc_ptr->fn_arg[2],
> +							(uintmax_t) stbuf.st_nlink);
>   					}
>   				} else {
>   					tst_resm(TFAIL, "%sA lstat of %s (ino:%jd) and of\n\t\t\


This patch fixes the one I sent earlier. There was a typo (%jd instaed 
of %ju on link03.c file )

-- 
markos


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
