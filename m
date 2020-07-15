From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jul 2020 10:03:44 +0200
Subject: [LTP] [PATCH 1/2] IMA: Verify that the kernel cmdline is passed
 and measured correctly through the kexec barrier.
In-Reply-To: <1594774692.12900.220.camel@linux.ibm.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <1594774692.12900.220.camel@linux.ibm.com>
Message-ID: <20200715080344.GA10916@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> > Add a testcase that verifies that kexec correctly logs the
> > kernel command line to the IMA buffer and that the command
> > line is then correctly measured.

> > This test must be run standalone, since it runs kexec
> > multiple times (and therefore reboots several times).

> Verifying the kexec boot command line doesn't require rebooting. ?Just
> loading the kexec kernel image should be enough (kexec -s -l).
> ?Verifying that the measurement list, including the kexec boot command
> line, is carried across kexec could be a separate test.
Mimi, thanks for a confirmation.
Lachlan, so is it possible to turn it as a normal LTP test? And the test looks
like IMA specific now, thus I'd move it into IMA tests.

I'll post some comments to the test itself.

Kind regards,
Petr
