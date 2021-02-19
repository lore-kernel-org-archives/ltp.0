From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Feb 2021 21:38:31 +0800
Subject: [LTP] [PATCH] openposix/fork/11-1.c: Clean up temporary file
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40386FA88@dggeml531-mbx.china.huawei.com>
References: <20210219050439.179039-1-zhaogongyi@huawei.com>
 <CAEemH2e75x8Jbc=ST5VQdg9i-nJDX8zDp=HCt3HaVhVxsVOA2Q@mail.gmail.com>
 <F3D3F6AC3820BB4C9FCA340DB5C32CB40386FA88@dggeml531-mbx.china.huawei.com>
Message-ID: <CAEemH2ch1-QTUgwz0zpUOWMLcrHkUiMp0UmSW0Mpnn=G0+ZKUw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 19, 2021 at 5:34 PM zhaogongyi <zhaogongyi@huawei.com> wrote:

> Hi Li,
>
>
>
> I think we need to delete the tempfile after the testing(in the cleanup
> phase).
>
>
>
> In this case, we just hope that call unlink after open/mkstemp since
> unlink would not destroy the inode,
>
>
>
> so call unlink before fork would not affect the test?
>

Right, but better to put behind of close(fd) that makes logic more clear.


>
> BTW, seems the child report a wrong status of the locked file, while
>
> fcntl(fd, F_SETLK, &fl) return -1 and sets errno to EACCES or EAGAIN,
>
> shouldn't that mean the file already been locked by the parent?
>

And what do u think about this?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210219/044cfd15/attachment.htm>
