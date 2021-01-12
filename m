From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 23:47:49 +0100
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <X/4kHp818UKMRmXm@pevik>
References: <20210111123626.28932-1-pvorel@suse.cz>
 <CAEemH2eTEEZVZc71=HF+251t_d7Rnu7XdFY2t54u=ORwY3M-7A@mail.gmail.com>
 <X/2E2GD/wimgo5Hi@pevik>
 <CAEemH2cmHrUGx3WXWfh6huNh-sv_GY56A+EvGVj-BiXT3WQ32A@mail.gmail.com>
 <X/4kHp818UKMRmXm@pevik>
Message-ID: <X/4nFTgDjsO4a9VU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> > From what I understanding, this macro runs the pkg-config tool to check
> > for the presence of packages against keyutils-libs and sets two variables:
> > LIBKEYUTILS_CFLAGS, LIBKEYUTILS_LIBS accordingly.

> > So the list-of-modules should be the precise name(or version) of the
> > library, am I right?
> > See: https://autotools.io/pkgconfig/pkg_check_modules.html

> Thanks for an explanation, but I'm still missing something.
> In openSUSE:

> $ pkg-config --libs --cflags libkeyutils
> -lkeyutils

> $ pkg-config --libs --cflags keyutils-libs
> Package keyutils-libs was not found in the pkg-config search path.
> Perhaps you should add the directory containing `keyutils-libs.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'keyutils-libs', required by 'virtual:world', not found

> That's correct, because keyutils-devel package has file:
> /usr/lib64/pkgconfig/libkeyutils.pc

> The same is for Debian, which has
> /usr/lib/x86_64-linux-gnu/pkgconfig/libkeyutils.pc

> Looking at Fedora:
> keyutils-libs-devel [1] has /usr/lib64/pkgconfig/libkeyutils.pc.

> Download and unpack the package and run:
> $ PKG_CONFIG_LIBDIR="$PWD/usr/lib64/pkgconfig/" pkg-config --libs --cflags libkeyutils
> -lkeyutils

And more importantly upstream has libkeyutils.pc.in [1] (not keyutils-libs.pc).

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/tree/libkeyutils.pc.in
