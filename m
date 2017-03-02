From: Eryu Guan <eguan@redhat.com>
Date: Thu,  2 Mar 2017 21:33:23 +0800
Subject: [LTP] [PATCH 3/3] runtest/dio: enable dio29/30
In-Reply-To: <20170302133323.5262-1-eguan@redhat.com>
References: <20170302133323.5262-1-eguan@redhat.com>
Message-ID: <20170302133323.5262-3-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not sure why dio29 and dio30 are commented out, I found a bug in
4.10 kernel by running them, see this patch

https://patchwork.kernel.org/patch/9598823/

So let's enable them by default.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 runtest/dio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/dio b/runtest/dio
index 97820e9..a26e001 100644
--- a/runtest/dio
+++ b/runtest/dio
@@ -40,8 +40,8 @@ dio27 diotest6 -b 8192 -o 1024000 -i 1000 -v 100
 dio28 diotest6 -b 8192 -o 1024000 -i 1000 -v 200
 
 ### Run the tests with more children
-#dio29 diotest3 -b 65536 -n 100 -i 1000 -o 1024000
-#dio30 diotest6 -b 65536 -n 100 -i 1000 -o 1024000
+dio29 diotest3 -b 65536 -n 100 -i 1000 -o 1024000
+dio30 diotest6 -b 65536 -n 100 -i 1000 -o 1024000
 #
 # RAW DEVICE TEST SECTION
 #   DEV1 and DEV2 should be exported prior to execution or
-- 
2.9.3

