From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 22 Jul 2020 09:16:57 -0700
Subject: [LTP] BUG at mm/vmalloc.c:3089! - invalid opcode: 0000 [#1] SMP
 KASAN PTI
In-Reply-To: <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
References: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
 <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
Message-ID: <CALvZod5cBTsytQz5=EbqT_s1_ZJ8YpkBe+CLEAU+25FP4kHSAg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 22, 2020 at 1:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Adding Roman Gushchin to Cc, he touched that code recently.
>
> Naresh, if nobody has any immediate ideas, you could double-check by
> reverting these commits:
>
> e0b8d00b7561 mm: memcg/percpu: per-memcg percpu memory statistics
> 99411af13595 mm/percpu: fix 'defined but not used' warning
> 9398ce6306b6 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix
> 54116d471779 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix
> ec518e090843 mm: memcg/percpu: account percpu memory to memory cgroups
> 9bc897d18dc3 percpu: return number of released bytes from pcpu_free_area()
>
>        Arnd
>

I think syzbot has bisected this issue to the suspect patch.

https://lore.kernel.org/lkml/00000000000043f09405ab01b0b8@google.com/
