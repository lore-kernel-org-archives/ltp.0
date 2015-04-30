Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YnobY-0002lj-MR
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 13:34:16 +0000
Date: Thu, 30 Apr 2015 15:33:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430133344.GD24720@rei.suse.de>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1427787975-10668-4-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427787975-10668-4-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 4/6] lib6/asapi_06.c: cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  testcases/network/lib6/asapi_06.c | 374 +++++++++++++++++---------------------
>  1 file changed, 167 insertions(+), 207 deletions(-)
> 
> diff --git a/testcases/network/lib6/asapi_06.c b/testcases/network/lib6/asapi_06.c
> index 960ebb5..733d1c4 100644
> --- a/testcases/network/lib6/asapi_06.c
> +++ b/testcases/network/lib6/asapi_06.c
> @@ -1,6 +1,7 @@
>  /*
>   *
>   *   Copyright (c) International Business Machines  Corp., 2001
> + *   Author: David L Stevens
>   *
>   *   This program is free software;  you can redistribute it and/or modify
>   *   it under the terms of the GNU General Public License as published by
> @@ -13,25 +14,12 @@
>   *   the GNU General Public License for more details.
>   *
>   *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *   along with this program;  if not, write to the Free Software Foundation,
> + *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
> -
>  /*
> - * Test Name: asapi_06
> - *
> - * Test Description:
> - *  Tests for RFC 3542 section 4 socket options and ancillary data
> - *
> - * Usage:  <for command-line>
> - *  asapi_06
> - *
> - * HISTORY
> - *	05/2005 written by David L Stevens
> - *
> - * RESTRICTIONS:
> - *  None.
> - *
> + *   Description:
> + *     Tests for RFC 3542 section 4 socket options and ancillary data.
>   */
>  
>  #include "config.h"
> @@ -58,42 +46,46 @@
>  
>  #include "test.h"
>  
> -char *TCID = "asapi_06";	/* Test program identifier.    */
> -
> -int TST_TOTAL = 1;
> -
> -pid_t pid;
> +static void setup(void);
> +static void test_soent(void);
> +#ifdef notyet
> +static void test_pktinfo(void);
> +#endif
>  
> -struct {
> -	char *prt_name;
> -	int prt_value;
> -} ptab[] = {
> +static void (*testfunc[])(void) = {
> +	test_soent,
> +#ifdef notyet
> +	test_pktinfo,
> +#endif

Does the test actually works if we remove the ifdefs?

Looks to me like this has been implemented in kernel in 2005 in:

commit 333fad5364d6b457c8d837f7d05802d2aaf8a961
Author: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date:   Thu Sep 8 09:59:17 2005 +0900

[IPV6]: Support several new sockopt / ancillary data in Advanced API (RFC3542).


>  };
>  
> -#define PTCOUNT	(sizeof(ptab)/sizeof(ptab[0]))
> -
> -#define READ_TIMEOUT	5	/* secs */
> -
> -void do_tests(void);
> -void setup(void), cleanup(void);
> +char *TCID = "asapi_06";
> +int TST_TOTAL = ARRAY_SIZE(testfunc);
>  
>  int main(int argc, char *argv[])
>  {
>  	int lc;
> +	int i;
>  
>  	tst_parse_opts(argc, argv, NULL, NULL);
>  
> -	pid = getpid();
> -
>  	setup();
>  
> -	for (lc = 0; TEST_LOOPING(lc); ++lc)
> -		do_tests();
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++)
> +			(*testfunc[i])();
> +	}
>  
> -	cleanup();
>  	tst_exit();
>  }
>  
> +void setup(void)
> +{
> +	TEST_PAUSE;
> +}
> +
>  #define NH_TEST	0x9f
>  
>  #ifndef IPV6_RECVPKTINFO
> @@ -145,11 +137,6 @@ union soval {
>  	int sou_bool;
>  };
>  
> -/* in6_addr initializer for loopback interface */
> -#define IN6_LOOP	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
> -#define IN6_ANY		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> -
> -/* so_clrval and so_setval members are initilized in the body */
>  struct soent {
>  	char *so_tname;
>  	int so_opt;
> @@ -160,72 +147,63 @@ struct soent {
>  	union soval so_setval;
>  	socklen_t so_valsize;
>  } sotab[] = {
> -/* RFC 3542, Section 4 */
> -	{
> -		"IPV6_RECVPKTINFO", IPV6_RECVPKTINFO, 1, IPV6_PKTINFO, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_RECVHOPLIMIT", IPV6_RECVHOPLIMIT, 1, IPV6_HOPLIMIT, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_RECVRTHDR", IPV6_RECVRTHDR, 0, IPV6_RTHDR, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_RECVHOPOPTS", IPV6_RECVHOPOPTS, 0, IPV6_HOPOPTS, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_RECVDSTOPTS", IPV6_RECVDSTOPTS, 0, IPV6_DSTOPTS, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_RECVTCLASS", IPV6_RECVTCLASS, 1, IPV6_TCLASS, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)},
> -/* make sure TCLASS stays when setting another opt */
> -	{
> -		"IPV6_RECVTCLASS (2)", IPV6_RECVHOPLIMIT, 1, IPV6_TCLASS, 0, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)},
> -/* OLD values */
> -	{
> -		"IPV6_2292PKTINFO", IPV6_2292PKTINFO, 1, IPV6_2292PKTINFO, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_2292HOPLIMIT", IPV6_2292HOPLIMIT, 1, IPV6_2292HOPLIMIT, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_2292RTHDR", IPV6_2292RTHDR, 0, IPV6_2292RTHDR, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_2292HOPOPTS", IPV6_2292HOPOPTS, 0, IPV6_2292HOPOPTS, 1, { { { { {
> -		0}}}}}, { { { { {
> -	0}}}}}, sizeof(int)}, {
> -		"IPV6_2292DSTOPTS", IPV6_2292DSTOPTS, 0, IPV6_2292DSTOPTS, 1, { { { { {
> -		0}}}}}, { { { { {
> -0}}}}}, sizeof(int)},};
> +	/* RFC 3542, Section 4 */
> +	{ "IPV6_RECVPKTINFO", IPV6_RECVPKTINFO, 1, IPV6_PKTINFO, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_RECVHOPLIMIT", IPV6_RECVHOPLIMIT, 1, IPV6_HOPLIMIT, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_RECVRTHDR", IPV6_RECVRTHDR, 0, IPV6_RTHDR, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_RECVHOPOPTS", IPV6_RECVHOPOPTS, 0, IPV6_HOPOPTS, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_RECVDSTOPTS", IPV6_RECVDSTOPTS, 0, IPV6_DSTOPTS, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_RECVTCLASS", IPV6_RECVTCLASS, 1, IPV6_TCLASS, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	/* make sure TCLASS stays when setting another opt */
> +	{ "IPV6_RECVTCLASS (2)", IPV6_RECVHOPLIMIT, 1, IPV6_TCLASS, 0,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	/* OLD values */
> +	{ "IPV6_2292PKTINFO", IPV6_2292PKTINFO, 1, IPV6_2292PKTINFO, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_2292HOPLIMIT", IPV6_2292HOPLIMIT, 1, IPV6_2292HOPLIMIT, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_2292RTHDR", IPV6_2292RTHDR, 0, IPV6_2292RTHDR, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_2292HOPOPTS", IPV6_2292HOPOPTS, 0, IPV6_2292HOPOPTS, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +	{ "IPV6_2292DSTOPTS", IPV6_2292DSTOPTS, 0, IPV6_2292DSTOPTS, 1,
> +		{ { { { { 0 } } }, 0 } }, { { { { { 0 } } }, 0 } },
> +		sizeof(int) },
> +};
>  
>  #define SOCOUNT	(sizeof(sotab)/sizeof(sotab[0]))

ARRAY_SIZE()

>  struct soprot {
> -	int sop_pid;		/* sender PID */
> -	int sop_seq;		/* sequence # */
> -	int sop_dlen;		/* tp_dat length */
> -	unsigned char sop_dat[0];	/* user data */
> +	int sop_pid;        /* sender PID */
> +	int sop_seq;        /* sequence # */
> +	int sop_dlen;       /* tp_dat length */
> +	unsigned char sop_dat[0];   /* user data */
>  };
>  
>  unsigned char tpbuf[sizeof(struct soprot) + 2048];
>  unsigned char rpbuf[sizeof(struct soprot) + 2048];
>  
>  unsigned char control[2048];
> -int clen;
>  
>  int seq;
>  
> -int setupso(void)
> -{
> -/* add routing headers, other ancillary data here */
> -	return 0;
> -}
> -
>  struct cme {
>  	int cm_len;
>  	int cm_level;
> @@ -235,17 +213,13 @@ struct cme {
>  		uint32_t cmu_hops;
>  	} cmu;
>  } cmtab[] = {
> -	{
> -		sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {
> -		0x12}
> -	}
> -	, {
> -		sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {
> -		0x21}
> -	}
> -,};
> +	{ sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {0x12} },
> +	{ sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {0x21} },
> +};
> +
> +#define CMCOUNT (sizeof(cmtab)/sizeof(cmtab[0]))

