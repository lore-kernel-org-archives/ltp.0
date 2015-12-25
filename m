From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 25 Dec 2015 12:09:59 +0300
Subject: [LTP] [PATCH v3] hugetlb: add new testcase hugeshmat05.c
In-Reply-To: <1450696717-6983-1-git-send-email-liwang@redhat.com>
References: <1450696717-6983-1-git-send-email-liwang@redhat.com>
Message-ID: <567D07E7.7040601@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 12/21/2015 02:18 PM, Li Wang wrote:
> shmget()/shmat() fails to allocate huge pages shared memory segment
> with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
> N*HUGE_PAGE_SIZE ]. This is a problem in the memory segment size round
> up algorithm. The requested size is rounded up to PAGE_SIZE (4096), but
> if this roundup does not match HUGE_PAGE_SIZE (2Mb) boundary - the
> allocation fails.

Applied, thanks!

Also fixed some style warns and errors:

ERROR: need consistent spacing around '-' (ctx:WxV)
#177: FILE: testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c:119:
+               N * hpage_size - page_size -1,


ERROR: space required before the open parenthesis '('
#185: FILE: testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c:127:
+               for(i = 0; i < ARRAY_SIZE(tst_sizes); ++i)

Thanks,
Alexey
