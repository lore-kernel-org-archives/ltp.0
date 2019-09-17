From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 Sep 2019 09:21:30 -0400 (EDT)
Subject: [LTP] Running kdump on Debian
In-Reply-To: <VI1PR0101MB2557E0698D03D10A8A95D71BF08F0@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
References: <VI1PR0101MB2557E0698D03D10A8A95D71BF08F0@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
Message-ID: <2111602431.467047.1568726490174.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hello,
> 
> I am trying to run the kdump testsuite on a Debian 9 distribution, but every
> test fails with "vmcore NOT FOUND".
> From what I understand, it is because /proc/vmcore is missing from my machine
> configuration.
> 
> I have the "crashkernel=256M@128M" parameter inside /etc/default/grub, and
> also nmi_watchdog=1.
> I also have inside the kernel configuration:
> CONFIG_PROC_VMCORE=y
> CONFIG_DEBUG_INFO=y
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> and everything described in the documents as needed.
> 
> Also, for example, when trying to simulate with the SysRq it doesn't even
> finish as at some point it hangs and you have to close and restart manually
> the machine.
> A snapshot is attached.

Looks like kernel bug. If manual kdump doesn't work, then this is
outside of scope for LTP.

Panic is in virtualbox module, I'd try blacklisting it in kdump kernel,
and also consider trying different kernel version(s).

> 
> Can anyone please offer some support for this?
> Nothing I found on google worked until now!
> 
> Best regards,
> 
> Emanuel-Vladut Magas
> 
> L4B Software, Iasi, Romania
> E-mail: vladut.m@l4b-software.com
> 
> 
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
