Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dyoung@redhat.com>) id 1XVzb8-000564-SV
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 09:07:54 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XVzb7-0002EV-NZ
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 09:07:54 +0000
Date: Mon, 22 Sep 2014 17:07:16 +0800
From: Dave Young <dyoung@redhat.com>
Message-ID: <20140922090716.GA23854@darkstar.nay.redhat.com>
References: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
	<293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [RFC] autokdump - automated kdump testsuite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, crash-utility <crash-utility@redhat.com>

Hi,

On 09/19/14 at 05:52am, CAI Qian wrote:
> I plan to release an automated kdump testsuite that will be
> focus on testing kernel and the crash utility. It should work
> for all major distros since it will use none of distro-specific
> stuff, and also support different arches including x86, ARM,
> PPC64 and s390x.

It's a good idea to create a kdump test project. Maybe you can consider to
test kexec as well.

> 
> It does the following:
> 1) check if there is a memory reserved for kdump. If not,
>    reserve the memory and reboot the system.
> 2) once the system is back, load kexec on panic and
>    prepare a separate initramfs that including needed
>    modules to load a local filesystem and necessary utilities
>    in order to analyse /proc/vmcore in the 2nd kernel.
> 3) trigger the system crash using methods like sysrq-c, NMI,
>    and panic_on_hung_task etc.
> 4) in the 2nd kernel, mount a filesystem and use the crash
>    utility to analyse /proc/vmcore. Then, gather the analyse
>    logs, serial console output, dmesg etc into the filesystem.
> 5) reboot back into the 1st kernel.
> 
> implementation:
> It will setup a daemon to handle reboots.
> 
> plan:
> I might also to test the makedumpfile all together later.

For makedumpfile, IMO you can add several test cases and collect the dump
time, vmcore size data as test results besides of the dump status.

Thanks
Dave

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
