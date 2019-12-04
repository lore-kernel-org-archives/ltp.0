From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Dec 2019 11:46:55 +0100
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
In-Reply-To: <b4489aba-9f59-ff44-e2b3-3af6d9cd3cb1@suse.cz>
References: <20191128163147.4377-1-mdoucha@suse.cz>
 <20191202032936.GA32335@dell5510>
 <b4489aba-9f59-ff44-e2b3-3af6d9cd3cb1@suse.cz>
Message-ID: <20191204104655.GA3852@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > BTW at least ksm01 will fail on VM host with running VMs,
> > but that's another story not related to this patch.

> > mem.c:251: FAIL: pages_shared is not 1 but 3629.
> > mem.c:251: FAIL: pages_sharing is not 98302 but 113789.
> > mem.c:251: FAIL: pages_volatile is not 0 but 12.
> > mem.c:251: FAIL: pages_unshared is not 1 but 48519.

> I'm aware of other KSM tests failing but the failures are rare and quite
> random so they'll be tricky to debug. The snippet you've sent looks like
> interference from another process running on the same VM but the
> failures I see in OpenQA look like some sort of race condition in kernel
> itself.
Yep, my failures are for sure different. I run the test on my workstation
(KVM host), after start of about 15 VMs. Before test was ok.
I haven't tested, but it should be ok when running on KVM guests.

Kind regards,
Petr
