From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 28 Feb 2020 15:00:36 +0800
Subject: [LTP] [PATCH] syscalls/add_key05: add maxbytes/maxkeys test
 under unprivileged user
In-Reply-To: <d9ec9c25-b452-e880-aab6-4bd3d2dcc5c6@cn.fujitsu.com>
References: <1581081297-20034-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200224153112.GB2210@rei>
 <d9ec9c25-b452-e880-aab6-4bd3d2dcc5c6@cn.fujitsu.com>
Message-ID: <8c5d0b3c-746c-91fe-cb9f-b07c69e37e5d@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> Hi!
> 
>> Hi!
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index 577a4a527..df7bbcbf1 100644
>>> -- 
>>> +void verify_max_btyes(void)
>>> +{
>>> +??? char *buf, *invalid_buf;
>>> +??? int plen, invalid_plen;
>>> +
>>> +??? tst_res(TINFO, "test max bytes under unprivileged user");
>>> +??? invalid_plen = max_bytes - used_bytes - data_len - 8;
>>
>> What is the -8 for, strlen("test_inv")?
> Yes.
>>
>> I guess that it will be more readable if we used the strlen() here as
>> well.
> OK. I will use strlen.
>>
>>> +??? plen = invalid_plen - 1;
>>> +??? buf = tst_alloc(plen);
>>> +??? invalid_buf = tst_alloc(invalid_plen);
>>> +
>>> +??? TEST(add_key("user", "test_inv", invalid_buf, invalid_plen, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??? if (TST_RET != -1)
>>> +??????? tst_res(TFAIL, "add_key(test_inv) succeeded unexpectedltly");
>>> +??? else {
>>> +??????? if (TST_ERR == EDQUOT)
>>> +??????????? tst_res(TPASS | TTERRNO, "add_key(test_inv) failed as 
>>> expected");
>>> +??????? else
>>> +??????????? tst_res(TFAIL | TTERRNO, "add_key(test_inv) failed 
>>> expected EDQUOT got");
>>> +??? }
>>> +
>>> +??? TEST(add_key("user", "test_max", buf, plen, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??? if (TST_RET != -1) {
>>> +??????? tst_res(TPASS, "add_key(test_max) succeeded as expected");
>>> +??????? SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, 
>>> &max_key, &used_bytes, &max_bytes);
>>> +??????? if (used_bytes == max_bytes)
>>> +??????????? tst_res(TPASS, "allow reaching the max bytes exactly");
>>> +??????? else
>>> +??????????? tst_res(TFAIL, "max used bytes %u, key allow max bytes 
>>> %u", used_bytes, max_bytes);
>>> +??? } else
>>> +??????? tst_res(TFAIL | TTERRNO, "add_key(test_max) failed 
>>> unexpectedly");
>>> +}
>>> +
>>> +void verify_max_keys(void)
>>> +{
>>> +??? unsigned int i;
>>> +??? char desc[10];
>>> +
>>> +??? tst_res(TINFO, "test max keys under unprivileged user");
>>> +??? for (i = used_key + 1; i < max_key; i++) {
>>> +??????? sprintf(desc, "abc%d", i);
>>> +??????? TEST(add_key("keyring", desc, keyring_buf, 0, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??????? if (TST_RET == -1)
>>> +??????????? tst_res(TFAIL | TTERRNO, "add keyring key(%s) failed", 
>>> desc);
>>
>> Why we are using the "keyring" ring here instead? I doubt that it
>> matters for the quota, but it just seems strange.
> It doesn't matter quota, only because "keyrings" plen is 0. I will use 
> "user" type for this.
>  ?>
>> Also we should stop the loop on a first failure, I guess that goto
>> count: would suffice.
> I ignored this before, thanks.
>>
>>> +??? }
>>> +
>>> +??? TEST(add_key("keyring", "abc200", keyring_buf, 0, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +
>>> +??? if (TST_RET == -1) {
>>> +??????? tst_res(TFAIL | TTERRNO, "add keyring key(abc200) failed");
>>> +??????? goto count;
>>> +??? } else
>>> +??????? tst_res(TPASS, "add keyring key(abc200) succedd");
>>
>> Why don't we just start the loop above at used_key? There is no point in
>> adding the last key here outside of the loop.
>>
> Using start + 1 more clean?
> abc100 >> the 100th key,
> We can change code (including last key)as below:
> for (i = used_key + 1; i <= max_key; i ++)
> 
>>> +??? TEST(add_key("keyring", "abc201", keyring_buf, 0, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??? if (TST_RET != -1) {
>>> +??????? tst_res(TFAIL, "add keyring key(abc201) succeeded 
>>> unexpectedly");
>>> +??????? goto count;
>>
>> We should add a key with a different name than the previous "abc%d"
>> pattern here, if the upper limit was over 200 we would just replace a
>> key here instread which will not fail at all.
> Do you mean to use? "invalid_num_key" to avoid upper limit over 200?
> 
>>
>>> +??? } else {
>>> +??????? if (TST_ERR == EDQUOT)
>>> +??????????? tst_res(TPASS | TTERRNO, "add keyring key(abc201) failed 
>>> as expected over max key");
>>> +??????? else
>>> +??????????? tst_res(TFAIL | TTERRNO, "add_keyring failed expected 
>>> EDQUOT got");
>>> +??? }
>>> +count:
>>> +??? SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, 
>>> &max_key, &used_bytes, &max_bytes);
>>> +??? if (used_key == max_key)
>>> +??????? tst_res(TPASS, "allow reaching the max key exactly");
>>> +??? else
>>> +??????? tst_res(TFAIL, "max used key %u, key allow max key %u", 
>>> used_key, max_key);
>>> +}
>>> +
>>> +static void do_test(unsigned int n)
>>> +{
>>> +??? add_user();
>>> +??? int f_used_bytes = 0;
>>> +
>>> +??? if (!SAFE_FORK()) {
>>> +??????? SAFE_SETUID(ltpuser->pw_uid);
>>> +
>>> +??????? TEST(add_key("user", "test1", user_buf, 64, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??????? if (TST_RET == -1)
>>> +??????????? tst_brk(TFAIL | TTERRNO, "add key test1 failed");
>>> +??????? SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, 
>>> &max_key, &used_bytes, &max_bytes);
>>> +??????? f_used_bytes = used_bytes;
>>> +
>>> +??????? TEST(add_key("user", "test2", user_buf1, 64, 
>>> KEY_SPEC_THREAD_KEYRING));
>>> +??????? if (TST_RET == -1)
>>> +??????????? tst_brk(TFAIL | TTERRNO, "add key test2 failed");
>>
>> Do we really need to pass a different users_buf to each call?
> I have seen kernel code, payload is used to instantiate or update the 
> key, I think it is no problme to use the same buf because we don't get 
> it again from kernel space.
>>
>>> +??????? SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, 
>>> &max_key, &used_bytes, &max_bytes);
>>> +
>>> +??????? data_len = used_bytes - f_used_bytes - strlen("test1") - 1 - 
>>> 64;
>>
>> So this code here is used to determine how much data will consume the
>> key structure in kernel itself? 

Sorry for the wrong info. This code is designed to compute delta, I have 
seen kernel code yestorday:
add_key calltrace as below:
add_key()
   key_create_or_update()
     key_alloc()
     __key_instantiate_and_link
       generic_key_instantiate
         key_payload_reserve
           ......

In key_alloc, we use type->def_datalen to alloc space, but when 
instantiating key, we using delta(quota_len -type->def_datalen) to 
adjust reserver space. So I compute this variable(delta, add_key05.c 
uses data_len) to avoid  that we can reach max bytes in key_alloc but 
got EDQOUT in key_payload_reserve.

more info:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/security/keys/core.rst#n1353

Also, using my v2 patch(send later), this case also fails on lastest 
kernel because of incomplete kernel commit.

more info:
https://patchwork.kernel.org/patch/11411507/

Best Regards
Yang Xu
> I debug this code after adding test1 key, show in /proc/keys
> add_key05.c:154: INFO: 1535d151 I--Q---??? 24 perm 3f030000???? 0???? 0 
> keyring?? _ses: 1
> 
> add_key05.c:154: INFO: 15d7df09 I--Q---???? 6 perm 1f3f0000???? 0 65534 
> keyring?? _uid.0: empty
> 
> add_key05.c:154: INFO: 1a300c72 I--Q---???? 1 perm 3f010000? 1003???? 0 
> user????? test1: 64
> 
> add_key05.c:154: INFO: 2e57738c I--Q---???? 1 perm 3f010000? 1003???? 0 
> keyring?? _tid: 1
> 
> the key num is 2 in /proc/key-users, I use this code to figure keyring 
>  ?_tid: 1(I don't know why has it) consumed data bytes.
> I guess that this is useless to run in
>> the case of testing for maximal number of keys, right? Can we put this
>> code into a function something as get_kernel_key_data_size() and call it
>> from the verify_max_bytes() only?
> Yes, it was only used in max_bytes.
>>
>> I guess that the SAFE_FILE_LINES_SCANF() intializes the max_key for the
>> max_keys test. Having a global variables that are initalized in random
>> places makes the code really confusing, can we avoid that if poissible
>> please?
> Ok. I will avoid this and make code clean.
>>
>> I guess that we can at least create:
>>
>> parse_proc_key_users(int *used_keys, int *max_key, int *used_bytes, 
>> *int max_bytes)
>>
>> function that would read the values into a local variables and copy the
>> results only if non-NULL pointers were passed.
>>
>> That way the verify_max_keys() would call:
>> parse_proc_key_users(NULL, &max_keys, NULL, NULL);
>> and use the result for the loop that adds the keys.
> Sound good, I will use it.
>>
>>> +??????? if (flag[n])
>>
>> Huh, why not just if (n)?
>>
> OK.
>>> +??????????? verify_max_btyes();
>>> +??????? else
>>> +??????????? verify_max_keys();
>>> +??????? exit(0);
>>> +??? }
>>> +??? tst_reap_children();
>>> +??? clean_user();
>>
>> What is the reason to add and remove a user for each iteration?
>>
>> Aare you cleaning the keys that way?
> Yes, I planed to look for a wise (try KEYCTL_CLEAR
>  ?or KEYCTL_INVALIDATE)way but failed. Can you give me some
> suggestion?
>>
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +??? .test = do_test,
>>> +??? .tcnt = 2,
>>> +??? .needs_root = 1,
>>> +??? .forks_child = 1,
>>> +??? .cleanup = clean_user,
>>> +??? .bufs = (struct tst_buffers []) {
>>> +??????? {&keyring_buf, .size = 1},
>>> +??????? {&user_buf, .size = 64},
>>> +??????? {&user_buf1, .size = 64},
>>> +??????? {}
>>> +??? },
>>> +??? .tags = (const struct tst_tag[]) {
>>> +??????? {"linux-git", "a08bf91ce28"},
>>> +??????? {}
>>> +??? }
>>> +};
>>> -- 
>>> 2.18.0
>>>
>>>
>>>
>>>
>>> -- 
>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>


