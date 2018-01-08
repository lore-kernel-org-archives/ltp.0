From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Jan 2018 15:08:56 +0100
Subject: [LTP] More CI testing on git push
Message-ID: <20180108140856.w5qaavlzfavoamuf@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

currently we use Travis for various gcc/clang based builds, cross-compile arm and i868.
I've been talking some time ago with Cyril about more CI testing. It would be great to
test also LTP compiled old glibc an kernel headers + testing musl/uclibc. This can be
achieved with using different CI with docker enabled along with Travis. This is needed as
Travis doesn't allow to mix container based setup and docker based setup. Builds with
different CI providers IMHO run in parallel.

I was thinking to use doozer.io. It provides some quite new distros:
Debian 8 Jessie (i386), glibc 2.19
Ubuntu 12.04 LTS Precise (i386, amd64), glibc 2.15
Ubuntu 14.04 LTS Trusty (i386, amd64), glibc 2.19
Ubuntu 16.04 LTS Xenial (i386, amd64), glibc 2.23
Fedora 24 (x86_64), glibc 2.23.1
Centos 7 (x86_64), glibc 2.17
Raspbian Jessie ARM 32bit
Raspbian Stretch ARM 32bit

It provides some variety of distros and glibc + kernel headers.
Docker based CI would give us more variants.

Cyril, Jan, which glibc and kernel header versions would you like to test?
Is this an improvement?

Kind regards,
Petr

[1] https://doozer.io/docs/doozerjson
