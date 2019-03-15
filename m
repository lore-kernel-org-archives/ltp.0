From: Matthias Maennich <maennich@google.com>
Date: Fri, 15 Mar 2019 09:31:00 +0000
Subject: [LTP] [PATCH v1] runtest/syscalls: add sigwait01
Message-ID: <20190315093100.138612-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sigwait01 is a compile time variant of sigwaitinfo01 and shall be added
to runtest/syscalls as well.

Signed-off-by: Matthias Maennich <maennich@google.com>
Cc: kernel-team@android.com
---
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d752dba33780..03b613c07b65 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1285,6 +1285,7 @@ sigsuspend01 sigsuspend01
 
 sigtimedwait01 sigtimedwait01
 
+sigwait01 sigwait01
 sigwaitinfo01 sigwaitinfo01
 
 socket01 socket01
-- 
2.21.0.360.g471c308f928-goog

