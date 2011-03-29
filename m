Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jhawkes@penguincomputing.com>) id 1Q4csX-0006ND-DC
	for ltp-list@lists.sourceforge.net; Tue, 29 Mar 2011 17:38:53 +0000
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71])
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q4csW-0001Cd-9A
	for ltp-list@lists.sourceforge.net; Tue, 29 Mar 2011 17:38:53 +0000
Received: by mail-vx0-f176.google.com with SMTP id 37so506120vxa.35
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Mar 2011 10:38:46 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Mar 2011 10:07:12 -0700
Message-ID: <AANLkTimQ87Q009E_3fM5KAHX79tDnHOVryR4VQijEi6y@mail.gmail.com>
From: John Hawkes <jhawkes@penguincomputing.com>
Subject: [LTP] testcases/kernel/mem/mtest01/mtest01.c mishandles fork()
	failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

I don't know if this has been reported previously, but
testcases/kernel/mem/mtest01/mtest01.c improperly handles fork()
failures.  This coding sequence appears in several spots:
        pid = fork();
        if (pid != 0)
                pid_cntr++;
        pid_list[i] = pid;

If fork() fails and returns -1, that -1 gets stored in pid_list[i].  Later:
         while (pid_list[i] != 0) {
                 kill(pid_list[i], SIGKILL);
                 i++;
         }
will execute   kill(-1, SIGKILL)   which attempts sends a SIGKILL to
every process on the system, except for init and the current process.
If LTP is running as root, then this will take down the system.

-- 
John Hawkes

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
