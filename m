Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ynn4w-0001wt-QR
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 11:56:30 +0000
Date: Thu, 30 Apr 2015 13:55:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430115558.GA24720@rei.suse.de>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1427787975-10668-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427787975-10668-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/6] lib6/asapi_04.c: cleanup
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
>  #include <stdio.h>
> @@ -49,36 +37,27 @@
>  
>  #include "test.h"
>  
> -char *TCID = "asapi_04";	/* Test program identifier.    */
> +#define READ_TIMEOUT	5	/* secs */
>  
>  pid_t pid;
>  
> -struct {
> -	char *prt_name;
> -	int prt_value;
> -} ptab[] = {
> -	{
> -	"hopopt", 0}, {
> -	"ipv6", 41}, {
> -	"ipv6-route", 43}, {
> -	"ipv6-frag", 44}, {
> -	"esp", 50}, {
> -	"ah", 51}, {
> -	"ipv6-icmp", 58}, {
> -	"ipv6-nonxt", 59}, {
> -"ipv6-opts", 60},};
> -
> -#define PTCOUNT	(sizeof(ptab)/sizeof(ptab[0]))
> +static void setup(void);
> +static void test_in6_are_addr_equal(void);
> +static void test_protocols_entry(void);
> +static int csum_test(char *rhost);
> +static void test_ipv6_checksum(void);
>  
> -#define READ_TIMEOUT	5	/* secs */
>  
> -void do_tests(void);
> -void setup(void), cleanup(void);
> -int csum_test(char *rhost);
> +static void (*testfunc[])(void) = { test_in6_are_addr_equal,
> +	test_protocols_entry, test_ipv6_checksum };
> +
> +char *TCID = "asapi_04";
> +int TST_TOTAL = ARRAY_SIZE(testfunc);
>  
>  int main(int argc, char *argv[])
>  {
>  	int lc;
> +	int i;
>  
>  	tst_parse_opts(argc, argv, 0, 0);
>  
> @@ -86,22 +65,27 @@ int main(int argc, char *argv[])
>  
>  	setup();
>  
> -	for (lc = 0; TEST_LOOPING(lc); ++lc)
> -		do_tests();
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
>  
> -	cleanup();
> +		for (i = 0; i < TST_TOTAL; i++)
> +			(*testfunc[i])();
> +	}
>  
>  	tst_exit();
>  }
>  
> -void do_tests(void)
> +void setup(void)
>  {
> -	int i;
> +	TEST_PAUSE;
> +}
>  
>  /* RFC 3542, Section 2.3 */
> +void test_in6_are_addr_equal(void)
> +{
>  #ifndef IN6_ARE_ADDR_EQUAL
>  	tst_resm(TBROK, "IN6_ARE_ADDR_EQUAL not present");
> -#else /* IN6_ARE_ADDR_EQUAL */
> +#else
>  	/*
>  	 * set each bit in an address and check for unequal; then set
>  	 * in the second address and check for equal. Covers all bits, all
> @@ -128,30 +112,56 @@ void do_tests(void)
>  			}
>  		tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
>  	}
> -#endif /* IN6_ARE_ADDR_EQUAL */
> +#endif
> +}
> +
> +struct {
> +	char *prt_name;
> +	int prt_value;
> +} ptab[] = {
> +	{ "hopopt", 0 },
> +	{ "ipv6", 41 },
> +	{ "ipv6-route", 43 },
> +	{ "ipv6-frag", 44 },
> +	{ "esp", 50 },
> +	{ "ah", 51 },
> +	{ "ipv6-icmp", 58 },
> +	{ "ipv6-nonxt", 59 },
> +	{ "ipv6-opts", 60 },
> +};
> +
> +#define PTCOUNT (sizeof(ptab)/sizeof(ptab[0]))

ARRAY_SIZE() here as well

>  /* RFC 3542, Section 2.4 */
> +void test_protocols_entry(void)
> +{
> +	unsigned int i;
> +
>  	for (i = 0; i < PTCOUNT; ++i) {
>  		struct protoent *pe;
>  		int pass;
>  
>  		pe = getprotobyname(ptab[i].prt_name);
>  		pass = pe && pe->p_proto == ptab[i].prt_value;
> -		tst_resm(pass ? TPASS : TFAIL, "\"%s\" protocols entry",
> -			 ptab[i].prt_name);
> +		if (pass) {
> +			tst_resm(TINFO, "\"%s\" protocols entry",
> +				ptab[i].prt_name);
> +		} else {
> +			tst_resm(TFAIL, "\"%s\" protocols entry",
> +				ptab[i].prt_name);
> +			return;
> +		}
>  	}
> +
> +	tst_resm(TPASS, "protocols entry tests succeed");
> +}

I do not think this is a good idea. Why can we just do the PASS/FAIL on
each testcase and adjust the test count variable accordingly?

