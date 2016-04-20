From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Apr 2016 17:23:18 +0800
Subject: [LTP] [PATCH 2/3] containers/mountns*: Fix unused parameter
	compiler warnings
In-Reply-To: <1461144199-29361-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1461144199-29361-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1461144199-29361-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/containers/mountns/mountns01.c | 2 +-
 testcases/kernel/containers/mountns/mountns02.c | 2 +-
 testcases/kernel/containers/mountns/mountns03.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 17364af..b0ba048 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -52,7 +52,7 @@ int TST_TOTAL	= 2;
 
 #if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
 
-int child_func(void *arg)
+int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index 70b2028..eb5301c 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -52,7 +52,7 @@ int TST_TOTAL	= 2;
 
 #if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
 
-int child_func(void *arg)
+int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 5e9341a..d21eade 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -57,7 +57,7 @@ int TST_TOTAL	= 2;
 #if defined(MS_SHARED) && defined(MS_PRIVATE) \
     && defined(MS_REC) && defined(MS_SLAVE)
 
-int child_func(void *arg)
+int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
-- 
1.8.3.1



