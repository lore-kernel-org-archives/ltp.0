From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Feb 2016 17:18:05 +0100
Subject: [LTP] [PATCH] lib/mem.c: exit from test_transparent_hugepage()
 if shortage of memory
In-Reply-To: <CAEemH2dohcOBq7wHrr5XP+YN2Zsf+Ha=ARC54iiL73rDXtcGzg@mail.gmail.com>
References: <1453790132-2360-1-git-send-email-liwang@redhat.com>
 <CAEemH2fJQh_g2cTtEL7mHEvmy1aqnucysgy7bkvbJCX2KE+wTA@mail.gmail.com>
 <CAEemH2dohcOBq7wHrr5XP+YN2Zsf+Ha=ARC54iiL73rDXtcGzg@mail.gmail.com>
Message-ID: <20160204161805.GC29623@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I recall a similar testcase thp04.c which had been removed not long ago,
>     commit 19cdd120b43aa6a6a4993b61e6ef675d1cdf04b4
> 
> after read the words written by Michal Ho, and I found these two (thp04/05)
> cases are facing with very similar issue.
> 
> now I doubt if we can really trust thp05 result PASS/FAIL for LTP, remove
> it or keep using(just reducing the nr_thps value)?
> 
> http://article.gmane.org/gmane.linux.ltp/23104

The test is indeed nearly the same as thp04 and it suffers the same
problem as thp04. Let's remove it (along with the functions from
testcases/kernel/mem/lib/mem.c that would be unused after the removal.

-- 
Cyril Hrubis
chrubis@suse.cz
