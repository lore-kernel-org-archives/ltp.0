Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NBLVd-0000Rl-97
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 04:54:13 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NBLVY-0007lk-E5
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 04:54:13 +0000
Received: by pxi33 with SMTP id 33so2012852pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Nov 2009 20:54:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF316379BD.F75980D7-ON85257674.000F56B9-85257674.0010FC8C@us.ibm.com>
References: <mailman.132487.1258104166.5845.ltp-list@lists.sourceforge.net>
	<OF316379BD.F75980D7-ON85257674.000F56B9-85257674.0010FC8C@us.ibm.com>
Date: Thu, 19 Nov 2009 20:54:02 -0800
Message-ID: <364299f40911192054t4468c150v662836173a53876@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] minimal ltp test set
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Subrata Modak1 <subrata.modak@in.ibm.com>

On Thu, Nov 19, 2009 at 7:05 PM, Mark Ver <markver@us.ibm.com> wrote:
> The number of testcases over the past year had increased faster than could
> be properly debugged by our skeleton team for the s390x platform. Many of
> the testcases seemed to be designed for features on later kernel versions
> with were not yet fully integrated by our supported distributions.
>
> Since we mostly used LTP for a quick regression test, I was discussing with
> Subrata about creating a minimal test set that we expected would run
> properly on a majority of the distributions with kernel 2.6 and not just the
> more recent versions of the kernel.
>
> This is my first pass at the test set:
> (See attached file: s390x_ltpcore_targets)
>
> It is basically a subset of the default SCENFILES from the ltp-full-20090731
> concatenated into one file.
>
> Basic rundown of the contents ...
> * Included tests:
> syscalls
> fs
> fsx
> dio
> mm
> ipc
> sched
> math
> nptl
> pty
> containers
> fs_bind
> filecaps
> fcntl-locktests
> -----
> * Excluded tests - new in 2009 (maybe late 2008) versions (appear to have
> build, run, or support issues depending on distribution release)
> io
> cap_bounds
> connectors
> admin_tools
> timers
> power_management_tests
> numa
> hugetlb
> commands
> hyperthreading
> -----
> * Excluded from original set:
> controllers
> - notes: this feature was currently available only on SLES-11 and the build
> and execution of the testcase appeared to need more work for s390x
> -----
>
> Ideally I was hoping to come up with a set of tests that were so basic, they
> should be supported by practically every release and would be expected to
> run correctly everywhere. They would only fail if major issues had been
> introduced into the system build.

Mark,
    An ideal solution to this problem is a two-tiered solution:
    1. Feature based conditional compilation.
    2. Tool based conditional compilation (some tests require certain
tools, such as perl, python, and various Unix utilities that aren't a
part of the minimal set of tools, e.g. useradd, userdel, etc).
    The tool based condition compilation is somewhat simple at a 10k
ft level (I have perl, python, ruby, etc -- add / remove these tests /
features) -- the feature based conditional compilation issue is a bit
more difficult to deal with as it requires a more in-depth
understanding of what code exists in the sourcebase, and what
functional tests map to what functional blocks under test. This is
ideal, but not trivial to perform.
    My first goal is to deal with any fallout from the make
infrastructure commit(s), dealing with the make 3.80 incompatibility
and other unforeseen usecases like you have with building and
executing out of the same source tree. Next, I want to clean up any
and all C warnings so the tests are more robust (Mike, Cyril, and I
have done a pretty good job but there's a ways to go...). Then I'll
undertake completing the ballista cleanup, which will also involve
adding the shims for perl and python across the entire sourcebase.
We'll need to revisit the feature based enabling a little later.
    How does that sound?
Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
