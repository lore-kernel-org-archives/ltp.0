From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2016 18:17:22 +0800
Subject: [LTP] [PATCH] lib/mem.c: exit from test_transparent_hugepage()
 if shortage of memory
In-Reply-To: <CAEemH2fJQh_g2cTtEL7mHEvmy1aqnucysgy7bkvbJCX2KE+wTA@mail.gmail.com>
References: <1453790132-2360-1-git-send-email-liwang@redhat.com>
 <CAEemH2fJQh_g2cTtEL7mHEvmy1aqnucysgy7bkvbJCX2KE+wTA@mail.gmail.com>
Message-ID: <CAEemH2dohcOBq7wHrr5XP+YN2Zsf+Ha=ARC54iiL73rDXtcGzg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I recall a similar testcase thp04.c which had been removed not long ago,
    commit 19cdd120b43aa6a6a4993b61e6ef675d1cdf04b4

after read the words written by Michal Ho, and I found these two (thp04/05)
cases are facing with very similar issue.

now I doubt if we can really trust thp05 result PASS/FAIL for LTP, remove
it or keep using(just reducing the nr_thps value)?

http://article.gmane.org/gmane.linux.ltp/23104


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160126/524b144d/attachment.html>
