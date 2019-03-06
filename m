From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2019 12:18:58 +0530
Subject: [LTP] [PATCH v2 1/2] syscalls/sync_file_range: add partial file
	sync test-case
In-Reply-To: <20190305141903.GD13703@rei>
References: <1551770065-20444-1-git-send-email-sumit.garg@linaro.org>
 <20190305141903.GD13703@rei>
Message-ID: <CAFA6WYOPW0mkmGFbcZRmvhXsOJouUi1d-rcV_-sgKVKpkqSMSA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 5 Mar 2019 at 19:49, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +static void verify_sync_partial_file(void)
> > +{
> > +     int fd;
> > +     unsigned long written;
> > +
> > +     fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
> > +
> > +     tst_dev_bytes_written(tst_device->dev);
> > +
> > +     tst_fill_fd(fd, 0xff, TST_MB, FILE_SIZE_MB);
> > +
> > +     TEST(sync_file_range(fd, FILE_SIZE/4, FILE_SIZE/2,
> > +                          SYNC_FILE_RANGE_WAIT_BEFORE |
> > +                          SYNC_FILE_RANGE_WRITE |
> > +                          SYNC_FILE_RANGE_WAIT_AFTER));
> > +
> > +     if (TST_RET)
> > +             tst_brk(TFAIL | TTERRNO, "sync_file_range() failed");
> > +
> > +     written = tst_dev_bytes_written(tst_device->dev);
> > +
> > +     SAFE_CLOSE(fd);
> > +
> > +     if (written >= FILE_SIZE/2)
> > +             tst_res(TPASS, "Test file range synced to device");
> > +     else
> > +             tst_res(TFAIL, "Synced %li, expected %i", written,
> > +                     FILE_SIZE/2);
> > +}
>
>
> Looking at this the function is nearly the same as the other one, I
> guess that we may as well define the function as:
>
> static void verify_sync_file_range(off64_t off, off64_t size, char byte)
> {
>         ...
> }
>

Yeah it could be made common. But we may not be able to reuse it for
third case you mentioned below.

> Also I'm not sure I was clear enough, but I was suggesting to check for
> upper bound for the synced size as well, which is why I suggested to do
> full write, sync only part of it, then check that the size was within
> bounds, i.e. >= size and  <= size + epsilon.
>

Do you see any value add of upper bound check? AFAIK, device writes
continue in back-end and we might not be sure about appropriate value
for "epsilon".

> I guess that we can even extend this to call the sync over a range that
> has been only partially written, but for that we would have to be
> careful and make sure all the data has been either synced at the end of
> the test function or use a different file for each test.
>

I think using different file for each case looks more appropriate.

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
