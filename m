Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdLyC-0001M2-Bj
	for ltp-list@lists.sourceforge.net; Wed, 21 Dec 2011 13:12:32 +0000
Date: Wed, 21 Dec 2011 14:22:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111221132206.GC22113@saboteur.suse.cz>
References: <1324351382-22497-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324351382-22497-1-git-send-email-YanFeng.Shang@windriver.com>
Subject: Re: [LTP] [PATCH] redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)
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
To: Shang Yanfeng <YanFeng.Shang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> testcase create NCPU=4 threads running with a high priority with the same sched
> policy and one with a low-priority. The low-priority thread should not run
> until the other threads stop running, unless the machine has more than NCPU processors
> when cpu core >4,testcase failed. redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)

There are two problems with that. The first one, and less problematic, is that
_SC_NPROCESSORS_CONF is not yet POSIX standardized.

The second and more problematic part is that such process would eat all
your CPU time, which may easily lock the whole box while testing.

I think that best solution for this is to use affinity (which is not
standartized by POSIX either, but at least the code is isolated in one
header in open_posix_testsuite/include/) to lock two test threads on
one CPU.

See conformance/interfaces/sched_yield/1-1.c and include/affinity.h in
open_posix_testsuite as an example.

And if you choose to rewrite the test, please remove the usage of
testfrmw.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
