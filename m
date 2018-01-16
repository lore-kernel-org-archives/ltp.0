From: rahul gupta <rahul.gupta412@gmail.com>
Date: Tue, 16 Jan 2018 16:23:03 +0530
Subject: [LTP] cross compilation failing
In-Reply-To: <20180116103829.GB24595@rei>
References: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
 <20180116103829.GB24595@rei>
Message-ID: <CAN9dZwcYaD89iQ8pTRGjB5bG3H4JrkdgD9M22d5fxyQjpSyNEQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

*For X86_64 :*
if executing testcases on x86_64 "GLIBC_2.14 not found"  giving.

# sh network.sh -6
tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.14' not found
(required by tst_net_ip_prefix)
tst_net_ip_prefix: /lib64/libc.so.6: version `GLIBC_2.13' not found
(required by tst_net_ip_prefix)

*For MIPS:*
following steps performed for cross compilation.
1) make autotools
2) ./configure --prefix=/var/fpwork/rahul_gupta/ltp_ampp/ltp-master/fpt18
CXX=${CROSS_COMPILE}g++ CC=${CROSS_COMPILE}gcc AS=${CROSS_COMPILE}as
AR=${CROSS_COMPILE}ar LD=${CROSS_COMPILE}ld NM=${CROSS_COMPILE}nm
OBJCOPY=${CROSS_COMPILE}objcopy OBJDUMP=${CROSS_COMPILE}objdump
RANLIB=${CROSS_COMPILE}ranlib  READELF=${CROSS_COMPILE}readelf
STRIP=${CROSS_COMPILE}strip --host=mips-wrs-linux-gnu
--build=i586-wrs-linux-gnu

then configuration part has been failed with following error.
configure: error: in `/var/fpwork/rahul_gupta/ltp_ampp/ltp-master':
configure: error: cannot run test program while cross compiling

please find the attached config.log file.

Thanks & Regards,
Rahul Gupta




On Tue, Jan 16, 2018 at 4:08 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > we are facing issue while compiling ltp for kernel version 2.6.34.15.
> > could you please let me know, does ltp depend on kernel version.
>
> The build does not depend on the running kernel at all. The usuall
> suspects are libc version and version of the kernel-headers.
>
> Can you append a log of the failing compilation? Without that we cannot
> really help here.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180116/a440f05d/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: application/octet-stream
Size: 141292 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180116/a440f05d/attachment-0001.obj>
