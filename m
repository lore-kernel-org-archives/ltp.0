From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 15:47:48 +0200
Subject: [LTP] [PATCH 4/4] syscalls/add_key03: new test for forging user
 keyrings
In-Reply-To: <20171010175120.90586-5-ebiggers3@gmail.com>
References: <20171010175120.90586-1-ebiggers3@gmail.com>
 <20171010175120.90586-5-ebiggers3@gmail.com>
Message-ID: <20171011134748.GC15968@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static key_serial_t create_keyring(const char *description)
> +{
> +	TEST(add_key("keyring", description, NULL, 0,
> +		     KEY_SPEC_PROCESS_KEYRING));
> +	if (TEST_RETURN < 0) {
> +		tst_brk(TBROK | TTERRNO,
> +			"unable to create keyring '%s'", description);
> +	}
> +	return TEST_RETURN;
> +}
> +
> +static key_serial_t get_keyring_id(key_serial_t special_id)
> +{
> +	TEST(keyctl(KEYCTL_GET_KEYRING_ID, special_id, 1));
> +	if (TEST_RETURN < 0) {
> +		tst_brk(TBROK | TTERRNO,
> +			"unable to get ID of keyring %d", special_id);
> +	}
> +	return TEST_RETURN;
> +}
> +
> +static void unlink_keyring(key_serial_t id)
> +{
> +	TEST(keyctl(KEYCTL_UNLINK, id, KEY_SPEC_PROCESS_KEYRING));
> +	if (TEST_RETURN < 0) {
> +		tst_brk(TBROK | TTERRNO,
> +			"unable to unlink the keyring we created");
> +	}
> +}
> +
> +static void do_test(void)
> +{
> +	int i;
> +
> +	/*
> +	 * Try with multiple user IDs before reporting success.  By chance, some
> +	 * users may already have an existing user keyring; the bug will not be
> +	 * reproducible for them.
> +	 */
> +	for (i = 0; i < 10; i++) {
> +		char description[32];
> +		uid_t uid;
> +		key_serial_t fake_user_keyring;
> +		key_serial_t fake_user_session_keyring;
> +
> +		uid = rand();
> +		if (uid == 0)
> +			continue;

We have testcases that look for unused uid with this loop:

	for (i = 1; i < 1000; i++) {
		if (!getpwuid(i))
			return i;
	}

What about using this instead of doing 10 random tries?

> +		sprintf(description, "_uid.%u", uid);
> +		fake_user_keyring = create_keyring(description);
> +		sprintf(description, "_uid_ses.%u", uid);
> +		fake_user_session_keyring = create_keyring(description);
> +
> +		TEST(setreuid(uid, 0));
> +		if (TEST_RETURN < 0) {
> +			tst_brk(TBROK | TTERRNO,
> +				"unable to set real uid to %u", uid);
> +		}

I guess that we should add SAFE_SETREUID() to the tst_safe_macros.h
library. We do have SAFE_SETRESUID() though, so we may as well use
SAFE_SETRESUID(uid, -1, -1) here.

> +		if (fake_user_keyring == get_keyring_id(KEY_SPEC_USER_KEYRING)) {
> +			tst_brk(TFAIL,
> +				"created user keyring for another user");
> +		}
> +
> +		if (fake_user_session_keyring ==
> +		    get_keyring_id(KEY_SPEC_USER_SESSION_KEYRING)) {
> +			tst_brk(TFAIL,
> +				"created user session keyring for another user");
> +		}
> +
> +		TEST(setreuid(0, 0));
> +		if (TEST_RETURN < 0)
> +			tst_brk(TBROK | TTERRNO, "unable to reset real uid");
> +		uid++;
> +
> +		unlink_keyring(fake_user_keyring);
> +		unlink_keyring(fake_user_session_keyring);
> +	}
> +	tst_res(TPASS, "expectedly could not create another user's keyrings");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_root = 1,
> +};
> -- 
> 2.14.2.920.gcf0c67979c-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
