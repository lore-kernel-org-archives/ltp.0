From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 18 Jul 2018 09:05:32 -0400 (EDT)
Subject: [LTP] How to convert TFAIL into TCONF for netns_*
In-Reply-To: <20180713150356.025d1b75@dell-desktop.home>
References: <20180713150356.025d1b75@dell-desktop.home>
Message-ID: <1467848633.34028528.1531919132241.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it



----- Original Message -----
> Hello everyone,
>=20
> While running containers' tests we got failures on all netns_xxx
> tests with different errors but the main one is:
>=20
> unable to create veth pair devices

Checking the output of 'ip' could be one way:

# ip link add ve_A type veth peer name ve_B
RTNETLINK answers: Operation not supported

If there's "Operation not supported" -> TCONF, else TBROK.

>=20
> It is because we currently do not have CONFIG_VETH enabled.
> There are also some tests failing because we again do not have the
> correct configuration such as CONFIG_TUN for netns_link tests:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/co=
ntainers/netns/netns_netlink.c#L142

Similar here, but check for ENODEV.

Other than that I can only think of grepping /proc/kallsyms,
which could break if symbols change name.

Regards,
Jan

>=20
> We would like to convert all these TFAIL tests into TCONF but we
> are not sure how to implement that in a proper way. The readme of this
> test indicates the kernel's configurations needed but we would like
> to test the kernel that we currently have without any modification.
>=20
> What do you think about that?
> What should we do to convert these TBROK into TCONF?
>=20
> Thank you in advance,
> Best regards,
>=20
> --
> Myl=C3=A8ne Josserand, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>=20
