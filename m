From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Feb 2020 15:47:20 +0800
Subject: [LTP] [PATCH 1/4] Avoid using tst_res(TBROK)
In-Reply-To: <20200227163922.317-1-pvorel@suse.cz>
References: <20200227163922.317-1-pvorel@suse.cz>
Message-ID: <CAEemH2fQ_oc8iEaKQV9pJgbfeOoq3yT7hqcGCmWK2JwMeRkzCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

This patch looks good.

But something wrong in patch applying, you probably need to do git rebase:).
    error: patch failed:
testcases/kernel/syscalls/gettimeofday/gettimeofday02.c:48
    error: testcases/kernel/syscalls/gettimeofday/gettimeofday02.c: patch
does not apply

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200228/393b3c56/attachment.htm>
