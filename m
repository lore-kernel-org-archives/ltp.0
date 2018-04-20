From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Apr 2018 09:21:21 +0200
Subject: [LTP] [PATCH v3 1/2] network/in6_02: Don't use default value for
	LHOST_IFACES
Message-ID: <20180420072122.16897-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In case of LHOST_IFACES not being defined was 'eth0' used as default.
Although eth0 is common iface, we cannot guarantee it, therefore skip
testing it.

Also check sscanf return value to catch whitespace only.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/lib6/in6_02.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index 7cb362666..e1a71d987 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -34,7 +34,7 @@ static struct {
 	int nonzero;
 } n2i[] = {
 	{ "lo", 1 },
-	{ "eth0", 1 },
+	{ NULL, 1 },
 	{ "hoser75", 0 },
 	{ "6", 0 },
 };
@@ -80,6 +80,11 @@ void n2itest(void)
 	char ifname[IF_NAMESIZE], *pifn;
 
 	for (i = 0; i < N2I_COUNT; ++i) {
+		if (n2i[i].name == NULL) {
+			tst_resm(TCONF, "LHOST_IFACES not defined or invalid, skip testing it");
+			return;
+		}
+
 		TEST(if_nametoindex(n2i[i].name));
 		if (!TEST_RETURN != !n2i[i].nonzero) {
 			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
@@ -256,22 +261,17 @@ void setup(void)
 {
 	TEST_PAUSE;
 
-	tst_resm(TINFO, "get interface name from LHOST_IFACES var");
-
 	char *ifnames = getenv("LHOST_IFACES");
-
-	if (!ifnames) {
-		tst_resm(TWARN, "LHOST_IFACES not defined, default to eth0");
+	if (!ifnames)
 		return;
-	}
 
 	static char name[256];
+	int ret;
 
-	sscanf(ifnames, "%255s", name);
-
-	if (!strcmp(name, n2i[1].name))
+	ret = sscanf(ifnames, "%255s", name);
+	if (ret == -1)
 		return;
 
-	tst_resm(TINFO, "change default 'eth0' name to '%s'", name);
+	tst_resm(TINFO, "get interface name from LHOST_IFACES: '%s'", name);
 	n2i[1].name = name;
 }
-- 
2.16.3

