From: Ronald Monthero <rmonther@redhat.com>
Date: Tue, 10 Mar 2020 12:53:15 +1000
Subject: [LTP] Fwd: Fix build error because of undefined CAP_SYS_TIME
In-Reply-To: <CAGR3Yi6r+caUYV+yZYHGsuRUPQBbpsN_PJOTTSvHwE2VARy92g@mail.gmail.com>
References: <CAGR3Yi6r+caUYV+yZYHGsuRUPQBbpsN_PJOTTSvHwE2VARy92g@mail.gmail.com>
Message-ID: <CAGR3Yi5dVfMwgBEUcOkXMNr4eX5=EumXi6PU_mqLo_MRZ0XkkQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Details of the build log at pr#654
https://github.com/linux-test-project/ltp/pull/654

Signed-off-by: Ronald Monthero <rmonther@redhat.com>
---
 include/lapi/capability.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 8833f0605..8ed68bfce 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -24,6 +24,10 @@
 # define CAP_NET_RAW          13
 #endif

+#ifndef CAP_SYS_TIME
+#define CAP_SYS_TIME          25
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
-- 
2.21.1

---------- Forwarded message ---------
From: Ronald Monthero <rmonther@redhat.com>
Date: Tue, Mar 10, 2020 at 12:44 PM
Subject: Fix build error because of undefined CAP_SYS_TIME
To: <ltp@lists.linux.it>


Details of the build log at pr#654
https://github.com/linux-test-project/ltp/pull/654

Signed-off-by: Ronald Monthero <rmonther@redhat.com>
---
diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 8833f0605..8ed68bfce 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -24,6 +24,10 @@
 # define CAP_NET_RAW          13
 #endif

+#ifndef CAP_SYS_TIME
+#define CAP_SYS_TIME          25
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
---

