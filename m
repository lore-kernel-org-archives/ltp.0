From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Apr 2021 21:01:08 +0800
Subject: [LTP] [PATCH] mkfs: print more info for debugging
In-Reply-To: <728318760.8908748.1618921049585.JavaMail.zimbra@redhat.com>
References: <20210420075351.16059-1-liwang@redhat.com>
 <728318760.8908748.1618921049585.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fcEjre5xd1KuXsAkYzZG6tGaCttE8x3zbjxamVHfUUng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 20, 2021 at 8:17 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > We can NOT reproduce the problem by manual with both ppc64le and s390x,
> > so let's print more useful info from test when getting fail.
>
> It's mkfs_verify_size, test expects to find 90% blocks (of device size),
> but lately we miss that by ~1-2%:
>
> # mkfs.ext3 /dev/loop0 16000
> mke2fs 1.46.2 (28-Feb-2021)

Thanks for the info.

How reproducible of this issue, and which arch/platform you used?
Or, can you reproduce it with a downgrade e2fsprogs version?


> /dev/loop0 contains a ext3 file system
>         created on Fri Apr 16 05:09:23 2021
> Proceed anyway? (y,N) y
> Discarding device blocks: done
> Creating filesystem with 16000 1k blocks and 4000 inodes
> Filesystem UUID: d66c4c37-13ce-41df-b3c4-345ec1641e1f
> Superblock backups stored on blocks:
>         8193
>
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (1024 blocks): done
> Writing superblocks and filesystem accounting information: done
>
>  mount /dev/loop0  /mnt/test
> # df -T
> Filesystem                           Type      1K-blocks      Used  Available Use% Mounted on
> /dev/loop0                           ext3          14343        19      13524   1% /mnt/test
>
>
> >
> >  mkfs01 1 TPASS: 'mkfs -t ext4  /dev/loop0 ' passed.
> >  mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, not expected.
> >  mkfs01 3 TPASS: 'mkfs -t ext4 -c /dev/loop0 ' passed.
> >  mkfs01 4 TPASS: 'mkfs -V   ' passed.
> >  mkfs01 5 TPASS: 'mkfs -h   ' passed.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/commands/mkfs/mkfs01.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/commands/mkfs/mkfs01.sh
> > b/testcases/commands/mkfs/mkfs01.sh
> > index 90368190d..55296c8df 100755
> > --- a/testcases/commands/mkfs/mkfs01.sh
> > +++ b/testcases/commands/mkfs/mkfs01.sh
> > @@ -128,7 +128,8 @@ mkfs_test()
> >       if [ -n "$device" ]; then
> >               mkfs_verify_type "$fs_type" "$device"
> >               if [ $? -ne 0 ]; then
> > -                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
> > +                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected type."
> > +                     cat temp
> >                       return
> >               fi
> >       fi
> > @@ -136,7 +137,8 @@ mkfs_test()
> >       if [ -n "$size" ]; then
> >               mkfs_verify_size "$fs_type" "$size"
> >               if [ $? -ne 0 ]; then
> > -                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
> > +                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected size."
> > +                     cat temp
> >                       return
> >               fi
> >       fi
> > --
> > 2.30.2
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
>


-- 
Regards,
Li Wang

