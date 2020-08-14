From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 14 Aug 2020 13:37:34 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/msgrcv09: Add error test for
 MSG_COPY flag
In-Reply-To: <20200813152536.GH13292@yuki.lan>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595230227-21468-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200813141953.GG13292@yuki.lan>
 <e304a375-2d99-a083-bd7c-2cb6fe2ed314@cn.fujitsu.com>
 <20200813152536.GH13292@yuki.lan>
Message-ID: <b7d3de64-af0f-f384-565f-5f11dc53eb38@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>>>> +static struct tst_test test = {
>>>> +	.needs_tmpdir = 1,
>>>> +	.needs_root = 1,
>>>> +	.needs_kconfigs = (const char *[]) {
>>>> +		"CONFIG_CHECKPOINT_RESTORE",
>>>> +		NULL
>>>> +	},
>>>> +	.min_kver = "3.8.0",
>>>> +	.tcnt = ARRAY_SIZE(tcases),
>>>> +	.test = verify_msgrcv,
>>>> +	.setup = setup,
>>>> +	.cleanup = cleanup,
>>>> +};
>>>
>>> Do we need both min_kver and CONFIG_CHECKPOINT_RESTORE? Wouldn't be
>>> CONFIG_CHECKPOINT_RESTORE enough?
>> I think we need both because the CONFIG_CHECKPOINT_RESTORE macro was not
>> introduced since 3.8. Before 3.8, we can enable this config but the
>> kernel does not support this MSG_COPY FLAG.
>> also using "CONFIG_CHECKPOINT_RESTORE=y" is better.
> 
> Ah, makes sense. I wonder if this worth a comment in the top level
> test description.
In my personal habit, I think a comment is better becuase this is more 
friendly for user.
> 


