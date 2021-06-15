From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 15 Jun 2021 08:51:04 +0100
Subject: [LTP] [PATCH] icmp_rate_limit01: Require CONFIG_VETH
Message-ID: <20210615075104.24870-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test fails with TBROK if it can not create a virtual ethernet
pair. So add it to the kconfigs.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Just thinking about the config meta data and embedded users. Functions
like tst_create_veth_pair could check needs_kconfigs for the required
config and TBROK if it is not there.

Alternatively (or in addition to) static analyses can be used to check
(or add) missing config.

In either case this may be wrong when a function is only used in a
branch. OTOH then the test needs splitting otherwise the metadata
can't be known ahead of execution.

 testcases/cve/icmp_rate_limit01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 0c2ac44df..f24ea5bf9 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -260,6 +260,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_kconfigs = (const char *[]) {
+		"CONFIG_VETH",
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
 		NULL
-- 
2.31.1

