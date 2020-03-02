From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Mar 2020 14:10:49 +0800
Subject: [LTP] use of pthread_cancel in tst_fuzzy_sync.h
In-Reply-To: <2365a007-02fe-c48c-2df5-04aedc076208@google.com>
References: <2365a007-02fe-c48c-2df5-04aedc076208@google.com>
Message-ID: <CAEemH2csQSdvaFkQu7aRDNdp44Ri7tgbzzrtQJh40f-EPFPU=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve,

Thanks for reporting this.

On Sat, Feb 29, 2020 at 3:47 AM Steve Muckle <smuckle@google.com> wrote:

> Hi Li,
>
> While integrating the latest LTP release into Android's VTS test suite I
> ran into trouble with this commit:
>
> commit cad524797ba4cee2e40985043f113256419f4a90
> Author: Li Wang <liwang@redhat.com>
> Date:   Thu Sep 26 17:39:21 2019 +0800
>
>      fzsync: revoke thread_b if parent hits accidental break
>
> It introduces a dependency on pthread_cancel() which Android does not
> implement:
>
>
> https://android.googlesource.com/platform/bionic/+/refs/heads/master/docs/status.md
>
> In the short term I can work around this, taking out the
> pthread_cancel() should be fine as far as I can tell as it is just used
>

Yes, for currently, we don't see another test(besides cve-2016-7117.c) that
hits the accidental break. So I think it's safe for you to revert my patch
on your branch:).

We also have fixed on cve-2016-7117.c for the break problem in a simple way:

commit 2e74d9963c882289be0551df63d33f5b7dee56d8
Author: Richard Palethorpe <rpalethorpe@suse.com>
Date:   Thu Jan 10 10:59:50 2019 +0100

    Check recvmmsg exists before entering fuzzy loop



> to avoid a timeout in certain circumstances. Long term though, could
> this be reworked to use pthread_kill() or some other mechanism?
>

Sure, it is a tiny defect in LTP test fuzzy synchronization. As before in
my patch V2[1], it tried to use pthread_kill/pthread_exit for solving the
problem, unfortunately, pthread_exit is not signal-safety function. So we
go pthread_cancel way for the fix. I'm thinking if we can go back to merge
these two way together now. Or maybe another idea is also welcomed~

[1] http://lists.linux.it/pipermail/ltp/2019-January/010489.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200302/e0b122bd/attachment.htm>
