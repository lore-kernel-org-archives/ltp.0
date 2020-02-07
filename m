From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Feb 2020 10:05:19 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <20200207081854.GU14282@dhcp-12-102.nay.redhat.com>
References: <20200206162722.18945-1-pvorel@suse.cz>
 <20200207081854.GU14282@dhcp-12-102.nay.redhat.com>
Message-ID: <20200207090519.GC8415@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zorro,

> > I implemented fixes for "newmount" Zorro's patch, hoping this is a final
> > version. Changes are minor, asked by Cyril + rename test to fsmount01,

BTW I forget to add v5 to be clear that it's a follow up of Zorro's v4 [1].

> Thanks so much!
You're welcome :). We thank you to finally start writing tests for new syscalls,
we need to test all new ones.

> I think I shouldn't ack a patch from myself. So I just ask a small question.
> I noticed that you decide to use the name as "syscalls/fsmount/fsmount01".
> I hope the "fsmount" is a general name, which doesn't mean fsmount() itself.
> Due to I might write other cases don't aim to test fsmount(). E.g.
> open_tree() and move_tree(). But I will name the name as fsmount?? . I hope
> that meets your expectation.
I chose fsmount as I agreed with Cyril [2] that fsmount() is the main syscall
tested (although your test is testing all of them). If you look in various tests
in LTP, they often use many syscalls, but just one of them is the main one (e.g.
testcases/kernel/syscalls/mount/mount0*.c and testcases/kernel/syscalls/umount2/umount2_0*.c
are using both mount() and umount()), but we always use real syscalls name.

So when you test specifically just open_tree(), use that name.
I was thinking whether to change this approach in current topic (new mount API
from v5.2), but IMHO from long term perspective people search for particular
tests names, so newmount would hide it. But we can always change it in the
future.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1224056/
[2] https://lists.linux.it/pipermail/ltp/2020-January/015068.html
