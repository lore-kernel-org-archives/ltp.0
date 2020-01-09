From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2020 14:17:13 +0800
Subject: [LTP] [PATCH v1 3/4] syscalls/capset03: add new EPERM error
 test without CAP_SETPCAP
In-Reply-To: <20200108110343.GA3318@rei.lan>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200107133913.GE26408@rei.lan>
 <e6cada30-fb4e-a2e0-72e9-cdfc796361cb@cn.fujitsu.com>
 <20200108110343.GA3318@rei.lan>
Message-ID: <cb1878f7-a00a-f5d1-c55f-6f80ff01cb6b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi!
>>>> +static void setup(void)
>>>> +{
>>>> +	pid_t pid;
>>>> +
>>>> +	pid = getpid();
>>>> +	header.pid = pid;
>>>> +	if (geteuid() == 0) {
>>>> +		TEST(tst_syscall(__NR_capset, &header, data));
>>>> +		if (TST_RET == -1)
>>>> +			tst_brk(TBROK | TTERRNO, "capset data failed");
>>>> +	}
>>>
>>> Please don't do that. If tests needs root (even for a subset of the
>>> test) just set the .needs_root flag.
>>>
>> This test doesn't need root. These code is designed to create a
>> envrionment for root user to generate this type EPERM
>> error??new_Inheritable is not a subset of old_Inheritable and
>> old_Permitted without CAP_SETPCAP??.
>> root user:
>> old pI: CAP_KILL
>> old pP: CAP_KILL
>> new pI: CAP_KILL + CAP_NET_RAW
>>
>> other user:
>> old pI: 0
>> old pP: 0
>> new pI: CAP_KILL + CAP_NET_RAW
>>
>> other user also met condition and can generate this EPERM error.
> 
> Hmm, we are testing different things under root and non-root then. When
> the test is executed under a regular user we assert that the system
> default is sane + the capset assertion, while under the root we test
> only capset.
> 
> It would make sense to run the test only under root to make sure that we
> are consistent.
> 
Ok. I will make this case consistent and add .need_root flag.
> Also the CAP_DROP in the tst_test structure seems to be useless to me.
> 
> 
> Looking at man 7 capabilities, there are also transitions defined for
> what is supposed to happen when we change user id. It would make sense
> to write tests that capabilities are correctly dropped when UID changes
> from 0 to nonzero. Which is what this test is testing when executed as
> non-root, since the transition from 0 to nonzero must have happened
> somewhere when user has logged in.
In man 7 capabilities " Effect of user ID changes on capabilities",
I see transitions between 0 and nonzero user IDs. But it is about 
capabilities?not about capset syscall. I think we should add these 
cases(user ID changes on capabilities) into kernel/security (such as 
cap_bound or filecaps). In capset, we can only test capset various EPERM 
error as kernel sercurity/commoncap.c  cap_capset function.
---------------------------------
      if (cap_inh_is_capped() &&
             !cap_issubset(*inheritable,
                           cap_combine(old->cap_inheritable,
                                       old->cap_permitted)))
                 /* incapable of using this inheritable set */
                 return -EPERM;

         if (!cap_issubset(*inheritable,
                           cap_combine(old->cap_inheritable,
                                       old->cap_bset)))
                 /* no new pI capabilities outside bounding set */
                 return -EPERM;

         /* verify restrictions on target's new Permitted set */
         if (!cap_issubset(*permitted, old->cap_permitted))
                 return -EPERM;

         /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
         if (!cap_issubset(*effective, *permitted))
                 return -EPERM;
---------------------------------
Also, if we only run under root, CAP_DROP(CAP_SETPCAP) is needed  to 
reproduce this EPERM error.
> 
>> ps: In capset03, getpid() is useless, we can use pid = 0 to replace.
>> Also, if we can use pid =0 in error test, maybe we don't need to test
>> pid =0 in capget01/capset01.c . What do you think about it?
> 
> Sure. We can use 0 in all tests if we have a least one for each syscall
> that tests it with pid != 0.
Ok. I will do it.
> 


