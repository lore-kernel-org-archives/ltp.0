From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Sep 2018 17:44:39 +0300
Subject: [LTP] [RFC PATCH 2/5] runtest/syscalls: rename CVE test cases
In-Reply-To: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1536849882-28897-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/syscalls | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..b68eda7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -950,8 +950,8 @@ renameat202 renameat202 -i 10
 request_key01 request_key01
 request_key02 request_key02
 request_key03 request_key03
-cve-2017-6951 cve-2017-6951
 request_key04 request_key04
+request_key05 cve-2017-6951
 
 rmdir01 rmdir01
 rmdir02 rmdir02
@@ -1177,7 +1177,7 @@ setsid01 setsid01
 
 setsockopt01 setsockopt01
 setsockopt02 setsockopt02
-cve-2016-4997 cve-2016-4997
+setsockopt03 cve-2016-4997
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
@@ -1195,7 +1195,7 @@ setxattr03 setxattr03
 
 shmat01 shmat01
 shmat02 shmat02
-cve-2017-5669 cve-2017-5669
+shmat03 cve-2017-5669
 
 shmctl01 shmctl01
 shmctl02 shmctl02
@@ -1390,7 +1390,7 @@ umask01 umask01
 uname01 uname01
 uname02 uname02
 uname03 uname03
-cve-2012-0957 cve-2012-0957
+uname04 cve-2012-0957
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
-- 
1.8.3.1

