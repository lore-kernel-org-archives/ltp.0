From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 6 Sep 2021 11:12:38 +0800
Subject: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
Message-ID: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

can_bcm01 is designed to test cve-2021-3609 instead of cve-2021-6309.

Fixes: 027ea6171c40 ("Add test for CVE 2021-3609")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/cve | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index 357b88feb..01211b5aa 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -67,7 +67,7 @@ cve-2020-14416 pty03
 cve-2020-25705 icmp_rate_limit01
 cve-2020-29373 io_uring02
 cve-2021-3444 bpf_prog05
-cve-2021-6309 can_bcm01
+cve-2021-3609 can_bcm01
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 # Tests below may cause kernel memory leak
-- 
2.23.0

