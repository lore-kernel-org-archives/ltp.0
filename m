From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 19 Apr 2018 17:33:41 +0300
Subject: [LTP] [PATCH v2 2/2] network/in6_02: Rewrite to the new library
In-Reply-To: <20180419131135.23693-2-pvorel@suse.cz>
References: <20180419131135.23693-1-pvorel@suse.cz>
 <20180419131135.23693-2-pvorel@suse.cz>
Message-ID: <9f01f7dc-0b27-1ee1-9ace-f877ff68610f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/19/2018 04:11 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/lib6/in6_02.c | 224 ++++++++++++++++++++--------------------
>  1 file changed, 110 insertions(+), 114 deletions(-)
> 
> diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
> index e1a71d987..e3a92f519 100644
> --- a/testcases/network/lib6/in6_02.c
> +++ b/testcases/network/lib6/in6_02.c
> @@ -1,115 +1,95 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *   Author: David L Stevens
> + * Author: David L Stevens
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -/*
> - *   Description:
> - *     Tests for name to index and index to name functions in IPv6
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Description:
> + * IPv6 name to index and index to name function tests
>   */
>  
> +
> +#include <stdlib.h>
> +#include <stdio.h>
>  #include <unistd.h>
>  #include <errno.h>
>  #include <sys/socket.h>
>  #include <net/if.h>
>  
> -#include "test.h"
> +#include "tst_test.h"
> +
> +#define I2N_RNDCOUNT	10	/* random ints */
> +#define I2N_LOWCOUNT	10	/* sequential from 0 */
>  
>  static struct {
>  	char *name;
>  	int nonzero;
> -} n2i[] = {
> +} test_case[] = {
>  	{ "lo", 1 },
>  	{ NULL, 1 },
>  	{ "hoser75", 0 },
>  	{ "6", 0 },
>  };
>  
> -#define N2I_COUNT (sizeof(n2i)/sizeof(n2i[0]))
> -#define I2N_RNDCOUNT	10	/* random ints */
> -#define I2N_LOWCOUNT	10	/* sequential from 0 */
> -
>  static void setup(void);
> -static void n2itest(void);
> -static void i2ntest(void);
> -static void initest(void);
> -
> -static void (*testfunc[])(void) = { n2itest,
> -	i2ntest, initest };
> +static void if_nametoindex_test(void);
> +static void if_indextoname_test(void);
> +static void if_nameindex_test(void);
>  
> -char *TCID = "in6_02";
> -int TST_TOTAL = ARRAY_SIZE(testfunc);
> +static void (*testfunc[])(void) = { if_nametoindex_test, if_indextoname_test,
> +	if_nameindex_test };
>  
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++)
> -			(*testfunc[i])();
> -	}
> -
> -	tst_exit();
> -}
> -
> -/* if_nametoindex tests */
> -void n2itest(void)
> +static void if_nametoindex_test(void)
>  {
>  	unsigned int i;
>  	char ifname[IF_NAMESIZE], *pifn;
>  
> -	for (i = 0; i < N2I_COUNT; ++i) {
> -		if (n2i[i].name == NULL) {
> -			tst_resm(TCONF, "LHOST_IFACES not defined or invalid, skip testing it");
> +	tst_res(TINFO, "IPv6 if_nametoindex() test");
> +
> +	for (i = 0; i < ARRAY_SIZE(test_case); ++i) {
> +		if (test_case[i].name == NULL) {
> +			tst_res(TCONF, "LHOST_IFACES not defined or invalid, skip testing it");
>  			return;
>  		}
>  
> -		TEST(if_nametoindex(n2i[i].name));
> -		if (!TEST_RETURN != !n2i[i].nonzero) {
> -			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
> -				"[should be %szero]", n2i[i].name, TEST_RETURN,
> -				n2i[i].nonzero ? "non" : "");
> +		TEST(if_nametoindex(test_case[i].name));
> +		if (!TEST_RETURN != !test_case[i].nonzero) {
> +			tst_res(TFAIL, "if_nametoindex(%s) %ld [should be %szero]",
> +					test_case[i].name, TEST_RETURN, test_case[i].nonzero ? "non"

This line is over 80 chars. test_case[i].nonzero can be moved to the next line:

> +					: "");

                                        test_case[i].nonzero ? "non" : ""

>  			return;
>  		}
>  		if (TEST_RETURN) {
>  			pifn = if_indextoname(TEST_RETURN, ifname);
> -			if (!pifn || strcmp(n2i[i].name, pifn)) {
> -				tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
> -					"doesn't match if_indextoname(%ld) "
> -					"\"%s\"", n2i[i].name, TEST_RETURN,
> -					TEST_RETURN, pifn ? pifn : "");
> +			if (!pifn || strcmp(test_case[i].name, pifn)) {
> +				tst_res(TFAIL,
> +					"if_nametoindex(%s) %ld doesn't match if_indextoname(%ld) \"%s\"",
> +					test_case[i].name, TEST_RETURN, TEST_RETURN, pifn ? pifn

Here as well:
                                        pifn ? pifn : ""

> +						: "");
>  				return;
>  			}
>  		}
> -		tst_resm(TINFO, "if_nametoindex(\"%s\") %ld",
> -			n2i[i].name, TEST_RETURN);
> +		tst_res(TINFO, "if_nametoindex(%s) %ld",
> +			test_case[i].name, TEST_RETURN);
>  	}
>  
> -	tst_resm(TPASS, "if_nametoindex() tests succeed");
> +	tst_res(TPASS, "if_nametoindex() test succeed");
>  }


I don't think we need to return on TCONF, what about using 'continue' in
this loop. Remove the last "tst_res(TPASS, ...)" in the end of this
function, and change TINFO to TPASS in the end of the loop?

Otherwise it will skip the other test-cases after TCONF.

>  
> -int sub_i2ntest(unsigned int if_index)
> +static int sub_if_indextoname_test(unsigned int if_index)
>  {
>  	char ifname[IF_NAMESIZE];
>  	unsigned int idx;
> @@ -117,48 +97,49 @@ int sub_i2ntest(unsigned int if_index)
>  	TEST((ifname == if_indextoname(if_index, ifname)));
>  	if (!TEST_RETURN) {
>  		if (TEST_ERRNO != ENXIO) {
> -			tst_resm(TFAIL, "if_indextoname(%d) returns %ld "
> -				 "but errno %d != ENXIO", if_index, TEST_RETURN,
> -				 TEST_ERRNO);
> +			tst_res(TFAIL,
> +				"if_indextoname(%d) returns %ld but errno %d != ENXIO",
> +				if_index, TEST_RETURN, TEST_ERRNO);
>  			return 0;
>  		}
> -		tst_resm(TINFO, "if_indextoname(%d) returns NULL", if_index);
> +		tst_res(TINFO, "if_indextoname(%d) returns NULL", if_index);
>  		return 1;
>  	}
>  	/* else, a valid interface-- double check name */
>  	idx = if_nametoindex(ifname);
>  	if (idx != if_index) {
> -		tst_resm(TFAIL, "if_indextoname(%u) returns \"%s\" but "
> -			 "doesn't if_nametoindex(\"%s\") returns %u",
> -			 if_index, ifname, ifname, idx);
> +		tst_res(TFAIL,
> +			"if_indextoname(%u) returns \"%s\" but doesn't if_nametoindex(%s) returns %u",
> +			if_index, ifname, ifname, idx);
>  		return 0;
>  	}
> -	tst_resm(TINFO, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
> +	tst_res(TINFO, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
>  	return 1;
>  }
>  
> -/* if_indextoname tests */
> -void i2ntest(void)
> +static void if_indextoname_test(void)
>  {
>  	unsigned int i;
>  
> +	tst_res(TINFO, "IPv6 if_indextoname() test");
> +
>  	/* some low-numbered indexes-- likely to get valid interfaces here */
>  	for (i = 0; i < I2N_LOWCOUNT; ++i)
> -		if (!sub_i2ntest(i))
> +		if (!sub_if_indextoname_test(i))
>  			return;	/* skip the rest, if broken */
>  	/* some random ints; should mostly fail */
>  	for (i = 0; i < I2N_RNDCOUNT; ++i)
> -		if (!sub_i2ntest(rand()))
> +		if (!sub_if_indextoname_test(rand()))
>  			return;	/* skip the rest, if broken */
>  
> -	tst_resm(TPASS, "if_indextoname() tests succeed");
> +	tst_res(TPASS, "if_indextoname() test succeed");
>  }
>  
>  /*
>   * This is an ugly, linux-only solution. getrusage() doesn't support the
>   * current data segment size, so we get it out of /proc
>   */
> -int getdatasize(void)
> +static int getdatasize(void)
>  {
>  	char line[128], *p;
>  	int dsize = -1;
> @@ -181,8 +162,7 @@ int getdatasize(void)
>  	return dsize;
>  }
>  
> -/* if_nameindex tests */
> -void initest(void)
> +static void if_nameindex_test(void)
>  {
>  	struct if_nameindex *pini;
>  	int i;
> @@ -191,79 +171,84 @@ void initest(void)
>  	int freenicount;
>  	int dsize_before, dsize_after;
>  
> +	tst_res(TINFO, "IPv6 if_nameindex() test");
> +
>  	pini = if_nameindex();
>  	if (pini == NULL) {
> -		tst_resm(TFAIL, "if_nameindex() returns NULL, errno %d (%s)",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> +		tst_res(TFAIL, "if_nameindex() returns NULL, errno %d (%s)",
> +			TEST_ERRNO, strerror(TEST_ERRNO));
>  		return;
>  	}
>  	for (i = 0; pini[i].if_index; ++i) {
>  		p = if_indextoname(pini[i].if_index, buf);
>  		if (!p || strcmp(p, pini[i].if_name)) {
> -			tst_resm(TFAIL, "if_nameindex idx %d name \"%s\" but "
> -				 "if_indextoname(%d) is \"%s\"",
> -				 pini[i].if_index, pini[i].if_name,
> -				 pini[i].if_index, p ? p : "");
> +			tst_res(TFAIL,
> +				"if_nameindex idx %d name \"%s\" but if_indextoname(%d) is \"%s\"",
> +				pini[i].if_index, pini[i].if_name,
> +				pini[i].if_index, p ? p : "");
>  			return;
>  		}
>  		idx = if_nametoindex(pini[i].if_name);
>  		if (idx != pini[i].if_index) {
> -			tst_resm(TFAIL, "if_nameindex idx %d name \"%s\" but "
> -				 "if_indextoname(\"%s\") is %d",
> -				 pini[i].if_index, pini[i].if_name,
> -				 pini[i].if_name, idx);
> +			tst_res(TFAIL,
> +				"if_nameindex idx %d name \"%s\" but if_indextoname(%s) is %d",
> +				pini[i].if_index, pini[i].if_name,
> +				pini[i].if_name, idx);
>  			return;
>  		}
> -		tst_resm(TINFO, "if_nameindex idx %d name \"%s\"",
> +		tst_res(TINFO, "if_nameindex idx %d name \"%s\"",
>  			 pini[i].if_index, pini[i].if_name);
>  	}
>  	if_freenameindex(pini);
>  
> -	/* if_freenameindex() has no error conditions; see if we run
> +	/*
> +	 * if_freenameindex() has no error conditions; see if we run
>  	 * out of memory if we do it a lot.
>  	 */
>  	dsize_before = getdatasize();
>  	if (dsize_before < 0) {
> -		tst_brkm(TBROK, NULL, "getdatasize failed: errno %d (%s)",
> +		tst_brk(TBROK, "getdatasize failed: errno %d (%s)",
>  			errno, strerror(errno));
>  	}
> -	/* we need to leak at least a page to detect a leak; 1 byte per call
> +
> +	/*
> +	 * we need to leak at least a page to detect a leak; 1 byte per call
>  	 * will be detected with getpagesize() calls.
>  	 */
>  	freenicount = getpagesize();
>  	for (i = 0; i < freenicount; ++i) {
>  		pini = if_nameindex();
>  		if (pini == NULL) {
> -			tst_resm(TINFO, "if_freenameindex test failed "
> -				 "if_nameindex() iteration %d", i);
> +			tst_res(TINFO,
> +				"if_freenameindex test failed if_nameindex() iteration %d", i);
>  			break;
>  		}
>  		if_freenameindex(pini);
>  	}
>  	dsize_after = getdatasize();
>  	if (dsize_after < 0) {
> -		tst_brkm(TBROK, NULL, "getdatasize failed: errno %d (%s)",
> +		tst_brk(TBROK, "getdatasize failed: errno %d (%s)",
>  			errno, strerror(errno));
>  	}
>  	if (dsize_after > dsize_before + getpagesize()) {
> -		tst_resm(TFAIL, "if_freenameindex leaking memory "
> -			 "(%d iterations) dsize before %d dsize after %d", i,
> -			 dsize_before, dsize_after);
> +		tst_res(TFAIL,
> +			"if_freenameindex leaking memory (%d iterations) dsize before %d dsize after %d",
> +			i, dsize_before, dsize_after);
>  		return;
> -	} else {
> -		tst_resm(TINFO, "if_freenameindex passed %d iterations", i);
>  	}
> +	tst_res(TINFO, "if_freenameindex passed %d iterations", i);
>  
> -	tst_resm(TPASS, "if_nameindex() tests succeed");
> +	tst_res(TPASS, "if_nameindex() test succeed");
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> -	TEST_PAUSE;
> -
>  	char *ifnames = getenv("LHOST_IFACES");
> -	if (!ifnames)
> +
> +	if (!ifnames) {
> +		tst_res(TINFO, "LHOST_IFACES not defined, it will not be tested");


And this seems to be over 80 too, you could either put it to the next
one or better just edit it a little bit so that it takes less space:

                tst_res(TINFO, "LHOST_IFACES not defined, it won't be tested");


So this is going to be printed on TCONF too, may be just left only one?


>  
>  	static char name[256];
>  	int ret;
> @@ -272,6 +257,17 @@ void setup(void)
>  	if (ret == -1)
>  		return;
>  
> -	tst_resm(TINFO, "get interface name from LHOST_IFACES: '%s'", name);
> -	n2i[1].name = name;
> +	tst_res(TINFO, "LHOST_IFACES \"%s\"", name);

tst_res(TINFO, "get interface name from LHOST_IFACES: '%s'", name); ?
