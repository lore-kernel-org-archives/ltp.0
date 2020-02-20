From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 18:09:47 +0800
Subject: [LTP] [PATCH V2 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200220055024.fgh2uxje6yanrshh@vireshk-i7>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <6ac7573e8ea5ab6f0ab9256b73802126d72b5156.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2f6gudJjZ1HAsVFVKkuR3FUyBVHf1JQDHeQMdavQqc+2A@mail.gmail.com>
 <20200220055024.fgh2uxje6yanrshh@vireshk-i7>
Message-ID: <CAEemH2ft=SJQzoY9yHYUpLyYXGpciWOowHM=yn-PO1cHo5=bUQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 20, 2020 at 1:50 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> On 20-02-20, 13:41, Li Wang wrote:
> > > +       TEST(fsconfig(fd, FSCONFIG_SET_PATH, "foo", tst_device->dev,
> > > AT_FDCWD));
> > > +       if (TST_RET == -1) {
> > > +               if (TST_ERR == EOPNOTSUPP) {
> > > +                       tst_res(TINFO, "fsconfig(): FSCONFIG_SET_PATH
> not
> > > supported");
>
> On my ARM setup, I always hit this path for few of the syscalls :(
>
> > > +               } else {
> > > +                       tst_res(TFAIL | TERRNO, "fsconfig() failed");
> > >
> >
> > The test reports an EINVAL error when testing fsconfig() with
> > 'FSCONFIG_SET_PATH' on XFS. I'm now trying to look close to this issue.
> >
> > kernel: 5.6.0-rc2+ x86_64
> >
> > tst_test.c:1278: INFO: Testing on xfs
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
> > fsconfig01.c:46: FAIL: fsconfig() failed: EINVAL (22)
>
> Both "foo" and tst_device->dev may be wrong here unfortunately. Same
> for few other commands like: _PATH, _PATH_EMPTY, _FD..
>

If the parameter '_key' is replaced by 'ro' or 'rw', then the test always
gets passed, the same behavior occurred in fspick01 too.

I'm not sure if the usage is correct for fsconfig(), it'd be great if FS
guys could give advice.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/d12ad1c0/attachment.htm>
