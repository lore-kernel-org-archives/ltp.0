Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlLmm-00009l-PL
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 16:46:52 +0000
Date: Tue, 26 Nov 2013 17:46:22 +0100
From: chrubis@suse.cz
Message-ID: <20131126164622.GD14089@rei.suse.cz>
References: <1384514055.12576.15.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384514055.12576.15.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] confstr/confstr01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> cleanup the confstr01.c test case.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/confstr/confstr01.c | 183 ++++++++++----------------
>  1 file changed, 73 insertions(+), 110 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/confstr/confstr01.c b/testcases/kernel/syscalls/confstr/confstr01.c
> index f301b35..b6aebf1 100644
> --- a/testcases/kernel/syscalls/confstr/confstr01.c
> +++ b/testcases/kernel/syscalls/confstr/confstr01.c
> @@ -13,8 +13,8 @@
>   *   the GNU General Public License for more details.
>   *
>   *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *   along with this program;  if not, write to the Free Software Foundation,
> + *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
>  /* 11/20/2002	Port to LTP	robbiew@us.ibm.com */
> @@ -33,134 +33,97 @@
>   *
>   */
>  
> -#define _XOPEN_SOURCE	500
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <errno.h>
>  
> -#define INVAL_FLAG	-1
> -
> -/** LTP Port **/
>  #include "test.h"
>  #include "usctest.h"
> -
> -#define FAILED 0
> -#define PASSED 1
> -
> -int local_flag = PASSED;
> +#include "safe_macros.h"
> +
> +static struct test_case_t {
> +	int value;
> +	char *name;
> +} test_cases[] = {
> +	{_CS_PATH, "PATH"},
> +	{_CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS"},
> +	{_CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS"},
> +	{_CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS"},
> +	{_CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS"},
> +	{_CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS"},
> +	{_CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS"},
> +	{_CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS"},
> +	{_CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS"},
> +	{_CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS"},
> +	{_CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS"},
> +	{_CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS"},
> +	{_CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS"},
> +	{_CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS"},
> +	{_CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS"},
> +	{_CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS"},
> +	{_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS"},
> +};
>  
>  char *TCID = "confstr01";
> -int TST_TOTAL = 1;
> -/**************/
> -
> -int confstr_var_vals[] = { _CS_PATH, _CS_XBS5_ILP32_OFF32_CFLAGS,
> -	_CS_XBS5_ILP32_OFF32_LDFLAGS,
> -	_CS_XBS5_ILP32_OFF32_LIBS,
> -	_CS_XBS5_ILP32_OFF32_LINTFLAGS,
> -	_CS_XBS5_ILP32_OFFBIG_CFLAGS,
> -	_CS_XBS5_ILP32_OFFBIG_LDFLAGS,
> -	_CS_XBS5_ILP32_OFFBIG_LIBS,
> -	_CS_XBS5_ILP32_OFFBIG_LINTFLAGS,
> -	_CS_XBS5_LP64_OFF64_CFLAGS,
> -	_CS_XBS5_LP64_OFF64_LDFLAGS,
> -	_CS_XBS5_LP64_OFF64_LIBS,
> -	_CS_XBS5_LP64_OFF64_LINTFLAGS,
> -	_CS_XBS5_LPBIG_OFFBIG_CFLAGS,
> -	_CS_XBS5_LPBIG_OFFBIG_LDFLAGS,
> -	_CS_XBS5_LPBIG_OFFBIG_LIBS,
> -	_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,
> -	0
> -};
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
>  
> -char *confstr_vars[] = { "PATH", "XBS5_ILP32_OFF32_CFLAGS",
> -	"XBS5_ILP32_OFF32_LDFLAGS", "XBS5_ILP32_OFF32_LIBS",
> -	"XBS5_ILP32_OFF32_LINTFLAGS",
> -	"XBS5_ILP32_OFFBIG_CFLAGS",
> -	"XBS5_ILP32_OFFBIG_LDFLAGS",
> -	"XBS5_ILP32_OFFBIG_LIBS",
> -	"XBS5_ILP32_OFFBIG_LINTFLAGS",
> -	"XBS5_LP64_OFF64_CFLAGS",
> -	"XBS5_LP64_OFF64_LDFLAGS",
> -	"XBS5_LP64_OFF64_LIBS",
> -	"XBS5_LP64_OFF64_LINTFLAGS",
> -	"XBS5_LPBIG_OFFBIG_CFLAGS",
> -	"XBS5_LPBIG_OFFBIG_LDFLAGS",
> -	"XBS5_LPBIG_OFFBIG_LIBS",
> -	"XBS5_LPBIG_OFFBIG_LINTFLAGS",
> -	"XXX5_MYBIG_VERBIG_MYFLAGS",
> -	0
> -};
> +static void setup(void);
> +static void cleanup(void);
>  
> -int main()
> +int main(int argc, char *argv[])
>  {
> -	size_t len = 0, retval;	/* return values for confstr(3C) */
> +	int lc;
>  	int i;

Add the option parsing code here.

> -	char *buf = NULL;
> -
> -	tst_tmpdir();		/* Now temp file is open */
> -
> -/*--------------------------------------------------------------------------*/
> -
> -	errno = 0;
> -	for (i = 0; confstr_vars[i]; i++) {
> -		len = confstr(confstr_var_vals[i], NULL, (size_t) 0);
> -		if (len != 0) {
> -			/* Allocate space for the buffer with size len */
> -			if ((buf = (char *)malloc(len)) == NULL) {
> -				tst_resm(TFAIL,
> -					 "\tmalloc() fails, error= %d\n",
> -					 errno);
> -				local_flag = FAILED;
> -				break;
> -			}
> -			/* Better to reset memory space of buffer */
> -			memset(buf, 0, len);
> -
> -			/* Get the value of config. variables thur. confstr */
> -			retval = confstr(confstr_var_vals[i], buf, len);
> -			if (retval != len) {
> -				tst_resm(TFAIL,
> -					 "\tconfstr returns invalid value :%s for variable: %s\n",
> -					 buf, confstr_vars[i]);
> -				local_flag = FAILED;
> -
> -				/* Free the memory and exit from loop */
> +	char *buf;
> +	int len;
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			TEST(confstr(test_cases[i].value, NULL, (size_t)0));
> +			if (TEST_RETURN != 0) {
> +				len = TEST_RETURN;
> +				buf = SAFE_MALLOC(cleanup, len);
> +				memset(buf, 0, len);

There is no need to clear the buffer before it's passed to the confstr()
call.

> +				TEST(confstr(test_cases[i].value, buf, len));
> +				if (TEST_RETURN != len) {
> +					tst_brkm(TBROK, cleanup,
> +						 "confstr :%s failed",
> +						 test_cases[i].name);
> +				} else {
> +					tst_resm(TPASS, "confstr %s success",
> +						 test_cases[i].name);

I would check here that the buffer is zero terminated.

> +				}
>  				free(buf);

There is also no need to set the buf to NULL after the free()

> -				break;
> -			}
> -
> -			/* Free the memory allocated for config. name */
> -			free(buf);
> -			/* Reset the buffer contents to NULL */
> -			buf = '\0';
> -		} else {
> -			if (!buf) {
> -				if ((!strcmp("XXX5_MYBIG_VERBIG_MYFLAGS",
> -					     confstr_vars[i])) &&
> -				    (errno != EINVAL)) {
> +				buf = NULL;
> +			} else {
> +				if (TEST_ERRNO == EINVAL) {
> +					tst_resm(TCONF,
> +						 "confstr %s not supported",
> +						 test_cases[i].name);
> +				} else {
>  					tst_resm(TFAIL,
> -						 "\tconfstr returns invalid error %d\n",
> -						 errno);
> -					local_flag = FAILED;
> -					break;
> +						 "confstr %s failed",
> +						 test_cases[i].name);
>  				}
> -			} else {
> -				tst_resm(TFAIL,
> -					 "\tconfstr returns string value: %s for variable %s\n",
> -					 buf, confstr_vars[i]);
> -				local_flag = FAILED;
> -				break;
>  			}
>  		}
>  	}
> -	(local_flag == PASSED) ? tst_resm(TPASS, "Test Passed")
> -	    : tst_resm(TFAIL, "Test Failed");
>  
> -	tst_rmdir();
> -/*--------------------------------------------------------------*/
> -	tst_exit();		/* THIS CALL DOES NOT RETURN - EXITS!!  */
> -/*--------------------------------------------------------------*/
> +	cleanup();
> +
>  	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	TEST_PAUSE;
> +}
>  
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
