From: QI Fuli <fukuri.sai@gmail.com>
Date: Mon, 29 Mar 2021 23:08:23 +0900
Subject: [LTP] [PATCH 0/6] Convert syscalls/swap{on, off}/ to the new API
In-Reply-To: <CAEemH2dQPS+zhp0gEcTjPswjwX+csN72xbCuHzwW=ExcgUPKNQ@mail.gmail.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
 <CAEemH2dQPS+zhp0gEcTjPswjwX+csN72xbCuHzwW=ExcgUPKNQ@mail.gmail.com>
Message-ID: <A54D5F52-9E92-4372-A4C8-C6795F1B3AE6@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li Wang,

> On Mar 29, 2021, at 14:33, Li Wang <liwang@redhat.com> wrote:
> 
> Hi Fuli,
> 
> QI Fuli <fukuri.sai@gmail.com <mailto:fukuri.sai@gmail.com>> wrote:
> 
> From: QI Fuli <qi.fuli@fujitsu.com <mailto:qi.fuli@fujitsu.com>>
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
> I made some changes based on your patchset and pushed it.
> 
> * remove the libs/libltpswapon from patch 1/6
> * add [Description] in the comment to make ltp/docparse happy
> * fix some TTERRNO/TERRNO usage issues
> * code indent issue e.g. add brackets while more than two lines in if...else sentence
> 
> Btw, next time you can add '-v2' parameter when generating the second patch version.
> 
> `git format-patch -v2 -6 ...`

Thank you very much for the help.

Best,
QI 

> 
> -- 
> Regards,
> Li Wang

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/c79f51b0/attachment-0001.htm>
