From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Aug 2020 16:41:02 -0700
Subject: [LTP] [PATCH v2 1/3] hotplug/memory_hotplug: Handle NULL
 returned by strtok_r when parsing inputs
In-Reply-To: <CAEemH2dxX2-t7S0TN3p7=zMLY_=TquSZdKUgqDRE9fpg_t8hdA@mail.gmail.com>
References: <20200811180604.4073173-1-aiden.gaoyuan@gmail.com>
 <CAEemH2dxX2-t7S0TN3p7=zMLY_=TquSZdKUgqDRE9fpg_t8hdA@mail.gmail.com>
Message-ID: <CAJuCfpH_Y6HwtZAiNLzBAf7q7MPjJe2UBchdthMkSc9v0SQ6bg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

On Thu, Aug 20, 2020 at 2:16 AM Li Wang <liwang@redhat.com> wrote:
>
> Hi Yuan,
>
> Thanks for contributing to the memory-hotplug test. I have no objection to these patches, but it seems quite a long time(since it imported to LTP from Linux foundation at the year 2008) nobody actually touches this memtoy except some code cleanup work.
>
> I'm wondering whether you guys play with the memtoy regularly? and how do you use it?

We did use memtoy to run memory experiments on Android (required some
minor tweaks to be able to build on Android). After Yuan's fixes we
were able to use it quite successfully.

>
> I take a rough look at the README file but got nothing useful to get a start.

You can see one of the scripts Yuan developed to ramp up memory
allocations of a given type (anon/file-backed/ion) using memtoy here:
https://android-review.googlesource.com/c/platform/external/ltp/+/1344879/44/testcases/kernel/hotplug/memory_hotplug/Scripts/ramp.sh
The usage is currently for experimentation only but we find it pretty
handy and we would like to keep using it in the future.
Thanks,
Suren.

>
> --
> Regards,
> Li Wang
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
