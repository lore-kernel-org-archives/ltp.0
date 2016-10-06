From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:54:52 +0300
Subject: [LTP] [PATCH 1/4] runtest/net_stress.ipsec_icmp: disable multinic
	tests
Message-ID: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These tests not fixed yet, disable for now. The file
includes new ipsec tests and having broken tests together
with the new ones can be unhandy.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.ipsec_icmp |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 2b989b1..071af7d 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -35,35 +35,3 @@ icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65
 # after compression. So we just use a large enough message size(65000) for testing
 icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
 icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
-
-icmp4-multi-diffip01 icmp4-multi-diffip01
-icmp4-multi-diffip02 icmp4-multi-diffip02
-icmp4-multi-diffip03 icmp4-multi-diffip03
-icmp4-multi-diffip04 icmp4-multi-diffip04
-icmp4-multi-diffip05 icmp4-multi-diffip05
-icmp4-multi-diffip06 icmp4-multi-diffip06
-icmp4-multi-diffip07 icmp4-multi-diffip07
-
-icmp6-multi-diffip01 icmp6-multi-diffip01
-icmp6-multi-diffip02 icmp6-multi-diffip02
-icmp6-multi-diffip03 icmp6-multi-diffip03
-icmp6-multi-diffip04 icmp6-multi-diffip04
-icmp6-multi-diffip05 icmp6-multi-diffip05
-icmp6-multi-diffip06 icmp6-multi-diffip06
-icmp6-multi-diffip07 icmp6-multi-diffip07
-
-icmp4-multi-diffnic01 icmp4-multi-diffnic01
-icmp4-multi-diffnic02 icmp4-multi-diffnic02
-icmp4-multi-diffnic03 icmp4-multi-diffnic03
-icmp4-multi-diffnic04 icmp4-multi-diffnic04
-icmp4-multi-diffnic05 icmp4-multi-diffnic05
-icmp4-multi-diffnic06 icmp4-multi-diffnic06
-icmp4-multi-diffnic07 icmp4-multi-diffnic07
-
-icmp6-multi-diffnic01 icmp6-multi-diffnic01
-icmp6-multi-diffnic02 icmp6-multi-diffnic02
-icmp6-multi-diffnic03 icmp6-multi-diffnic03
-icmp6-multi-diffnic04 icmp6-multi-diffnic04
-icmp6-multi-diffnic05 icmp6-multi-diffnic05
-icmp6-multi-diffnic06 icmp6-multi-diffnic06
-icmp6-multi-diffnic07 icmp6-multi-diffnic07
-- 
1.7.1

