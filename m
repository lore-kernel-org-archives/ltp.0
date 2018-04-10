From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Apr 2018 12:21:15 +0200
Subject: [LTP] [RFC PATCH 1/8] lib/tst_test.c: mntpoint implies tmpdir
In-Reply-To: <5ACC87D9.2040205@cn.fujitsu.com>
References: <20180405140154.6218-1-chrubis@suse.cz>
 <20180405140154.6218-2-chrubis@suse.cz>
 <5ACC7CB0.2030100@cn.fujitsu.com> <20180410091417.GD23143@rei>
 <5ACC87D9.2040205@cn.fujitsu.com>
Message-ID: <20180410102115.GE23143@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ah, right, we do have the condition up there, but it does not work for
> > needs_rofs for example that utilizes mntpoint as well.
> >
> > So the correct patch should be:
> >
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 8be13327c..05ba95e2e 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -638,6 +638,7 @@ static int needs_tmpdir(void)
> >   {
> >          return tst_test->needs_tmpdir ||
> >                 tst_test->needs_device ||
> > +              tst_test->mntpoint ||
> >                 tst_test->resource_files ||
> >                 tst_test->needs_checkpoints;
> >   }
> >
> > Which will ensure that the test library will not create files outside of
> > the test temporary directory.
> Hi Cyril,
> 
> For needs_rofs flag, this patch looks good to me.
> 
> Besides, can we repalce needs_device with mount_device in needs_tmpdir() ?
> I think just needs_device flag needn't create a temporary directory(e.g. 
> ioctl06).

Actually we can't since unless user passes path to a real device via the
LTP_DEV env variable the loop device is backed by a temporary file that
has to be created somewhere. See the tst_device.c and the
tst_acquire_device__() function.

-- 
Cyril Hrubis
chrubis@suse.cz
