From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Mar 2021 13:33:30 +0800
Subject: [LTP] [PATCH 0/6] Convert syscalls/swap{on, off}/ to the new API
In-Reply-To: <20210327103226.99073-1-qi.fuli@fujitsu.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
Message-ID: <CAEemH2dQPS+zhp0gEcTjPswjwX+csN72xbCuHzwW=ExcgUPKNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Fuli,

QI Fuli <fukuri.sai@gmail.com> wrote:

From: QI Fuli <qi.fuli@fujitsu.com>
>
> Rename libs/libltpswapon libs/libltpswap and Convert it to the new API
> Convert syscalls/swap{on,off}/ to the new API
>
> QI Fuli (6):
>   libs/libltpswap: Add libs/libltpswap by using the new API
>   syscalls/swapon/swapon01: Convert swapon01 to the new API
>   syscalls/swapon/swapon02: Convert swapon02 to the new API
>   syscalls/swapon/swapon03: Convert swapon03 to the new API
>   syscalls/swapoff/swapoff01: Convert swapoff01 to the new API
>   syscalls/swapoff/swapoff02: Convert swapoff02 to the new API
>

I made some changes based on your patchset and pushed it.

* remove the libs/libltpswapon from patch 1/6
* add [Description] in the comment to make ltp/docparse happy
* fix some TTERRNO/TERRNO usage issues
* code indent issue e.g. add brackets while more than two lines in
if...else sentence

Btw, next time you can add '-v2' parameter when generating the second patch
version.

`git format-patch -v2 -6 ...`

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/3ad0518b/attachment.htm>
