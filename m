From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Aug 2018 06:19:57 -0400 (EDT)
Subject: [LTP] [PATCH v2 ltp] syscalls/munlockall02: remove deprecated
 test
In-Reply-To: <20180829082320.6903-1-junchi.chen@intel.com>
References: <20180829082320.6903-1-junchi.chen@intel.com>
Message-ID: <471948097.43438055.1535537997606.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it


----- Original Message -----
> ISSUE:
>   This TCONF message: "Some distros... support
>    non-superuser munlockall calls."
>    has unnecessarily shown for years.
>=20
> REASON=EF=BC=9A
>   The test is expecting EPERM error when calling munlockall with user
>    nobody. However, the unprivileged calling of munlockall has been
>    allowed at least since v2.6.
>=20
> Signed-off-by: Junchi Chen <junchi.chen@intel.com>

Pushed.

Thanks,
Jan
