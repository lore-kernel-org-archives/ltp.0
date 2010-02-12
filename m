Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Nfzg8-0000ss-HT
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 17:51:44 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nfzg6-000336-Iz
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 17:51:44 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1CHiF1w010764
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:44:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1CHpQLu152738
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:51:26 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1CHpPZq000420
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 15:51:26 -0200
Date: Fri, 12 Feb 2010 11:51:25 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100212175125.GC15333@us.ibm.com>
References: <000001caabb7$fe895b60$fb9c1220$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000001caabb7$fe895b60$fb9c1220$@co.jp>
Subject: Re: [LTP] "pidns17" problem in "2010-02-11" cvs
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Quoting Mitani (mitani@ryobi.co.jp):
> Hi,
> 
> I tried to test with "2010-02-11" cvs in RHEL5.4 system.
> But the test brings termination of connection.
> 
> I examined the phenomenon and discovered that "pidns17" test made 
> accident and sshd stopped after the test.
> 
> 
> I had some problems.
> 
> 1. I think that "tst_exit()" must be added last of "cleanup()"
>    function.
> ============
> --- ./testcases/kernel/containers/pidns/pidns17.c       2009-12-07
> 05:55:16.000000000 +0900
> +++ ./testcases/kernel/containers/pidns/pidns17.c.new   2010-02-12
> 16:26:31.000000000 +0900
> @@ -104,7 +104,6 @@
> 
>         /* cleanup and exit */
>         CLEANUP();
> -       tst_exit();
>  }
> 
>  /***********************************************************************
> @@ -136,7 +135,6 @@
> 
>         /* cleanup and exit */
>         CLEANUP();
> -       tst_exit();
>  }      /* End main */
> 
>  /*
> @@ -147,4 +145,5 @@
>  {
>         /* Clean the test testcase as LTP wants*/
>         TEST_CLEANUP;
> +       tst_exit();
>  }

Yeah I'm afraid I don't understand what CLEANUP and tst_exit exactly
do.  Hopefully Garrett can give an educated answer.

> ============
> 
> After revision, connection termination didn't occur.
> 
> 
> 2. I cannot understand the purpose that "kill()" function whose 
>    first parameter is "-1" is called.
> ------------
>         if (kill(-1, SIGUSR1) == -1) {
>                 tst_resm(TBROK | TERRNO, "cinit: kill(-1, SIGUSR1) failed");
>                 CLEANUP();
>         }
> ------------
> 
> If kill()'s first option is "-1", "man kill" says that
> "All processes with pid larger than 1 will be signaled."

Right, the test is checking whether kill -1 inside a private pidns
kills all processes besides init in the pid namespace.

> Therefore, not only the "sshd" but also the other processes were 
> affected, I think.

sshd is not in the private pid namespace and should not be killed.
If it is being killed by the pid -1 inside the container, then there
is a kernel bug.

> I'm glad if I could get some opinions.
> 
> 
> Thank you--
> 
> 
> -Tomonori Mitani

Thanks for testing.

-serge

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
