From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 4 Nov 2019 17:30:33 +0100
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E9-rc1-dfe283e=2Ecki_=28stable=29?=
In-Reply-To: <251943262.10356408.1572881121044.JavaMail.zimbra@redhat.com>
References: <cki.1210A7ECB0.BD9Q3APV4K@redhat.com>
 <2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com>
 <20191104135135.GA2162401@kroah.com>
 <1341418315.10342806.1572877690830.JavaMail.zimbra@redhat.com>
 <20191104145947.GA2211991@kroah.com>
 <251943262.10356408.1572881121044.JavaMail.zimbra@redhat.com>
Message-ID: <20191104163033.GB2253150@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 04, 2019 at 10:25:21AM -0500, Jan Stancek wrote:
> 
> ----- Original Message -----
> > On Mon, Nov 04, 2019 at 09:28:10AM -0500, Jan Stancek wrote:
> > > 
> > > 
> > > ----- Original Message -----
> > > > On Mon, Nov 04, 2019 at 08:35:51AM -0500, Jan Stancek wrote:
> > > > > 
> > > > > 
> > > > > ----- Original Message -----
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > We ran automated tests on a recent commit from this kernel tree:
> > > > > > 
> > > > > >        Kernel repo:
> > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > > > >             Commit: dfe283e9fdac - Linux 5.3.9-rc1
> > > > > > 
> > > > > > The results of these automated tests are provided below.
> > > > > > 
> > > > > >     Overall result: FAILED (see details below)
> > > > > >              Merge: OK
> > > > > >            Compile: OK
> > > > > >              Tests: FAILED
> > > > > > 
> > > > > > All kernel binaries, config files, and logs are available for
> > > > > > download
> > > > > > here:
> > > > > > 
> > > > > >   https://artifacts.cki-project.org/pipelines/262380
> > > > > > 
> > > > > > One or more kernel tests failed:
> > > > > > 
> > > > > >     x86_64:
> > > > > >      ? LTP lite
> > > > > >
> > > > > 
> > > > > Not a 5.3 -stable regression.
> > > > > 
> > > > > Failure comes from test that sanity checks all /proc files by doing
> > > > > 1k read from each. There are couple issues it hits wrt. snd_hda_*.
> > > > > 
> > > > > Example reproducer:
> > > > >   dd if=/sys/kernel/debug/regmap/hdaudioC0D3-hdaudio/access of=out.txt
> > > > >   count=1 bs=1024 iflag=nonblock
> > > > 
> > > > That's not a proc file :)
> > > 
> > > Right. It's same test that's used for /proc too.
> > > 
> > > > 
> > > > > It's slow and triggers soft lockups [1]. And it also requires lot
> > > > > of memory, triggering OOMs on smaller VMs:
> > > > > 0x0000000024f0437b-0x000000001a32b1c8 1073745920 seq_read+0x131/0x400
> > > > > pages=262144 vmalloc vpages N0=262144
> > > > > 
> > > > > I'm leaning towards skipping all regmap entries in this test.
> > > > > Comments are welcomed.
> > > > 
> > > > Randomly poking around in debugfs is a sure way to cause crashes and
> > > > major problems.  Also, debugfs files are NOT stable and only for
> > > > debugging and should never be enabled on "real" systems.
> > > > 
> > > > So what exactly is the test trying to do here?
> > > 
> > > It's (unprivileged) user trying to open/read anything it can (/proc, /sys)
> > > to see if that triggers anything bad.
> > > 
> > > It can run as privileged user too, which was the case above.
> > 
> > Sure, you can do tons of bad things as root poking around in sysfs,
> > debugfs, and procfs.  What exactly are you trying to do, break the
> > system?
> 
> We are talking about read-only here. Is it unreasonable to expect
> that root can read all /proc entries without crashing the system?

You are NOT reading /proc/ here.  You are reading debugfs which you
really have NOT idea what is in there.  As you saw, you are reading from
hardware that is slow and doing odd things when you read from it.

And yes, there are some /proc/ files that you should not read from as
root and expect things to always work.  PCI devices are notorious for
this, and if you are reading those files as root, you "know" you know
what you are doing and can accept the risk for when things go wrong.

It is fine to write tests to read specific /proc/ files that you know
what is happening in them.  To pick random ones is never a good idea.

thanks,

greg k-h
