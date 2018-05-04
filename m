From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  4 May 2018 10:28:29 +0200
Subject: [LTP] [PATCH 1/1] setregid: Fallback to `nogroup' group
Message-ID: <20180504082829.10973-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

if group `nobody' does not exist

This is at least on default installation of Debian 9.

Fixes: 1b7cf9474 setregid: use common user and group names.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setregid/setregid03.c | 15 ++++++++++++++-
 testcases/kernel/syscalls/setregid/setregid04.c | 11 ++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 97102e0ee..a4caf238d 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -195,7 +195,20 @@ static void setup(void)
 	group ## _gr = *(junk); \
 } while (0)
 
-	GET_GID(nobody);
+#define GET_GID_FALLBACK(group, group2) do { \
+	junk = getgrnam(#group); \
+	if (junk == NULL) { \
+		tst_resm(TINFO, "%s not found, trying fallback %s", #group, #group2); \
+		junk = getgrnam(#group2); \
+		if (junk == NULL) { \
+			tst_brkm(TBROK, NULL, "%s or %s must be a valid group", #group, #group2); \
+		} \
+	} \
+	GID16_CHECK(junk->gr_gid, setregid, NULL); \
+	group ## _gr = *(junk); \
+} while (0)
+
+	GET_GID_FALLBACK(nobody, nogroup);
 	GET_GID(daemon);
 	GET_GID(bin);
 
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 73f8bcb03..bf744ff05 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -116,6 +116,15 @@ int main(int ac, char **av)
 	} \
 	GROUPNAME ## _gr = *(getgrnam(#GROUPNAME));
 
+#define SAFE_GETGROUP_FALLBACK(GROUPNAME, GROUPNAME2)	\
+	if (getgrnam(#GROUPNAME) != NULL) \
+		GROUPNAME ## _gr = *(getgrnam(#GROUPNAME)); \
+	else if (getgrnam(#GROUPNAME2) != NULL) { \
+		GROUPNAME ## _gr = *(getgrnam(#GROUPNAME2)); \
+		tst_resm(TINFO, "`" #GROUPNAME "' group not found, trying fallback `" #GROUPNAME2 "' group"); \
+	} else \
+		tst_brkm(TBROK, NULL, "Couldn't find neither`" #GROUPNAME "' `" #GROUPNAME2 "' nor group");
+
 static void setup(void)
 {
 	tst_require_root();
@@ -123,7 +132,7 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	SAFE_GETGROUP(root);
-	SAFE_GETGROUP(nobody);
+	SAFE_GETGROUP_FALLBACK(nobody, nogroup);
 	SAFE_GETGROUP(daemon);
 	SAFE_GETGROUP(bin);
 
-- 
2.16.3

