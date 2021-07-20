From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 18:26:48 +0300
Subject: [LTP] [PATCH 00/16] syscalls/sched_*: convert to new API and
 handle ENOSYS errno
In-Reply-To: <YPbcfEgPs66/ng7c@yuki>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
 <YPbNQ4AebDiUMxVz@yuki> <f9767568-466f-73d2-7d73-aa880fde6a63@bell-sw.com>
 <YPbcfEgPs66/ng7c@yuki>
Message-ID: <7941651c-1712-55cb-a935-277cff8b1969@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20.07.2021 17:23, Cyril Hrubis wrote:
> Hi!
>> BTW, sched_rr_get_interval* tests already using tst_variants, adding
>> more variants will double them too, right?
> 
> Actually not, since we do run the test for both the libc
> sched_rr_get_interval and for all possible syscalls variants we don't
> have to touch these tests at all.

sched_rr_get_interval works with musl, the one which returns ENOSYS
is sched_setscheduler() there, in setup().