ARRAY_SIZE()

> -#define CMCOUNT	(sizeof(cmtab)/sizeof(cmtab[0]))
> +unsigned int count;
>  
>  ssize_t sendall(int st)
>  {
> @@ -254,7 +228,8 @@ ssize_t sendall(int st)
>  	struct iovec iov;
>  	struct soprot *psop;
>  	unsigned char *pd;
> -	int i, ctotal;
> +	unsigned int i;
> +	int ctotal;
>  
>  	psop = (struct soprot *)tpbuf;
>  	psop->sop_pid = htonl(getpid());
> @@ -300,32 +275,29 @@ void so_test(struct soent *psoe)
>  	int st;
>  
>  	if (psoe->so_opt == -1) {
> -		tst_resm(TBROK, "%s not present at compile time",
> +		tst_brkm(TBROK, NULL, "%s not present at compile time",
>  			 psoe->so_tname);
> -		return;
>  	}
>  	if (psoe->so_clear || sr < 0) {
>  		if (sr < 0)
>  			close(sr);
>  		sr = socket(PF_INET6, SOCK_RAW, NH_TEST);
>  		if (sr < 0) {
> -			tst_resm(TBROK, "%s socket: %s", psoe->so_tname,
> -				 strerror(errno));
> -			return;
> +			tst_brkm(TBROK | TERRNO, NULL, "%s socket: %s",
> +				psoe->so_tname, strerror(errno));
                                           ^
                                Remove the strerror() if you added TERRNO

>  		}
>  	}
>  	memset(&sin6, 0, sizeof(sin6));
>  	sin6.sin6_family = AF_INET6;
>  	sin6.sin6_addr = in6addr_loopback;
>  	if (bind(sr, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
> -		tst_resm(TBROK, "%s: bind: %s", psoe->so_tname,
> -			 strerror(errno));
> +		tst_brkm(TBROK | TERRNO, NULL, "%s: bind: %s",
> +			psoe->so_tname, strerror(errno));

Here as well.

>  	}
>  	if (setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_clrval,
>  		       psoe->so_valsize) < 0) {
> -		tst_resm(TBROK, "%s: setsockopt: %s", psoe->so_tname,
> -			 strerror(errno));
> -		return;
> +		tst_brkm(TBROK | TERRNO, NULL, "%s: setsockopt: %s",
> +			psoe->so_tname, strerror(errno));

And here.

>  	}
>  	TEST(setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_setval,
>  			psoe->so_valsize));
> @@ -337,25 +309,23 @@ void so_test(struct soent *psoe)
>  	valsize = psoe->so_valsize;
>  	TEST(getsockopt(sr, SOL_IPV6, psoe->so_opt, &sobuf, &valsize));
>  	if (TEST_RETURN != 0) {
> -		tst_resm(TBROK, "%s set-get: getsockopt: %s", psoe->so_tname,
> -			 strerror(errno));
> -		return;
> -	} else if (memcmp(&psoe->so_setval, &sobuf, psoe->so_valsize))
> +		tst_brkm(TBROK | TTERRNO, NULL, "%s set-get: getsockopt: %s",
> +			psoe->so_tname, strerror(errno));

And here.

> +	} else if (memcmp(&psoe->so_setval, &sobuf, psoe->so_valsize)) {
>  		tst_resm(TFAIL, "%s set-get optval != setval", psoe->so_tname);
> -	else
> -		tst_resm(TPASS, "%s set-get", psoe->so_tname);
> +		return;
> +	} else {
> +		tst_resm(TINFO, "%s set-get", psoe->so_tname);
> +	}

