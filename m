From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Nov 2015 11:23:39 +0800
Subject: [LTP] [PATCH] runtest/hugetlb: enable testcase hugemmap02.c
Message-ID: <1447817019-19637-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

the testcase has been fixed by this commit:
	commit 74c95c22deaf143c1e00b6dc146193f89442d5ae
	Author: Li Wang <liwang@redhat.com>
	Date:   Thu Oct 15 11:23:23 2015 +0800

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/hugetlb | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 7fcaa01..2e9f215 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,6 +1,5 @@
 hugemmap01 hugemmap01
-# test is broken in design
-#hugemmap02 hugemmap02
+hugemmap02 hugemmap02
 hugemmap04 hugemmap04
 hugemmap05 hugemmap05
 hugemmap05_1 hugemmap05 -m
-- 
1.8.3.1

