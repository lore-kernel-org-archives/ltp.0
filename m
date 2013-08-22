Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VCV0Q-0003oA-NQ
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 13:32:54 +0000
Date: Thu, 22 Aug 2013 15:32:49 +0200
From: chrubis@suse.cz
Message-ID: <20130822133248.GB11897@rei.ASUS>
References: <1377097927.S.3511.11139.H.TmNocnViaXNAc3VzZS5jegBSZTogW0xUUF0gb3BlbiBwb3NpeCB0ZXN0c3VpdGUgY29tcGlsYXRpb24_.RU.rfs279,
	rfs279, 557,
	625.f5-224-110.old.1377175547.17217@webmail.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377097927.S.3511.11139.H.TmNocnViaXNAc3VzZS5jegBSZTogW0xUUF0gb3BlbiBwb3NpeCB0ZXN0c3VpdGUgY29tcGlsYXRpb24_.RU.rfs279,
	rfs279, 557,
	625.f5-224-110.old.1377175547.17217@webmail.rediffmail.com>
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> I used the following command&nbsp;
> ./configure --with-open-posix-testsuite
> and hit the following issue.
> 7632 make-3.81[3]:
> Entering directory `/opt/ltp/testcases/open_posix_testsuite'

That is really strange, it should not look into /opt/ltp/ if you are
compiling ltp in you home directory.

Could you send what exactly did you do (i.e. the commands executed) and
their output so that we can figure out what is wrong?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
