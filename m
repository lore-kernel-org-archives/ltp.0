From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Jan 2018 09:14:45 +0100
Subject: [LTP] cross compilation failing
In-Reply-To: <20180116115120.GC24595@rei>
References: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
 <20180116103829.GB24595@rei>
 <CAN9dZwcYaD89iQ8pTRGjB5bG3H4JrkdgD9M22d5fxyQjpSyNEQ@mail.gmail.com>
 <20180116115120.GC24595@rei>
Message-ID: <20180117081445.2ohref7ypmmurmdb@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Rahul,
> > *For X86_64 :*
> > if executing testcases on x86_64 "GLIBC_2.14 not found"  giving.

> > # sh network.sh -6
> > tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.14' not found
> > (required by tst_net_ip_prefix)
> > tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.13' not found
> > (required by tst_net_ip_prefix)
Does tst_net_ip_prefix really wants two glibc versions?

> This looks like you have compiled the binaries on different distribution
> (quite likely against different libc) than you attempt to run them on,
> which will not work for obvious reasons.
+1

> > *For MIPS:*
> > following steps performed for cross compilation.
> > 1) make autotools
> > 2) ./configure --prefix=/var/fpwork/rahul_gupta/ltp_ampp/ltp-master/fpt18
> > CXX=${CROSS_COMPILE}g++ CC=${CROSS_COMPILE}gcc AS=${CROSS_COMPILE}as
> > AR=${CROSS_COMPILE}ar LD=${CROSS_COMPILE}ld NM=${CROSS_COMPILE}nm
> > OBJCOPY=${CROSS_COMPILE}objcopy OBJDUMP=${CROSS_COMPILE}objdump
> > RANLIB=${CROSS_COMPILE}ranlib  READELF=${CROSS_COMPILE}readelf
> > STRIP=${CROSS_COMPILE}strip --host=mips-wrs-linux-gnu
> > --build=i586-wrs-linux-gnu

> AFAIK ou are supposed only to define the CROSS_COMPILE and --host here,
> which may cause the failure.

Agree, please run configure just as:
./configure CROSS_COMPILE="/build/fpsdkroot_cougar/sysroots/mips/sysroot-wrlinux-4.3-NSN6607-fp_octwnd_6880_ampp2-glibc_cgl/x86-linux2/mips-wrs-linux-gnu-mips64_octeon2-glibc_cgl-" --host=mips-wrs-linux-gnu

BTW you can see that cross LTP compilation works on travis (tested on arm):
https://travis-ci.org/linux-test-project/ltp/branches
https://travis-ci.org/linux-test-project/ltp/jobs/329049819
https://travis-ci.org/linux-test-project/ltp/jobs/329049820
It's tested on arm, but it should be the same for mips. It uses ./build.sh script, which
you can use locally as well.


Kind regards,
Petr
