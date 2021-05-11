From: dongshijiang <dongshijiang@inspur.com>
Date: Tue, 11 May 2021 05:16:30 -0400
Subject: [LTP] [PATCH] bugfix for network/lib6/getaddrinfo_01.c
Message-ID: <20210511091630.23257-1-dongshijiang@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For test cases (test2 ,IPV4 canonical name) and (test13 ,IPV6 canonical name)

The gethostname() API returns the official name of host, not the canonical name of host. The canonical name of host needs to be obtained through the gethostbyname() API;

Signed-off-by: dongshijiang <dongshijiang@inspur.com>
---
 testcases/network/lib6/getaddrinfo_01.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index db252a998..bf5af7b4a 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -75,6 +75,14 @@ static void gaiv4(void)
 	if (gethostname(hostname, sizeof(hostname)) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "gethostname failed");
 	strncpy(shortname, hostname, MAXHOSTNAMELEN);
+
+	//get official name of host
+	struct hostent *phostent = NULL;
+
+	phostent = gethostbyname(hostname);
+	if (phostent == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "gethostbyname failed");
+
 	shortname[MAXHOSTNAMELEN] = '\0';
 	p = strchr(shortname, '.');
 	if (p)
@@ -134,10 +142,10 @@ static void gaiv4(void)
 				 "entries with canonical name set");
 			freeaddrinfo(aires);
 			return;
-		} else if (strcasecmp(hostname, pai->ai_canonname)) {
+		} else if (strcasecmp(phostent->h_name, pai->ai_canonname)) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 canonical name "
 				 "(\"%s\") doesn't match hostname (\"%s\")",
-				 pai->ai_canonname, hostname);
+				 pai->ai_canonname, phostent->h_name);
 			freeaddrinfo(aires);
 			return;
 		}
@@ -533,6 +541,14 @@ static void gaiv6(void)
 	if (gethostname(hostname, sizeof(hostname)) < 0)
 		tst_brkm(TBROK, NULL, "gethostname failed - %s",
 			 strerror(errno));
+
+	//get official name of host
+	struct hostent *phostent = NULL;
+
+	phostent = gethostbyname(hostname);
+	if (phostent == NULL)
+		tst_brkm(TBROK | TERRNO, NULL, "gethostbyname failed");
+
 	strncpy(shortname, hostname, MAXHOSTNAMELEN);
 	shortname[MAXHOSTNAMELEN] = '\0';
 	p = strchr(shortname, '.');
@@ -593,10 +609,10 @@ static void gaiv6(void)
 				 "entries with canonical name set");
 			freeaddrinfo(aires);
 			return;
-		} else if (strcasecmp(hostname, pai->ai_canonname)) {
+		} else if (strcasecmp(phostent->h_name, pai->ai_canonname)) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 canonical name "
 				 "(\"%s\") doesn't match hostname (\"%s\")",
-				 pai->ai_canonname, hostname);
+				 pai->ai_canonname, phostent->h_name);
 			freeaddrinfo(aires);
 			return;
 		}
-- 
2.18.2

