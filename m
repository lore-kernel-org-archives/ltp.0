From: Li Wang <liwang@redhat.com>
Date: Tue, 7 May 2019 18:06:16 +0800
Subject: [LTP] [PATCH v1] crypto/af_alg02: fixed read() being stuck
In-Reply-To: <7f9b69db-12a2-6e88-7687-602b88ce8cd7@suse.de>
References: <20190507065530.12174-1-camann@suse.com>
 <CAEemH2e=9J_7OtSsS5wq+4YgfOm1zj=PK5cnaBk69LKtdR71ZA@mail.gmail.com>
 <7f9b69db-12a2-6e88-7687-602b88ce8cd7@suse.de>
Message-ID: <CAEemH2cgcYG7OAkwbVHrjUCaHUrsXJkU2gKDnTUuvqp=9D1QcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 7, 2019 at 4:59 PM Christian Amann <camann@suse.de> wrote:

> Hi Li,
>
> Thanks for having a look at my patch. To my knowledge
> *pthread_timedjoin_np* does not kill the thread if it times out. It
> returns ETIMEDOUT which, in this case, leads to the whole testcase
> terminating.
>
Yes, you method could be work but not elegant. AFAIK, pthread_timedjoin_np
is non-standard and first appeared in glibc in version 2.3.3

> I chose this method over setting test.timeout because this way an
> informative error-message can be printed.
>
> I may be missing the problem here. Can you point me in the right direction
> why this is bad practice?
>
Seems you misundertood my words:). I was not suggest to set timeout for the
test before. As I saw you define VERIFY_TIMEOUT by yourself and involves
many variables to revoke thread when it hits reading stuck. That looks a
bit redundant.

Maybe we can take use of tst_timeout_remaining() to make things simpler?

we could call:

pthread_setcancelstate(PTHREAD_CANCEL_ENABLE)

at the start of parent, then creat thread to run test for a while of time,
until the tst_timeout_remaining() < 10sec, then call:

pthread_cancel(<thread_b_pid>)

At last, print something to declear if necessary.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190507/5e0101ab/attachment.html>
