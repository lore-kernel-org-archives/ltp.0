From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 16:31:59 +0200
Subject: [LTP] [PATCH 1/4] [COMMITTED] nfsv4/locktests: Get rid of useless
	comments
Message-ID: <20170828143202.24021-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Removes mostly the duplict french ones but also a few written in
english.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/nfsv4/locks/locktests.c | 92 ++-----------------------------
 testcases/network/nfsv4/locks/locktests.h | 12 +---
 testcases/network/nfsv4/locks/netsync.c   | 19 +------
 3 files changed, 6 insertions(+), 117 deletions(-)

diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
index 02e8ff7b8..73fca3095 100644
--- a/testcases/network/nfsv4/locks/locktests.c
+++ b/testcases/network/nfsv4/locks/locktests.c
@@ -39,7 +39,6 @@ int esclaveLecteur;
 int maitreLecteur;
 int esclaveEcrivain;
 
-/* Quel lock sera appplique par le maitre en debut de test */
 /* Which lock will be applied by the master process on test startup */
 int LISTE_LOCKS[] = { READLOCK, WRITELOCK,
 	READLOCK, WRITELOCK,
@@ -48,9 +47,7 @@ int LISTE_LOCKS[] = { READLOCK, WRITELOCK,
 	BYTELOCK_READ, BYTELOCK_WRITE
 };
 
-/* Les operations que les programes esclaves essaieront de faire */
 /* The operations the slave processes will try to perform */
-
 int LISTE_TESTS[] = { WRONLY, WRONLY,
 	RDONLY, RDONLY,
 	READLOCK, WRITELOCK,
@@ -71,9 +68,7 @@ char *LISTE_NOMS_TESTS[] = { "WRITE ON A READ  LOCK",
 	"WRITE LOCK THE WHOLE FILE BYTE BY BYTE"
 };
 
-/* Resultat attendu du test - Processus */
 /* List of expected test results, when slaves are processes */
-
 int LISTE_RESULTATS_PROCESS[] = { SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	SUCCES, ECHEC,
@@ -82,7 +77,6 @@ int LISTE_RESULTATS_PROCESS[] = { SUCCES, SUCCES,
 };
 
 /* List of expected test results, when slaves are threads */
-
 int LISTE_RESULTATS_THREADS[] = { SUCCES, SUCCES,
 	SUCCES, SUCCES,
 	SUCCES, SUCCES,
@@ -107,7 +101,6 @@ int (*load) ();
 
 struct donneesPub dp;
 
-/* Manipulation des tests/ noms de tests/ resultats de tests */
 /* Functions to access tests/tests names/tests results*/
 int testSuiv(int n)
 {
@@ -129,8 +122,7 @@ int lockSuiv(int n)
 	return LISTE_LOCKS[n];
 }
 
-/* Verifie si le resultat obtenu pour le test est le resultat attendu pour ce test */
-/* Verifie the test result is the expected one */
+/* Verify the test result is the expected one */
 int matchResult(int r, int n)
 {
 
@@ -141,20 +133,15 @@ int matchResult(int r, int n)
 		return 0;
 }
 
-/* Incremente le nombre de process ayant valide le test */
 /* Increments the number of process which have successfully passed the test */
 void compteur(int r, int n)
 {
 	TOTAL_RESULTAT_OK[n] += matchResult(r, n);
 }
 
-/* Validation des resultats pour le lock de fichier octet par octet
- * Pour chaque octet on verifie qu'un lock de 1 octet est bien pose
- */
 /* Special case for test 'lock file byte byte by byte'.
  * We ensure each byte is correctly locked.
  */
-
 void validationResultats(int n)
 {
 	int i, u, l, fsize;
@@ -164,7 +151,7 @@ void validationResultats(int n)
 	TOTAL_RESULTAT_OK[n] = 0;
 	l = FALSE;
 	u = TRUE;
-	/* Si le resultat de l'operation attendu est un succe on prevoi d'incrementer le nombre de resultats corrects */
+
 	/* If the expected operation result is a success, we will have to increase the number of correct results */
 	if (LISTE_RESULTATS[n]) {
 		l = TRUE;
@@ -177,7 +164,6 @@ void validationResultats(int n)
 		request.l_start = i;
 		request.l_len = 1;
 		fcntl(dp.fd, F_GETLK, &request);
-		/* On verifie si le lock est mis ou non */
 		/* Ensure the lock is correctly set */
 		if (request.l_type != F_UNLCK)
 			TOTAL_RESULTAT_OK[n] += l;
@@ -186,9 +172,6 @@ void validationResultats(int n)
 	}
 }
 
-/* Procedures d'initialisation */
-/* Initialisation functions */
-
 int initTest()
 {
 
@@ -207,14 +190,12 @@ struct donneesFils *initClientFork(int i)
 	struct donneesPriv *dpr;
 	struct donneesFils *df;
 
-	/* Initialisation des champs de donnees */
 	/* Initialize private data fields */
 	dpr = malloc(sizeof(struct donneesPriv));
 	df = malloc(sizeof(struct donneesFils));
 	dpr->whoami = i;
 	df->dp = &dp;
 	df->dpr = dpr;
-	/* Initialisation du tubes de synchronisation */
 	/* Initialize master to client pipe */
 	dp.lclnt[i] = malloc(sizeof(int) * 2);
 	if (pipe(dp.lclnt[i]) < 0) {
@@ -229,14 +210,12 @@ struct donneesFils *initClientFork(int i)
 int initialise(int clnt)
 {
 
-	/* Initialisation des donnees publiques */
 	/* Initialize private data fields */
 	printf("Init\n");
 	dp.nclnt = clnt;
 	dp.lclnt = malloc(sizeof(int *) * clnt);
 	dp.lthreads = malloc(sizeof(pthread_t) * clnt);
 
-	/* initialisation de la communication avec le maitre */
 	/* Initialize client to master pipe */
 	if (pipe(dp.maitre) < 0) {
 		perror("Master pipe creation error\n");
@@ -285,7 +264,6 @@ void lockWholeFile(struct flock *request)
 {
 	request->l_whence = SEEK_SET;
 	request->l_start = 0;
-	/* Lock de l'ensemble du fichier */
 	/* Lock the whole file */
 	request->l_len = 0;
 }
@@ -319,10 +297,7 @@ void rapport(clnt)
 int serverSendLocal()
 {
 	int i;
-	/* Synchronisation des processus esclaves. */
 	/* Synchronize slave processes */
-
-	/* On configure les esclaves pour le test */
 	/* Configure slaves for test */
 
 	for (i = 0; i < dp.nclnt; i++)
@@ -479,7 +454,6 @@ int getResults(int ntest)
 {
 	int i, c;
 	int resultat = 0;
-	/* On comptabilise les resultats distants */
 	/* Add remote test results */
 	for (c = 0; c < maxClients; c++) {
 		for (i = 0; i < dp.nclnt; i++) {
@@ -489,7 +463,6 @@ int getResults(int ntest)
 
 		}
 	}
-	/* On comptabilise les resultats locaux */
 	/* Add local test results */
 	for (i = 0; i < dp.nclnt; i++) {
 		read(maitreLecteur, message, M_SIZE);
@@ -500,18 +473,13 @@ int getResults(int ntest)
 	return 0;
 }
 
-/* Usefull debug macro */
 #ifdef DEBUG
 #define P(a,b)  memset(dbg,0,16);sprintf(dbg,a,b);write(0,dbg,16);
 #endif
 
-/* Le maitre de l'application client n'est qu'un repetiteur d'information.
- * Il retransmet l'information qu'il re�oit du maitre du client a ses esclaves
- */
 /* In the case of a network use, the master of the client application si only
  * a 'repeater' of information. It resends server-master instructions to its own slaves.
  */
-
 void maitreClient()
 {
 	fd_set fdread;
@@ -530,7 +498,6 @@ void maitreClient()
 	n = fdServeur > maitreLecteur ? fdServeur : maitreLecteur;
 	printf("Maitre CLient - fdServeur=%d\n", fdServeur);
 	while (1) {
-		/* On ajoute les descripteurs esclave et serveur */
 		/* Add slave and server pipe file descriptors */
 		FD_ZERO(&fdread);
 		FD_SET(fdServeur, &fdread);
@@ -545,9 +512,6 @@ void maitreClient()
 		}
 
 		if (FD_ISSET(fdServeur, &fdread)) {
-			/* On vient de recevoir une information du serveur
-			 * On la retransmet aux esclaves
-			 */
 			/* We just have received information from the server.
 			 * We repeat it to slaves.
 			 */
@@ -555,9 +519,7 @@ void maitreClient()
 			t = message[0];
 			switch (t) {
 			case 'L':
-				/* Instruction : Lock. Dans ce cas il faut envoyer a chaque processus une section differente a locker */
 				/* Lock instruction. We need to send a different section to lock to each process */
-
 				unSerialiseFLock(&lock);
 				start = lock.l_start;
 				for (i = 0; i < dp.nclnt; i++) {
@@ -568,12 +530,7 @@ void maitreClient()
 				printf("\n");
 				continue;
 			case 'T':
-				/* Instruction: Test. Il s'agit d'une trame annoncant un nouveau test : on verifie qu'il ne s'agit pas d'une
-				 * demande de FIN des tests
-				 */
 				/* Test instruction. Ensure server is not sending the FIN(ish) instruction to end tests */
-
-				/* A re-ecrire un peu mieux des que possible */
 				/* To be rewritten asap */
 				m = atoi(&(message[2]));
 				if (m == FIN)
@@ -586,8 +543,6 @@ void maitreClient()
 			}
 			break;
 		} else {
-			/* Dans le cas inverse, on lis les esclaves et on remonte l'information au serveur
-			 */
 			/* Else, we read information from slaves and repeat them to the server */
 			for (i = 0; i < dp.nclnt; i++) {
 				r = read(maitreLecteur, message, M_SIZE);
@@ -600,15 +555,12 @@ void maitreClient()
 		}
 	}
 
-	/* On vient de recevoir la trame FIN de programme */
 	/* Receive the FIN(ish) instruction */
 
-	/* On la communique a tous les esclaves */
 	/* Repeat it to the slaves */
 	printf("Fin du programme en cours...\n");
 	serverSendLocal();
 
-	/* Et c'est fini! */
 	/* Ok, we can quit */
 	printf("Bye :)\n");
 
@@ -633,14 +585,12 @@ void maitre()
 	clnt = dp.nclnt;
 	maitreLecteur = dp.maitre[0];
 	etat = SELECT;
-	/* On commence par le premier test. C'est original ;) */
 	/* Start with the first test ;) */
 	n = 0;
 	printf("\n--------------------------------------\n");
 	while (1) {
 		switch (etat) {
 		case SELECT:
-			/* Selection du test a effectuer */
 			/* Select the test to perform   */
 			printf("\n");
 			E("Maitre: SELECT");
@@ -674,7 +624,6 @@ void maitre()
 			continue;
 
 		case LOCK:
-			/* On applique le lock que l'on veut */
 			/* Apply the wanted lock */
 			E("Maitre: LOCK");
 			write(dp.fd, phraseTest, strlen(phraseTest));
@@ -701,15 +650,6 @@ void maitre()
 			continue;
 
 		case BYTELOCK:
-			/*
-			 * L'idee est de faire locker l'ensemble du fichier octet par octet par un ensemble de sous processus
-			 * Il nous faut donc
-			 * -creer un fichier ayant autant d'octet que le nombre de processus passe en parametres
-			 * -passer les sections a locker a chacun des esclaves
-			 * -verifier que les locks sont bien appliques
-			 *
-			 */
-
 			/* The main idea is to lock all the bytes in a file. Each slave process locks one byte.
 			 *
 			 * We need :
@@ -718,9 +658,6 @@ void maitre()
 			 * - ensure locks have been correctly set
 			 */
 
-			/* On cree une chaine de caracteres a enregistrer dans le fichier qui contienne exactement un octet par
-			 * processus.
-			 */
 			/* Create a string to record in the test file. Length is exactly the number of sub process */
 			P("Maitre: BYTELOCK: %d\n", etat);
 			buf = malloc(clnt * (maxClients + 1));
@@ -728,24 +665,19 @@ void maitre()
 			write(dp.fd, buf, clnt);
 			free(buf);
 
-			/* Chaque processus esclave reecrit son champs a locker. */
 			/* Each slave process re-writes its own field to lock */
 			request.l_whence = SEEK_SET;
 			request.l_start = 0;
 			request.l_len = 1;
 
-			/* On commence par les envois reseau */
 			/* Start to send sections to lock to remote process (network clients) */
-
 			for (i = 0; i < maxClients; i++) {
-				/* On renseigne la structure avec le lock qui va bien */
 				/* Set the correct byte to lock */
 				offset = (i + 1) * clnt;
 				request.l_start = (off_t) offset;
 				serverSendLockClient(&request, i);
 			}
 
-			/* Puis les envois locaux */
 			/* Now send sections to local processes */
 			for (i = 0; i < clnt; i++) {
 				request.l_start = i;
@@ -768,7 +700,6 @@ void maitre()
 			continue;
 
 		case RESULTAT:
-			/* On lit les resultats un par un */
 			/* Read results by one */
 			getResults(n - 1);
 			if (bl)
@@ -777,15 +708,12 @@ void maitre()
 			continue;
 
 		case CLEAN:
-			/* On demande aux clients d'arreter le test */
 			/* Ask the clients to stop testing ... */
 			tLock.test = CLEAN;
 			serialiseTLock(&tLock);
 			serverSend();
-			/* ... et on attend un accuse de reception avant de fermer */
 			/* ... and wait for an ack before closing */
 			serverReceive();
-			/* On ignore les resultats, ce n'est qu'un accuse de reception */
 			/* Ignore message content : that is only an ack */
 
 			/* close and open file */
@@ -803,9 +731,9 @@ void maitre()
 			printf("(end)\n");
 			exit(0);
 
-		}		/* switch */
+		}
 		break;
-	}			/* while */
+	}
 
 	rapport(clnt);
 }
@@ -847,7 +775,6 @@ void *esclave(void *donnees)
 
 			continue;
 		case RDONLY:
-			/* On tente de lire un fichier */
 			/* Try to read a file */
 			P("TEST READ ONLY %d\n", RDONLY);
 			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
@@ -867,7 +794,6 @@ void *esclave(void *donnees)
 			continue;
 
 		case WRONLY:
-			/* On tente d'ecrire un fichier */
 			/* Try to write a file */
 			P("TEST WRITE ONLY %d\n", WRONLY);
 			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
@@ -888,7 +814,6 @@ void *esclave(void *donnees)
 		case LOCK:
 
 		case READLOCK:
-			/* On essaie de lire une section lockee en lecture sur le fichier */
 			/* Try to read a read-locked section */
 			P("READ LOCK %d\n", F_RDLCK);
 			if ((ftest = open(dp.fname, O_RDONLY | O_NONBLOCK)) < 0) {
@@ -900,7 +825,6 @@ void *esclave(void *donnees)
 			}
 
 			P("fd=%d\n", ftest);
-			/* Lock de l'ensemble du fichier */
 			/* Lock the whole file */
 			request.l_type = F_RDLCK;
 			request.l_whence = SEEK_SET;
@@ -917,7 +841,6 @@ void *esclave(void *donnees)
 			continue;
 
 		case WRITELOCK:
-			/* On essaie d'ecrire le fichier */
 			/* Try to write a file */
 			P("WRITE LOCK %d\n", F_WRLCK);
 			if ((ftest = open(dp.fname, O_WRONLY | O_NONBLOCK)) < 0) {
@@ -927,7 +850,6 @@ void *esclave(void *donnees)
 					perror("\nOpen:");
 				continue;
 			}
-			/* Lock de l'ensemble du fichier */
 			/* Lock the whole file */
 			P("fd=%d\n", ftest);
 			request.l_type = F_WRLCK;
@@ -955,11 +877,7 @@ void *esclave(void *donnees)
 			continue;
 
 		case BYTELOCK:
-			/* On se met en attente de la section a locker. L'ensemble de la structure est
-			 * donnee par le maitre et transmise par le tube.
-			 */
 			/* Wait for the exact section to lock. The whole file is sent by the master */
-
 			P("BYTE LOCK %d\n", etat);
 			getLockSection(&request);
 			if ((ftest = open(dp.fname, O_RDWR | O_NONBLOCK)) < 0) {
@@ -977,7 +895,6 @@ void *esclave(void *donnees)
 				etat = RESULTAT;
 				continue;
 			}
-			/* On change le caractere a la place donnee pour verification */
 			/* Change the character@the given position for an easier verification */
 			a = lseek(ftest, request.l_start, SEEK_SET);
 			write(ftest, "=", 1);
@@ -1077,7 +994,6 @@ int main(int argc, char **argv)
 			serveur = 0;
 			continue;
 		}
-		/* Option inconnue */
 		printf("Ignoring unknown option: %s\n", argv[i]);
 	}
 
diff --git a/testcases/network/nfsv4/locks/locktests.h b/testcases/network/nfsv4/locks/locktests.h
index 34ba36461..eba856a0e 100644
--- a/testcases/network/nfsv4/locks/locktests.h
+++ b/testcases/network/nfsv4/locks/locktests.h
@@ -90,7 +90,7 @@
 
 #define M_SIZE 512
 
-int writeToAllClients(char *foo);//#define DEBUG
+int writeToAllClients(char *foo);
 
 int serverReceiveNet();
 int clientReceiveNet();
@@ -118,36 +118,26 @@ enum etat_t     {
                 BYTELOCK_WRITE
 };
 
-/* Donnees communes aà tous les processu */
 /* Public data */
 struct donneesPub {
-    /* Nombre de clients */
     /* Number of clients */
     int nclnt;
-    /* Liste des clients (liste des tubes)*/
     /* List of master to slave pipes */
     int **lclnt;
-    /* Tube de communication avec le maitre */
     /* Slave to master pipe */
     int maitre[2];
-    /* Liste des threads */
     /* Thread list */
     pthread_t *lthreads;
-    /* nom du fichier test */
     /* test file name */
     char *fname;
-    /* descripteur du fichier test */
     /* test file file-descriptor */
     int fd;
-    /* Affichage des messages d'erreur */
     /* Detailed error messages */
     int verbose;
 };
 
-/* Donnees privees aux processus */
 /* private data */
 struct donneesPriv {
-    /* Numero de thread. */
     /* thread number */
     int whoami;
 };
diff --git a/testcases/network/nfsv4/locks/netsync.c b/testcases/network/nfsv4/locks/netsync.c
index be0d04398..34dabc9bd 100644
--- a/testcases/network/nfsv4/locks/netsync.c
+++ b/testcases/network/nfsv4/locks/netsync.c
@@ -15,7 +15,6 @@ int serverReceiveClient(int c)
 {
 	char tmp[M_SIZE];
 	int r, s;
-	/* Il faut etre sur que l'on lit _exactement_ la trame envoyee (M_SIZE) */
 	/* Ensure we read _exactly_ M_SIZE characters in the message */
 	memset(message, 0, M_SIZE);
 	memset(tmp, 0, M_SIZE);
@@ -24,8 +23,7 @@ int serverReceiveClient(int c)
 
 	while (s < M_SIZE) {
 		r = read(fdClient[c], tmp, M_SIZE - s);
-		/* On complete le message au fur et a mesure */
-		/* Loop until we have a complete  message */
+		/* Loop until we have a complete message */
 		strncpy(message + s, tmp, r);
 		s += r;
 	}
@@ -73,9 +71,6 @@ int setupConnectionServeur()
 	}
 	size = sizeof(struct sockaddr_in);
 	for (c = 0; c < maxClients; c++) {
-
-		/* On accepte les connections clientes */
-		/* Accept incoming connections */
 		if ((fdClient[c] =
 		     accept(sock, (struct sockaddr *)&remote, &size)) == -1) {
 			perror("accept");
@@ -111,15 +106,6 @@ int writeToAllClients(char *foo)
 int setupClients(int type, char *fname, int nThread)
 {
 	/*
-	 * Envoi des parametres a tous les clients
-	 *
-	 * on doit envoyer 3 parametres :
-	 * - l'emplacement du fichier test
-	 * - Le nombre d'esclaves
-	 * - Le type de sous processus : thread ou process
-	 */
-
-	/*
 	 * Send parameters to all slaves :
 	 *
 	 * We must send :
@@ -127,7 +113,6 @@ int setupClients(int type, char *fname, int nThread)
 	 * - the number of slaves for each client
 	 * - The kind of slaves : process or thread
 	 */
-
 	char message[512];
 	sprintf(message, "%d:%s:%d::", type, fname, nThread);
 	writeToAllClients(message);
@@ -176,7 +161,6 @@ int readFromServer(char *message)
 {
 	char tmp[M_SIZE];
 	int r, s;
-	/* Il faut etre sur que l'on lit _exactement_ la trame envoyee de taille M_SIZE */
 	/* Ensure we read exactly M_SIZE characters */
 	memset(message, 0, M_SIZE);
 	memset(tmp, 0, M_SIZE);
@@ -184,7 +168,6 @@ int readFromServer(char *message)
 	s = 0;
 	while (s < M_SIZE) {
 		r = read(fdServeur, tmp, M_SIZE - s);
-		/* On complete le message au fur et a mesure */
 		/* Loop until we have a complete message */
 		strncpy(message + s, tmp, r);
 		s += r;
-- 
2.13.0

