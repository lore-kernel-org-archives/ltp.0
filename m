Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X9Fq4-0002IK-BL
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 15:49:20 +0000
Date: Mon, 21 Jul 2014 17:48:38 +0200
From: chrubis@suse.cz
Message-ID: <20140721154838.GA30527@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C2ADF0458@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C2ADF0458@LCHQEX03.lancope.local>
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
> Ah, then autotools must be my issue.
> I've got "autotools-dev-20120608.1" package installed, per dpkg-query on those boxes.
> Must be something stuck in our local package-repo mirroring process;  maybe it's manual-only.
> 
> If we can figure out which version of autotools is fine, I suggest we document that in INSTALL
> alongside putting the patch back in.

LTP must be backward compatible so I've readded the -I m4 back.

So currently we have both -I m4 and AC_CONFIG_MACRO_DIR() which works
fine with both older and newer autotools and also fixes autoreconf on
newer autotools. So only thing that may get documented is that
autoreconf needs newer autoconf.

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
