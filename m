From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 16:32:01 +0200
Subject: [LTP] [PATCH 3/4] [COMMITTED] nfsv4/locktest: Mechanically
	translate to english
In-Reply-To: <20170828143202.24021-1-chrubis@suse.cz>
References: <20170828143202.24021-1-chrubis@suse.cz>
Message-ID: <20170828143202.24021-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit mechanically translated french function names and variable
into english which makes the code much more readable for anybody who
does not speak french.

This has been done with following sed script file:

s/esclave/slave/g
s/maitre/master/g
s/Esclave/Slave/g
s/Maitre/Master/g
s/Lecteur/Reader/g
s/Ecrivain/Writer/g
s/Serveur/Server/g
s/terminer/finish/g
s/donnees/data/g
s/compteur/counter/g
s/Resultats/Results/g
s/resultat/result/g
s/FIN/END/g
s/initialise/initialize/g
s/Fils/Child/g
s/RESULTAT/RESULT/g
s/rapport/report/g
s/serveur/server/g
s/etat/state/g
s/Etat/State/g
s/Serialise/Serialize/g
s/serialise/serialize/g
s/NOMS/NAMES/g
s/LISTE/LIST/g

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/nfsv4/locks/locktests.c | 360 +++++++++++++++---------------
 testcases/network/nfsv4/locks/locktests.h |  20 +-
 testcases/network/nfsv4/locks/netsync.c   |  22 +-
 3 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
index dd6899cd1..869dbe3c8 100644
--- a/testcases/network/nfsv4/locks/locktests.c
+++ b/testcases/network/nfsv4/locks/locktests.c
@@ -32,15 +32,15 @@
 int MAXLEN = 64;
 int MAXTEST = 10;
 extern int maxClients;
-extern int fdServeur;
+extern int fdServer;
 
 char message[M_SIZE];
-int esclaveLecteur;
-int maitreLecteur;
-int esclaveEcrivain;
+int slaveReader;
+int masterReader;
+int slaveWriter;
 
 /* Which lock will be applied by the master process on test startup */
