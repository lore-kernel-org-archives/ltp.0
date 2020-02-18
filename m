From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Feb 2020 14:50:03 +0800
Subject: [LTP] [PATCH 0/7] Add new LTP tests related to fsmount family
 of syscalls
In-Reply-To: <20200218061906.GB14282@dhcp-12-102.nay.redhat.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <20200218061906.GB14282@dhcp-12-102.nay.redhat.com>
Message-ID: <CAEemH2dOnQanRKv6EQD2Y_ro65Wc4tXCkkyqnyEjwqf8WrD=JQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 18, 2020 at 2:09 PM Zorro Lang <zlang@redhat.com> wrote:

> On Fri, Feb 14, 2020 at 05:05:49PM +0530, Viresh Kumar wrote:
> > Hello,
> >
> > This series adds a bunch of LTP tests related to fsmount family of
> > syscalls.
>
> Hi Viresh,
>
> Thanks for all these cases, that's really helpful.
>
> Although you write cases for each new mount API, each xxxxx01.c case looks
> nearly do same things.
>
Yes, I have the same feelings. Below are my 2 cents:

Probably because the APIs should be used to bind together, but it is best
to reflect the focus of each test case. e.g. fsmount01.c as basic test
needs to cover more parameters to verify that all the functionality is
really working. fsmount02.c more like a test target for all error
conditions.

FYI madvise test:
[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise01.c
[2]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise02.c


> That's why I only wrote one case for new-mount currently, due to basic
> mount
> test already can through most of new APIs(except open_tree and fspick). I
> don't
> know if we should write nearly same things in different directories.
> Actually I prepared open_tree and fspick test cases(planned to name as
> newmount02
> and newmount03. but the newmount01 has been changed to fsmount01 :), but
> didn't
> sent out, due to I hope to the first case(which does basic changes) can be
> merged
> at first.
>

It'd be great if those tests can be merged together with Viresh's patch.


>
> All of your xxxxx02.c cases are great! I planned to test more different
> parameters of fsconfig() later too. Your invalid parameters test are nice.
> As you've sent these cases, I think these should be reviewed at first,
> avoid
> we do same things:) I'll try to help to review V2 patchset too, if I can:-P
>

Thank you in advance, Zorro!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200218/414e45c5/attachment-0001.htm>
