From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Jun 2016 16:54:56 +0200
Subject: [LTP] [PATCH] proc01: handle EOPNOTSUPP if !hugepages_supported()
Message-ID: <f4698e880d970a74fb613191748487183cf35e08.1465311184.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds an entry to known issue list. These 2 proc files
may return EOPNOTSUPP if CONFIG_HUGETLB_PAGE=Y and hugepages_supported()
is false:
  /proc/sys/vm/nr_hugepages: errno=EOPNOTSUPP(95): Operation not supported
  /proc/sys/vm/nr_overcommit_hugepages: errno=EOPNOTSUPP(95): Operation not supported

from mm/hugetlb.c:
--------------------------------- 8< ---------------------------------
static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
                         struct ctl_table *table, int write,
                         void __user *buffer, size_t *length, loff_t *ppos)
{
        struct hstate *h = &default_hstate;
        unsigned long tmp = h->max_huge_pages;
        int ret;

        if (!hugepages_supported())
                return -EOPNOTSUPP;
--------------------------------- >8 ---------------------------------

I've noticed this issue on s390 only after this commit:
  commit 7f9be77555bb2e52de84e9dddf7b4eb20cc6e171
  Author: Dominik Dingel <dingel@linux.vnet.ibm.com>
  Date:   Fri Jul 17 16:23:39 2015 -0700
    s390/hugetlb: add hugepages_supported define

Also note, that kernel versions prior to 4.4 may fail with
ENOTSUPP, which has been changed to EOPNOTSUPP by:
  commit 86613628b3d367743f71b945c203774c522404f4
  Author: Jan Stancek <jstancek@redhat.com>
  Date:   Wed Mar 9 14:08:35 2016 -0800
    mm/hugetlb: use EOPNOTSUPP in hugetlb sysctl handlers

Given that nobody complained running into this issue before,
it's assumed that this is not common and therefore this patch
adds only EOPNOTSUPP to list.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/proc/proc01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 2825b51dff95..409d6f9e32fe 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -108,6 +108,8 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
 	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
 	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
+	{"read", "/proc/sys/vm/nr_hugepages", EOPNOTSUPP},
+	{"read", "/proc/sys/vm/nr_overcommit_hugepages", EOPNOTSUPP},
 	{"", "", 0}
 };
 
-- 
1.8.3.1

