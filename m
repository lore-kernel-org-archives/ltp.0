Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsBvO-0000Ab-BL
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 13:07:46 +0000
Date: Thu, 27 Jun 2013 15:09:18 +0200
From: chrubis@suse.cz
Message-ID: <20130627130917.GA21389@rei>
References: <1372336933-2770-1-git-send-email-sedat.dilek@gmail.com>
	<51CC37E2.20304@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CC37E2.20304@ti.com>
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
> > Signed-off-by: Sedat Dilek<sedat.dilek@gmail.com>
> > ---
> >   runtest/ipc | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 60 insertions(+)
> 
> NAK. Duplication is generally a bad idea.
> This have the side effect of running the same tests twice for people 
> that run ipc and syscalls test scenarios.

Hmm, this is a valid point.

Thinking of the ideal way, it may be more data driven framework with a
list of all tests anotated with some group labels. I noted this for the
planned testdriver rewrite.

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
