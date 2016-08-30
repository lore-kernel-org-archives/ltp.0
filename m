From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Aug 2016 15:34:44 +0200
Subject: [LTP] [PATCH v3 1/2] test.sh: make the loop device size can be
 increased
In-Reply-To: <CAEemH2eD2L49XGtPJd72FbyOg9RbgQwzNFyBYJPSpY3zyAZJrg@mail.gmail.com>
References: <1471525749-18509-1-git-send-email-liwang@redhat.com>
 <20160822171854.GA22470@rei>
 <CAEemH2eD2L49XGtPJd72FbyOg9RbgQwzNFyBYJPSpY3zyAZJrg@mail.gmail.com>
Message-ID: <20160830133443.GB23854@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm now hesitating whether we should keep tst_device.c as same as the
> shell? although we don't need it for a while.

I do not care that much either way.

> Which something like:
> 
> const char *tst_acquire_device(void (cleanup_fn)(void), int size)
> {
>     int acq_dev_size;
>     long long ltp_dev_size;
>     char *dev;
>     struct stat st;
> 
>     if (size > 0)
>         acq_dev_size = size;
>     else
>         acq_dev_size = 150;

size = size > 0 ? size : 150;

is a bit shorter.

>     if (device_acquired)
>         tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
> 
>     if (!tst_tmpdir_created()) {
>         tst_brkm(TBROK, cleanup_fn,
>                  "Cannot acquire device without tmpdir() created");
>     }
> 
>     dev = getenv("LTP_DEV");
> 
>     if (dev) {
>         tst_resm(TINFO, "Using test device LTP_DEV='%s'", dev);
>
>         SAFE_STAT(cleanup_fn, dev, &st);
> 
>         if (!S_ISBLK(st.st_mode)) {
>             tst_brkm(TBROK, cleanup_fn,
>                     "%s is not a block device", dev);
>         }
> 
>         ltp_dev_size = (int)st.st_size/1024/1024;
> 
>         if (acq_dev_size <= ltp_dev_size) {
>             if (tst_fill_file(dev, 0, 1024, 512)) {
>                 tst_brkm(TBROK | TERRNO, cleanup_fn,
>                     "Failed to clear the first 512k of %s", dev);
>             }
> 
>             return dev;
>         }

	We should print here that the LTP_DEV was skipped
	because it was too small. Something as:

	tst_resm(TINFO, "Skipping $LTP_DEV size %dMB, requested size %dMB",
	         ltp_dev_size, size);

	Otherwise it would look like the $LTP_DEV was used from the test
	log.

>     }
> 
>     if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
>         tst_brkm(TBROK | TERRNO, cleanup_fn,
>                  "Failed to create " DEV_FILE);
> 
>     }
> 
>     if (find_free_loopdev())
>         return NULL;
> 
>     attach_device(cleanup_fn, dev_path, DEV_FILE);
> 
>     device_acquired = 1;
> 
>     return dev_path;
> }

Otherwise this looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
