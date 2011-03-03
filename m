Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pv98S-0004dn-KD
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 14:04:08 +0000
Date: Thu, 3 Mar 2011 15:24:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110303142453.GA21064@saboteur.suse.cz>
References: <1299068635.4463.1.camel@subratamodak.linux.ibm.com>
	<1469445745.266603.1299117157337.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469445745.266603.1299117157337.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 FEBRUARY 2011.
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sf.net, vapier@gentoo.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, akpm@linux-foundation.org

Hi!
I'm not completely against this. At least LTP and possibly other
testsuites would gain by attention from developers (it seems that the QA
people themselves are the only ones interested). But some things are not
just as simple as you see them (at least from my point of view).

> Those days, there just too many tests and testing projects for kernel like
> LTP, autotest, xfstests and so on. Why not have somewhere to collabrate and
> then to extract the best?

That is IMHO just too much work. You would need somebody to extract it
and then somebody to keep things in sync.

> LTP has so many goals and focus which isn't going to be only to test kernel
> any more and it is increasing difficult to support so many distros, kernel
> versions, and so on.

Frankly, LTP has maybe quite a lot of goals, but has a very little
manpower, so just now it's mostly broken and rotten code. I would
rather focus on cleaning up and fixing up the LTP, dropping ambiguous
tests and so.  We already did some progress in that area (I tend to say
"we" but besides random contributions we have like three or five people).

> There are some CORE tests like memory management tests, ksm, oom etc have
> benefit from the developers' bless and review. It also need to be updated
> to keep the tests relevant to the current git tree, since the features/specs
> are changing consistent inside the kernel.

That's true indeed.

> This could be also useful to improve the kernel quality by providing test
> code inside the kernel tree that to be used during the code review process
> that for example, a ksm patchset needs to pass that particular sanity tests
> in order to catch the regression. It provide benefit that when the changelog
> said that it passed the ksm tests inside the kernel, we knew exactly what it is
> without needing to sync up with another project like LTP.

Well, I don't see what would be gained by merging parts of the LTP into
kernel tree. As I said before, this would probably lead to splitting of
the forces (and not that we have a lot to split anyway). LTP already has
directory called testcases/kernel/, LTP is in the git repository and we
have a mailing list. All that is needed is people start noticing that
we are here.

> In term of maintenance, it needs to be selectively which tests need to be
> inside the kernel. There should ideally have a dedicated maintainer from the
> testing point of view to review them. The criteria can be something like,
> 
> 1) purely purpose of the tests are to test kernel written in C with the kernel
>    coding style. Userspace and integration tests should be better to put into
>    LTP and other projects.

I don't think that it's easy to say if some tests are testing
kernel/userspace. Sometimes the line isn't that clear.

> 2) tests need to pass sub-system maintainers' review that for example, ksm
>    tests need MM sub-system maintainers' review-by and sign-off-by and alike.

Well, requiring maintainers to sign-off your tests is kind of dull. That
would probably block the tests from being accepted just because
maintainers don't care too much/have different things to do.

> 3) they need to be working with and sync up to the latest git version.
> 4) they have to be proved to be the best tests we can have to test those
>    particular kernel code. There are many tests in LTP, but there are also
>    many duplicated tests as well. Those need to be solved when considering to
>    be moved inside the kernel source.

You can't easily prove that something is best ;).

> 5) they should really be functional testing. Non-functional tests like stress
>    or performance tests are usually more complex to setup hence defeat the
>    purpose of quick regression checking.
>
> Once we have those tests in-place, the next step to improve the kernel quality
> is to have more patches had Tested-by tags before been accepted in the kernel
> git tree. Those testers can simply use the non-ambiguious references for tests
> provided by those in-kernel tests.

Once again, LTP does exist so reference to LTP is not ambiguous. Yes,
it's, for historical reasons, hosted on sourceforge rather than
kernel.org. But there it is.

> In addition, those could be a follow-up items with the kernel regression reports
> that after fixed/analyzed a regression in kernel, the next natural thing to do
> is to fix/add missing tests to close this gap in the future by providing efficient
> tests to our users if all possible.

That's right thing to do, but once more, LTP is here for you ;). So my
conclusion is that the major point here is make LTP more visible among
linux hackers. On that note, I'm planing to prepare some presentation to
let the people know what is the current state and what we are doing to
get it better.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
