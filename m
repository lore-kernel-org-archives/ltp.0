From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jun 2018 07:37:17 -0400 (EDT)
Subject: [LTP] [PATCH] testcase: gethostid: Check if hostid is available
In-Reply-To: <20180615061807.15099-1-mylene.josserand@bootlin.com>
References: <20180615061807.15099-1-mylene.josserand@bootlin.com>
Message-ID: <33720795.27478831.1529408237932.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it


----- Original Message -----
> On some embedded systems, hostid may not be installed.
> Because of that, the test will fail with:
>=20
> gethostid01    1  TFAIL  :  gethostid01.c:171: fgets failed
>=20
> The test should return a TCONF instead.
> This commit uses tst_get_path function to check if "hostid"
> is available in $PATH. Otherwise, it will return a TCONF.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>

Pushed.

Thanks,
Jan
