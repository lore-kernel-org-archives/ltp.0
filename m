From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 13:04:57 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/keyctl: Make use of lapi/keyctl.h
 && Add existing test to runtest/cve
In-Reply-To: <20170825032423.21004-2-fenggw-fnst@cn.fujitsu.com>
References: <1d294342-1504-e66f-5fdc-f9cd7806afef@cn.fujitsu.com>
 <20170825032423.21004-1-fenggw-fnst@cn.fujitsu.com>
 <20170825032423.21004-2-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170828110457.GB21355@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1.syscalls/keyctl02 and syscalls/keyctl03 make use of lapi/keyctl.h
> 
> 2.syscalls/keyctl0* use keyutils.h fallback definition in lapi/keyctl.h
>   instead of raw syscall, thus we would test the keyutils library if the
>   header is present and these tests will not be disabled otherwise.
> 
> 3.Add syscalls/keyctl02 and commands/keyctl01 to the CVE runtest file as
>   cve-2015-7550 and cve-2016-4470 respectively.

It would be a bit cleaner if the part 3. was send in a separate part.

>  static void do_test(void)
>  {
>  	key_serial_t key;
>  
> -	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
> -		KEY_SPEC_USER_SESSION_KEYRING));
> -
> +	TEST(keyctl(KEYCTL_GET_KEYRING_ID, KEY_SPEC_USER_SESSION_KEYRING));
>  	if (TEST_RETURN != -1)
>  		tst_res(TPASS, "KEYCTL_GET_KEYRING_ID succeeded");
>  	else
>  		tst_res(TFAIL | TTERRNO, "KEYCTL_GET_KEYRING_ID failed");
>  
>  	for (key = INT32_MAX; key > INT32_MIN; key--) {
> -		TEST(tst_syscall(__NR_keyctl, KEYCTL_READ, key));
> +		TEST(keyctl(KEYCTL_READ, key));
>  		if (TEST_RETURN == -1 && TEST_ERRNO == ENOKEY)
>  			break;
>  	}
>  
> -	TEST(tst_syscall(__NR_keyctl, KEYCTL_REVOKE, key));
> -
> +	TEST(keyctl(KEYCTL_REVOKE, key));
>  	if (TEST_RETURN != -1) {
>  		tst_res(TFAIL, "KEYCTL_REVOKE succeeded unexpectedly");
>  		return;
> @@ -66,6 +60,14 @@ static void do_test(void)
>  	tst_res(TPASS | TTERRNO, "KEYCTL_REVOKE failed as expected");
>  }
>  
> +static void setup(void)
> +{
> +#ifndef HAVE_KEYUTILS_H
> +	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
> +#endif /* HAVE_KEYUTILS_H */
> +}

And I do not think that this message is necessary and if it is we should
probably print it from the lapi call rather than adding it into each of
the testcases.


Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
