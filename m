From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jan 2019 11:50:05 +0100
Subject: [LTP] [PATCH 6/6] ima: Use ima tcb policy files for test
In-Reply-To: <1547494342.4156.188.camel@linux.ibm.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
 <1547494342.4156.188.camel@linux.ibm.com>
Message-ID: <20190115105005.GA12143@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi, Jia,

> On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> > In order to make all tests running smoothly, the policy files should
> > keep up with the default ima tcb policy.

> Keeping the policy rules in sync is a good idea, but some of the rules
> might cause a regression with older kernels (eg. NSFS magic).  Not
> including the rule, also poses a problem.

Mimi, you added NSFS_MAGIC into policy in v4.2 (cd025f7f9410 "ima: do not
measure or appraise the NSFS filesystem"), in the commit is Cc for 3.19, but
it's not in origin/linux-3.19.y stable tree (v3.19.8). So regression could be
from kernel <= 4.1.

> The kernel headers package includes magic.h.  One solution would be to check whether a magic name is included in magic.h.
Interesting approach, I like this approach. Policy would have to be generated on
the fly, but that shouldn't be a problem.


Kind regards,
Petr
