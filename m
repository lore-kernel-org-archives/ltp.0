From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Mar 2021 17:07:54 +0800
Subject: [LTP] [PATCH 7/7] zram: Increase timeout according to used
 devices
In-Reply-To: <20210301220222.22705-8-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-8-pvorel@suse.cz>
Message-ID: <CAEemH2fiVoM+1DzFUv8BLntP3sPt7ijXrLg1c5iT03VdCKJfmw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 2, 2021 at 6:02 AM Petr Vorel <pvorel@suse.cz> wrote:

> to avoid unexpected timeout, which occurred even on just 4 zram devices.
>
> On my system where run with ext{2,3,4}, xfs, btrfs, vfat, exfat, ntfs
> it run for 12 min, i.e. mean 90s. Multiply by security constant 5,
> expecting 450 sec for each filesystem.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

Apart from the two places(patch 5/7, 6/7) that need tweaking/discussion,
the patches look good.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210302/d2d2695b/attachment.htm>
