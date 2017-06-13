From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jun 2017 12:59:54 +0200
Subject: [LTP] [PATCH v2] syscalls/write01.c: Add test with different
 buffer sizes && Remove write02
In-Reply-To: <1497252431-8344-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <20170526141655.GE6492@rei.lan>
 <1497252431-8344-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20170613105953.GA29757@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/write/write01.c |  40 +++++---
>  testcases/kernel/syscalls/write/write02.c | 146 ------------------------------

If you are removing a test you have to update runtest/* files as well as
syscalls/.gitignore.

> diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
> index 1a60052..14fa7c9 100644
> --- a/testcases/kernel/syscalls/write/write01.c
> +++ b/testcases/kernel/syscalls/write/write01.c
> @@ -20,17 +20,9 @@
>   * You should have received a copy of the GNU General Public License along
>   * with this program; if not, write the Free Software Foundation, Inc.,
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>   */
>  
> +#include <stdio.h>

Isn't memset() defined in string.h? Or for which definition do we need
stdio.h here?

>  #include <errno.h>
>  #include "tst_test.h"
>  
> @@ -38,17 +30,35 @@ static int fd;
>  
>  static void verify_write(void)
>  {
> -	TEST(write(fd, "w", 1));
> +	int i, badcount = 0;
> +	char buf[BUFSIZ];
> +
> +	memset(buf, 'w', BUFSIZ);
>  
> -	if (TEST_RETURN == -1)
> -		tst_res(TFAIL | TTERRNO, "write(2) failed");
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +
> +	for (i = BUFSIZ; i > 0; i--) {
> +		TEST(write(fd, &buf, i));

The &buf == buf for arrays, but I find simply passing buf a bit less
confusing.

> +		if (TEST_RETURN == -1) {
> +			tst_res(TFAIL | TTERRNO, "write failed");
> +			return;
> +		}
> +
> +		if (TEST_RETURN != i) {
> +			badcount++;
> +			tst_res(TINFO, "bad write count");

Maybe we should write something as:

"write() returned %ld, expected %d", TEST_RETURN, i

> +		}
> +	}
> +
> +	if (badcount != 0)
> +		tst_res(TFAIL, "write() failed to return proper count");
>  	else
> -		tst_res(TPASS, "write(2) returned %ld", TEST_RETURN);
> +		tst_res(TPASS, "write() passed");
>  }

Otherwise it looks OK.

-- 
Cyril Hrubis
chrubis@suse.cz
