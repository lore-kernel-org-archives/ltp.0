Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMCyL-0003eq-1S
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 09:23:25 +0000
Date: Tue, 26 Aug 2014 11:22:21 +0200
From: chrubis@suse.cz
Message-ID: <20140826092221.GA25567@rei.suse.cz>
References: <d00e2fbc8b2b96403e841845b3df25104dada721.1408543124.git.jstancek@redhat.com>
	<20140820143252.GA23782@rei>
	<290231308.10805374.1408632310290.JavaMail.zimbra@redhat.com>
	<20140826085518.GA25390@rei.suse.cz>
	<1624956800.12985322.1409044708265.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1624956800.12985322.1409044708265.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] profil01: don't use address of function
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
> > It looks like I've accidentally deleted your reply to this email, sorry.
> > 
> > As both methods (the one with builtin and the one with asm()) seems to
> > work fine, feel free to proceed with either one of them.
> 
> Pushed. (I went with the gcc builtin)

Tested that it fixed the failure I've been seeing on ia64.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
