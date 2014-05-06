Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhgLE-00014B-Gk
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 14:27:32 +0000
Date: Tue, 6 May 2014 16:26:32 +0200
From: chrubis@suse.cz
Message-ID: <20140506142632.GB8814@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C54931E@LCHQEX03.lancope.local>
	<20140430142009.GB21327@rei>
	<4506ACC2AE90484D87F9A883BA36C21C1C30735E@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C1C30735E@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch to recvfrom / recvmsg tests
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > What arch is this?
> 
> Irrelevant, I think, but x86_64.

Sorry the question was not specific enough I should have asked for
distribution and architecture. But the paragraph below explains why you
system is different.

> > On my system both getfdsetsize() and FD_SETSIZE are set to 1024?
> 
> The test uses getdtablesize(), which pulls the OPEN_MAX kernel parameter.
> In our kernel, we have OPEN_MAX set to more than FD_SETSIZE.
> 
> I first found this problem when this parameter had a typo, adding an order of magnitude to OPEN_MAX.
> Without the added clause in the loop to restrict it, the test would usually core from zero-bit bombardment into related memory. 
> Correcting the parameter typo unfortunately did not alter the test binary's behavior.
> 
> Arguably, this might be a bug with /usr/include/x86_64-linux-gnu/bits/typesizes.h and /usr/include/linux/posix_types.h
> which hard-code __FD_SETSIZE to 1024 instead of checking the OPEN_MAX kernel paramenter.
> (My knee-jerk reaction is to file this alongside "select() is broken".  :-)

Well, select() is decades old interface and fd_set was designed as fixed
size buffer back then, I would say that it's broken by design, because
if you open more filedescriptors than was __FD_SETSIZE by the time of
the program compilation it will break anyway. Happily we have poll() and
epoll() for programs that need to use more than 1024 file descriptors.

> An alternative patch might be to replace the getdtablesize() call by getfdsetsize().
> This would rely on accept() never returning a value greater than FD_SETSIZE.

That will not happen in this case, see below.

> I see no indication in accept, select, or poll manpages whether this is the case;
> I suspect it is so, otherwise select/poll cannot detect activity on some range of returned fd.

Well filedescriptors are allocated from lowest available number, so
everything works fine unless you keep open more than 1022 file
descriptors (first three are allocated for stdin, stdout and stderr).

> This would require inspecting the accept() code, though, and adding a test on accept() to verify that accept() cannot return a fd greater than FD_SETSIZE.
> Maybe accept() in a near-infinite loop to exhaust all fd's ...?
> (Beyond my available time right now.)
> 
> 
> > What about we set nfds to sfd + 1 and for each child we accept we set nfds to max(nfds, newfd+1)?
> 
> When accept() returns the highest-select()-detectable fd, this will clear the high-bit just off the end of the fdset, would it not?
> It'll hit far less often, but still be out-of-bounds, sadly ....

Looking at the code, the newly opened filedescriptor is closed right
away. I've tried to add printf() to the code and indeed it's always se
to 4, so the maximum would end up as 5.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
