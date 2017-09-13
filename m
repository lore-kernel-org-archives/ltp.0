From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 13 Sep 2017 15:18:29 +0300
Subject: [LTP] [PATCH v3 2/2] lib6/in6_01: Add bind() while testing
	sockaddr_in6
In-Reply-To: <20170912072030.15667-2-pvorel@suse.cz>
References: <20170912072030.15667-1-pvorel@suse.cz>
 <20170912072030.15667-2-pvorel@suse.cz>
Message-ID: <7bd85b03-79d8-e512-c420-a61c577c1705@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/12/2017 10:20 AM, Petr Vorel wrote:
> + rewrite to use new API
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/lib6/in6_01.c | 180 ++++++++++++++++++++--------------------
>  1 file changed, 91 insertions(+), 89 deletions(-)
>
> diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
> index 70e771357..1878f0f4f 100644
> --- a/testcases/network/lib6/in6_01.c
> +++ b/testcases/network/lib6/in6_01.c
> @@ -1,36 +1,34 @@
>  /*
> +   Copyright (c) International Business Machines Corp., 2001
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
> +
>  /*
> - *   Description:
> - *     Verify that in6 and sockaddr fields are present. Most of these are
> - *     "PASS" if they just compile.
> + * Description: Verify that in6 and sockaddr fields are present.
>   */
>  
> -#include <stdio.h>
> -#include <unistd.h>
>  #include <errno.h>
> -
> -#include <netinet/in.h>
>  #include <arpa/inet.h>
> +#include <netinet/in.h>
> +#include <sys/socket.h>
>  
> -#include "test.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>  
>  static struct {
>  	char *addr;
> @@ -58,43 +56,33 @@ static struct {
>  
>  #define SSSIZE (sizeof(sstab)/sizeof(sstab[0]))
>  
> -static void setup(void);
>  static void test_in6_addr(void);
>  static void test_sockaddr_in6(void);
>  static void test_global_in6_def(void);
>  static void test_in6_is_addr_v4mapped(void);
>  static void test_sockaddr_storage(void);
>  
> -static void (*testfunc[])(void) = { test_in6_addr,
> -	test_sockaddr_in6, test_global_in6_def,
> -	test_in6_is_addr_v4mapped, test_sockaddr_storage };
> -
> -char *TCID = "in6_01";
> -int TST_TOTAL = ARRAY_SIZE(testfunc);
> -
> -int main(int argc, char *argv[])
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++)
> -			(*testfunc[i])();
> -	}
> -
> -	tst_exit();
> -}
> +struct test_case {
> +	void (*test)(void);
> +};
> +static struct test_case tcase[] = {
> +	{
> +		.test = test_in6_addr,
> +	},
> +	{
> +		.test = test_sockaddr_in6,
> +	},
> +	{
> +		.test = test_global_in6_def,
> +	},
> +	{
> +		.test = test_in6_is_addr_v4mapped,
> +	},
> +	{
> +		.test = test_sockaddr_storage,
> +	},
> +};

I don't think it is necessary to wrap function pointers with a struct since
there is no additional fields there.

Also I've got minor style warnings from checkpatch:

WARNING: Missing a blank line after
declarations                                                   
#159: FILE:
testcases/network/lib6/in6_01.c:118:                                                   

+       int sd = SAFE_SOCKET(AF_INET6, SOCK_STREAM,
0);                                            
+       bind(sd, (struct sockaddr *)&sin6,
sizeof(sin6));                                          

WARNING: Comparisons should place the constant on the right side of the test
#230: FILE: testcases/network/lib6/in6_01.c:171:                           
+               if (TEST_RETURN == maptab[i].ismap)


Best regards,
Alexey

