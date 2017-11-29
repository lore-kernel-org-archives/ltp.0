From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 15:34:08 +0100
Subject: [LTP] [PATCH v2 02/13] thp: ensure THP/hugetlbfs is available
In-Reply-To: <87bmjl1ad6.fsf@e105922-lin.cambridge.arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-3-punit.agrawal@arm.com>
 <20171127162000.GA20047@rei.lan>
 <878ter3bfn.fsf@e105922-lin.cambridge.arm.com>
 <20171129124411.GB18489@rei>
 <87bmjl1ad6.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20171129143408.GA15160@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> The test passes even if THP is not enabled on the test kernel. This
> >> gives the false impression that THP is working as expected.
> >> 
> >> The explicit check is making sure the functionality under test is is
> >> enabled in the test kernel.
> >
> > I see where that came from, but I do not think that the test name is a
> > reason to disable this stress test. However I'm not sure if there is a
> > better name for the test. I guess that we may possibly move it to the
> > cve directory.
> >
> 
> So you're saying the test should run irrespective of whether THP is
> enabled or not in the kernel. I'll drop the thp01.c hunk from this patch
> then.

Exactly, it's basically test that tries to pass as large argument list
to exec() as possible, the fact that this has been broken with THP
enabled does not make it irrelevant for kernel without it.

-- 
Cyril Hrubis
chrubis@suse.cz
