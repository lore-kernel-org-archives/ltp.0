From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Aug 2020 14:23:48 +0200
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
Message-ID: <20200821122348.GA31841@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cixi,

> Hi ALL:

> I want to add a reboot function in LTP for my team write a memory page
> related case?
> and need reboot to make the memory cache or some likely it pure clear.

> So I want to add a tst_needs_reboot. when it was set, reboot the
> machine and continue
> run test from the point before.

> I think  this requirement is meaningful? So can you give me some advise?

IMHO setup for reboot has been usually handled outside of LTP (in frameworks
which use LTP), because without any more capable runner [*] reboot would just
stop testing. I'm not saying it's not possible, but requires more thinking. At
least I'd add some variable which would prevent boot (and thus tst_brk TCONF
would be issued for this test).

I wonder what other think about it.

Kind regards,
Petr

[*] runltp is dead, but even Cyril's not yet upstreamed runltp-ng [1] and other
plans [2] does not handle reboot either. It'd have to be some service which can
pick-up the state.

[1] https://github.com/metan-ucw/runltp-ng
[2] https://people.kernel.org/metan/towards-parallel-kernel-test-runs
