From: Li Wang <liwang@redhat.com>
Date: Sun, 11 Apr 2021 13:01:14 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <202103241726592002447@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <YBE03REJywKIlM0X@yuki.lan> <2021012718043566596022@chinatelecom.cn>
 <CAEemH2dA0T1F3wsdwtG2hsfDUUJsY8gFeTLTHyGz+pu034gH4g@mail.gmail.com>
 <202103051352110688245@chinatelecom.cn>
 <CAEemH2cW9djj3sN8j9Xj_A5iNB9DLhYYkK=nu8ypaOtiYMnLyw@mail.gmail.com>
 <202103241726592002447@chinatelecom.cn>
Message-ID: <CAEemH2cYTS1mEXR+2W8Fh_HtySj3gTmhfqmcmy4DZ4dG2S4o1w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

Seems this ioctl_sg01 problem is caused by the kernel commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c7829b04c523cdc732cb77f59f03320e09f3386

I start a new thread for tracking it in Linux-MM just now:
https://lists.linux.it/pipermail/ltp/2021-April/021903.html

liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn> wrote:

Hi Li Wang,
> I think your patch is good.
> 1.CommitLimit is the memory that can be allocated by application.
> 2.ioctl_sg01 in serveral machines with your patch,the result is passed.
>
>
Thank you Xinpeng,

That is just an eclectic workaround but not the key point of the OOM occurs
issue.
I'd not suggest merging my patch to LTP:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210411/44f80803/attachment.htm>