Again why do we exit on first failure? And why don't we rather adjust the
number of testcases?

>  	st = socket(PF_INET6, SOCK_RAW, NH_TEST);
>  	if (st < 0) {
> -		tst_resm(TBROK, "%s transmit socket: %s", psoe->so_tname,
> -			 strerror(errno));
> -		return;
> +		tst_brkm(TBROK | TERRNO, NULL, "%s transmit socket: %s",
> +			psoe->so_tname, strerror(errno));

strerror() here as well.

>  	}
>  	if (sendall(st) < 0) {
> -		tst_resm(TBROK, "%s transmit sendto: %s", psoe->so_tname,
> -			 strerror(errno));
> -		close(st);
> -		return;
> +		tst_brkm(TBROK, NULL, "%s transmit sendto: %s",
> +			psoe->so_tname, strerror(errno));

And this should rather be changed to TBROK | TERRNO and the strerror() removed
to be consistent with the rest.

>  	}
>  	close(st);
>  
> @@ -382,14 +352,12 @@ void so_test(struct soent *psoe)
>  			if (nfds < 0) {
>  				if (errno == EINTR)
>  					continue;
> -				tst_resm(TBROK, "%s select: %s", psoe->so_tname,
> -					 strerror(errno));
> -				return;
> +				tst_brkm(TBROK | TERRNO, NULL, "%s select: %s",
> +					psoe->so_tname, strerror(errno));

Here as well.

>  			}
>  			if (nfds == 0) {
> -				tst_resm(TBROK, "%s recvmsg timed out",
> +				tst_brkm(TBROK, NULL, "%s recvmsg timed out",
>  					 psoe->so_tname);
> -				return;
>  			}
>  			/* else, nfds == 1 */
>  			if (!FD_ISSET(sr, &rfds))
> @@ -405,11 +373,9 @@ void so_test(struct soent *psoe)
>  
>  			cc = recvmsg(sr, &msg, 0);
>  			if (cc < 0) {
> -				tst_resm(TBROK, "%s recvmsg: %s",
> +				tst_brkm(TBROK | TERRNO, NULL, "%s recvmsg: %s",
>  					 psoe->so_tname, strerror(errno));

And here.

> -				return;
>  			}
> -/* check pid & seq here */
>  			break;
>  		}
>  		gotone = 0;
> @@ -429,11 +395,31 @@ void so_test(struct soent *psoe)
>  				return;
>  			}
>  		}
> -/* check contents here */
> -		if (psoe->so_dorecv)
> -			tst_resm(gotone ? TPASS : TFAIL, "%s receive",
> -				 psoe->so_tname);
> +		if (psoe->so_dorecv) {
> +			if (gotone)
> +				tst_resm(TINFO, "%s receive", psoe->so_tname);
> +			else
> +				tst_resm(TFAIL, "%s receive", psoe->so_tname);
> +		}

