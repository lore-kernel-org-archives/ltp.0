From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Jun 2018 10:44:13 +0800
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving
 EXTPROC|ICANON terminal mode
In-Reply-To: <20180604114039.GB3362@rei>
References: <20180513000101.13027-1-ebiggers3@gmail.com>
 <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
 <20180604114039.GB3362@rei>
Message-ID: <CAEemH2fejxF0bxd9SuDxbit-aj9qvYsW5j954+2p_z6=NwfnyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Mon, Jun 4, 2018 at 7:40 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I'm running into compilation errors on older distros (RHEL5/6)
> > with this test:
> >
> > pty02.c: In function ???do_test???:
> > pty02.c:34: error: ???EXTPROC??? undeclared (first use in this function)
> > pty02.c:34: error: (Each undeclared identifier is reported only once
> > pty02.c:34: error: for each function it appears in.)
> > make: *** [pty02] Error 1
> >
> > We should probably ifdef the test, because adding define to LAPI
> > still makes it fail:
> >
> > tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
> > pty02.c:44: BROK: tcsetattr() failed: EINVAL
>
> Or we can return TCONF on EINVAL since EINVAL means unsupported value
> anyway...
>

=E2=80=8BMaybe at least we should do more try before skipping it when getti=
ng
EINVAL. Because sometimes it also fails with EINVAL when using a termios
structure that was not obtained using tcgeaatr(). tcsetattr() should use
only a termios structure that was obtained by tcgetattr().

 pty02.c works fine on mainline kernel-v4.17 after applying this:
  http://lists.linux.it/pipermail/ltp/2018-May/008253.html

What do you think?

--=20
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180605/936fccfa/att=
achment.html>