-int LISTE_LOCKS[] = { READLOCK, WRITELOCK,
+int LIST_LOCKS[] = { READLOCK, WRITELOCK,
 	READLOCK, WRITELOCK,
 	READLOCK, WRITELOCK,
 	READLOCK, WRITELOCK,
@@ -48,7 +48,7 @@ int LISTE_LOCKS[] = { READLOCK, WRITELOCK,
 };
 
 /* The operations the slave processes will try to perform */
-int LISTE_TESTS[] = { WRONLY, WRONLY,
+int LIST_TESTS[] = { WRONLY, WRONLY,
 	RDONLY, RDONLY,
 	READLOCK, WRITELOCK,
 	WRITELOCK, READLOCK,
@@ -56,7 +56,7 @@ int LISTE_TESTS[] = { WRONLY, WRONLY,
 };
 
 /* List of test names */
-char *LISTE_NOMS_TESTS[] = { "WRITE ON A READ  LOCK",
+char *LIST_NAMES_TESTS[] = { "WRITE ON A READ  LOCK",
 	"WRITE ON A WRITE LOCK",
 	"READ  ON A READ  LOCK",
 	"READ  ON A WRITE LOCK",
@@ -69,7 +69,7 @@ char *LISTE_NOMS_TESTS[] = { "WRITE ON A READ  LOCK",
 };
 
 /* List of expected test results, when slaves are processes */
-int LISTE_RESULTATS_PROCESS[] = { SUCCES, SUCCES,
+int LIST_RESULTS_PROCESS[] = { SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	SUCCES, ECHEC,
 	ECHEC, ECHEC,
@@ -77,49 +77,49 @@ int LISTE_RESULTATS_PROCESS[] = { SUCCES, SUCCES,
 };
 
 /* List of expected test results, when slaves are threads */
-int LISTE_RESULTATS_THREADS[] = { SUCCES, SUCCES,
+int LIST_RESULTS_THREADS[] = { SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	ECHEC, ECHEC
 };
 
-int *LISTE_RESULTATS = NULL;
+int *LIST_RESULTS = NULL;
 char *eType = NULL;
 
-int TOTAL_RESULTAT_OK[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+int TOTAL_RESULT_OK[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-void *esclave(void *donnees);
-int (*terminer) (int a);
+void *slave(void *data);
+int (*finish) (int a);
 
-int terminerProcess(int a)
+int finishProcess(int a)
 {
 	exit(a);
 }
 
 int (*load) (void);
 
-struct donneesPub dp;
+struct dataPub dp;
 
 /* Functions to access tests/tests names/tests results*/
 int testSuiv(int n)
 {
-	return LISTE_TESTS[n];
+	return LIST_TESTS[n];
 }
 
 int resAttSuiv(int n)
 {
-	return LISTE_RESULTATS[n];
+	return LIST_RESULTS[n];
 }
 
 char *nomTestSuiv(int n)
 {
-	return LISTE_NOMS_TESTS[n];
+	return LIST_NAMES_TESTS[n];
 }
 
 int lockSuiv(int n)
 {
-	return LISTE_LOCKS[n];
+	return LIST_LOCKS[n];
 }
 
 /* Verify the test result is the expected one */
@@ -127,33 +127,33 @@ int matchResult(int r, int n)
 {
 
 	P("r=%d\n", r);
-	if (r == LISTE_RESULTATS[n])
+	if (r == LIST_RESULTS[n])
 		return 1;
 	else
 		return 0;
 }
 
 /* Increments the number of process which have successfully passed the test */
-void compteur(int r, int n)
+void counter(int r, int n)
 {
-	TOTAL_RESULTAT_OK[n] += matchResult(r, n);
+	TOTAL_RESULT_OK[n] += matchResult(r, n);
 }
 
 /* Special case for test 'lock file byte byte by byte'.
  * We ensure each byte is correctly locked.
  */
-void validationResultats(int n)
+void validationResults(int n)
 {
 	int i, u, l, fsize;
 	struct flock request;
 
 	fsize = dp.nclnt * (maxClients + 1);
-	TOTAL_RESULTAT_OK[n] = 0;
+	TOTAL_RESULT_OK[n] = 0;
 	l = FALSE;
 	u = TRUE;
 
 	/* If the expected operation result is a success, we will have to increase the number of correct results */
-	if (LISTE_RESULTATS[n]) {
+	if (LIST_RESULTS[n]) {
 		l = TRUE;
 		u = FALSE;
 	}
@@ -166,33 +166,33 @@ void validationResultats(int n)
 		fcntl(dp.fd, F_GETLK, &request);
 		/* Ensure the lock is correctly set */
 		if (request.l_type != F_UNLCK)
-			TOTAL_RESULTAT_OK[n] += l;
+			TOTAL_RESULT_OK[n] += l;
 		else
-			TOTAL_RESULTAT_OK[n] += u;
+			TOTAL_RESULT_OK[n] += u;
 	}
 }
 
 int initTest(void)
 {
 
-	P("Maitre ouvre %s\n", dp.fname);
+	P("Master opens %s\n", dp.fname);
 	dp.fd = open(dp.fname, OPENFLAGS, MANDMODES);
 	if (dp.fd < 0) {
 		perror("lock test : can't open test file :");
-		terminer(1);
+		finish(1);
 	}
 	P("fd=%d\n", dp.fd);
 	return 0;
 }
 
-struct donneesFils *initClientFork(int i)
+struct dataChild *initClientFork(int i)
 {
-	struct donneesPriv *dpr;
-	struct donneesFils *df;
+	struct dataPriv *dpr;
+	struct dataChild *df;
 
 	/* Initialize private data fields */
-	dpr = malloc(sizeof(struct donneesPriv));
-	df = malloc(sizeof(struct donneesFils));
+	dpr = malloc(sizeof(struct dataPriv));
+	df = malloc(sizeof(struct dataChild));
 	dpr->whoami = i;
 	df->dp = &dp;
 	df->dpr = dpr;
@@ -207,7 +207,7 @@ struct donneesFils *initClientFork(int i)
 	return df;
 }
 
-int initialise(int clnt)
+int initialize(int clnt)
 {
 
 	/* Initialize private data fields */
@@ -217,7 +217,7 @@ int initialise(int clnt)
 	dp.lthreads = malloc(sizeof(pthread_t) * clnt);
 
 	/* Initialize client to master pipe */
-	if (pipe(dp.maitre) < 0) {
+	if (pipe(dp.master) < 0) {
 		perror("Master pipe creation error\n");
 		exit(1);
 	}
@@ -228,7 +228,7 @@ int initialise(int clnt)
 	return 0;
 }
 
-void cleanClient(struct donneesFils *df)
+void cleanClient(struct dataChild *df)
 {
 	int i;
 	i = df->dpr->whoami;
@@ -246,13 +246,13 @@ void clean(void)
 int loadProcess(void)
 {
 	int i;
-	struct donneesFils *df;
+	struct dataChild *df;
 	for (i = 0; i < dp.nclnt; i++) {
 		df = initClientFork(i);
 		if (!fork()) {
 			P("Running slave num: %d\n", df->dpr->whoami);
 			write(0, ".", 1);
-			esclave((void *)df);
+			slave((void *)df);
 			cleanClient(df);
 			exit(0);
 		}
@@ -278,7 +278,7 @@ void selectTest(int n, struct s_test *test)
 }
 
 /* Final test report */
-void rapport(int clnt)
+void report(int clnt)
 {
 	int i;
 	int totalClients;
@@ -289,8 +289,8 @@ void rapport(int clnt)
 	printf("%s number running test successfully :\n", eType);
 	for (i = 0; i < MAXTEST; i++)
 		printf("%d %s of %d successfully ran test : %s\n",
-		       TOTAL_RESULTAT_OK[i], eType, totalClients,
-		       LISTE_NOMS_TESTS[i]);
+		       TOTAL_RESULT_OK[i], eType, totalClients,
+		       LIST_NAMES_TESTS[i]);
 
 }
 
@@ -326,19 +326,19 @@ int serverReceiveLocal(void)
 {
 	int i;
 	for (i = 0; i < dp.nclnt; i++)
-		read(maitreLecteur, message, M_SIZE);
+		read(masterReader, message, M_SIZE);
 	return 0;
 }
 
 int clientReceiveLocal(void)
 {
-	read(esclaveLecteur, message, M_SIZE);
+	read(slaveReader, message, M_SIZE);
 	return 0;
 }
 
 int clientSend(void)
 {
-	write(esclaveEcrivain, message, M_SIZE);
+	write(slaveWriter, message, M_SIZE);
 	return 0;
 }
 
@@ -359,7 +359,7 @@ int serverReceive(void)
 /* binary structure <-> ASCII functions used to ensure data will be correctly used over
  * the network, especially when multiples clients do not use the same hardware architecture.
  */
-int serialiseTLock(struct s_test *tLock)
+int serializeTLock(struct s_test *tLock)
 {
 	memset(message, 0, M_SIZE);
 	sprintf(message, "T:%d:%d:%d::", tLock->test, tLock->type,
@@ -367,7 +367,7 @@ int serialiseTLock(struct s_test *tLock)
 	return 0;
 }
 
-void unSerialiseTLock(struct s_test *tLock)
+void unSerializeTLock(struct s_test *tLock)
 {
 	sscanf(message, "T:%d:%d:%d::", &(tLock->test), &(tLock->type),
 	       &(tLock->resAtt));
@@ -375,7 +375,7 @@ void unSerialiseTLock(struct s_test *tLock)
 
 }
 
-void serialiseFLock(struct flock *request)
+void serializeFLock(struct flock *request)
 {
 	int len, pid, start;
 	memset(message, 0, M_SIZE);
@@ -387,19 +387,19 @@ void serialiseFLock(struct flock *request)
 		request->l_type, request->l_whence, start, len, pid);
 }
 
-void serialiseResult(int resultat)
+void serializeResult(int result)
 {
 	memset(message, 0, M_SIZE);
-	sprintf(message, "R:%d::", resultat);
+	sprintf(message, "R:%d::", result);
 
 }
 
-void unSerialiseResult(int *resultat)
+void unSerializeResult(int *result)
 {
-	sscanf(message, "R:%d::", resultat);
+	sscanf(message, "R:%d::", result);
 }
 
-void unSerialiseFLock(struct flock *request)
+void unSerializeFLock(struct flock *request)
 {
 	int len, pid, start;
 	sscanf(message, "L:%hd:%hd:%d:%d:%d::",
@@ -411,27 +411,27 @@ void unSerialiseFLock(struct flock *request)
 
 int serverSendLockClient(struct flock *request, int client)
 {
-	serialiseFLock(request);
+	serializeFLock(request);
 	return serverSendClient(client);
 }
 
-int serverSendLockLocal(struct flock *request, int esclave)
+int serverSendLockLocal(struct flock *request, int slave)
 {
-	serialiseFLock(request);
-	return write(dp.lclnt[esclave][1], message, M_SIZE);
+	serializeFLock(request);
+	return write(dp.lclnt[slave][1], message, M_SIZE);
 }
 
 int getLockSection(struct flock *request)
 {
 	memset(message, 0, M_SIZE);
 	clientReceiveLocal();
-	unSerialiseFLock(request);
+	unSerializeFLock(request);
 	return 0;
 }
 
 int sendLockTest(struct s_test *tLock)
 {
-	serialiseTLock(tLock);
+	serializeTLock(tLock);
 	serverSend();
 	return 0;
 }
@@ -439,13 +439,13 @@ int sendLockTest(struct s_test *tLock)
 int getLockTest(struct s_test *tLock)
 {
 	clientReceiveLocal();
-	unSerialiseTLock(tLock);
+	unSerializeTLock(tLock);
 	return 0;
 }
 
-int sendResult(int resultat)
+int sendResult(int result)
 {
-	serialiseResult(resultat);
+	serializeResult(result);
 	clientSend();
 	return 0;
 }
@@ -453,21 +453,21 @@ int sendResult(int resultat)
 int getResults(int ntest)
 {
 	int i, c;
-	int resultat = 0;
+	int result = 0;
 	/* Add remote test results */
 	for (c = 0; c < maxClients; c++) {
 		for (i = 0; i < dp.nclnt; i++) {
 			serverReceiveClient(c);
-			unSerialiseResult(&resultat);
-			compteur(resultat, ntest);
+			unSerializeResult(&result);
+			counter(result, ntest);
 
 		}
 	}
 	/* Add local test results */
 	for (i = 0; i < dp.nclnt; i++) {
-		read(maitreLecteur, message, M_SIZE);
-		unSerialiseResult(&resultat);
-		compteur(resultat, ntest);
+		read(masterReader, message, M_SIZE);
+		unSerializeResult(&result);
+		counter(result, ntest);
 	}
 
 	return 0;
@@ -480,7 +480,7 @@ int getResults(int ntest)
 /* In the case of a network use, the master of the client application si only
  * a 'repeater' of information. It resends server-master instructions to its own slaves.
  */
-void maitreClient(void)
+void masterClient(void)
 {
 	fd_set fdread;
 	struct timeval tv;
@@ -491,17 +491,17 @@ void maitreClient(void)
 	struct flock lock;
 	int t;
 
-	maitreLecteur = dp.maitre[0];
+	masterReader = dp.master[0];
 	FD_ZERO(&fdread);
 	tv.tv_sec = 50;
 	tv.tv_usec = 0;
-	n = fdServeur > maitreLecteur ? fdServeur : maitreLecteur;
-	printf("Maitre CLient - fdServeur=%d\n", fdServeur);
+	n = fdServer > masterReader ? fdServer : masterReader;
+	printf("Master Client - fdServer=%d\n", fdServer);
 	while (1) {
 		/* Add slave and server pipe file descriptors */
 		FD_ZERO(&fdread);
-		FD_SET(fdServeur, &fdread);
-		FD_SET(maitreLecteur, &fdread);
+		FD_SET(fdServer, &fdread);
+		FD_SET(masterReader, &fdread);
 		r = select(n + 1, &fdread, NULL, NULL, &tv);
 		if (r < 0) {
 			perror("select:\n");
@@ -511,7 +511,7 @@ void maitreClient(void)
 			exit(0);
 		}
 
-		if (FD_ISSET(fdServeur, &fdread)) {
+		if (FD_ISSET(fdServer, &fdread)) {
 			/* We just have received information from the server.
 			 * We repeat it to slaves.
 			 */
@@ -520,20 +520,20 @@ void maitreClient(void)
 			switch (t) {
 			case 'L':
 				/* Lock instruction. We need to send a different section to lock to each process */
-				unSerialiseFLock(&lock);
+				unSerializeFLock(&lock);
 				start = lock.l_start;
 				for (i = 0; i < dp.nclnt; i++) {
 					lock.l_start = start + i;
-					serialiseFLock(&lock);
+					serializeFLock(&lock);
 					write(dp.lclnt[i][1], message, M_SIZE);
 				}
 				printf("\n");
 				continue;
 			case 'T':
-				/* Test instruction. Ensure server is not sending the FIN(ish) instruction to end tests */
+				/* Test instruction. Ensure server is not sending the END(ish) instruction to end tests */
 				/* To be rewritten asap */
 				m = atoi(&(message[2]));
-				if (m == FIN)
+				if (m == END)
 					break;
 				if (m == CLEAN)
 					printf("\n");
@@ -545,8 +545,8 @@ void maitreClient(void)
 		} else {
 			/* Else, we read information from slaves and repeat them to the server */
 			for (i = 0; i < dp.nclnt; i++) {
-				r = read(maitreLecteur, message, M_SIZE);
-				r = write(fdServeur, message, M_SIZE);
+				r = read(masterReader, message, M_SIZE);
+				r = write(fdServer, message, M_SIZE);
 				if (r < 0)
 					perror("write : ");
 
@@ -555,10 +555,10 @@ void maitreClient(void)
 		}
 	}
 
-	/* Receive the FIN(ish) instruction */
+	/* Receive the END(ish) instruction */
 
 	/* Repeat it to the slaves */
-	printf("Fin du programme en cours...\n");
+	printf("Exitting...\n");
 	serverSendLocal();
 
 	/* Ok, we can quit */
@@ -566,7 +566,7 @@ void maitreClient(void)
 
 }
 
-void maitre(void)
+void master(void)
 {
 	int i, n, bl;
 	int clnt;
@@ -576,35 +576,35 @@ void maitre(void)
 #endif
 	struct flock request;
 	struct s_test tLock;
-	enum etat_t etat;
+	enum state_t state;
 	int offset;
 	/* A test sentence written in the file */
 	char phraseTest[] =
 	    "Ceci est une phrase test ecrite par le maitre dans le fichier";
 	bl = -1;
 	clnt = dp.nclnt;
-	maitreLecteur = dp.maitre[0];
-	etat = SELECT;
+	masterReader = dp.master[0];
+	state = SELECT;
 	/* Start with the first test ;) */
 	n = 0;
 	printf("\n--------------------------------------\n");
 	while (1) {
-		switch (etat) {
+		switch (state) {
 		case SELECT:
 			/* Select the test to perform   */
 			printf("\n");
-			E("Maitre: SELECT");
+			E("Master: SELECT");
 			selectTest(n, &tLock);
-			etat = tLock.type;
+			state = tLock.type;
 			bl = 0;
 			if (n < MAXTEST) {
 				memset(tmp, 0, MAXLEN);
 				sprintf(tmp, "TEST : TRY TO %s:",
-					LISTE_NOMS_TESTS[n]);
+					LIST_NAMES_TESTS[n]);
 				write(0, tmp, strlen(tmp));
 			} else
-				etat = FIN;
-			P("etat=%d\n", etat);
+				state = END;
+			P("state=%d\n", state);
 			n += 1;
 			continue;
 
@@ -612,20 +612,20 @@ void maitre(void)
 		case WRONLY:
 
 		case READLOCK:
-			P("Read lock :%d\n", etat);
+			P("Read lock :%d\n", state);
 			request.l_type = F_RDLCK;
-			etat = LOCK;
+			state = LOCK;
 			continue;
 
 		case WRITELOCK:
-			P("Write lock :%d\n", etat);
+			P("Write lock :%d\n", state);
 			request.l_type = F_WRLCK;
-			etat = LOCK;
+			state = LOCK;
 			continue;
 
 		case LOCK:
 			/* Apply the wanted lock */
-			E("Maitre: LOCK");
+			E("Master: LOCK");
 			write(dp.fd, phraseTest, strlen(phraseTest));
 			lockWholeFile(&request);
 			if (fcntl(dp.fd, F_SETLK, &request) < 0) {
@@ -633,20 +633,20 @@ void maitre(void)
 				perror("Echec\n");
 				exit(0);
 			}
-			E("Maitre");
-			etat = SYNC;
+			E("Master");
+			state = SYNC;
 			continue;
 
 		case BYTELOCK_READ:
 			bl = 1;
 			request.l_type = F_RDLCK;
-			etat = SYNC;
+			state = SYNC;
 			continue;
 
 		case BYTELOCK_WRITE:
 			bl = 1;
 			request.l_type = F_WRLCK;
-			etat = SYNC;
+			state = SYNC;
 			continue;
 
 		case BYTELOCK:
@@ -659,7 +659,7 @@ void maitre(void)
 			 */
 
 			/* Create a string to record in the test file. Length is exactly the number of sub process */
-			P("Maitre: BYTELOCK: %d\n", etat);
+			P("Master: BYTELOCK: %d\n", state);
 			buf = malloc(clnt * (maxClients + 1));
 			memset(buf, '*', clnt);
 			write(dp.fd, buf, clnt);
@@ -683,34 +683,34 @@ void maitre(void)
 				request.l_start = i;
 				serverSendLockLocal(&request, i);
 			}
-			etat = RESULTAT;
+			state = RESULT;
 			continue;
 
 		case SYNC:
 			sendLockTest(&tLock);
 			if (bl) {
-				etat = BYTELOCK;
+				state = BYTELOCK;
 				continue;
 			}
 
 			if (n < MAXTEST + 1)
-				etat = RESULTAT;
+				state = RESULT;
 			else
-				etat = FIN;
+				state = END;
 			continue;
 
-		case RESULTAT:
+		case RESULT:
 			/* Read results by one */
 			getResults(n - 1);
 			if (bl)
-				validationResultats(n - 1);
-			etat = CLEAN;
+				validationResults(n - 1);
+			state = CLEAN;
 			continue;
 
 		case CLEAN:
 			/* Ask the clients to stop testing ... */
 			tLock.test = CLEAN;
-			serialiseTLock(&tLock);
+			serializeTLock(&tLock);
 			serverSend();
 			/* ... and wait for an ack before closing */
 			serverReceive();
@@ -719,11 +719,11 @@ void maitre(void)
 			/* close and open file */
 			close(dp.fd);
 			initTest();
-			etat = SELECT;
+			state = SELECT;
 			continue;
-		case FIN:
-			tLock.test = FIN;
-			serialiseTLock(&tLock);
+		case END:
+			tLock.test = END;
+			serializeTLock(&tLock);
 			serverSend();
 			sleep(2);
 			break;
@@ -735,15 +735,15 @@ void maitre(void)
 		break;
 	}
 
-	rapport(clnt);
+	report(clnt);
 }
 
 /* Slave process/thread */
 
-void *esclave(void *donnees)
+void *slave(void *data)
 {
-	struct donneesFils *df;
-	int i, a, resultat, ftest;
+	struct dataChild *df;
+	int i, a, result, ftest;
 	struct s_test tLock;
 	struct flock request;
 	char tmp[16];
@@ -752,34 +752,34 @@ void *esclave(void *donnees)
 #endif
 	char *phraseTest = "L'ecriture a reussi";
 	int len;
-	enum etat_t etat;
+	enum state_t state;
 
-	resultat = -1;
+	result = -1;
 	ftest = -1;
 	len = strlen(phraseTest);
-	df = (struct donneesFils *)donnees;
+	df = (struct dataChild *)data;
 	i = df->dpr->whoami;
-	P("Esclave n=%d\n", i);
-	esclaveLecteur = dp.lclnt[i][0];
-	esclaveEcrivain = dp.maitre[1];
-	etat = SYNC;
+	P("Slave n=%d\n", i);
+	slaveReader = dp.lclnt[i][0];
+	slaveWriter = dp.master[1];
+	state = SYNC;
 	errno = 0;
 	memset(tmp, 0, 16);
 	while (1) {
-		switch (etat) {
+		switch (state) {
 		case SELECT:
 		case SYNC:
 			getLockTest(&tLock);
-			etat = tLock.test;
-			P("Esclave Etat=%d\n", etat);
+			state = tLock.test;
+			P("Slave State=%d\n", state);
 
 			continue;
 		case RDONLY:
 			/* Try to read a file */
 			P("TEST READ ONLY %d\n", RDONLY);
 			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				if (dp.verbose)
 					perror("Open:");
 				continue;
@@ -787,28 +787,28 @@ void *esclave(void *donnees)
 			P("fd=%d\n", ftest);
 			a = read(ftest, tmp, 16);
 			if (a < 16)
-				resultat = ECHEC;
+				result = ECHEC;
 			else
-				resultat = SUCCES;
-			etat = RESULTAT;
+				result = SUCCES;
+			state = RESULT;
 			continue;
 
 		case WRONLY:
 			/* Try to write a file */
 			P("TEST WRITE ONLY %d\n", WRONLY);
 			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				if (dp.verbose)
 					perror("Open read only:");
 				continue;
 			}
 			P("fd=%d\n", ftest);
 			if (write(ftest, phraseTest, len) < len)
-				resultat = ECHEC;
+				result = ECHEC;
 			else
-				resultat = SUCCES;
-			etat = RESULTAT;
+				result = SUCCES;
+			state = RESULT;
 			continue;
 
 		case LOCK:
@@ -817,8 +817,8 @@ void *esclave(void *donnees)
 			/* Try to read a read-locked section */
 			P("READ LOCK %d\n", F_RDLCK);
 			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				if (dp.verbose)
 					perror("Open read-write:");
 				continue;
@@ -834,18 +834,18 @@ void *esclave(void *donnees)
 			if (fcntl(ftest, F_SETLK, &request) < 0) {
 				if (dp.verbose || errno != EAGAIN)
 					perror("RDONLY: fcntl");
-				resultat = ECHEC;
+				result = ECHEC;
 			} else
-				resultat = SUCCES;
-			etat = RESULTAT;
+				result = SUCCES;
+			state = RESULT;
 			continue;
 
 		case WRITELOCK:
 			/* Try to write a file */
 			P("WRITE LOCK %d\n", F_WRLCK);
 			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				if (dp.verbose)
 					perror("\nOpen:");
 				continue;
@@ -860,29 +860,29 @@ void *esclave(void *donnees)
 			if (fcntl(ftest, F_SETLK, &request) < 0) {
 				if (dp.verbose || errno != EAGAIN)
 					perror("\nWRONLY: fcntl");
-				resultat = ECHEC;
+				result = ECHEC;
 			} else
-				resultat = SUCCES;
-			etat = RESULTAT;
+				result = SUCCES;
+			state = RESULT;
 			continue;
 
 		case BYTELOCK_READ:
-			P("BYTE LOCK READ: %d\n", etat);
-			etat = BYTELOCK;
+			P("BYTE LOCK READ: %d\n", state);
+			state = BYTELOCK;
 			continue;
 
 		case BYTELOCK_WRITE:
-			P("BYTE LOCK WRITE: %d\n", etat);
-			etat = BYTELOCK;
+			P("BYTE LOCK WRITE: %d\n", state);
+			state = BYTELOCK;
 			continue;
 
 		case BYTELOCK:
 			/* Wait for the exact section to lock. The whole file is sent by the master */
-			P("BYTE LOCK %d\n", etat);
+			P("BYTE LOCK %d\n", state);
 			getLockSection(&request);
 			if ((ftest = open(dp.fname, O_RDWR | O_NONBLOCK)) < 0) {
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				if (dp.verbose)
 					perror("\nOpen:");
 				continue;
@@ -891,39 +891,39 @@ void *esclave(void *donnees)
 			if (fcntl(ftest, F_SETLK, &request) < 0) {
 				if (dp.verbose || errno != EAGAIN)
 					perror("\nBTLOCK: fcntl");
-				resultat = ECHEC;
-				etat = RESULTAT;
+				result = ECHEC;
+				state = RESULT;
 				continue;
 			}
 			/* Change the character@the given position for an easier verification */
 			a = lseek(ftest, request.l_start, SEEK_SET);
 			write(ftest, "=", 1);
-			resultat = SUCCES;
-			etat = RESULTAT;
+			result = SUCCES;
+			state = RESULT;
 			continue;
 
-		case RESULTAT:
-			if (resultat == SUCCES)
+		case RESULT:
+			if (result == SUCCES)
 				write(0, "=", 1);
 			else
 				write(0, "x", 1);
-			P("RESULTAT: %d\n", resultat);
-			sendResult(resultat);
-			etat = SYNC;
+			P("RESULT: %d\n", result);
+			sendResult(result);
+			state = SYNC;
 			continue;
 
 		case CLEAN:
 			close(ftest);
 			/* Send CLEAN Ack */
-			sendResult(resultat);
-			etat = SYNC;
+			sendResult(result);
+			state = SYNC;
 			continue;
 
-		case FIN:
+		case END:
 			E("(End)\n");
-			terminer(0);
+			finish(0);
 			printf("Unknown command\n");
-			terminer(1);
+			finish(1);
 
 		}
 	}
@@ -958,7 +958,7 @@ int main(int argc, char **argv)
 	type = PROCESS;
 	dp.fname = NULL;
 	dp.verbose = 0;
-	int serveur = 1;
+	int server = 1;
 	char *host;
 
 	host = NULL;
@@ -991,17 +991,17 @@ int main(int argc, char **argv)
 		if (!strcmp("--server", argv[i])) {
 			if (!(host = nextArg(argc, argv, &i)))
 				usage();
-			serveur = 0;
+			server = 0;
 			continue;
 		}
 		printf("Ignoring unknown option: %s\n", argv[i]);
 	}
 
-	if (serveur) {
+	if (server) {
 		if (!(dp.fname && nThread))
 			usage();
 		if (clients > 0) {
-			configureServeur(clients);
+			configureServer(clients);
 			setupClients(type, dp.fname, nThread);
 		}
 	} else {
@@ -1015,14 +1015,14 @@ int main(int argc, char **argv)
 		printf("By process.\n");
 	load = loadProcess;
 	eType = "process";
-	terminer = terminerProcess;
-	LISTE_RESULTATS = LISTE_RESULTATS_PROCESS;
-	initialise(nThread);
-	if (serveur) {
-		maitre();
+	finish = finishProcess;
+	LIST_RESULTS = LIST_RESULTS_PROCESS;
+	initialize(nThread);
+	if (server) {
+		master();
 
 	} else {
-		maitreClient();
+		masterClient();
 		free(dp.fname);
 	}
 	clean();
diff --git a/testcases/network/nfsv4/locks/locktests.h b/testcases/network/nfsv4/locks/locktests.h
index eba856a0e..e26c7305b 100644
--- a/testcases/network/nfsv4/locks/locktests.h
+++ b/testcases/network/nfsv4/locks/locktests.h
@@ -102,15 +102,15 @@ int readFromServer(char *message);
 int serverSendClient(int n);
 
 
-enum etat_t     {
+enum state_t     {
                 CLEAN,
                 RDONLY,
-                RESULTAT,
+                RESULT,
                 WRONLY,
                 SELECT,
                 LOCK,
                 SYNC,
-                FIN,
+                END,
                 READLOCK,
                 WRITELOCK,
                 BYTELOCK,
@@ -119,13 +119,13 @@ enum etat_t     {
 };
 
 /* Public data */
-struct donneesPub {
+struct dataPub {
     /* Number of clients */
     int nclnt;
     /* List of master to slave pipes */
     int **lclnt;
     /* Slave to master pipe */
-    int maitre[2];
+    int master[2];
     /* Thread list */
     pthread_t *lthreads;
     /* test file name */
@@ -137,14 +137,14 @@ struct donneesPub {
 };
 
 /* private data */
-struct donneesPriv {
+struct dataPriv {
     /* thread number */
     int whoami;
 };
 
-struct donneesFils{
-    struct donneesPub *dp;
-    struct donneesPriv *dpr;
+struct dataChild{
+    struct dataPub *dp;
+    struct dataPriv *dpr;
 };
 
 
@@ -159,7 +159,7 @@ struct s_test {
 
 
 
-int configureServeur(int  max);
+int configureServer(int  max);
 int configureClient(char *s);
 
 #endif
diff --git a/testcases/network/nfsv4/locks/netsync.c b/testcases/network/nfsv4/locks/netsync.c
index f53b347f1..b40c002fe 100644
--- a/testcases/network/nfsv4/locks/netsync.c
+++ b/testcases/network/nfsv4/locks/netsync.c
@@ -7,8 +7,8 @@
 
 int maxClients;
 int *fdClient;
-char *serveur;
-int fdServeur;
+char *server_name;
+int fdServer;
 extern char message[M_SIZE];
 
 int serverReceiveClient(int c)
@@ -41,7 +41,7 @@ int clientReceiveNet(void)
 	return 0;
 }
 
-int setupConnectionServeur(void)
+int setupConnectionServer(void)
 {
 	struct sockaddr_in local;
 	int c;
@@ -119,12 +119,12 @@ int setupClients(int type, char *fname, int nThread)
 	return 0;
 }
 
-int configureServeur(int max)
+int configureServer(int max)
 {
 	maxClients = max;
 	fdClient = malloc(sizeof(int) * max);
 
-	setupConnectionServeur();
+	setupConnectionServer();
 
 	return 0;
 }
@@ -135,13 +135,13 @@ int setupConnectionClient(void)
 	struct hostent *server;
 	struct sockaddr_in serv_addr;
 
-	if (!(server = gethostbyname(serveur))) {
+	if (!(server = gethostbyname(server_name))) {
 		printf("erreur DNS\n");
 		return 1;
 	}
 
-	fdServeur = socket(AF_INET, SOCK_STREAM, 0);
-	if (fdServeur < 0) {
+	fdServer = socket(AF_INET, SOCK_STREAM, 0);
+	if (fdServer < 0) {
 		perror("socket");
 		return 1;
 	}
@@ -149,7 +149,7 @@ int setupConnectionClient(void)
 	serv_addr.sin_addr = *(struct in_addr *)server->h_addr;
 	serv_addr.sin_port = htons(PORT);
 	serv_addr.sin_family = AF_INET;
-	if (connect(fdServeur, (struct sockaddr *)&serv_addr, sizeof(serv_addr))
+	if (connect(fdServer, (struct sockaddr *)&serv_addr, sizeof(serv_addr))
 	    < 0) {
 		perror("connect");
 		return 1;
@@ -167,7 +167,7 @@ int readFromServer(char *message)
 	r = 0;
 	s = 0;
 	while (s < M_SIZE) {
-		r = read(fdServeur, tmp, M_SIZE - s);
+		r = read(fdServer, tmp, M_SIZE - s);
 		/* Loop until we have a complete message */
 		strncpy(message + s, tmp, r);
 		s += r;
@@ -195,7 +195,7 @@ int getConfiguration(int *type, char *fname, int *nThread)
 
 int configureClient(char *s)
 {
-	serveur = s;
+	server_name = s;
 	setupConnectionClient();
 	return 0;
 }
-- 
2.13.0

