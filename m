From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jun 2018 14:37:02 +0800
Subject: [LTP] [PATCH] swapon: commit swapfile caches to disk
In-Reply-To: <CAEemH2cyoZB__UCyPGEb3Afo_UtqkdP2Au-NWSX8SCTjPcvMfQ@mail.gmail.com>
References: <1528806239-14297-1-git-send-email-liwang@redhat.com>
 <1468267167.25962192.1528808172867.JavaMail.zimbra@redhat.com>
 <CAEemH2cyoZB__UCyPGEb3Afo_UtqkdP2Au-NWSX8SCTjPcvMfQ@mail.gmail.com>
Message-ID: <CAEemH2ebuneSDNF=Zc-ZEFW2+NCHNZ6E2_N29ufjB6pjcER7pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 12, 2018 at 9:12 PM, Li Wang <liwang@redhat.com> wrote:
>
>
>
> On Tue, Jun 12, 2018 at 8:56 PM, Jan Stancek <jstancek@redhat.com> wrote:
>>
>>
>> ----- Original Message -----
>> > Testcase include swapon(8) fails on mainline kernel-v4.17+ as:
>> >   swapon01    1  TFAIL  :  swapon01.c:47: Failed to turn on swapfile:
>> >   TEST_ERRNO=EINVAL(22): Invalid argument
>> >   swapon02    4  TFAIL  :  swapon02.c:91: swapon(2) failed to produce
>> >   expected error: 16, errno: EBUSY and got 22.
>> >   swapon03    1  TFAIL  :  swapon03.c:243: Failed to setup swaps
>> >   swapoff01   1  TBROK  :  swapoff01.c:64: Failed to turn on the swap file,
>> >   skipping test iteration
>> >
>> > And dmesg shows that:
>> >   [  128.698981] swapon: file is not committed
>> >
>> > The error located in IOMAP_F_DIRTY(linux/fs/iomap.c) checking, which means
>> > this swapfile have uncommitted metadata in caches. After adding sync() to
>> > the end of all mkswap opertaion, these errors were gone.
>> >
>> > linux/fs/iomap.c:
>> >       static loff_t iomap_swapfile_activate_actor(
>> >               struct inode *inode,
>> >               loff_t pos,
>> >               loff_t count,
>> >               void *data,
>> >               struct iomap *iomap)
>> >       {
>> >               struct iomap_swapfile_info *isi = data;
>> >               int error;
>> >               ...
>> >
>> >               /* No uncommitted metadata or shared blocks. */
>> >               if (iomap->flags & IOMAP_F_DIRTY) {
>> >                       pr_err("swapon: file is not committed\n");
>> >                       return -EINVAL;
>> >               }
>> >               ...
>> >       }
>> >                                                                       }
>> > Signed-off-by: Li Wang <liwang@redhat.com>
>> > ---
>> >
>> > Notes:
>> >     The new changes about swapfile activation function were merged in
>> >     kernel-4.17
>> >     recently, so we didn't hit this failures before.
>>
>> Comment/code in mkswap, that has been present for years:
>>         /*
>>          * A subsequent swapon() will fail if the signature
>>          * is not actually on disk. (This is a kernel bug.)
>>          * The fsync() in close_fd() will take care of writing.
>>          */
>>
>> I'm assuming your mkswap is recent enough. Any idea why fsync()
>> in mkswap is no longer enough?
>
>
>
> Good catch, Jan. It sounds like a mkswap/fsync issue.

I looked into this issue today. It seems like a new kernel bug which
has been fixed by commit 117a148ffe0 (iomap: fsync swap files before
iterating mappings) in linus tree.

------------------
Simple steps to reproduce that:

# dd if=/dev/zero of=swapfile01 bs=2048 count=1024
1024+0 records in
1024+0 records out
2097152 bytes (2.1 MB) copied, 0.00408662 s, 513 MB/s

# mkswap swapfile01
Setting up swapspace version 1, size = 2044 KiB
no label, UUID=17830401-9cf2-4143-88a8-5a89c0b2d01d

# chmod 600 swapfile01

# swapon swapfile01
swapon: swapfile01: swapon failed: Invalid argument

Checking dmesg and get the root cause is swapfile01 have uncommitted
metadata in caches:
    [  128.698981] swapon: file is not committed

Then, I tracking the __x64_sys_swapon function calltrace on my bad kernel:

xfs_iomap_swapfile_activate [xfs]() {
  iomap_swapfile_activate() {
    filemap_write_and_wait() {   <===== [1]
      mapping_needs_writeback();
      __filemap_fdatawrite_range() {
        _raw_spin_lock();
        wbc_attach_and_unlock_inode();
        do_writepages() {
          xfs_vm_writepages [xfs]() {
            _raw_spin_lock();
            write_cache_pages() {
              tag_pages_for_writeback() {
                _raw_spin_lock_irq();
              }
              pagevec_lookup_range_tag() {
                find_get_pages_range_tag();
              }
            }
          }
        }
        wbc_detach_inode();
      }

Noticed [1] was being replaced by "ret = vfs_fsync(swap_file, 1);" in
the kernel commit 117a148ff. And this change works fine to me.

But I still have a query as Jan mentioned that, the command mkswap has
already done the write-back action via fsync() in close_fd(). Why we
have to do this fsync() again in kernel side and then have effect to
swapfile?

$ tail util-linux/disk-utils/mkswap.c
#endif
/*
* A subsequent swapon() will fail if the signature
* is not actually on disk. (This is a kernel bug.)
* The fsync() in close_fd() will take care of writing.
*/
if (close_fd(ctl.fd) != 0)
err(EXIT_FAILURE, _("write failed"));
return EXIT_SUCCESS;
}

$ tail -12 util-linux/disk-utils/include/closestream.h
static inline int
close_fd(int fd)
{
const int fsync_fail = (fsync(fd) != 0);
const int close_fail = (close(fd) != 0);

if (fsync_fail || close_fail)
return EOF;
return 0;
}

#endif /* UTIL_LINUX_CLOSESTREAM_H */

--------------

Anyway, this is not a LTP issue, so plz ignore my previous patch.

Thanks,
Li Wang
