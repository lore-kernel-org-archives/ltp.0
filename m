From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 16:09:30 +0200
Subject: [LTP] [PATCH] tst_virt: Make use of systemd-detect-virt if
	available
In-Reply-To: <1783998347.724638.1471526149366.JavaMail.zimbra@redhat.com>
References: <20160818123809.GA26650@rei.suse.cz>
 <1783998347.724638.1471526149366.JavaMail.zimbra@redhat.com>
Message-ID: <20160825140930.GJ10490@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You can also boot QEMU with non-default -cpu option and you will get the
> > same result.
> > 
> > The easiest solution is to try the systemd-detect-virt first if it
> > exists, then we fall back to the previously implemented detections for
> > older distributions. This is not complete solution though, as the
> > detection still fails with older and non-systemd distributions.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> 
> We could also add a function that tries "virt-what", to increase our chances.
> Anyway, I think it's good idea to not rely just on /proc/cpuinfo.

Looking around virt-what does not seem to be installed by default on
anything I have here so it does not seem to add too much value. Feel
free to add it if you have a usecase.

Another option would be more or less copying what systemd-detect-virt
does, checking dmi, etc. But that is 500 lines of heuristics and
maintaining that would take take non-trivial amount of effort I would
rather like to spend on something more productive...

-- 
Cyril Hrubis
chrubis@suse.cz
