Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsCER-0005hD-63
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 13:27:27 +0000
Date: Thu, 27 Jun 2013 15:28:57 +0200
From: chrubis@suse.cz
Message-ID: <20130627132857.GB21560@rei>
References: <1372336933-2770-1-git-send-email-sedat.dilek@gmail.com>
	<51CC37E2.20304@ti.com> <20130627130917.GA21389@rei>
	<51CC3C3B.2020803@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CC3C3B.2020803@ti.com>
Subject: Re: [LTP] [PATCH] runtest/ipc: Add some IPC syscalls test-cases
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
To: Carlos Hernandez <ceh@ti.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>> Signed-off-by: Sedat Dilek<sedat.dilek@gmail.com>
> >>> ---
> >>>    runtest/ipc | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 60 insertions(+)
> >> NAK. Duplication is generally a bad idea.
> >> This have the side effect of running the same tests twice for people
> >> that run ipc and syscalls test scenarios.
> > Hmm, this is a valid point.
> >
> > Thinking of the ideal way, it may be more data driven framework with a
> > list of all tests anotated with some group labels. I noted this for the
> > planned testdriver rewrite.
> >
> 
> We can easily support this with existing infrastructure if we add some 
> structure to the test case tags.
> For instance on runtest/syscalls, one could use:
> msgctl01_ipc
> msgctl02_ipc
> ...
>
> Then when calling runltp, one can use -s option to filter tests cases, 
> e.g. ./runltp -f syscalls -s '*_ipc'
> 
> At Texas Instruments we use following convention for TAG names
> <AREA>_<SCOPE>_<TYPE>_<ID>
> 
> 

That is no go, at least here we have database of testruns for different
distributions and renaming the testcases tags will break the regression
detection. So I would preffer solution that adds a metadata without
renaming the current test tags. The problem is that ltp-pan and runltp
are so horribly outdated and unmaintaned that adding functionality to
these is out of question.

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
