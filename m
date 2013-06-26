Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1Ure8Y-0006hc-SZ
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 01:03:06 +0000
Received: from mail-ee0-f49.google.com ([74.125.83.49])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ure8X-0002Vr-2d
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 01:03:06 +0000
Received: by mail-ee0-f49.google.com with SMTP id b57so7074633eek.22
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jun 2013 18:02:58 -0700 (PDT)
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 26 Jun 2013 03:02:51 +0200
Message-Id: <1372208571-9642-1-git-send-email-sedat.dilek@gmail.com>
Subject: [LTP] [PATCH] runtest: Add new syscalls-ipc test-suite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Run via './runltp -f syscalls-ipc'.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 runtest/syscalls-ipc | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 runtest/syscalls-ipc

diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
new file mode 100644
index 0000000..f57a96e
--- /dev/null
+++ b/runtest/syscalls-ipc
@@ -0,0 +1,68 @@
+msgctl01 msgctl01
+msgctl02 msgctl02
+msgctl03 msgctl03
+msgctl04 msgctl04
+msgctl05 msgctl05
+msgctl06 msgctl06
+msgctl07 msgctl07
+msgctl08 msgctl08
+msgctl09 msgctl09
+msgctl10 msgctl10
+msgctl11 msgctl11
+
+msgget01 msgget01
+msgget02 msgget02
+msgget03 msgget03
+msgget04 msgget04
+
+msgrcv01 msgrcv01
+msgrcv02 msgrcv02
+msgrcv03 msgrcv03
+msgrcv04 msgrcv04
+msgrcv05 msgrcv05
+msgrcv06 msgrcv06
+
+msgsnd01 msgsnd01
+msgsnd02 msgsnd02
+msgsnd03 msgsnd03
+msgsnd04 msgsnd04
+msgsnd05 msgsnd05
+msgsnd06 msgsnd06
+
+semctl01 semctl01
+semctl02 semctl02
+semctl03 semctl03
+semctl04 semctl04
+semctl05 semctl05
+semctl06 semctl06
+semctl07 semctl07
+
+semget01 semget01
+semget02 semget02
+semget03 semget03
+semget05 semget05
+semget06 semget06
+
+semop01 semop01
+semop02 semop02
+semop03 semop03
+semop04 semop04
+semop05 semop05
+
+shmat01 shmat01
+shmat02 shmat02
+shmat03 shmat03
+
+shmctl01 shmctl01
+shmctl02 shmctl02
+shmctl03 shmctl03
+shmctl04 shmctl04
+
+shmdt01 shmdt01
+shmdt02 shmdt02
+
+shmget01 shmget01
+shmget02 shmget02
+shmget03 shmget03
+shmget04 shmget04
+shmget05 shmget05
-- 
1.8.3.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
