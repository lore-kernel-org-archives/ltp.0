Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XGs8O-0008Iv-1H
	for ltp-list@lists.sourceforge.net; Mon, 11 Aug 2014 16:07:44 +0000
Date: Mon, 11 Aug 2014 18:06:49 +0200
From: chrubis@suse.cz
Message-ID: <20140811160648.GA5271@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C2ADF02C2@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C2ADF02C2@LCHQEX03.lancope.local>
Subject: Re: [LTP] More observations on HEAD
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
> The default test set runs move_pages* twice.

True, these are part of two different runtest files and both runtest
files are part of default scenario. I do not think that this is wrong as
it is.

It's rather limitation of the current system to run testcases. What I
would rather is is some label based system, where testcases can be
labeled with different scenarios.

I.e. in this cases move_pages would be labeled as syscalls, numa and
default. Then we can run testcases by labels rather than runtest
files...

> run_cgroup_test_fj.sh hangs on heavy-load systems with $LTPROOT/output/ not present.
> 
> Some test under container_test.sh (sourcing childns.sh) attempts to create veth pairs without verifying veth functionality supported.
> Other tests under container_test.sh fail to source files (childns.sh cannot source cmdlib.sh;  child_1.sh and childipv6.sh cannot source initialize.sh).
> 
> Many tests under cgroup_regression_test.sh blindly log to hard-coded $LTPROOT/output/ directory without making sure it's there.
> Also, subtest #7 "fails to mount hugetlb" because it seemingly did not first check whether the functionality was enabled.
> 
> Under cgroup_fj also seems to have some tests which do latency tests and other tests, outputting "TINFO" and "FAIL" and "PASS" not in standard format.
> I will see if I can bisect it down and work out which tests those are.

Adding checks for missing functionality should be pretty
straightforward and patches are welcome :).

The runltp script contains code to create the $LTPROOT/output directory
so there are a few testcases that expect that directory to exist,
nevertheless they should create test temporary directory with tst_tmpdir
and use it instead.

> dma_thread_diotest invocations all claim to be "dma_thread_diotest07" in the runltp outputfile.

We forget to rename the TCID after we renamed the file. Fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
