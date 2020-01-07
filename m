From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 7 Jan 2020 11:02:57 +0800
Subject: [LTP] LTP Release plans
In-Reply-To: <c3c2588b-edc5-ddeb-eb0d-992041d4ff67@cn.fujitsu.com>
References: <20191213125435.GB20795@rei.lan> <20200106150329.GC26880@rei.lan>
 <c3c2588b-edc5-ddeb-eb0d-992041d4ff67@cn.fujitsu.com>
Message-ID: <1317ae5a-5f74-73bc-66fa-0da43793def8@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2020/01/07 10:03, Yang Xu wrote:
> 
> 
> Hi Cyril
>> Hi!
>> First of all Happy New Year!
>>
>> I'm back at patch review and we are getting close to a pre-release
>> testing freeze.
>>
>> As I stated before I will have a look at he fallocate05 test and the
>> capset/capget patches. Is there anything else that should be part of the
>> release?
>>
>> Looking at the patch queue we should probably include:
>>
>> tst_dev_bytes_written: parsing /proc/diskstats instead of sys file
>> syscalls/userfaultfd01: add hint about unprivileged_userfaultfd
>>
>> Anything else I should look at?
Also. In December-end, pengfei sent a kconfig patch set to support 
CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y. CONFIG_X86_INTEL_UMIP=y for 
umip kconfig before and v5.4  mainline kernel. CONFIG_X86_UMIP=y for 
umip kconfig after v5.5 mainline kernel. I think we can include this 
patchset before release if it is ok.

url:
http://lists.linux.it/pipermail/ltp/2019-December/014841.html
> Yes. I also sent a pipe test[1]to ltp(it has undefined F_GETPIPE_SZ 
> error on old kernel [2]and I will fix it in v2), as below:
> syscalls/pipe12: add new test for piep when write bytes > PIPE_BUF
> 
> Also, Cypresslin has a pull[3] about syscalls/statx05: add mkfs.ext4 
> package version check.
> 
> [1]https://patchwork.ozlabs.org/patch/1215360/
> [2]https://travis-ci.org/xuyang0410/ltp/jobs/629597516?utm_medium=notification&utm_source=github_status 
> 
> [3]https://github.com/linux-test-project/ltp/pull/626
> 
> Best Regards
> Yang Xu
>>
> 
> 
> 


