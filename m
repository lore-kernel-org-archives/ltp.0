From: Li Wang <liwang@redhat.com>
Date: Tue, 31 Dec 2019 15:32:19 +0800
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of
 write back
In-Reply-To: <d3baf4e5-66cb-6288-6742-0f7d1dc89090@cn.fujitsu.com>
References: <20191218082826.25083-1-liwang@redhat.com>
 <2104821569.17247635.1576661091375.JavaMail.zimbra@redhat.com>
 <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
 <CAEemH2eRhmozt5OiT6z-YBjJUBNaGZgQVQRh40hNpKcq2d4-aw@mail.gmail.com>
 <CAFA6WYOBbH8UbwrK1f3ZQjGuqHJqGZxhQ-N0w1mpBHz0bnPG1w@mail.gmail.com>
 <CAEemH2eXvZB9uCuZFsc2uMAt5k2F_gfgXCqch58juMsJn4Gr4w@mail.gmail.com>
 <CAEemH2coGZGjFLhHzeR4JJYWpERGypjRdXRQ2dO0f1=Drh2KOg@mail.gmail.com>
 <23f8d05b-efff-56ba-b5d8-f99046e5619c@cn.fujitsu.com>
 <CAEemH2dyHSS20Lf9neVfY6voN-EO60_MQdXjb0Xjy9VsDfbZwA@mail.gmail.com>
 <d3baf4e5-66cb-6288-6742-0f7d1dc89090@cn.fujitsu.com>
Message-ID: <CAEemH2fE=+6qi8P8wu6CDOkS1NOCWTTTmKeSBiRDWiu0qGhTOw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 31, 2019 at 3:05 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
> >>     I have tried this for many different systems, and it doesn't hit
> >>     the failure at least one time. So if no more comments, I would
> >>     merge the patch as below in the next step.
> >
> >     I have a question.we must call sync()? I think syncfs is more
> accurate.
> >
> >
> > Here we use sync() is to make fs metadata/cache being written back
> > before testing because there is no obtainable file descriptor 'fd' for
> > the ext4 deferred IO (e.g. initialize the journal and inode tables).
>


> I see. For other test cases using tst_dev_bytes_written api such as
> fdatasync03.c,  we also need to call sync() to make this written value
> more accurate.  What do you think about it?
>

Good point. I think we should take care of them as we do for
sync_file_range02 too. It will more easily report fail in the case of a
situation that synced data is less than expected.

$ git grep tst_dev_bytes_written
kernel/syscalls/fdatasync/fdatasync03.c:
 tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/fdatasync/fdatasync03.c:        written =
tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/fsync/fsync04.c:
 tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/fsync/fsync04.c:        written =
tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/sync/sync03.c:  tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/sync/sync03.c:  written =
tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/sync_file_range/sync_file_range02.c:
 tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/sync_file_range/sync_file_range02.c:    written =
tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/syncfs/syncfs01.c:
 tst_dev_bytes_written(tst_device->dev);
kernel/syscalls/syncfs/syncfs01.c:      written =
tst_dev_bytes_written(tst_device->dev);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191231/73f7871b/attachment.htm>
