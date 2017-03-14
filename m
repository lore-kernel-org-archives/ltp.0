From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Mar 2017 15:41:18 +0800
Subject: [LTP] [PATCH] gitignore: Add cscope generated files
Message-ID: <20170314074118.25540-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6d57825..a7e6563 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,6 +41,9 @@ autom4te.cache
 /pan/ltp-pan
 /pan/ltp-scanner
 
+cscope.*
+ncscope.*
+
 .dep_modules
 .gitattributes
 .pc/
-- 
2.9.3

