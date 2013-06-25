Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrWhO-00074n-8M
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 17:06:36 +0000
Date: Tue, 25 Jun 2013 19:08:02 +0200
From: chrubis@suse.cz
Message-ID: <20130625170802.GA29135@rei>
References: <CA+icZUXjY1QAWk80FqnENt=S1H+x+MaREjoHMuOmoq-QMnT3+A@mail.gmail.com>
	<201306251229.46574.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201306251229.46574.vapier@gentoo.org>
Subject: Re: [LTP] [ltp-full-20130503] runltp and dash-bug
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> if the output really should be silenced, it should be changed to:
> 	>/dev/null 2>&1
> rather than just deleting it

It is better withtout the redirections. The runltp output is a few lines
longer but it will include output from losetup and mkfs if something has
failed and withtout that debugging is close to impossible.

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
