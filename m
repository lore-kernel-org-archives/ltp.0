From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:54:55 +0200
Subject: [LTP] [RFC PATCH v3 02/10] security/ima: Change order of tests
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unfortunately in some circumstances there are interdependencies between
tests.
measurements test require loaded IMA policy. If it's not loaded, policy
test do it for us => run measurements test after policy test.

Policy test somehow breaks violations test => run it before policy test.
TODO: this does not help if CONFIG_IMA_WRITE_POLICY=y and without auditd
daemon. Maybe we should require auditd for violation tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Is it caused by using unsigned policy?
This problem haven't been solved by avoiding tmpfs.
---
 runtest/ima | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/ima b/runtest/ima
index bcae16bb7..e7824a62a 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -1,5 +1,5 @@
 #DESCRIPTION:Integrity Measurement Architecture (IMA)
-ima_measurements ima_measurements.sh
+ima_violations ima_violations.sh
 ima_policy ima_policy.sh
+ima_measurements ima_measurements.sh
 ima_tpm ima_tpm.sh
-ima_violations ima_violations.sh
-- 
2.16.3