>  /* RFC 3542, Section 3.1 */
> +void test_ipv6_checksum(void)
> +{
>  	csum_test("::1");
>  }
>  
> -/*
> - * this next-header value shouldn't be a real protocol!!
> - * 0x9f = 01 0 11111
> - *         | |     |
> - *         | |     |--- rest- ~0
> - *         | |--------- chg - "no change enroute"
> - *         |----------- act - "discard unknown"
> - */
>  #define	NH_TEST	0x9f

I guess that this comment should rather stay as it explains the
constant.

>  struct tprot {
> @@ -173,17 +183,13 @@ struct csent {
>  	int cs_sndresult;	/* send expected result */
>  	int cs_snderrno;	/* send expected errno */
>  } cstab[] = {
> -	{
> -	0, 5, 0, 0, 0, 0}, {
> -	6, 30, 0, 0, 0, 0}, {
> -	3, 20, -1, EINVAL, -1, -1},	/* non-aligned offset */
> -	{
> -	4, 5, 0, 0, -1, EINVAL},	/* not enough space */
> -	{
> -	50, 5, 0, 0, -1, EINVAL},	/* outside of packet */
> -	{
> -	22, 30, 0, 0, 0, 0}, {
> -	2000, 2004, 0, 0, 0, 0},	/* in a fragment (over Ethernet) */
> +	{ 0, 5, 0, 0, 0, 0 },
> +	{ 6, 30, 0, 0, 0, 0 },
> +	{ 3, 20, -1, EINVAL, -1, -1 },	/* non-aligned offset */
> +	{ 4, 5, 0, 0, -1, EINVAL },	/* not enough space */
> +	{ 50, 5, 0, 0, -1, EINVAL },	/* outside of packet */
> +	{ 22, 30, 0, 0, 0, 0 },
> +	{ 2000, 2004, 0, 0, 0, 0 },	/* in a fragment (over Ethernet) */
>  };
>  
>  #define CSCOUNT	(sizeof(cstab)/sizeof(cstab[0]))
> @@ -197,7 +203,7 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
>  	tpt = (struct tprot *)packet;
>  	total = cc = recv(sd, packet, sizeof(struct tprot), 0);
>  	expected = sizeof(struct tprot);	/* until we get tp_dlen */
> -	gothead = total >= sizeof(struct tprot);
> +	gothead = (unsigned int)total >= sizeof(struct tprot);
>  	if (gothead)
>  		expected += ntohl(tpt->tp_dlen);
>  	if (cc <= 0)
> @@ -206,7 +212,8 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
>  		cc = recv(sd, &packet[total], expected - total, 0);
>  		if (cc >= 0) {
>  			total += cc;
> -			if (!gothead && total >= sizeof(struct tprot)) {
> +			if (!gothead && (unsigned int)total >=
> +				sizeof(struct tprot)) {
>  				gothead = 1;
>  				expected += ntohl(tpt->tp_dlen);
>  			}
> @@ -248,7 +255,8 @@ static int client(int prot, int sfd)
>  	struct tprot *prtp = (struct tprot *)rpbuf;
>  	struct sockaddr_in6 rsin6;
>  	static int seq;
> -	int i, sd, cc, cs;
> +	unsigned int i;
> +	int sd, cc, cs;
>  
>  	memset(&rsin6, 0, sizeof(rsin6));
>  	rsin6.sin6_family = AF_INET6;
> @@ -261,8 +269,8 @@ static int client(int prot, int sfd)
>  
>  	sd = socket(PF_INET6, SOCK_RAW, NH_TEST);
>  	if (sd < 0) {
> -		tst_resm(TBROK, "can't create raw socket: %s", strerror(errno));
> -		return -1;
> +		tst_brkm(TBROK | TERRNO, NULL, "can't create raw socket: %s",
> +			strerror(errno));
                         ^
                        You should remove the strerror() now, as it's
			not needed anymore with TERRNO.

>  	}
>  	for (i = 0; i < CSCOUNT; ++i) {
>  		int offset, len, xlen;
> @@ -287,10 +295,10 @@ static int client(int prot, int sfd)
>  				 "IPV6_CHECKSUM offset %d len %d "
>  				 "- result %ld != %d", offset, len, TEST_RETURN,
>  				 cstab[i].cs_setresult);
> -			continue;
> +			return -1;
>  		}
>  		if (TEST_RETURN < 0) {
> -			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
> +			tst_resm(TINFO, "IPV6_CHECKSUM offset %d len %d",
>  				 offset, len);
>  			continue;
>  		}
> @@ -298,7 +306,7 @@ static int client(int prot, int sfd)
>  			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
>  				 "- errno %d != %d", offset, len,
>  				 TEST_ERRNO, cstab[i].cs_seterrno);
> -			continue;
> +			return -1;

What is the reason for exitting the test on first failure?

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
