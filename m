From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 15 Jul 2020 15:40:52 -0400
Subject: [LTP] [PATCH 1/2] IMA: Verify that the kernel cmdline is passed
 and measured correctly through the kexec barrier.
In-Reply-To: <53323968-55b9-68ae-dc3f-de9cbd223ff1@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <1594774692.12900.220.camel@linux.ibm.com>
 <53323968-55b9-68ae-dc3f-de9cbd223ff1@linux.microsoft.com>
Message-ID: <1594842052.12900.337.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-07-15 at 15:38 -0400, Lachlan Sneff wrote:
> On 7/14/20 8:58 PM, Mimi Zohar wrote:
> > On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> >> Add a testcase that verifies that kexec correctly logs the
> >> kernel command line to the IMA buffer and that the command
> >> line is then correctly measured.
> >>
> >> This test must be run standalone, since it runs kexec
> >> multiple times (and therefore reboots several times).
> > Verifying the kexec boot command line doesn't require rebooting. ?Just
> > loading the kexec kernel image should be enough (kexec -s -l).
> >  ?Verifying that the measurement list, including the kexec boot command
> > line, is carried across kexec could be a separate test.
> 
> This is true. However, it only appends to the IMA log once, even if you 
> unload (`kexec -u`) the kexec kernel after `kexec -s -l ...`.
> 
> Therefore, the test would only be able to check kexec with the cmdline 
> supplied in one way.
> 
> I will have to check internally if that's the right way to go. If it 
> didn't need to reboot, then the test could be integrated into the normal 
> IMA tests,
> which would definitely be a good thing.

For files, there is a single measurement unless the file changes.  I
would assume that would be the same for the kexec command line as
well. ?You could modify the command line a bit to force it to be re-
measured.

Mimi
