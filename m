From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Jan 2020 14:33:02 +0530
Subject: [LTP] [PATCH 5.4 000/191] 5.4.8-stable review
In-Reply-To: <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
References: <20200102215829.911231638@linuxfoundation.org>
 <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com>
 <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com>
 <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
 <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
Message-ID: <CA+G9fYvzkPz6Ewm00ie+HqBpfQHFuRGn694Av-gj8Pt8iKrDQg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, 4 Jan 2020 at 00:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 3, 2020 at 9:59 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > Before I started investigating, Jan Stancek found and fixed the issue.
> >
> > http://lkml.kernel.org/r/a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com
>
> Applied upstream as commit 15f0ec941f4f ("mm/hugetlbfs: fix
> for_each_hstate() loop in init_hugetlbfs_fs()").

After applying above patch.
LTP test case memfd_create04 getting PASS on mainline Linus's tree
from Jan 3rd onwards.

ref link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/memfd_create04

- Naresh Kamboju
