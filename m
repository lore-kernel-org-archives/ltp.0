Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V8ozO-0000nH-Iq
	for ltp-list@lists.sourceforge.net; Mon, 12 Aug 2013 10:04:38 +0000
Date: Mon, 12 Aug 2013 12:04:37 +0200
From: chrubis@suse.cz
Message-ID: <20130812100437.GA24518@rei>
References: <20130808130919.2587.qmail@f5mail-224-107.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130808130919.2587.qmail@f5mail-224-107.rediffmail.com>
Subject: Re: [LTP] open posix testsuite compilation
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
To: devaraja b v <sunildev_63@rediffmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> ltp-full-20130109 source code is having old open posix testsuite.New version posixtestsuite-1.5.2&nbsp;is available at&nbsp;http://sourceforge.net/projects/posixtest/files/posixtest/&nbsp;link.Please use this or the latest module in the next release of LTP, as the latest one is easy to cross compile and run on various platforms.
> I am facing the following issues when I am compiling this new tool inside LTP.&nbsp;Please let me know any lead or pointer to fix this issue?

Open posix testuite in LTP was updated to the latest version (1.5.2) in
2007. The open posix testuite upstream is dead for about seven years and
the development was continued inside the LTP. The open posix testsuite
in LTP is the latest and best you can have.

> cat: LDFLAGS: No such file or
> directoryltp/obj-i686/locate-test:
> Command not foundltp/obj-i686/locate-test:
> Command not foundmake-3.81[3]: *** No rule to
> make target `install'.&nbsp; Stop.make-3.81[3]: Leaving
> directoryltp/obj-i686/testcases/open_posix_testsuite'
> 
> make-3.81[2]: *** [install] Error
> 2
> 
> make-3.81[2]: Leaving directory&nbsp;ltp/obj-i686/testcases'
> 
> make-3.81[1]: ***
> [testcases-install] Error 2
> 
> &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;make-3.81[1]: Leaving directory&nbsp;ltp/obj-i686'
> 
> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;make-3.81: ***ltp/obj-i686/install.sentinel]
> Error 2
> 

Can you include exact steps that lead to this failure?

Also please send emails to the mailing list in plain text next time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
