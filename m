Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RqSWl-0005V2-OX
	for ltp-list@lists.sourceforge.net; Thu, 26 Jan 2012 16:50:23 +0000
Date: Thu, 26 Jan 2012 18:03:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120126170310.GD6666@saboteur.suse.cz>
References: <CANoG8sVidgJ-=eRjbk7L-NSajQzMqQr24wFAYSW3FU8ChzL4ow@mail.gmail.com>
	<CAMgc3zMJMshA4Ahub0UyDoeOu+0PWDnEZkekgbk+Dmr6ryPR+w@mail.gmail.com>
	<CAMgc3zN1g9eWXe2dRq=ihDK2tcS1D_0YubWd-6Bag8kb9rVTRw@mail.gmail.com>
	<20120126151417.GC6666@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120126151417.GC6666@saboteur.suse.cz>
Subject: Re: [LTP] Strange output of fork13 testcase
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
To: Shane Volpe <shanevolpe@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The following patch fixes the problem but I'm not very knowledgeable
> > on what fork13 does so this patch might not be a good approach.  Can
> > someone more knowledgeable on it let me know if this is a valid
> > approach?
> 
> Strange indeed. I could see the same errors in the log as well. I'll
> look closer on this hopefully today.

Okay, here is the cause:

The '-c 2' parameter of the test causes it to fork at the test very
beginning (in the TEST_PAUSE macro that evaluates to call to
usc_global_test_hook()). So two instances of the test are running.

However the ltp-pan, as it executes the test, remebers pid of the test
it has started (in this case first instance of the fork13 testcase) and
then waits until this program exits, reports the test success/failure
accordingly to it's return value etc... And also kills all lefover
processes forked from the testcase (in this case, most likely the second
instance of the test running and it's child).

Moreover even if the second instance of the test finishes fine, it's
return value is ignored.

So the -c option is broken by design and should be removed, maybe even
from LTP as whole.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
