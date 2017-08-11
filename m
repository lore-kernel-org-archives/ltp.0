From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Aug 2017 07:26:06 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] syscalls/pselect: Add a zero
	latency	constraint
In-Reply-To: <ad947ee0-ee2a-840a-b9ac-74170d0ec7f3@linaro.org>
References: <1502352088-10136-1-git-send-email-daniel.lezcano@linaro.org>
 <1502352088-10136-2-git-send-email-daniel.lezcano@linaro.org>
 <1cbcc5dd-e060-94df-982e-198b3b342ec6@redhat.com>
 <ad947ee0-ee2a-840a-b9ac-74170d0ec7f3@linaro.org>
Message-ID: <1217268944.70548669.1502450766723.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 10/08/2017 13:50, Jiri Jaburek wrote:
> > On 08/10/17 10:01, Daniel Lezcano wrote:
> >> The pselect_01 testcase works well on an x86 as it is a fast platform,
> >> with
> >> fast exit latency idle routine.
> >>
> >> However on ARM[64] the idle routine can take much more time, for example
> >> 1500us.
> >>
> >> The pselect fails on the ARM[64] platforms because of these slow exit
> >> latencies,
> >> the delay between the expected expiration and the observed one is not
> >> acceptable.
> >>
> >> The fix could be to increase the deviation on ARM64 but that wouldn't make
> >> sense as some platforms, for the same architecture, can have faster or
> >> different delays, hence we can potentially miss a bug.
> >>
> >> The simplest solution is to set the cpu_dma latency constraint to zero, so
> >> the
> >> idle driver will always choose the fastest idle state, thus fixing the
> >> issue
> >> above. The latency constraint will apply only for this test.
> > 
> > I think a more generic LTP-wide solution could be made; there are more
> > tests that fail ie. on virtualized environments because of CPU over-
> > provisioning on the host (x86, s390, ppc, etc.)
> 
> Not sure a latency constraint will fix the above.

We could detect bare-metal / (some [1]) virt and adjust threshold
for timer tests, but I'm assuming Daniel sees this on bare metal,
so this patch would be useful anyway.

[1] kvm/xen is easy to detect, lpars might be more tricky

Regards,
Jan
