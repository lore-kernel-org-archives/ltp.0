Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UdHSs-0006ei-1t
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 10:00:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdHSo-0005DV-67
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 10:00:42 +0000
Message-ID: <5195FABB.4010102@cn.fujitsu.com>
Date: Fri, 17 May 2013 17:39:07 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
In-Reply-To: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] waitid02: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 05/17/2013 04:59 PM, Jan Stancek wrote:
> Remove useless comments, convert spaces to tabs
> and fix long lines.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/waitid/waitid02.c |  104 +++++++++------------------
>  1 files changed, 33 insertions(+), 71 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
> index 98bf3ea..e265c32 100644
> --- a/testcases/kernel/syscalls/waitid/waitid02.c
> +++ b/testcases/kernel/syscalls/waitid/waitid02.c
> @@ -11,9 +11,9 @@
>  /* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
>  /* the GNU General Public License for more details.                           */
>  /*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> +/* You should have received a copy of the GNU General Public License along    */
> +/* with this program; if not, write to the Free Software Foundation,  Inc.,   */
> +/* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA                 */
>  /*                                                                            */
>  /******************************************************************************/
>  /******************************************************************************/
> @@ -54,55 +54,16 @@ char *TCID = "waitid02";
>  int testno;
>  int TST_TOTAL = 4;
>  
> -/* Extern Global Functions */
> -/******************************************************************************/
> -/*                                                                            */
> -/* Function:    cleanup                                                       */
> -/*                                                                            */
> -/* Description: Performs all one time clean up for this test on successful    */
> -/*              completion,  premature exit or  failure. Closes all temporary */
> -/*              files, removes all temporary directories exits the test with  */
> -/*              appropriate return code by calling tst_exit() function.       */
> -/*                                                                            */
> -/* Input:       None.                                                         */
> -/*                                                                            */
> -/* Output:      None.                                                         */
> -/*                                                                            */
> -/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*              On success - Exits calling tst_exit(). With '0' return code.  */
> -/*                                                                            */
> -/******************************************************************************/
> -extern void cleanup()
> +static void cleanup(void)
>  {
> -
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  
>  	tst_exit();
>  }
>  
> -/* Local  Functions */
> -/******************************************************************************/
> -/*                                                                            */
> -/* Function:    setup                                                         */
> -/*                                                                            */
> -/* Description: Performs all one time setup for this test. This function is   */
> -/*              typically used to capture signals, create temporary dirs      */
> -/*              and temporary files that may be used in the course of this    */
> -/*              test.                                                         */
> -/*                                                                            */
> -/* Input:       None.                                                         */
> -/*                                                                            */
> -/* Output:      None.                                                         */
> -/*                                                                            */
> -/* Return:      On failure - Exits by calling cleanup().                      */
> -/*              On success - returns 0.                                       */
> -/*                                                                            */
> -/******************************************************************************/
> -void setup()
> +static void setup(void)
>  {
> -	/* Capture signals if any */
> -	/* Create temporary directories */
>  	TEST_PAUSE;
>  	tst_tmpdir();
>  }
> @@ -112,7 +73,6 @@ int main(int ac, char **av)
>  	id_t pgid;
>  	id_t id1, id2, id3;
>  	siginfo_t infop;
> -	int i = 0;
>  
>  	int lc;
>  	char *msg;
> @@ -131,14 +91,14 @@ int main(int ac, char **av)
>  
>  			TEST(waitid(P_ALL, 0, &infop, WNOHANG));
>  			if (TEST_RETURN == -1)
> -				tst_resm(TPASS,
> -					 "Success1 ... -1 is returned. error is %d.",
> -					 TEST_ERRNO);
> +				tst_resm(TPASS, "Success1 ... -1 is returned."
> +					" error is %d.", TEST_ERRNO);
>  			else {
>  				tst_resm(TFAIL, "%s Failed1 ...", TCID);
>  			}
>  
> -			/* option == WEXITED | WCONTINUED | WSTOPPED | WNOHANG | WNOWAIT */
> +			/* option == WEXITED | WCONTINUED | WSTOPPED |
> +			 * WNOHANG | WNOWAIT */
>  
>  			TEST(id1 = fork());
>  			if (TEST_RETURN == 0) {
> @@ -170,9 +130,8 @@ int main(int ac, char **av)
>  
>  			TEST(waitid(P_ALL, 0, &infop, WNOHANG | WEXITED));
>  			if (TEST_RETURN == 0)
> -				tst_resm(TPASS,
> -					 "Success 2 ...0 is returned.. error is %d.",
> -					 TEST_ERRNO);
> +				tst_resm(TPASS, "Success 2 ...0 is returned.."
> +					" error is %d.", TEST_ERRNO);
>  			else {
>  				tst_resm(TFAIL | TTERRNO, "%s Failed 2", TCID);
>  				tst_exit();
> @@ -184,8 +143,8 @@ int main(int ac, char **av)
>  			TEST(waitid(P_PGID, pgid, &infop, WEXITED));
>  			if (TEST_RETURN == 0) {
>  				tst_resm(TPASS, "Success3 ... 0 is returned.");
> -				tst_resm(TINFO,
> -					 "si_pid = %d ; si_code = %d ; si_status = %d",
> +				tst_resm(TINFO, "si_pid = %d ; si_code = %d ;"
> +					" si_status = %d",
>  					 infop.si_pid, infop.si_code,
>  					 infop.si_status);
>  			} else {
> @@ -197,28 +156,29 @@ int main(int ac, char **av)
>  
>  			TEST(kill(id2, SIGSTOP));
>  
> -			TEST(i =
> -			     waitid(P_PID, id2, &infop, WSTOPPED | WNOWAIT));
> +			TEST(waitid(P_PID, id2, &infop, WSTOPPED | WNOWAIT));
>  			if (TEST_RETURN == 0) {
>  				/*EINVAL*/
> -				    tst_resm(TINFO,
> -					     "si_pid = %d, si_code = %d, si_status = %d",
> -					     infop.si_pid, infop.si_code,
> -					     infop.si_status);
> +				tst_resm(TINFO,	"si_pid = %d, si_code = %d,"
> +					" si_status = %d",
> +					infop.si_pid, infop.si_code,
> +					infop.si_status);
>  				tst_resm(TPASS, "Success4 ... 0 is returned");
>  			} else {
>  				tst_resm(TFAIL | TTERRNO,
> -					 "Fail4 ...  %d is returned", i);
> +					"Fail4 ...  %ld is returned",
> +					TEST_RETURN);
>  				tst_exit();
>  			}
>  
>  			TEST(waitid(P_PID, id3, &infop, WEXITED));
>  			if (TEST_RETURN == 0) {
>  				/*NOCHILD*/
> -				    tst_resm(TINFO,
> -					     "si_pid = %d, si_code = %d, si_status = %d",
> -					     infop.si_pid, infop.si_code,
> -					     infop.si_status);
> +				tst_resm(TINFO,
> +					"si_pid = %d, si_code = %d, "
> +					"si_status = %d",
> +					infop.si_pid, infop.si_code,
> +					infop.si_status);
>  				tst_resm(TPASS, "Success5 ... 0 is returned");
>  			} else {
>  				tst_resm(TFAIL | TTERRNO,
> @@ -227,17 +187,19 @@ int main(int ac, char **av)
>  				tst_exit();
>  			}
>  
> -			TEST(i = waitid(P_PID, id2, &infop, WCONTINUED));
> +			TEST(waitid(P_PID, id2, &infop, WCONTINUED));
>  			if (TEST_RETURN == 0) {
>  				/*EINVAL*/
> -				    tst_resm(TINFO,
> -					     "si_pid = %d, si_code = %d, si_status = %d",
> -					     infop.si_pid, infop.si_code,
> -					     infop.si_status);
> +				tst_resm(TINFO,
> +					"si_pid = %d, si_code = %d, "
> +					"si_status = %d",
> +					infop.si_pid, infop.si_code,
> +					infop.si_status);
>  				tst_resm(TPASS, "Success6 ... 0 is returned");
>  			} else {
>  				tst_resm(TFAIL | TTERRNO,
> -					 "Fail6 ...  %d is returned", i);
> +					 "Fail6 ...  %ld is returned",
> +					 TEST_RETURN);
>  				tst_exit();
>  			}
>  
> 


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
