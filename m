Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xy1lx-0001IX-GT
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 17:06:57 +0000
Date: Mon, 8 Dec 2014 18:06:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208170640.GA16442@rei.suse.de>
References: <20141208164328.41386591@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141208164328.41386591@mats-desktop>
Subject: Re: [LTP] Full nohz test
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
> I'm (still...) working on a new test case for testing the NO_HZ_FULL
> kernel feature available from Linux 3.10. This test code depends on a
> tool that performs CPU isolation, which is a requirement for the
> NO_HZ_FULL to work.
> 
> It was previously proposed that this tool, rt-tools, would be a git
> submodule to ltp. That sounded good in the beginning, until I started
> to think about cross-compile, altering install location, etc. Since
> rt-tools uses cmake, and ltp uses autotools, there is no automatic
> inheritance of configuration. It would therefore be easy to miss copying
> some configuration from configure to the cmake invocation, causing
> surprises.
> 
> Since the test case is not intended to be part of default, I suggest
> the simple solution: Just document in the README file that this test
> case requires that the rt-tools are built and installed before the test
> case is run on target, and instructions how to get started with that.

Sounds ok to me. If the tool installs binaries somewhere to the $PATH
you just have to assert that these are installed. For bash code there is
tst_check_cmds function. For C code you can probably use tst_get_path().

In short make sure that the test exits louldy if these are not installed
and point the user to a README in the message.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
