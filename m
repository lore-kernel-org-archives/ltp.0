From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jan 2018 12:51:20 +0100
Subject: [LTP] cross compilation failing
In-Reply-To: <CAN9dZwcYaD89iQ8pTRGjB5bG3H4JrkdgD9M22d5fxyQjpSyNEQ@mail.gmail.com>
References: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
 <20180116103829.GB24595@rei>
 <CAN9dZwcYaD89iQ8pTRGjB5bG3H4JrkdgD9M22d5fxyQjpSyNEQ@mail.gmail.com>
Message-ID: <20180116115120.GC24595@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> *For X86_64 :*
> if executing testcases on x86_64 "GLIBC_2.14 not found"  giving.
> 
> # sh network.sh -6
> tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.14' not found
> (required by tst_net_ip_prefix)
> tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.13' not found
> (required by tst_net_ip_prefix)

This looks like you have compiled the binaries on different distribution
(quite likely against different libc) than you attempt to run them on,
which will not work for obvious reasons.

> *For MIPS:*
> following steps performed for cross compilation.
> 1) make autotools
> 2) ./configure --prefix=/var/fpwork/rahul_gupta/ltp_ampp/ltp-master/fpt18
> CXX=${CROSS_COMPILE}g++ CC=${CROSS_COMPILE}gcc AS=${CROSS_COMPILE}as
> AR=${CROSS_COMPILE}ar LD=${CROSS_COMPILE}ld NM=${CROSS_COMPILE}nm
> OBJCOPY=${CROSS_COMPILE}objcopy OBJDUMP=${CROSS_COMPILE}objdump
> RANLIB=${CROSS_COMPILE}ranlib  READELF=${CROSS_COMPILE}readelf
> STRIP=${CROSS_COMPILE}strip --host=mips-wrs-linux-gnu
> --build=i586-wrs-linux-gnu

AFAIK ou are supposed only to define the CROSS_COMPILE and --host here,
which may cause the failure.

-- 
Cyril Hrubis
chrubis@suse.cz
