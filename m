Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrUM2-000184-Mn
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 14:36:22 +0000
Date: Tue, 25 Jun 2013 16:37:51 +0200
From: chrubis@suse.cz
Message-ID: <20130625143751.GL31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUU_kFw76obbvVHtiHNL0HK7D7avAZnbZcfSHZQECAZjCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUU_kFw76obbvVHtiHNL0HK7D7avAZnbZcfSHZQECAZjCQ@mail.gmail.com>
Subject: Re: [LTP] How to run only a specific test series like for example
 IPC?
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> I wanted to only run the IPC tests as I have troubles with IPC(-MSG)
> >> in Linux-Next.
> >>
> >> This is what I did...
> >>
> >> root# cd /opt/ltp/
> >>
> >> root# ./runltp ./runtest/ipc
> >>
> >> ...is that the correct way? Wrong?
> >
> > I belive that the syntax is ./runltp -f ipc
> >
> > Also there are additional tests for POSIX IPC in open_posix_testsuite
> > that are not executed by the runltp script.
> >
> 
> How do I run the "POSIX IPC"?

Look into testcases/open_posix_testsuite/ directory, the openposix
testcases are currently not executed from the runltp script and needs to
be compiled and executed separetely. Do 'make' and 'make test' to
compile and run the testsuite (it contains testcases for POSIX
semaphores, message queues and shared memory).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