Again I don't like this, let's keep the PASS/FAIL here.

>  	}
> +
> +	count++;
> +}
> +
> +void test_soent(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < SOCOUNT; ++i) {
> +		sotab[i].so_clrval.sou_bool = 0;
> +		sotab[i].so_setval.sou_bool = 1;
> +		so_test(&sotab[i]);
> +	}
> +
> +	if (count < SOCOUNT)
> +		tst_resm(TPASS, "socket set-get/receive tests fail");
                          ^
                      Should this be TFAIL?
> +	else
> +		tst_resm(TPASS, "socket set-get/receive tests succeed");
>  }
>  
>  #define IPV6_ADDR_NODE		1
> @@ -449,7 +435,7 @@ static int ipv6_addr_scope(struct in6_addr *pin6)
>  		return IPV6_ADDR_NODE;
>  	return IPV6_ADDR_GLOBAL;
>  }
> -#endif /* HAVE_IFADDRS_H */
> +#endif

If the #ifdef #endif pair spans over more than a few lines it's fine to have
this comment there.

>  int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
>  {
> @@ -462,8 +448,7 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
>  	int s;
>  
>  	if (!pifa_head && getifaddrs(&pifa_head)) {
> -		tst_resm(TBROK, "%s: getifaddrs failed", tname);
> -		return -1;
> +		tst_brkm(TBROK, NULL, "%s: getifaddrs failed", tname);
>  	}
>  	if (psin6_arg)
>  		ifindex = psin6_arg->sin6_scope_id;
> @@ -483,20 +468,19 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
>  		     (this_scope > 0 && this_scope != scope)))
>  			continue;
>  		psin6->sin6_scope_id = if_nametoindex(pifa->ifa_name);
> -		if ((ifindex < 0 && -ifindex == psin6->sin6_scope_id) ||
> -		    (ifindex > 0 && ifindex != psin6->sin6_scope_id))
> +		if ((ifindex < 0 && -(unsigned int)ifindex ==

Eh, casting to (unsigned int) and then negating it with - sounds wrong. What
was the problem here?

> +			psin6->sin6_scope_id) || (ifindex > 0 &&
> +			(unsigned int)ifindex != psin6->sin6_scope_id))
>  			continue;
>  		s = socket(PF_INET6, SOCK_DGRAM, 0);
>  		if (s < 0) {
> -			tst_resm(TBROK, "%s: socket %s", tname,
> +			tst_brkm(TBROK | TERRNO, NULL, "%s: socket %s", tname,
>  				 strerror(errno));

The strerror() again.

> -			return -1;
>  		}
>  		if (bind(s, pifa->ifa_addr, sizeof(struct sockaddr_in6)) < 0) {
> -			tst_resm(TBROK, "%s: bind \"%s\": %s", tname,
> -				 inet_ntop(AF_INET6, &psin6->sin6_addr, strbuf,
> -					   sizeof(strbuf)), strerror(errno));
> -			return -1;
> +			tst_brkm(TBROK | TERRNO, NULL, "%s: bind \"%s\": %s",
> +				tname, inet_ntop(AF_INET6, &psin6->sin6_addr,
> +				strbuf, sizeof(strbuf)), strerror(errno));

Here as well.

>  		}
>  		if (psin6_arg) {
>  			*psin6_arg = *psin6;
> @@ -530,15 +514,13 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
>  		else
>  			intfstr = 0;
>  
> -		if (intfstr)
> -			tst_resm(TBROK, "%s: getsock : no%s addresses%s %d",
> -				 tname, scopestr, intfstr, ifindex);
> -		else
> +		if (intfstr == 0) {
>  			tst_resm(TBROK, "%s: getsock : no%s addresses",
>  				 tname, scopestr);
> +		}

This change does not look right. Looks like the purpose of the code was to add
more information to the tst_resm() message if intfstr was not zero and this
change removed the tst_resm() for intfstr != 0. Or was the previous code wrong
(if it was, I would expect description of the change in the commit message)?

>  	}
>  	return -1;
> -#else /* HAVE_IFADDRS_H */
> +#else
>  	return -1;
>  #endif
>  }
> @@ -563,98 +545,76 @@ void test_pktinfo(void)
>  
>  	s_snd = getsock(tname, 0, IPV6_ADDR_GLOBAL);
>  	if (s_snd < 0) {
> -		tst_resm(TBROK, "%s: can't create send socket", tname);
> -		return;
> +		tst_brkm(TBROK, NULL, "%s: can't create send socket", tname);
>  	}
>  	/* global-scope address, interface X */
>  	sa_rcv[0].sin6_scope_id = 0;
>  	s_rcv[0] = getsock(tname, &sa_rcv[0], IPV6_ADDR_GLOBAL);
>  	if (s_rcv[0] == -1) {
> -		tst_resm(TBROK, "%s: only link-scope addresses", tname);
> -		return;
> +		tst_brkm(TBROK, NULL, "%s: only link-scope addresses", tname);
>  	}
>  	/* link-local-scope address, interface X */
>  	sa_rcv[1].sin6_scope_id = sa_rcv[0].sin6_scope_id;
>  	s_rcv[1] = getsock(tname, &sa_rcv[1], IPV6_ADDR_LINK);
>  	if (s_rcv[1] < 0) {
> -		tst_resm(TBROK, "%s: no link-local address on ifindex %d",
> +		tst_brkm(TBROK, NULL, "%s: no link-local address on ifindex %d",
>  			 tname, sa_rcv[0].sin6_scope_id);
> -		return;
>  	}
>  	/* link-local-scope address, interface Y */
>  	sa_rcv[2].sin6_scope_id = -sa_rcv[0].sin6_scope_id;
>  	s_rcv[2] = getsock(tname, &sa_rcv[2], IPV6_ADDR_LINK);
>  	if (s_rcv[2] < 0) {
> -		tst_resm(TBROK, "%s: only one interface?", tname);
> -		return;
> +		tst_brkm(TBROK, NULL, "%s: only one interface?", tname);
>  	}
>  	/* send to rcv1 to verify communication */
>  	/* force to rcv2 w/ PKTINFO */
> -/* TESTS: */
> -/* sticky set-get */
> +	/* TESTS: */
> +	/* sticky set-get */
>  	tname = "IPV6_PKTINFO set";
>  	pi.ipi6_addr = sa_rcv[1].sin6_addr;
>  	pi.ipi6_ifindex = sa_rcv[1].sin6_scope_id;
>  	TEST(setsockopt(s_snd, SOL_IPV6, IPV6_PKTINFO, &pi, sizeof(pi)));
> -	if (TEST_RETURN != 0)
> +	if (TEST_RETURN != 0) {
>  		tst_resm(TFAIL, "%s: %s", tname, strerror(errno));
> -	else
> -		tst_resm(TPASS, "%s", tname);
> +		return;
> +	} else {
> +		tst_resm(TINFO, "%s", tname);
> +	}

Again, why do we exit on first failure?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
