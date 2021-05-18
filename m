From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 08:02:56 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
References: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YKNYkNOqsmhv9kSJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Moving everything to /etc/hosts based setup is a great idea
as we get rid of network setup related failures.

Do we lost any getaddrinfo() test coverage for bypassing DNS?

Just a few unimportant nits below (feel free to ignore them).
Again, I'd be for merging this before release.

> The test is now independent of various machine settings
> regarding the test host name as it adds predefined names
> and aliases to /etc/hosts file and restores it to its
> original state after completing the test.

> This should fix the following failures:
> * when gethostname() returns an alias name that doesn't
>   match canonical name;
> * No AAAA record for the returned name from gethostname().

> Addresses and names added to /etc/hosts are more or less
> unique, so that there are no conflicts with the existing
> configuration.
We might want to put this into docparse documentation, e.g:

/*\
 * [Description]
 *
 * Basic getaddrinfo() tests.
 *
 * Test use LTP specific addresses and names added to /etc/hosts to avoid
 * problems with DNS and hostname setup or conflicts with existing
 * configuration.
 */

> Also most of the duplicate code is now gone.

> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  testcases/network/lib6/getaddrinfo_01.c | 1140 +++++------------------
>  1 file changed, 235 insertions(+), 905 deletions(-)

> diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
> index db252a998..23a279ed1 100644

...
> +static void gaiv(void)
> +{
> +	check_addrinfo(1, "basic lookup", hostname, 0, NULL, 0, 0, 0, NULL);
> +	check_addrinfo_name("canonical name");

...
> +	check_addrinfo(1, "host+service", hostname, 7, "echo", 0, 0, 0, NULL);
> +
> +	check_addrinfo(1, "host+service, AI_PASSIVE", hostname, 9462, "9462",
> +		       AI_PASSIVE, SOCK_STREAM, 0, test_passive);
> +
> +	check_addrinfo(0, "host+service, AI_NUMERICHOST", hostname, 7, "echo",
> +		       AI_NUMERICHOST, SOCK_STREAM, 0, NULL);
> +	if (TST_RET != EAI_NONAME)
> +		tst_brk(TFAIL, "AI_NUMERICHOST: ret %ld exp %d (EAI_NONAME)",
> +			TST_RET, EAI_NONAME);
> +	tst_res(TPASS, "AI_NUMERICHOST: exp %ld (EAI_NONAME)", TST_RET);
> +
> +	check_addrinfo(1, "0+service, AI_PASSIVE", NULL, 9462, "9462",
> +		       AI_PASSIVE, SOCK_STREAM, 0, test_passive_no_host);
> +
> +	check_addrinfo(0, "0+service", NULL, 9462, "9462",
> +		       0, SOCK_STREAM, 0, test_loopback);
> +	if (TST_RET == EAI_BADFLAGS) {
> +		tst_res(TPASS, "0+service ('', '9462') returns %ld '%s'",
> +			TST_RET, gai_strerror(TST_RET));
> +	} else if (TST_RET) {
> +		tst_brk(TFAIL, "0+service ('', '9462') returns %ld '%s'",
> +			TST_RET, gai_strerror(TST_RET));
>  	}
nit: Maybe having check_addrinfo_badflags() which would do the verification
would safe few lines of code duplicity.

...
> -	/* test 16, IPv6 host+service w/ AI_NUMERICHOST */
> -	memset(&hints, 0, sizeof(hints));
> -	strcpy(service, "echo");
> -	servnum = 7;
> -	hints.ai_family = AF_INET6;
> -	hints.ai_flags = AI_NUMERICHOST;
> -	TEST(getaddrinfo(hostname, service, &hints, &aires));
> -	if (TEST_RETURN != EAI_NONAME) {
> -		tst_resm(TFAIL, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname: "
> -			 "returns %ld expected %d (EAI_NONAME)",
> -			 TEST_RETURN, EAI_NONAME);
> -		if (!TEST_RETURN)
> -			freeaddrinfo(aires);
> -		return;
> +	check_addrinfo(0, "SOCK_STREAM/IPPROTO_UDP", NULL, 0, NULL, 0,
> +		       SOCK_STREAM, IPPROTO_UDP, NULL);
> +	if (!TST_RET)
> +		tst_brk(TFAIL, "SOCK_STREAM/IPPROTO_UDP: unexpected pass");
> +	tst_res(TPASS, "SOCK_STREAM/IPPROTO_UDP: failed as expected");
> +
> +	check_addrinfo(0, "socktype 0, 513", NULL, 513, "513", 0, 0, 0, NULL);
And here also check_addrinfo_badflags() (if implemented)
and nit: "socktype 0,513" (remove space)

> +	if (TST_RET == EAI_BADFLAGS) {
> +		tst_res(TPASS, "socktype 0,513 returns %ld '%s'",
> +			TST_RET, gai_strerror(TST_RET));
> +	} else if (TST_RET) {
> +		tst_brk(TFAIL, "socktype 0,513 returns %ld '%s'",
> +			TST_RET, gai_strerror(TST_RET));
>  	}

Kind regards,
Petr
