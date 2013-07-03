Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UuKtW-0007IE-3y
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 11:06:42 +0000
Date: Wed, 3 Jul 2013 13:08:15 +0200
From: chrubis@suse.cz
Message-ID: <20130703110815.GA2993@rei>
References: <1372765421-2934-1-git-send-email-alexey.kodanev@oracle.com>
	<201307021650.56483.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201307021650.56483.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v6] fw_load: new test of device firmware loading
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
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net, vasily.isaenko@oracle.com


Hi!
> generally it's preferable to organize the code such that forward decls aren't 
> even necessary.  seems like it'd be trivial to reorganize this file as such.

I keep telling that to people yet they are stubborn to organize the
files more to the actual code flow, i.e. main() first then all the
functions uses in main and so forth...

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
