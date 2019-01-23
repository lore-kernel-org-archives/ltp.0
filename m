From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jan 2019 18:04:09 +0100
Subject: [LTP] [PATCH v3 5/6] ima: Rename the folder name for policy
 files to datafiles
In-Reply-To: <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <20190123170409.GA11731@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Jia,

> If we choose to run ima_policy.sh locally without installation,
> a failure message is reported as following:

> ima_policy 1 TCONF: missing <path>/ltp/testcases/kernel/security/integrity/ima/datafiles/measure.policy

> TST_DATAROOT would be extended to datafiles but the policy files
> are actually placed under policy.

> In order to make it easier, just rename the folder name to datafiles.

> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---

I wasn't sure about this one as make install isn't that hard to do even during
debugging and policy is more descriptive. But other tests use datafiles as well,
therefore taken as well.

Whole patchset merged, thank you both for your work.

Kind regards,
Petr
