From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Aug 2016 19:03:27 +0800
Subject: [LTP] [PATCH v3 1/2] test.sh: make the loop device size can be
	increased
In-Reply-To: <20160822171854.GA22470@rei>
References: <1471525749-18509-1-git-send-email-liwang@redhat.com>
 <20160822171854.GA22470@rei>
Message-ID: <CAEemH2eD2L49XGtPJd72FbyOg9RbgQwzNFyBYJPSpY3zyAZJrg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 23, 2016 at 1:18 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> This one looks fine.
>
> We should also update the test-writing-guidelines in this patch since

ok, I ll do that.

> the shell version has optional parameter now.

I'm now hesitating whether we should keep tst_device.c as same as the
shell? although we don't need it for a while.

Which something like:

const char *tst_acquire_device(void (cleanup_fn)(void), int size)
{
    int acq_dev_size;
    long long ltp_dev_size;
    char *dev;
    struct stat st;

    if (size > 0)
        acq_dev_size = size;
    else
        acq_dev_size = 150;

    if (device_acquired)
        tst_brkm(TBROK, cleanup_fn, "Device allready acquired");

    if (!tst_tmpdir_created()) {
        tst_brkm(TBROK, cleanup_fn,
                 "Cannot acquire device without tmpdir() created");
    }

    dev = getenv("LTP_DEV");

    if (dev) {
        tst_resm(TINFO, "Using test device LTP_DEV='%s'", dev);

        SAFE_STAT(cleanup_fn, dev, &st);

        if (!S_ISBLK(st.st_mode)) {
            tst_brkm(TBROK, cleanup_fn,
                    "%s is not a block device", dev);
        }

        ltp_dev_size = (int)st.st_size/1024/1024;

        if (acq_dev_size <= ltp_dev_size) {
            if (tst_fill_file(dev, 0, 1024, 512)) {
                tst_brkm(TBROK | TERRNO, cleanup_fn,
                    "Failed to clear the first 512k of %s", dev);
            }

            return dev;
        }
    }

    if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
        tst_brkm(TBROK | TERRNO, cleanup_fn,
                 "Failed to create " DEV_FILE);

    }

    if (find_free_loopdev())
        return NULL;

    attach_device(cleanup_fn, dev_path, DEV_FILE);

    device_acquired = 1;

    return dev_path;
}


-- 
Regards,
Li Wang
Email: liwang@redhat.com
