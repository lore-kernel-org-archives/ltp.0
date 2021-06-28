From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Jun 2021 10:42:48 +0800
Subject: [LTP] [PATCH] fix cpuhotplug04 check last cpu error
In-Reply-To: <20210628011538.10060-1-gouhao@uniontech.com>
References: <20210628011538.10060-1-gouhao@uniontech.com>
Message-ID: <CAEemH2f9Fo1rDo9dXWwYuUy2a8p6aF0L=wX1ciDGi2onZd032A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Hao,

On Mon, Jun 28, 2021 at 9:16 AM Gou Hao <gouhao@uniontech.com> wrote:

> From: gouhao <gouhao@uniontech.com>
>
>

> Cpuhotplug04 uses get_hotplug_cpus when traversing,
> get_hotplug_cpus will filter out cpu without online files,
> and $cpus_num will be used to determine the last cpu num?



>
> If some cpu do not have an online file,
> it will lead to an error in the judgment of the last cpu.
>

I'm wondering what kind of CPU does not have the online file, and which
kernel version is being used? Is that test machine an x86 or MIPS?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210628/fd406b00/attachment.htm>
