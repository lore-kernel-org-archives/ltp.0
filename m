From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jan 2021 08:36:40 +0100
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <8735ytzbj4.fsf@oc8242746057.ibm.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com> <YAgmPjaf8iRn20x2@pevik>
 <8735ytzbj4.fsf@oc8242746057.ibm.com>
Message-ID: <YAqAiB3fQwVAKHFF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex,

> Hi Petr,
> Date: Fri, 22 Jan 2021 08:16:41 +0100
> Message-ID: <874kj9zbja.fsf@oc8242746057.ibm.com>
> X-Trend-IP-HD: ip=[9.171.79.240]sender=(egorenar@linux.ibm.com)recipient=<ltp@lists.linux.it;liwang@redhat.com;pvorel@suse.cz>

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Alexander, Li,

> > First I found quite hard to have correct setup to avoid TCONF "Not enough swap
> > space to test". It often requires to add additional swap file via mkswap && swapon
> > and use some RAM with:

> > dd if=/dev/zero of=/dev/shm/fill bs=1k count=14024k

> > It'd be great if test could do required setup itself.
> > And it'd also help at least to print swap_free_init and mem_over_max in that TCONF:

> >         if (swap_free_init < mem_over_max)
> > -               tst_brk(TCONF, "Not enough swap space to test.");
> > +               tst_brk(TCONF, "Not enough swap space to test (%ld < %ld)", swap_free_init, mem_over_max);


> yeah, that was a problem for me too when i was new to this test :/
:)


> > I tried to debug swapping01 on s390x (without this patch) with using additional
> > swap and eat RAM with dd. and got bus error (core dumped). Is that due too
> > aggressive memory eating? I'm not able to crash it on intel arch.


> that's something new for me. If possible please run it in gdb with debug symbols
> to find out where exactly this signal is raised.
I'll do.

Kind regards,
Petr

> Regards
> Alex
