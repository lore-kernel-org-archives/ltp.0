From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 16:32:00 +0200
Subject: [LTP] [PATCH 2/4] [COMMITTED] nfsv4/locktest: Fix old style
	function definitions
In-Reply-To: <20170828143202.24021-1-chrubis@suse.cz>
References: <20170828143202.24021-1-chrubis@suse.cz>
Message-ID: <20170828143202.24021-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This mostly adds void to functions without parameters but also removes
one case where parameters are wrongly passed to such function.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/nfsv4/locks/locktests.c | 34 +++++++++++++++----------------
 testcases/network/nfsv4/locks/netsync.c   |  8 ++++----
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
index 73fca3095..dd6899cd1 100644
--- a/testcases/network/nfsv4/locks/locktests.c
+++ b/testcases/network/nfsv4/locks/locktests.c
@@ -97,7 +97,7 @@ int terminerProcess(int a)
 	exit(a);
 }
 
-int (*load) ();
+int (*load) (void);
 
 struct donneesPub dp;
 
@@ -172,7 +172,7 @@ void validationResultats(int n)
 	}
 }
 
-int initTest()
+int initTest(void)
 {
 
 	P("Maitre ouvre %s\n", dp.fname);
@@ -237,13 +237,13 @@ void cleanClient(struct donneesFils *df)
 	free(df);
 }
 
-void clean()
+void clean(void)
 {
 	free(dp.lthreads);
 	free(dp.lclnt);
 }
 
-int loadProcess()
+int loadProcess(void)
 {
 	int i;
 	struct donneesFils *df;
@@ -278,7 +278,7 @@ void selectTest(int n, struct s_test *test)
 }
 
 /* Final test report */
-void rapport(clnt)
+void rapport(int clnt)
 {
 	int i;
 	int totalClients;
@@ -294,7 +294,7 @@ void rapport(clnt)
 
 }
 
-int serverSendLocal()
+int serverSendLocal(void)
 {
 	int i;
 	/* Synchronize slave processes */
@@ -306,12 +306,12 @@ int serverSendLocal()
 
 }
 
-void serverSendNet()
+void serverSendNet(void)
 {
 	writeToAllClients(message);
 }
 
-int serverReceiveNet()
+int serverReceiveNet(void)
 {
 	int i, c;
 	for (c = 0; c < maxClients; c++) {
@@ -322,7 +322,7 @@ int serverReceiveNet()
 	return 0;
 }
 
-int serverReceiveLocal()
+int serverReceiveLocal(void)
 {
 	int i;
 	for (i = 0; i < dp.nclnt; i++)
@@ -330,26 +330,26 @@ int serverReceiveLocal()
 	return 0;
 }
 
-int clientReceiveLocal()
+int clientReceiveLocal(void)
 {
 	read(esclaveLecteur, message, M_SIZE);
 	return 0;
 }
 
-int clientSend()
+int clientSend(void)
 {
 	write(esclaveEcrivain, message, M_SIZE);
 	return 0;
 }
 
-int serverSend()
+int serverSend(void)
 {
 	serverSendNet();
 	serverSendLocal();
 	return 0;
 }
 
-int serverReceive()
+int serverReceive(void)
 {
 	serverReceiveNet();
 	serverReceiveLocal();
@@ -480,7 +480,7 @@ int getResults(int ntest)
 /* In the case of a network use, the master of the client application si only
  * a 'repeater' of information. It resends server-master instructions to its own slaves.
  */
-void maitreClient()
+void maitreClient(void)
 {
 	fd_set fdread;
 	struct timeval tv;
@@ -566,7 +566,7 @@ void maitreClient()
 
 }
 
-void maitre()
+void maitre(void)
 {
 	int i, n, bl;
 	int clnt;
@@ -718,7 +718,7 @@ void maitre()
 
 			/* close and open file */
 			close(dp.fd);
-			initTest(dp);
+			initTest();
 			etat = SELECT;
 			continue;
 		case FIN:
@@ -939,7 +939,7 @@ char *nextArg(int argc, char **argv, int *i)
 	return NULL;
 }
 
-int usage()
+int usage(void)
 {
 	printf("locktest -n <number of process> -f <test file> [-T]\n");
 	printf("Number of child process must be higher than 1\n");
diff --git a/testcases/network/nfsv4/locks/netsync.c b/testcases/network/nfsv4/locks/netsync.c
index 34dabc9bd..f53b347f1 100644
--- a/testcases/network/nfsv4/locks/netsync.c
+++ b/testcases/network/nfsv4/locks/netsync.c
@@ -35,13 +35,13 @@ int serverSendClient(int n)
 	return write(fdClient[n], message, M_SIZE);
 }
 
-int clientReceiveNet()
+int clientReceiveNet(void)
 {
 	readFromServer(message);
 	return 0;
 }
 
-int setupConnectionServeur()
+int setupConnectionServeur(void)
 {
 	struct sockaddr_in local;
 	int c;
@@ -86,7 +86,7 @@ int writeToClient(int c, char *message)
 	return write(fdClient[c], message, 512);
 }
 
-int serverCloseConnection()
+int serverCloseConnection(void)
 {
 	int c;
 	for (c = 0; c < maxClients; c++)
@@ -129,7 +129,7 @@ int configureServeur(int max)
 	return 0;
 }
 
-int setupConnectionClient()
+int setupConnectionClient(void)
 {
 
 	struct hostent *server;
-- 
2.13.0

