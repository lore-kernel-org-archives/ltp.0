Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XBm1C-0002zA-Cz
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 14:35:14 +0000
Date: Mon, 28 Jul 2014 16:34:29 +0200
From: chrubis@suse.cz
Message-ID: <20140728143428.GA14973@rei.suse.cz>
References: <20140722165406.GA10128@rei>
	<1406107729-29729-1-git-send-email-mmarhefk@redhat.com>
	<1537340131.14625347.1406186431983.JavaMail.zimbra@redhat.com>
	<20140728140851.GB12993@rei.suse.cz>
	<2081581613.15959281.1406557594456.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2081581613.15959281.1406557594456.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3] containers: added pidns/pidns03.c
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
Cc: metan@suse.de, ltp-list@lists.sourceforge.net

Hi!
> > > looks good to me, with small note to make umount also in readlink() error
> > > path.
> > > If there'll be no other objections from Cyril, I can add that during commit
> > > (no need to resubmit).
> > 
> > The latest version looks good to me as well.
> > 
> > Maybe we can add a comment that would explain that /proc/self points to
> > directory named with the process pid so that it's clear why readlink
> > returns the process pid there.
> 
> Pushed with extra comment about proc/self symlink.

Looking at the commit we miss runtest record.

Even more the testcases are currently executed by the runpidnstest.sh.

Can we get that converted to a runtest file and have the pidns03 added?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
