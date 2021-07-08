From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jul 2021 14:36:38 +0800
Subject: [LTP] [PATCH v2 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <CAEemH2dRgd8m0Wtuw=QF0rH8SqOvQ11aTzi6O227q-PYQOYL4w@mail.gmail.com>
References: <20210705082527.855688-1-liwang@redhat.com> <YOV0bemK+1NI0Cz4@yuki>
 <CAEemH2dRgd8m0Wtuw=QF0rH8SqOvQ11aTzi6O227q-PYQOYL4w@mail.gmail.com>
Message-ID: <CAEemH2eEMMX6CC6-RF+q93bAxv8GMN7LcwZeBtAydsAnys+79g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 8, 2021 at 10:50 AM Li Wang <liwang@redhat.com> wrote:

> Cyril Hrubis <chrubis@suse.cz> wrote:
>
>
>>
>> > +static char *limit_tmpfs_mount_size(const char *mnt_data,
>> > +                     char *buf, size_t buf_size, const char *fs_type)
>> > +{
>> > +     int fd;
>> > +     uint64_t dev_size;
>> > +
>> > +     if (strcmp(fs_type, "tmpfs"))
>> > +             return mnt_data;
>> > +
>> > +     fd = SAFE_OPEN(tdev.dev, O_RDONLY);
>> > +     SAFE_IOCTL(fd, BLKGETSIZE64, &dev_size);
>> > +     SAFE_CLOSE(fd);
>>
>> We can as well add size to the struct tst_device and fill it in when
>> device is created, that would be a slightly cleaner solution.
>>
>
>
> That should be fine. But I'm afraid we have to change the return type
> for many functions in tst_device.c, because currently most of them
> only return a path to the test device. And that will affect more tests.
>
> Or, maybe just create a function to get the device size and pass it
> to tdev.size simply?
>

With adding new field 'size' in struct tst_device, I'm also planning
to extract that from tst_acquire_device__ and export it as a global
function:
    uint64_t tst_get_device_size(const char *dev_path);

then reuse of it to get block device size in more places, like:
     tdev.size = tst_get_device_size(tdev.dev);   <-- in prepare_device
and
      ltp_dev_size = tst_get_device_size(dev);   <-- in tst_acquire_device__
That would keep most of the function API no change and save
the tdev.size. Is this way OK, or any else?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/f5cb6423/attachment.htm>
