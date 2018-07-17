From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 17 Jul 2018 11:41:07 +0200
Subject: [LTP] [PATCH 4.17 00/67] 4.17.7-stable review
In-Reply-To: <2078122506.33400530.1531776704409.JavaMail.zimbra@redhat.com>
References: <20180716073443.294323458@linuxfoundation.org>
 <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
 <2078122506.33400530.1531776704409.JavaMail.zimbra@redhat.com>
Message-ID: <20180717094107.GB25341@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Mon, Jul 16, 2018 at 05:31:44PM -0400, Jan Stancek wrote:
>=20
>=20
> ----- Original Message -----
> > On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g>
> > wrote:
> > > This is the start of the stable review cycle for the 4.17.7 release.
> > > There are 67 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/pa=
tch-4.17.7-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> > >         linux-4.17.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >=20
> >=20
> > Results from Linaro=E2=80=99s test farm.
> > Regressions detected.
> >=20
> > LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
> >  - creat08
> >  - open10
>=20
> This is consequence of:
>   0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
>=20
> So likely cause of action here will be modifying both tests to not
> expect S_ISGID in scenario described in commit above.

Yes, ltp should be fixed up here.

thanks,

greg k-h
