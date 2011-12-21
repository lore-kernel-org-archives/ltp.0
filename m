Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdLUl-0001Ct-Dn
	for ltp-list@lists.sourceforge.net; Wed, 21 Dec 2011 12:42:07 +0000
Date: Wed, 21 Dec 2011 13:51:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111221125142.GA22113@saboteur.suse.cz>
References: <CAGH67wTvxOTeyN6K2a23FG30TDA=Mn6xT6Xy4X3Hjmph09yBTg@mail.gmail.com>
	<f0db187c-f0fd-4362-a618-f9c2dcd081e2@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0db187c-f0fd-4362-a618-f9c2dcd081e2@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and
 open()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I posted single patch yesterday:
> [LTP] [PATCH] pipeio: prevent race between SIGCHLD and open()
> 
> You requested to use TERRNO instead of strerror(errno), so
> while I was at it, I made this change for all existing code in pipeio.c:
> [LTP] [PATCH v2 1/2] pipeio: convert strerror(errno) to TERRNO
> 
> and then put my original patch (with minor changes) on top of that:
> [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and open()

Should be fixed in latest commit, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
