From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Jan 2018 21:28:21 +0100
Subject: [LTP] [RFC PATCH 2/2] security/ima: Run measurements after policy
In-Reply-To: <20180111202821.31639-1-pvorel@suse.cz>
References: <20180111202821.31639-1-pvorel@suse.cz>
Message-ID: <20180111202821.31639-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes failing policy tests when no IMA is configured on SUT.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/ima b/runtest/ima
index 20d2e0810..3462d12b1 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -1,5 +1,5 @@
 #DESCRIPTION:Integrity Measurement Architecture (IMA)
-ima01 ima_measurements.sh
-ima02 ima_policy.sh
+ima01 ima_policy.sh
+ima02 ima_measurements.sh
 ima03 ima_tpm.sh
 ima04 ima_violations.sh
-- 
2.15.1

