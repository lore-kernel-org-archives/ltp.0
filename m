From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2020 15:24:20 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <20200102125759.GE32710@rei.lan>
References: <20200102015236.7400-1-liwang@redhat.com>
 <20200102125759.GE32710@rei.lan>
Message-ID: <CAEemH2fdY_pPjNCEFmcd_zsye4HAciPuhF+Fiyde9WmBci=+Lg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Thu, Jan 2, 2020 at 8:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > To avoid FS deferred IO metadata/cache interferes test result, so we
> > do sync simply before the tst_dev_bytes_written invocation.
>
> Can we do fsync() on the fd instead of full sync()? That should be
> slightly faster.
>

Probably you miss the previous discussed [1], we use sync() here because we
do want to make sure all FS metadata/cache being written back before the
testing since there is no obtainable file descriptor 'fd' for the ext4
deferred IO (e.g. initialize the journal and inode tables).

If I was wrong here, feel free to correct me.

[1] http://lists.linux.it/pipermail/ltp/2019-December/014792.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200103/afa5ca78/attachment.htm>
