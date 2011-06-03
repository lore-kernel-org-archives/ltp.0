Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QSU2G-0002Yu-Ol
	for ltp-list@lists.sourceforge.net; Fri, 03 Jun 2011 13:03:32 +0000
Date: Fri, 3 Jun 2011 15:00:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110603130036.GA7155@saboteur.suse.cz>
References: <BANLkTinjK1N+jzhSOJrECj3O95k16+6Fkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTinjK1N+jzhSOJrECj3O95k16+6Fkg@mail.gmail.com>
Subject: Re: [LTP] open posix "sigpause" test defect
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
To: "Kevin R. Whitney" <krwhitney@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is my first post, so if I'm in the wrong place, please direct me to the
> correct place!
> 
> I found that
> test testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c is
> unstable because of a defect in the code.  Of course I can provide the logic
> and diffs, but where/who should I send it to?

You got to the right place ;). Send a signed patch here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger.
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Discover what all the cheering's about.
Get your free trial download today. 
http://p.sf.net/sfu/quest-dev2dev2 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
