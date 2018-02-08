From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 8 Feb 2018 10:17:51 +0100
Subject: [LTP] [PATCH] controllers/cpuset_lib: Fix compiler error
In-Reply-To: <1518072964-31020-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1518072964-31020-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180208091751.pal74duma7dd6cgn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Before glibc 2.19, _DEFAULT_SOURCE wasn't added and led to compiler error.
> We replace _BSD_SOURCE, _XOPEN_SOURCE and _DEFAULT_SOURCE with _GNU_SOURCE.

> Fixes: 78fb665 ("controllers/cpuset: Fix compiler warning")

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> index 134a172..172e237 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> @@ -22,8 +22,7 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>   */

> -#define _XOPEN_SOURCE 500	/* need to see pread() */
> -#define _DEFAULT_SOURCE 1	/* need to see syscall() */
> +#define _GNU_SOURCE	/* need to see pread() and syscall() */
>  #include <unistd.h>

>  #include <ctype.h>
Thanks for fixing, pushed!
I should have checked it and tested it on old distros myself.


Kind regards,
Petr
