From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Jun 2021 12:27:32 +0800
Subject: [LTP] [PATCH] fix cpuhotplug04 check last cpu error
In-Reply-To: <20210628115740.5da3dbfda1c263f95d66c77a@uniontech.com>
References: <20210628115740.5da3dbfda1c263f95d66c77a@uniontech.com>
Message-ID: <CAEemH2cMAEuf_Qx-UE8LFX_1zB6N=p=RzJUXr2+tLAFLHuqg9A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 28, 2021 at 11:58 AM <gouhao@uniontech.com> wrote:

> This change makes sense.
>
> On my computer, the last CPU can't be offline, which causes the execution
> of this testcase to fail.
>

But the CPU0 on your system will always online, so the last one should be
offline safely.
If it not, that might a kernel issue I guess.

>
> However, the testcase makes special treatment to the last CPU. If the last
> CPU cannot be offline, the execution result of the testcase should not be
> affected.
>

Yes, but from cpuhotplug04.sh comment line#84:

# If all the CPUs are hotpluggable, we expect
# that the kernel will refuse to offline the last CPU.
# If only some of the CPUs are hotpluggable,
# they all can be offlined.

How do you think of this description? In your system, it obviously belongs
to
the second scenario that the cpu0 is online and you should be able to
offline
all the remaining hotplugged one, isn't it?

>
> Therefore, if cpu0 does not have an online file, it will lead to an error
> in the judgment of the last CPU.
>

If cpu0 does not have an online file, that means the last CPU (hotplugged)
can be offline as well.
To verify this assumption, you can try manually offline CPU one by one,
this time I suggest you
try the last one first.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210628/2b93ddcf/attachment.htm>
