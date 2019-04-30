From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Apr 2019 16:18:00 +0800
Subject: [LTP] [PATCH] OVL_MNT: put overlayfs lower, upper, work,
 mnt dir in separated mountpoint
In-Reply-To: <20190430043957.479-1-xzhou@redhat.com>
References: <20190430043957.479-1-xzhou@redhat.com>
Message-ID: <CAEemH2fX+8DhH56E0dmXxiX9FXb2i1VdF544y-AtxCPkEK+4uQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 30, 2019 at 12:40 PM Murphy Zhou <xzhou@redhat.com> wrote:

> Some tests are mounting overlayfs internally and run tests on it.
> This mount can fail if the filesystem we are running on does not
> support overlay mount upon it. For example, we are already running
> tests on overlayfs or NFS, or CIFS. Test will report broken and
> failure.
>
> Fixing this by put overlayfs dirs in a separaed mountpoint, like
> readahead02 by Amir.
>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

LGTM.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190430/d0fb3739/attachment.html>
