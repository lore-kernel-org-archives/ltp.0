From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jul 2021 10:50:14 +0800
Subject: [LTP] [PATCH v2 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <YOV0bemK+1NI0Cz4@yuki>
References: <20210705082527.855688-1-liwang@redhat.com> <YOV0bemK+1NI0Cz4@yuki>
Message-ID: <CAEemH2dRgd8m0Wtuw=QF0rH8SqOvQ11aTzi6O227q-PYQOYL4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > +static char *limit_tmpfs_mount_size(const char *mnt_data,
> > +                     char *buf, size_t buf_size, const char *fs_type)
> > +{
> > +     int fd;
> > +     uint64_t dev_size;
> > +
> > +     if (strcmp(fs_type, "tmpfs"))
> > +             return mnt_data;
> > +
> > +     fd = SAFE_OPEN(tdev.dev, O_RDONLY);
> > +     SAFE_IOCTL(fd, BLKGETSIZE64, &dev_size);
> > +     SAFE_CLOSE(fd);
>
> We can as well add size to the struct tst_device and fill it in when
> device is created, that would be a slightly cleaner solution.
>


That should be fine. But I'm afraid we have to change the return type
for many functions in tst_device.c, because currently most of them
only return a path to the test device. And that will affect more tests.

Or, maybe just create a function to get the device size and pass it
to tdev.size simply?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/5ddf761e/attachment.htm>
