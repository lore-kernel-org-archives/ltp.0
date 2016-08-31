From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2016 17:12:18 +0800
Subject: [LTP] [PATCH v3 1/2] test.sh: make the loop device size can be
	increased
In-Reply-To: <20160830133443.GB23854@rei.lan>
References: <1471525749-18509-1-git-send-email-liwang@redhat.com>
 <20160822171854.GA22470@rei>
 <CAEemH2eD2L49XGtPJd72FbyOg9RbgQwzNFyBYJPSpY3zyAZJrg@mail.gmail.com>
 <20160830133443.GB23854@rei.lan>
Message-ID: <CAEemH2cnQHghMHJfUakZ9kBkA=YL7Jq+CxQi2mPxx6hUN977nA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks for your opinion. From myself testing, a little problem was
found in this patch.

On Tue, Aug 30, 2016 at 9:34 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> I'm now hesitating whether we should keep tst_device.c as same as the
>> shell? although we don't need it for a while.
>
> I do not care that much either way.
>
>> Which something like:
>>
>> const char *tst_acquire_device(void (cleanup_fn)(void), int size)
>> {
>>     int acq_dev_size;
>>     long long ltp_dev_size;
>>     char *dev;
>>     struct stat st;
>>
>>     if (size > 0)
>>         acq_dev_size = size;
>>     else
>>         acq_dev_size = 150;
>
> size = size > 0 ? size : 150;
>
> is a bit shorter.
>
>>     if (device_acquired)
>>         tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
>>
>>     if (!tst_tmpdir_created()) {
>>         tst_brkm(TBROK, cleanup_fn,
>>                  "Cannot acquire device without tmpdir() created");
>>     }
>>
>>     dev = getenv("LTP_DEV");
>>
>>     if (dev) {
>>         tst_resm(TINFO, "Using test device LTP_DEV='%s'", dev);
>>
>>         SAFE_STAT(cleanup_fn, dev, &st);
>>
>>         if (!S_ISBLK(st.st_mode)) {
>>             tst_brkm(TBROK, cleanup_fn,
>>                     "%s is not a block device", dev);
>>         }
>>
>>         ltp_dev_size = (int)st.st_size/1024/1024;

Seems like stat(); can not get the block device size correctly. I
tried many times but always failed with "st.st_size = 0" here. So I
have to use ioctl(); for replacement.

...
               fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
               SAFE_IOCTL(cleanup_fn, fd, BLKGETSIZE64, &ltp_dev_size);
               SAFE_CLOSE(cleanup_fn, fd);
               ltp_dev_size = ltp_dev_size/1024/1024;
...

See:
http://www.microhowto.info/howto/get_the_size_of_a_linux_block_special_device_in_c.html

>>
>>         if (acq_dev_size <= ltp_dev_size) {
>>             if (tst_fill_file(dev, 0, 1024, 512)) {
>>                 tst_brkm(TBROK | TERRNO, cleanup_fn,
>>                     "Failed to clear the first 512k of %s", dev);
>>             }
>>
>>             return dev;
>>         }
>
>         We should print here that the LTP_DEV was skipped
>         because it was too small. Something as:
>
>         tst_resm(TINFO, "Skipping $LTP_DEV size %dMB, requested size %dMB",
>                  ltp_dev_size, size);
>
>         Otherwise it would look like the $LTP_DEV was used from the test
>         log.
>
>>     }
>>
>>     if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
>>         tst_brkm(TBROK | TERRNO, cleanup_fn,
>>                  "Failed to create " DEV_FILE);
>>
>>     }
>>
>>     if (find_free_loopdev())
>>         return NULL;
>>
>>     attach_device(cleanup_fn, dev_path, DEV_FILE);
>>
>>     device_acquired = 1;
>>
>>     return dev_path;
>> }
>
> Otherwise this looks fine.

Thanks, Patch V4 is coming.



-- 
Regards,
Li Wang
Email: liwang@redhat.com
