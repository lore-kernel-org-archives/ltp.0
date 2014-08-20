Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XK6xV-0001TM-Cq
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 14:33:53 +0000
Date: Wed, 20 Aug 2014 16:32:52 +0200
From: chrubis@suse.cz
Message-ID: <20140820143252.GA23782@rei>
References: <d00e2fbc8b2b96403e841845b3df25104dada721.1408543124.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d00e2fbc8b2b96403e841845b3df25104dada721.1408543124.git.jstancek@redhat.com>
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
> This testcase is failing on ppc64 BE system, because
> address of &test_profil does not reference beginning of code,
> but entry in .opd section:
>   "This section contains the official procedure descriptors.
>    A pointer to a function shall reference a procedure descriptor
>    in this section."
> which was at address larger than all .text of test_profil.
> 
> This patch is replacing address of function approach with gcc's
> __builtin_return_address() to get current pc value.

How is it with compatibility? In which gcc version was this building
introduced? Does it work with clang?

If we are in doubt, we should add a configure check and use it only when
available. And probably to default to &test_profil in all cases but
ppc64 BE which is known to fail.

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
