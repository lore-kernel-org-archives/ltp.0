From: Matthias Maennich <maennich@google.com>
Date: Tue, 12 Mar 2019 14:55:51 +0000
Subject: [LTP] [PATCH v1] runtest/syscalls: add (rt_)sigtimedwait01
Message-ID: <20190312145551.246466-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rt_sigtimedwait01 and sigtimedwait01 are compile time variants of
sigwaitinfo01 and shall be addded to runtest/syscalls as well.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 runtest/syscalls | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 978a56a0788c..d752dba33780 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1004,6 +1004,7 @@ rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
 rt_sigsuspend01 rt_sigsuspend01
+rt_sigtimedwait01 rt_sigtimedwait01
 rt_tgsigqueueinfo01 rt_tgsigqueueinfo01
 
 sbrk01 sbrk01
@@ -1282,6 +1283,8 @@ sigrelse01 sigrelse01
 
 sigsuspend01 sigsuspend01
 
+sigtimedwait01 sigtimedwait01
+
 sigwaitinfo01 sigwaitinfo01
 
 socket01 socket01
-- 
2.21.0.360.g471c308f928-goog

