Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XOjRV-0005ln-EL
	for ltp-list@lists.sourceforge.net; Tue, 02 Sep 2014 08:27:57 +0000
Date: Tue, 2 Sep 2014 10:27:46 +0200
From: chrubis@suse.cz
Message-ID: <20140902082745.GA6002@rei.suse.cz>
References: <20140901183433.GT30210@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140901183433.GT30210@waldemar-brodkorb.de>
Subject: Re: [LTP] issue #13
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
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have added a comment to issue #13.
> https://github.com/linux-test-project/ltp/issues/13
> I was unable to reopen it.
> 
> Any ideas about the exp10 check problem?

Does the trick suggested by Mike (vapier) works for you?

I.e. changing the input of the exp10() function to (float)argc so that
the compiler cannot assume that the vhole expression is a constant?

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
