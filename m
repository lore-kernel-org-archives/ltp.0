From: Qian Cai <cai@lca.pw>
Date: Mon, 18 Mar 2019 12:08:36 -0400
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190315160142.GA8921@rei>
References: <20190315160142.GA8921@rei>
Message-ID: <1552925316.26196.5.camel@lca.pw>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Fri, 2019-03-15 at 17:01 +0100, Cyril Hrubis wrote:
> Hi!
> I've started to write tests for mbind() and found out that mbind() does
> not work as described in manual page in a case that page has been
> faulted on different node that we are asking it to bind to. Looks like
> this is working fine on older kernels. On my testing machine with 3.0
> mbind() fails correctly with EIO but succeeds unexpectedly on newer
> kernels such as 4.12.
>=20
> What the test does is:
>=20
> * mmap() private mapping
> * fault it
> * find out on which node it is faulted on
> * mbind() it to a different node with MPOL_BIND and MPOL_MF_STRICT and
> =C2=A0 expects to get EIO
>=20
> The test code can be seen and compiled from:
>=20
> https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mb=
ind/m
> bind02.c
>=20

I am too lazy to checkout the repository and compile the whole thing just t=
o be
able to reproduce. If you can make it a standalone program without LTP mark=
ups,
I'd be happy to take a look.
