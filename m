From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Aug 2016 09:15:49 -0400 (EDT)
Subject: [LTP] [PATCH] tst_virt: Make use of systemd-detect-virt if
	available
In-Reply-To: <20160818123809.GA26650@rei.suse.cz>
References: <20160818123809.GA26650@rei.suse.cz>
Message-ID: <1783998347.724638.1471526149366.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Thursday, 18 August, 2016 2:38:09 PM
> Subject: [PATCH] tst_virt: Make use of systemd-detect-virt if available
> 
> The problem is that there is no defined way to detect if we are inside
> of a virtual machine, only bunch of heuristics. If you look at the
> src/basic/virt.c in systemd source code it's ~500 lines of code that
> tries many different things to try to guess if we are running
> virtualized and under what hypervisor.
> 
> Currenlty LTP fails to detect KVM in OpenStack Cloud (and possibly many
> more) since the /proc/cpuinfo does not contain the QEMU string there.

I noticed the same in some RHEL KVM guests.

> You can also boot QEMU with non-default -cpu option and you will get the
> same result.
> 
> The easiest solution is to try the systemd-detect-virt first if it
> exists, then we fall back to the previously implemented detections for
> older distributions. This is not complete solution though, as the
> detection still fails with older and non-systemd distributions.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

We could also add a function that tries "virt-what", to increase our chances.
Anyway, I think it's good idea to not rely just on /proc/cpuinfo.

Regards,
Jan
