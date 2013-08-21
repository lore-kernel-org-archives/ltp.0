Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VCA4u-0000s2-C2
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 15:12:08 +0000
Date: Wed, 21 Aug 2013 17:12:08 +0200
From: chrubis@suse.cz
Message-ID: <20130821151208.GB5035@rei>
References: <1376375432.S.6723.RU.sfs3, sfs3, 36,
	732.29940.f5mail-224-141.rediffmail.com.old.1377001056.29933@webmail.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376375432.S.6723.RU.sfs3, sfs3, 36,
	732.29940.f5mail-224-141.rediffmail.com.old.1377001056.29933@webmail.rediffmail.com>
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
> PFB the steps I followed to compile open_posix_testsuite under LTP.I had placed ltp-full-20130109 directory under the following path in my work space in development host./nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109I have a main Makefile in /nb/devraj/realtime/nv/ct/ltp path which will trigger ltp-full-20130109's configuration, make all and make install and build will go successful all the time and I am able to run LTP on my device with these binaries created.since open_posix_testsuite is FILTER_OUT from default build through /nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/testcases/Makefile, so I have enabled the build by the following changes at this Makefile and given for the build.
> #ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)#FILTER_OUT_DIRS &nbsp; &nbsp; &nbsp; &nbsp; += open_posix_testsuite#endif
> I got the following issues&nbsp;&nbsp;*** No rule to make target `/nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/scripts/generate-makefiles.sh', needed by `conformance/interfaces/timer_settime/Makefile'. &nbsp;Stop.so I copied the /nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/testcases/open_posix_testsuite/scripts/generate-makefiles.sh script to nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/scripts path and this issue got resolved.
> Again I got the following issues*** No rule to make target `/nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/CFLAGS', needed by `conformance/interfaces/timer_settime/Makefile'. &nbsp;Stop.So I copied the /nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/testcases/open_posix_testsuite/CFLAGS file to nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109/ path and this issue got resolved.
> Same issues repeated for LDFLAGS and LDLIBS and those are resolved by copying these files to /nb/devraj/realtime/nv/ct/ltp/ltp-full-20130109 path.

You should not touch the Makefiles nor copy any files to the tree.

You can either enable Open Posix Testsuite build by:

./configure --with-open-posix-testsuite
make

or compile it directly by
cd testcases/open_posix_testsuite/
make

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
