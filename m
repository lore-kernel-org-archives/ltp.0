From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 8 Jan 2020 11:19:14 +0800
Subject: [LTP] [PATCH v1 3/4] syscalls/capset03: add new EPERM error
 test without CAP_SETPCAP
In-Reply-To: <20200107133913.GE26408@rei.lan>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200107133913.GE26408@rei.lan>
Message-ID: <e6cada30-fb4e-a2e0-72e9-cdfc796361cb@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> Hi!
>> +static void setup(void)
>> +{
>> +	pid_t pid;
>> +
>> +	pid = getpid();
>> +	header.pid = pid;
>> +	if (geteuid() == 0) {
>> +		TEST(tst_syscall(__NR_capset, &header, data));
>> +		if (TST_RET == -1)
>> +			tst_brk(TBROK | TTERRNO, "capset data failed");
>> +	}
> 
> Please don't do that. If tests needs root (even for a subset of the
> test) just set the .needs_root flag.
> 
This test doesn't need root. These code is designed to create a 
envrionment for root user to generate this type EPERM 
error?new_Inheritable is not a subset of old_Inheritable and 
old_Permitted without CAP_SETPCAP?.
root user:
old pI: CAP_KILL
old pP: CAP_KILL
new pI: CAP_KILL + CAP_NET_RAW

other user:
old pI: 0
old pP: 0
new pI: CAP_KILL + CAP_NET_RAW

other user also met condition and can generate this EPERM error.

ps: In capset03, getpid() is useless, we can use pid = 0 to replace.
Also, if we can use pid =0 in error test, maybe we don't need to test 
pid =0 in capget01/capset01.c . What do you think about it?
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = verify_capset,
>> +	.caps = (struct tst_cap []) {
>> +		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
>> +		{}
>> +	},
>> +};
>> -- 
>> 2.18.0
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


