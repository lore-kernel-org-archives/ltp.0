From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jul 2018 17:37:04 +0200
Subject: [LTP] [RFC] new LTP testrunner
In-Reply-To: <4457957.33743155.1531841330713.JavaMail.zimbra@redhat.com>
References: <20180717114328.GB27873@rei>
 <1174539544.33712886.1531838009077.JavaMail.zimbra@redhat.com>
 <20180717144555.GA22013@rei>
 <4457957.33743155.1531841330713.JavaMail.zimbra@redhat.com>
Message-ID: <20180717153704.GA24297@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It's there but not in the README, there is a sh backend that just runs
> > the tests in a localy executed shell see --help.
> > 
> > But I would like to discourage running the testcases locally for any
> > test automation/CI.
> 
> Can you elaborate? Assuming I don't crash, what is the negative
> of running locally?

We do have tests that invoke OOM as well in that case the test execution
framework may be hit as well. The filesystem tests can corrupt the fs we
are saving the logfiles and results to, etc.

This also means some of the tests cannot be really done at all, if the
testrunner is supposed to be running on a separate machine we can
possibly implement testcases for example for kexec, MCE, magic sysrq,
etc.

> > > The way we coped with (fatal) issues is pre-processing
> > > runtest files based on kernel version, package versions,
> > > architecture, etc.
> > 
> > This is something I wanted to avoid if possible because it requires to
> > maintain a database which time consuming and prone to errors.
> 
> True, but if you want to avoid wasting countless hours just
> on reboots due to known bugs, there probably isn't a better way.
> 
> This might not be big deal for VMs, but some bare metal
> takes its time to come up.

Well yes, some big servers take ages to boot, the VMs are quite fast to
reboot compared to that.

-- 
Cyril Hrubis
chrubis@suse.cz
