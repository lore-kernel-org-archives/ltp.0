Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XW4qv-0006Wb-1Y
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 14:44:33 +0000
Date: Mon, 22 Sep 2014 16:44:15 +0200
From: chrubis@suse.cz
Message-ID: <20140922144415.GA21875@rei.suse.cz>
References: <20140922154742.71edd101@mats-desktop>
	<20140922142631.GA12628@rei.suse.cz>
	<20140922163759.068fcaf1@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140922163759.068fcaf1@mats-desktop>
Subject: Re: [LTP] Failed out of tree compile
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Ok, thanks for the workaround, I'll try that!
> 
> I haven't played much with autotools as a developer, but I recently
> dived into CMake. Seems like CMake scripts are easier to understand and
> maintain. Are there thoughts about switching to CMake, or is there some
> big disadvantage with CMake?

The usage of autotools in LTP is in fact quite limited. It's used only
to create the configure script to check for various features, the rest
uses hand written Makefile rules that are fine. The problem with ffsb in
this case is that it's third party tool that came with the full
autotools mess that tends to break...

In short I do not see any advantages to switing to CMake or any other
build system. The only thing that needs to be done it this case is
fixing build for single ffsb binary.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
