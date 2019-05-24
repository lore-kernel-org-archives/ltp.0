From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 24 May 2019 21:58:28 +0800
Subject: [LTP] [PATCH v3] syscalls/prctl05.c: New test for prctl() with
 PR_{SET, GET}_NAME
In-Reply-To: <20190524134849.GB2251@rei>
References: <70578dc6-1a6b-9ab1-1298-0539ae8562f9@163.com>
 <1558684246-2658-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <b6b85048-ff36-9681-05bd-2131721efd4f@163.com> <20190524134849.GB2251@rei>
Message-ID: <7113d89a-3eb8-5671-bb6a-26cc4cbb69bf@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/24/2019 09:48 PM, Cyril Hrubis wrote:
> Hi!
>>> +	if (strcmp(tc->expname, buf))
>>> +		tst_res(TFAIL,
>>> +			"prctl(PR_GET_NAME) failed ,expected %s, got %s", tc->expname, buf);
>>> +	else
>>> +		tst_res(TPASS,
>>> +			"prctl(PR_GET_NAME) succeeded, thread name is %s", buf);
>> Hi Xu,
>>
>> It is not necessary to continue if buf mismatches tc->expname.
>>
>>> +
>>> +	tid = tst_syscall(__NR_gettid);
>>> +
>>> +	sprintf(PROC_NAME_PATH, "/proc/self/task/%d/comm", tid);
>>> +	SAFE_FILE_SCANF(PROC_NAME_PATH, "%s", comm_buf);
>> You didn't create multiple threads here so it seems simpler to use
>> /proc/self/comm
>> instead of /proc/self/task/<tid>/comm. do you think so?
>> Please see the following url for details:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/proc.txt
> Actually we should check both.
Hi Cyril,

Thanks for your quick reply.

It's better to check both.
>> BTW:
>> Should we print three TPASS messages for one test?
>> Can we replace previous TPASS with TINFO and then print TPASS at the end?
> I think that it's cleaner to print PASS/FAIL message for each subtest.
OK, we can keep it as you said.

Best Regards,
Xiao Yang


