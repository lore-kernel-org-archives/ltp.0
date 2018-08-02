From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Thu, 2 Aug 2018 16:08:07 +0200
Subject: [LTP] How to convert TFAIL into TCONF for netns_*
In-Reply-To: <1467848633.34028528.1531919132241.JavaMail.zimbra@redhat.com>
References: <20180713150356.025d1b75@dell-desktop.home>
 <1467848633.34028528.1531919132241.JavaMail.zimbra@redhat.com>
Message-ID: <20180802160807.55ca5ab1@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

Sorry for the late answer and thanks for the help!

On Wed, 18 Jul 2018 09:05:32 -0400 (EDT)
Jan Stancek <jstancek@redhat.com> wrote:

> ----- Original Message -----
> > Hello everyone,
> > 
> > While running containers' tests we got failures on all netns_xxx
> > tests with different errors but the main one is:
> > 
> > unable to create veth pair devices  
> 
> Checking the output of 'ip' could be one way:
> 
> # ip link add ve_A type veth peer name ve_B
> RTNETLINK answers: Operation not supported
> 
> If there's "Operation not supported" -> TCONF, else TBROK.

okay, I created a patch that handles that and it is working, thanks.

> 
> > 
> > It is because we currently do not have CONFIG_VETH enabled.
> > There are also some tests failing because we again do not have the
> > correct configuration such as CONFIG_TUN for netns_link tests:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/containers/netns/netns_netlink.c#L142  
> 
> Similar here, but check for ENODEV.
> 

It was a good idea but unfortunately, the system() call of the ip
command is not setting errno:
https://github.com/linux-test-project/ltp/commit/085b5e6d9b

For this issue, I reproduced what the test "ioctl03" is already
performing: report a TCONF if the file "/dev/net/tun" is not available:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L81..L87

I will send two patches in few minutes to fix these two above issues,
let me know if you have another idea on how to handle that.

Best regards,

Mylène

> Other than that I can only think of grepping /proc/kallsyms,
> which could break if symbols change name.
> 
> Regards,
> Jan
> 
> > 
> > We would like to convert all these TFAIL tests into TCONF but we
> > are not sure how to implement that in a proper way. The readme of this
> > test indicates the kernel's configurations needed but we would like
> > to test the kernel that we currently have without any modification.
> > 
> > What do you think about that?
> > What should we do to convert these TBROK into TCONF?
> > 
> > Thank you in advance,
> > Best regards,
> > 
> > --
> > Mylène Josserand, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >   




-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
