Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uthh8-00084Q-Ve
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 17:15:19 +0000
Date: Mon, 1 Jul 2013 19:16:48 +0200
From: chrubis@suse.cz
Message-ID: <20130701171647.GB32691@rei.suse.cz>
References: <1372348066-5944-1-git-send-email-alexey.kodanev@oracle.com>
	<20130701150959.GA29141@rei.suse.cz> <51D1A828.70304@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D1A828.70304@oracle.com>
Subject: Re: [LTP] [PATCH v5] fw_load: new test of device firmware loading
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >>   getcontext01 getcontext01
> > We created kernel_misc runtest file just lately and I think that this
> > test is better suited to be added to that runtest file rather than to
> > syscalls, do you agree?
> OK, is it possible to add kernel_misc to default scenario?

We should have done that allready, I will fix this.

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
