Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X97nW-0000aO-HJ
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 07:14:10 +0000
Date: Mon, 21 Jul 2014 09:13:28 +0200
From: chrubis@suse.cz
Message-ID: <20140721071328.GA5025@rei.suse.cz>
References: <4506ACC2AE90484D87F9A883BA36C21C2ADF0001@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C2ADF0001@LCHQEX03.lancope.local>
Subject: Re: [LTP] Apparent trouble with HEAD of LTP
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Merely adding libtool (2.4.2) onto the system still leaves me with the munged ./configure script.
> 
> To correct this issue I did:
> 
> 1:  added back '-I m4' to include/mk/automake.mk
> 
> 2:  `make distclean ; rm -f configure`
> 
> 3:  restarted my work at the `make autotools` step
> 
> I see no odd output or bad warnings from compilations.
> `make install` is also clean, and invoking `/path/to/runltp -h` gives help output as expected.


You are not the only one with this problem, I will fix this ASAP.

With the last commit I've added AC_CONFIG_MACRO_DIR(m4) which should add
the path to m4 directory instead of the -I m4 (which works for me
apparently because I have recent enough autotools). According to the GNU
mailing list the macro was not working until recently, see:

http://lists.gnu.org/archive/html/autoconf/2013-08/msg00013.html

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
