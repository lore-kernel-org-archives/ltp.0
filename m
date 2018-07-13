From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 15:03:56 +0200
Subject: [LTP] How to convert TFAIL into TCONF for netns_*
Message-ID: <20180713150356.025d1b75@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello everyone,

While running containers' tests we got failures on all netns_xxx
tests with different errors but the main one is:

unable to create veth pair devices

It is because we currently do not have CONFIG_VETH enabled.
There are also some tests failing because we again do not have the
correct configuration such as CONFIG_TUN for netns_link tests:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/cont=
ainers/netns/netns_netlink.c#L142

We would like to convert all these TFAIL tests into TCONF but we
are not sure how to implement that in a proper way. The readme of this
test indicates the kernel's configurations needed but we would like
to test the kernel that we currently have without any modification.

What do you think about that?
What should we do to convert these TBROK into TCONF?

Thank you in advance,
Best regards,

--=20
Myl=C3=A8ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
