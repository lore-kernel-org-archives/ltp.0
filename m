From: xieziyao <xieziyao@huawei.com>
Date: Tue, 4 May 2021 06:19:39 +0000
Subject: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function
 to kernel syscall
In-Reply-To: <YJDYAnOZgAgu5y6A@pevik>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <YJBJB/S1ThSsNvCk@pevik>
 <CAASaF6w3xihoQRakDsBB52jnTimexy3V6eoj2wVbtT43Yq9iCQ@mail.gmail.com>,
 <YJDYAnOZgAgu5y6A@pevik>
Message-ID: <f4927571ebe74ea4b378e475befda3c7@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr, Jan,

I am working on adapting the new API to the testsuite of syscalls/io_*.

At the same time, I prefer to replace libaio wrapper function with raw system call(tst_syscall(__NR_io_*)) just for the aio testcases of kernel/syscalls, since this method may be more straightforward, no need to rely on other libraries.

Glad to see your discussion and participation, thanks.

Kind regards,
Ziyao
From: Petr Vorel<pvorel@suse.cz<mailto:pvorel@suse.cz>>
To: Jan Stancek<jstancek@redhat.com<mailto:jstancek@redhat.com>>
Cc: xieziyao<xieziyao@huawei.com<mailto:xieziyao@huawei.com>>;ltp<ltp@lists.linux.it<mailto:ltp@lists.linux.it>>;Richard Palethorpe<rpalethorpe@suse.com<mailto:rpalethorpe@suse.com>>
Subject: Re: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function to kernel syscall
Time: 2021-05-04 13:13:53

Hi Jan,

> On Mon, May 3, 2021 at 9:03 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Ziyao,

> > > Instead of using the libaio wrapper function, the system call is changed
> > to be invoked via syscall(2).


> I probably missed some discussion. Why are we replacing it with syscall?

you haven't missed anything. io_destroy(ctx) (libaio.h) is being replaced with
raw syscall (tst_syscall(__NR_io_destroy, ctx).

Kind regards,
Petr
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210504/f92c4e36/attachment-0001.htm>
