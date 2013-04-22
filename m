Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UU6JK-0005Nq-Nu
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 02:16:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UU6JJ-0008Tk-Ap
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 02:16:54 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3M2GoBe021341
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Apr 2013 10:16:50 +0800
Message-ID: <51749DA3.60200@cn.fujitsu.com>
Date: Mon, 22 Apr 2013 10:17:07 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5170BAC7.1010202@cn.fujitsu.com>
In-Reply-To: <5170BAC7.1010202@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]syscalls/adjtimex01.c: cleanup
Reply-To: gaowanlong@cn.fujitsu.com
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 04/19/2013 11:32 AM, DAN LI wrote:
> 
> cleanup for syscalls/adjtimex01.c
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Applied, thank you.

Wanlong Gao

> ---
>  testcases/kernel/syscalls/adjtimex/adjtimex01.c | 84 +++++--------------------
>  1 file changed, 17 insertions(+), 67 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex01.c b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> index 000a979..b995e8e 100644
> --- a/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> +++ b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> @@ -12,57 +12,18 @@
>   * You should have received a copy of the GNU General Public License along
>   * with this program; if not, write the Free Software Foundation, Inc.,
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
>   */
> -/**********************************************************
> - *
> - *    TEST IDENTIFIER	: adjtimex01
> - *
> - *    EXECUTED BY	: root / superuser
> - *
> - *    TEST TITLE	: Basic test for adjtimex(2)
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	This is a Phase I test for the adjtimex(2) system call.
> - *	It is intended to provide a limited exposure of the system call.
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *	  Save current parameters in tim_save
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  call adjtimex with saved timex structure
> - *	  Check return value is between 0 & 5
> - *		Test passed
> - *	  Otherwise
> - *		Test failed
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - * adjtimex01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
> - *			where,  -c n : Run n copies concurrently.
> - *				-e   : Turn on errno logging.
> - *				-h   : Show help screen
> - *				-f   : Turn off functional testing
> - *				-i n : Execute test n times.
> - *				-I x : Execute test for x seconds.
> - *				-p   : Pause for SIGUSR1 before starting
> - *				-P x : Pause for x seconds between iterations.
> - *				-t   : Turn on syscall timing.
> - *
> - ****************************************************************/
> +
> +/*
> +  AUTHOR: Saji Kumar.V.R <saji.kumar@wipro.com>
> +  EXECUTED BY: root / superuser
> +
> +  TEST ITEMS:
> +   1. Check to see if adjtimex succeed with mode combination :
> +      ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR |
> +      ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK
> +   2. Check to see if adjtimex succeed with mode ADJ_OFFSET_SINGLESHOT
> +*/
> 
>  #if defined UCLINUX && !__THROW
>  /* workaround for libc bug causing failure in sys/timex.h */
> @@ -74,11 +35,11 @@
>  #include "test.h"
>  #include "usctest.h"
> 
> -#define SET_MODE ( ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
> -	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK )
> +#define SET_MODE (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
> +	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
> 
> -static void setup();
> -static void cleanup();
> +static void setup(void);
> +static void cleanup(void);
> 
>  char *TCID = "adjtimex01";
>  int TST_TOTAL = 1;
> @@ -87,7 +48,6 @@ static struct timex tim_save;
> 
>  int main(int ac, char **av)
>  {
> -
>  	int lc;
>  	char *msg;
> 
> @@ -118,10 +78,8 @@ int main(int ac, char **av)
>  	tst_exit();
>  }
> 
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup()
> +static void setup(void)
>  {
> -
>  	tst_require_root(NULL);
> 
>  	tim_save.modes = 0;
> @@ -136,15 +94,7 @@ void setup()
>  			 "failed to save current parameters");
>  }
> 
> -/*
> - *cleanup() -  performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup()
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	TEST_CLEANUP;
>  }
> 


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
