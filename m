From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Aug 2016 12:06:07 +0100
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <1476945951.10231924.1470047399416.JavaMail.zimbra@redhat.com>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
 <1476945951.10231924.1470047399416.JavaMail.zimbra@redhat.com>
Message-ID: <CAFEAcA8ntKfL=1rWz-3Qpc3Grj5Ru3tabc_8BrN9PJd3HFK8EA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1 August 2016 at 11:29, Jan Stancek <jstancek@redhat.com> wrote:
> ----- Original Message -----
>> From: "Peter Maydell" <peter.maydell@linaro.org>
>> Disclaimer: untested on PPC.
>
> I don't have such HW available at the moment, but I tested this
> on RHEL5.6/6.0/7.2 x86_64. RHEL5.6 exits with TCONF as expected.

Thanks. I gave the test case a quick spin on the gcc compile
farm's PPC64 box ("IBM POWER7 / 64 GB RAM / IBM Power 730 Express
server / Fedora 18"); the test passes OK, but on the other hand
it passes even if you hack out the cache ops entirely, so
either it's not the right PPC hardware to reveal the problem
or it only happens if you're thrashing the machine.

thanks
-- PMM
