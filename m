From: Sandeep Patil <sspatil@android.com>
Date: Wed, 17 Apr 2019 09:39:23 -0700
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
References: <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
 <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
 <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
 <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
 <20190412194809.GE124555@google.com>
 <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
Message-ID: <20190417163923.GG124555@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Apr 16, 2019 at 08:27:24PM +0800, 阮正旺 wrote:
>  Hi Sandeep,
> 
> 
> -------- Original Message --------
> From: Sandeep Patil
> Sent: Fri, 12 Apr 2019 12:48:09 -0700
> To: 阮正旺
> Cc: Petr Vorel, Ltp, Steve Muckle
> Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable
> __ANDROID__ definition for Android build
> > On Sat, Apr 13, 2019 at 12:15:18AM +0800, 阮正旺 wrote:
> > > -------- Original Message --------
> > > From: Petr Vorel
> > > Sent: Fri, 12 Apr 2019 08:28:14 +0200
> > > To: 阮正旺
> > > Cc: Sandeep Patil, Ltp, Steve Muckle
> > > Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable
> > > __ANDROID__ definition for Android build
> > > > Hi Zhengwang,
> > > > 
> > > > > > > According to [1] android toolchain (I guess both AOSP and NDK toolchain) define
> > > > > > > __ANDROID__. Which is what I'd expect.
> > > > > > > Grepping aosp only dnsmasq and swiftshader use -D__ANDROID__ (these are from
> > > > > > > externals). -DANDROID is use more times (e.g. some drivers in hardware - ril,
> > > > > > > qcom, libsensors and wpa_supplicant).
> > > > > > >    From my point of view, instead of -D__ANDROID__ or -DANDROID I'd prefer to to have
> > > > > > > proper #ifdef HAVE_FOO guarders made by autotools checks. As android is not the
> > > > > > > only minor libc. But I understand it's not always possible and we already use
> > > > > > > some #ifdef __ANDROID__ in library sources and headers, so ack from myself to
> > > > > > > help compilation outside AOSP and without NDK.
> > > > > > Actually I was wrong. 1) I was using NDK toolchain. I'd expect it'd generate
> > > > > > __ANDROID__, but I don't see it in the output. 2) Building for android with
> > > > > > distro toolchain doesn't make sense as it wouldn't have Bionic.
> > > > > 1) Did you build outside AOSP? If so,  I think it is reasonable since
> > > > Yes, with android NDK (for Bionic and special toolchain tweeks).
> > > > Then I use ANDROID=1
> > > > 
> > > > > whatever __ANDROID__ or ANDROID are defined by Android build system instead
> > > > > of toolchain. I also tried to build the external/* thing and found ANDROID
> > > > > was actually generated. In my test, ANDROID seems to be the more suitable
> > > > > one, but in fact we can not build ltp inside AOSP because there is no
> > > > > Android.mk in ltp (please correct me if I am wrong...),  so ANDROID is
> > > > Yes, inside AOSP you need to use Android fork [1] which uses usual Android.bp.
> > > > Therefore AOSP does not use our build system.
> > > > 
> > > > > meaningless to us here. Actually, this is why I think this patch is still
> > > > > useful, since __ANDROID__ is enough to distinguish what to compile if
> > > > > ANDROID=1 is set with make.
> > > > > 2) In the case of cross-compilation, I think it still makes sense, since we
> > > > > can use the same toolchain, such as clang,  and build parameters (the
> > > > > specify the include headers and libs, etc) as AOSP. This is what I am doing
> > > > > now, you can see my steps I posted in my previous reply. But in this case,
> > > > > we need to obviously set -D__ANDROID__ in CFLAGS. After that , the process
> > > > > should be similar as we launch a build inside AOSP.
> > > > I don't know much about android toolchain, but IMHO there are some other tweaks
> > > > in their build system (to comply changes in Bionic), so not sure if it's even
> > > > possible to avoid using NDK for out-of-aosp tree. See also [2]. But that's a
> > > > question for for Android devs.
> > > According to also [2], the situation gets clear now. All android targets
> > > should get __ANDROID__ defined by the compiler, but ANDROID only means 'this
> > > is AOSP' and is only for Windows targets. In our case, __ANDROID__ should be
> > > preferred.
> > Correct, and the build can still be make ANDROID=1 which translates to
> > -D__ANDROID__.
> > 
> > JFYI, there have been occasions when we changed something in bionic as a
> > result of an LTP tests, so those fixes will be missing for someone who is
> > using ndk for testing and building LTP.
> > 
> > That being said, thats a fairly small subset and is manageable. We can catch
> > those in reviews / patches very easily.
> > 
> > I like the idea of being able to build ouf-of-aosp, so I'm going to give this
> > a try now and will report.
> 
> Have you tried to build out-of-aosp? :-)

Yes, I did that now and ran into a build error with pread02 pasted at the
end of this email.

This was much easier than I thought and I think I can start sending trivial
fixes as I go. Here's what I did.

1. Download the ndk20 beta from - https://developer.android.com/ndk/downloads
2. Set up ndk toolchains for autoconf as shown in
   https://developer.android.com/ndk/guides/other_build_systems#autoconf
3. In LTP, do
   $ ./configure --host x86_64-linux-android --prefix=<preferred install location>
   $ make ANDROID=1

Please let me know if this doesn't sound right? It seems a lot easier than
the steps pasted earlier.

- ssp


======================

/usr/local/google/home/sspatil/bin/android-ndk-r20-beta2/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android28-clang -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -Werror-implicit-function-declaration -D_FORTIFY_SOURCE=2 -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv/../utils -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib -L../../../../lib/android_libpthread -L../../../../lib/android_librt  preadv02.c   -lltp -o preadv02
preadv02.c:89:7: error: implicit declaration of function 'preadv' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        TEST(preadv(*tc->fd, tc->name, tc->count, tc->offset));
             ^
1 error generated.
<builtin>: recipe for target 'preadv02' failed
make[4]: *** [preadv02] Error 1
make[4]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv'
../../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[3]: *** [all] Error 2
make[3]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls'
../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[2]: *** [all] Error 2
make[2]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel'
../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases'
Makefile:111: recipe for target 'testcases-all' failed
make: *** [testcases-all] Error 2
