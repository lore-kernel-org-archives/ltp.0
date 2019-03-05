From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2019 12:05:22 +0530
Subject: [LTP] [PATCH 1/2] syscalls/sync_file_range: add partial file
	sync test-case
In-Reply-To: <20190304144000.GA15696@rei>
References: <1551428901-30162-1-git-send-email-sumit.garg@linaro.org>
 <20190304144000.GA15696@rei>
Message-ID: <CAFA6WYOvjg_ujpyqhGNtrEHEDP-et4g7SU3cnWw_tRk=oUW-zw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 4 Mar 2019 at 20:10, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +static void verify_sync_partial_file(void)
> > +{
> > +     int fd;
> > +     unsigned long written;
> > +
> > +     fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
> > +
> > +     lseek(fd, FILE_SIZE/4, SEEK_SET);
> > +
> > +     tst_dev_bytes_written(tst_device->dev);
> > +
> > +     tst_fill_fd(fd, 0xff, TST_MB, FILE_SIZE_MB/2);
>
> Any reason why we don't do full FILE_SIZE_MB write here and then check
> that the result was somewhere between FILE_SIZE/2 +-10% ?
>

Don't have any compelling reason to not do full file write. So will
write whole file and test sync for particular portion of file
(FILE_SIZE/4 to 3*FILE_SIZE/4).

-Sumit

> Other than that the patch looks good.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
