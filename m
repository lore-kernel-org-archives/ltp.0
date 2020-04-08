From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 08 Apr 2020 12:54:30 +0200
Subject: [LTP] [PATCH 1/2] add_key05: Avoid race with key garbage
 collection
In-Reply-To: <d950a46d-b65a-ac33-e71b-f93a2dce7620@cn.fujitsu.com>
References: <20200408090635.4686-1-rpalethorpe@suse.com>
 <d950a46d-b65a-ac33-e71b-f93a2dce7620@cn.fujitsu.com>
Message-ID: <87wo6qz1qx.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> writes:

> Hi Richard
>
>> The key subsystem independently tracks user info against UID. If a user is
>> deleted and the UID reused for a new user then the key subsystem will mistake
>> the new user for the old one.
> Does any documentation or kernel comment mentioned this? I didn't notice this
> before.

The definition of struct key_user in security/keys/internal.h.

/*
 * Keep track of keys for a user.
 *
 * This needs to be separate to user_struct to avoid a refcount-loop
 * (user_struct pins some keyrings which pin this struct).
 *
 * We also keep track of keys under request from userspace for this UID here.
 */
struct key_user {
	struct rb_node		node;
	struct mutex		cons_lock;	/* construction initiation lock */
	spinlock_t		lock;
	refcount_t		usage;		/* for accessing qnkeys & qnbytes */
	atomic_t		nkeys;		/* number of keys */
	atomic_t		nikeys;		/* number of instantiated keys */
	kuid_t			uid;
	int			qnkeys;		/* number of keys allocated to this user */
	int			qnbytes;	/* number of bytes allocated to this user */
};

As you can see it just has the uid and, AFIACT, deleting a user will not
cause this structure to be cleaned up. However I am not familiar with
the key code.

>>
>> The keys/keyrings may not be accessible to the new user, but if they are not
>> yet garbage collected (which happens asynchronously) then the new user may be
>> exceeding its quota limits.
>>
>> This results in a race condition where this test can fail because the old
>> thread keyring is taking up the full quota. We should be able to avoid this by
>> creating two users in parallel instead of sequentially so that they have
>> different UIDs.
> I guess you may want to creat two user, so next, the key subsystem think the
> new user is different from  the last deleting user. It can avoid race.
>
> But you patch overrides ltpuser, in actually, we still use ltp_add_key05_1 in
> SAFE_SETUID.

Good catch!

>
> Also, this patch doesn't handle delete user when we using -i parameters.
>
> I think the right way should use ltp_add_key05_0 for the 1st case and use
> ltp_add_key05_1 for the 2nd case.  how about the following code?

I don't think it is necessary to delete the user on every iteration
because of the above problem with struct key_user.

Infact I suppose there is still a race condition with -i because the
keys are freed asynchronously. Even if we delete the users the UIDs will
get reused. Deleting the user does slow down the test which may stop the
race most of the time, but I don't think it is a good solution.

Possibly what we should do instead is retry test1 if EDQUOT is returned?
However the keyring and its keys are not all freed atomically, so this
will still result in errors when test1 passes because one key was freed,
but the next test fails because the other keys are still not freed.

Frankly I am not sure this is going to work with an arbitrary value for
-i unless there is some way of forcibly freeing the keys? However we
could create up to 10 users (0-9) and recycle them?


>
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -167,6 +167,7 @@ count:
>
>  static void do_test(unsigned int n)
>  {
> +       add_user(n);
>         if (!SAFE_FORK()) {
>                 SAFE_SETUID(ltpuser->pw_uid);
>                 TEST(add_key("user", "test1", user_buf, 64,
> KEY_SPEC_THREAD_KEYRING));
> @@ -181,6 +182,7 @@ static void do_test(unsigned int n)
>                 exit(0);
>         }
>         tst_reap_children();
> +       clean_user(n);
>  }
>
>  static void setup(void)
> @@ -188,14 +190,12 @@ static void setup(void)
>         SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxkeys", "200");
>         SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxbytes", "20000");
>
> -       add_user(0);
> -       add_user(1);
>  }
>
>
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>   testcases/kernel/syscalls/add_key/add_key05.c | 36 ++++++++++---------
>>   1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
>> index f64c359bb..5691b8579 100644
>> --- a/testcases/kernel/syscalls/add_key/add_key05.c
>> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
>> @@ -19,8 +19,6 @@
>>   #include "lapi/keyctl.h"
>>     static char *user_buf;
>> -static const char *username = "ltp_add_key05";
>> -static int user_added;
>>   struct passwd *ltpuser;
>>   static char fmt[1024];
>>   @@ -30,30 +28,29 @@ static const char *const save_restore[] = {
>>   	NULL,
>>   };
>>   -static void add_user(void)
>> +static void add_user(char n)
>>   {
>> -	if (user_added)
>> -		return;
>> -
>> +	char username[] = "ltp_add_key05_n";
>>   	const char *const cmd_useradd[] = {"useradd", username, NULL};
>>   +	username[sizeof(username) - 2] = '0' + n;
>> +
>>   	SAFE_CMD(cmd_useradd, NULL, NULL);
>> -	user_added = 1;
>>   	ltpuser = SAFE_GETPWNAM(username);
>>   	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
>> +
>> +	tst_res(TINFO, "Created user %s", ltpuser->pw_name);
>>   }
>>   -static void clean_user(void)
>> +static void clean_user(char n)
>>   {
>> -	if (!user_added)
>> -		return;
>> -
>> +	char username[] = "ltp_add_key05_n";
>>   	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
>>   +	username[sizeof(username) - 2] = '0' + n;
>> +
>>   	if (tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL))
>>   		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
>> -	else
>> -		user_added = 0;
>>   }
>>     static inline void parse_proc_key_users(int *used_key, int *max_key, int
>> *used_bytes, int *max_bytes)
>> @@ -170,7 +167,6 @@ count:
>>     static void do_test(unsigned int n)
>>   {
>> -	add_user();
>>   	if (!SAFE_FORK()) {
>>   		SAFE_SETUID(ltpuser->pw_uid);
>>   		TEST(add_key("user", "test1", user_buf, 64, KEY_SPEC_THREAD_KEYRING));
>> @@ -185,13 +181,21 @@ static void do_test(unsigned int n)
>>   		exit(0);
>>   	}
>>   	tst_reap_children();
>> -	clean_user();
>>   }
>>     static void setup(void)
>>   {
>>   	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxkeys", "200");
>>   	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxbytes", "20000");
>> +
>> +	add_user(0);
>> +	add_user(1);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	clean_user(0);
>> +	clean_user(1);
>>   }
>>     static struct tst_test test = {
>> @@ -200,7 +204,7 @@ static struct tst_test test = {
>>   	.needs_root = 1,
>>   	.forks_child = 1,
>>   	.setup = setup,
>> -	.cleanup = clean_user,
>> +	.cleanup = cleanup,
>>   	.save_restore = save_restore,
>>   	.bufs = (struct tst_buffers []) {
>>   		{&user_buf, .size = 64},
>>


--
Thank you,
Richard.
