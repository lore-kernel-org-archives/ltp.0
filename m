From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Mar 2016 16:27:24 +0800
Subject: [LTP] [PATCH RFC 3/9] tracing[2]: reorganize ftrace stress
 tests to general tests
In-Reply-To: <20160321122107.GB32294@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <20160317163918.GD31815@rei.lan>
 <CAEemH2duh-a3yw-2y0xx9VBe0Sor8imJJeotcC-Q-t-w8J2fCw@mail.gmail.com>
 <20160321122107.GB32294@rei.lan>
Message-ID: <CAEemH2fjFsmo=RnnDweiO61Dnk=wL2Y6ozKZM88gfqJ0ciV-DQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Mar 21, 2016 at 8:21 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Seems like these regression cases are petty and simple. I fear that would
> > be too dispersed to read. How about taking use of the cgroup tests
> > code-style to organise them?
>
> I do not think so. The problem with running to many testcases as one
> test is that we get wrong idea about the overall result. Even if one
> regression test fails the test will return failure and instead of 90%
> green we end up with 100% red in the results.
>

ok, I have got the point, will separate the regression case in each.


>
> And also the cgroup_regression_test.sh does not use the test.sh library
> do not take the test as example please.
>
>
thanks!

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160322/d063e72e/attachment.html>
