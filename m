From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Thu, 24 Jan 2019 13:11:46 +0800
Subject: [LTP] [PATCH v3 5/6] ima: Rename the folder name for policy
 files to datafiles
In-Reply-To: <20190123170409.GA11731@dell5510>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
 <20190123170409.GA11731@dell5510>
Message-ID: <49244744-3546-c477-f443-a70ced4a4ed4@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 2019/1/24 上午1:04, Petr Vorel wrote:
> Hi Mimi, Jia,
> 
>> If we choose to run ima_policy.sh locally without installation,
>> a failure message is reported as following:
> 
>> ima_policy 1 TCONF: missing <path>/ltp/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> 
>> TST_DATAROOT would be extended to datafiles but the policy files
>> are actually placed under policy.
> 
>> In order to make it easier, just rename the folder name to datafiles.
> 
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> ---
> 
> I wasn't sure about this one as make install isn't that hard to do even during
> debugging and policy is more descriptive. But other tests use datafiles as well,
> therefore taken as well.

Actually, this patch resolves the issue if we just follow this step to
run IMA-only test:

$ git clone https://github.com/linux-test-project/ltp.git
$ cd ltp
$ export LTP_ROOT="$PWD"
$ make autotools
$ ./configure
$ cd testcases/lib
$ make
$ cd ../kernel/security/integrity/ima
$ make
$ sudo PATH=$LTP_ROOT/testcases/lib:tests:$PATH ./tests/ima_policy.sh

A full LTP installation doesn't have this issue.

Jia

> 
> Whole patchset merged, thank you both for your work.
> 
> Kind regards,
> Petr
> 
