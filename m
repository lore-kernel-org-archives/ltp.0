From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Aug 2018 14:53:03 +0200
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
References: <1533111474.1176.4.camel@mtkswgap22>
 <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
Message-ID: <20180801125302.GA25023@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void do_child(void)
> > +{
> > +       char *argv[2] = {TEST_FILE_PATH, NULL};
> > +       int fd;
> > +
> > +       SAFE_CP(TEST_APP, TEST_FILE_PATH);
> > +
> > +       fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
> > +       SAFE_UNLINK(TEST_FILE_PATH);
> > +
> > +       TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
> >
> 
> Shouldn't we handle EINVAL here? As the comment says from kernel-4.14,
> this case is expected to fail with EINVAL.

I already asked about this, apparently the syscall returns EINVAL when
the bug is hit, hence this would render the testcase useless.

So we decided to set minimal kernel version that has the call
implemented rather than handle EINVAL.

Well I guess that the best option would be trying execveat() before we
unlink the file and TCONF if we got EINVAL and proceed with the testing
otherwise...

-- 
Cyril Hrubis
chrubis@suse.cz
