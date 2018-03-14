From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Mar 2018 16:57:29 +0100
Subject: [LTP] [RFC PATCH v2 2/4] security/ima: Run measurements after policy
In-Reply-To: <20180314155731.5943-1-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
Message-ID: <20180314155731.5943-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes failing policy tests when no IMA is configured on SUT.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Mimi suggested in [1]:
The current ordering of the tests assume that the system was booted
with the builtin "ima_tcb" policy enabled on the boot command line.
Assuming that the kernel doesn't require policies to be signed,
changing the order of the tests is fine.  Or simply test whether the
system was booted with either "ima_tcb" or "ima_policy=tcb" boot
command line options.

Mimi, do I understand it correctly that ima_policy.sh should be called
first when using ima_tcb (original order) and second otherwise?
That would be problematic, as we need a fixed order of tests in runtest
file.

[1] http://lists.linux.it/pipermail/ltp/2018-January/007025.html
---
 runtest/ima | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/ima b/runtest/ima
index bcae16bb7..06bfd7720 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -1,5 +1,5 @@
 #DESCRIPTION:Integrity Measurement Architecture (IMA)
-ima_measurements ima_measurements.sh
 ima_policy ima_policy.sh
+ima_measurements ima_measurements.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
-- 
2.16.2

