From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 May 2021 07:13:38 +0200
Subject: [LTP] [PATCH 0/3] syscalls/aio: Convert libaio wrapper function
 to kernel syscall
In-Reply-To: <CAASaF6w3xihoQRakDsBB52jnTimexy3V6eoj2wVbtT43Yq9iCQ@mail.gmail.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <YJBJB/S1ThSsNvCk@pevik>
 <CAASaF6w3xihoQRakDsBB52jnTimexy3V6eoj2wVbtT43Yq9iCQ@mail.gmail.com>
Message-ID: <YJDYAnOZgAgu5y6A@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
