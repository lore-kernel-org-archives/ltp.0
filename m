From: Yury Norov <ynorov@caviumnetworks.com>
Date: Fri, 4 Dec 2015 06:47:11 +0300
Subject: [LTP] {get|set}_thread_area issue on ARM
Message-ID: <20151204034711.GA27222@yury-N73SV>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

I just tried build ltp for arm, and one (maybe, first of) test failed
build. Namely, set_thread_area01.c

The reason is that __NR_set_thread_area and __NR_get_thread_area are
not declared. They should come from
/usr/arm-linux-gnueabi/include/asm/unistd.h
But there's only:
[...]
#define __NR_remap_file_pages           (__NR_SYSCALL_BASE+253)
                                         /* for set_thread_area */
                                         /* for get_thread_area */
#define __NR_set_tid_address            (__NR_SYSCALL_BASE+256)
[...]

In kernel, there are stubs for corresponding syscall numbers. So it
looks like this pair is deprecated and unsupported. I can build ltp
for aarch64 and x84_64 just fine.

Could someone explain me what am I doing wrong?

BR,
Yury.

ltp config:
CCC=arm-linux-gnueabi
./configure --target=arm --host=arm --prefix=$PWD/aarch32 \
                     CC=$CCC-gcc \
                     AR=$CCC-ar \
                     RANLIB=$CCC-ranlib \
                     STRIP=$CCC-strip \
                     LDFLAGS="-Wl,--rpath=/root/lib32
                     -Wl,--dynamic-linker=/root/lib32/ld-2.21.so"


yury@yury-N73SV:~/work/ltp$ arm-linux-gnueabi-gcc -v
Using built-in specs.
COLLECT_GCC=arm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/arm-linux-gnueabi/5/lto-wrapper
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion='Ubuntu
5.2.1-22ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-5 --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libitm --disable-libquadmath --enable-plugin
--with-system-zlib --disable-browser-plugin --enable-java-awt=gtk
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-5-armel-cross/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-5-armel-cross
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-5-armel-cross
--with-arch-directory=arm
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj
--enable-objc-gc --enable-multiarch --enable-multilib
--disable-sjlj-exceptions --with-arch=armv5t --with-float=soft
--disable-werror --enable-multilib --enable-checking=release
--build=x86_64-linux-gnu --host=x86_64-linux-gnu
--target=arm-linux-gnueabi --program-prefix=arm-linux-gnueabi-
--includedir=/usr/arm-linux-gnueabi/include
Thread model: posix
gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu1)

