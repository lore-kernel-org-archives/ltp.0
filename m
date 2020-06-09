From: Li Wang <liwang@redhat.com>
Date: Tue,  9 Jun 2020 17:51:02 +0800
Subject: [LTP] [PATCH v4 4/4] mm: add cpuset01 to runtest file
In-Reply-To: <20200609095102.21153-1-liwang@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
Message-ID: <20200609095102.21153-4-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test was moved to stress test since commit ae8fa55a8, but stress
runtest has been removed from commit e752f7c19674 :).

Here adding back it as a general memory test without '-I 3600'.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/mm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/mm b/runtest/mm
index a09f39c1e..612a4d066 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -73,6 +73,8 @@ ksm06 ksm06
 ksm06_1 ksm06 -n 10
 ksm06_2 ksm06 -n 10000
 
+cpuset01 cpuset01
+
 oom01 oom01
 oom02 oom02
 oom03 oom03
-- 
2.21.1

