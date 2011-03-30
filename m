Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q4ykK-0006bT-46
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 16:59:52 +0000
Date: Wed, 30 Mar 2011 19:22:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110330172258.GG29707@saboteur.suse.cz>
References: <AANLkTimQ87Q009E_3fM5KAHX79tDnHOVryR4VQijEi6y@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimQ87Q009E_3fM5KAHX79tDnHOVryR4VQijEi6y@mail.gmail.com>
Subject: Re: [LTP] testcases/kernel/mem/mtest01/mtest01.c mishandles fork()
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
To: John Hawkes <jhawkes@penguincomputing.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I don't know if this has been reported previously, but
> testcases/kernel/mem/mtest01/mtest01.c improperly handles fork()
> failures.  This coding sequence appears in several spots:
>         pid = fork();
>         if (pid != 0)
>                 pid_cntr++;
>         pid_list[i] = pid;
> 
> If fork() fails and returns -1, that -1 gets stored in pid_list[i].  Later:
>          while (pid_list[i] != 0) {
>                  kill(pid_list[i], SIGKILL);
>                  i++;
>          }
> will execute   kill(-1, SIGKILL)   which attempts sends a SIGKILL to
> every process on the system, except for init and the current process.
> If LTP is running as root, then this will take down the system.

That is broken indeed. Do you care to send a patch or this is just
bugreport?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
