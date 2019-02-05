From: Steve Muckle <smuckle@google.com>
Date: Mon, 4 Feb 2019 16:00:43 -0800
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190202172245.GA979@x230>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
 <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com> <20190202172245.GA979@x230>
Message-ID: <3b103f67-48da-dc9a-0920-76e3a9cba766@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/02/2019 09:22 AM, Petr Vorel wrote:
> Hi Steve,
> 
>> How did you come across these issues? We have yet to see them. Did you merge
>> tip of LTP into an Android AOSP tree and build it that way?
> Any sane person who wants to tests Android kernel uses LTP build inside of AOSP
> to get all your custom (not yet upstreamed) fixes, skip non relevant test etc.
> But I don't want to store whole AOSP on my disc, so I tried to cross compile
> upstream LTP with android standalone toolchain (with make ANDROID=1).
> 
> Looking now, you're using lib/tst_safe_sysv_ipc.c in gen.bp and that was missing
> in our Makefile.
> 
> I thought you might not build tests needing includes, but you do. Do you pass
> some flag to compiler?
> 
> Compiler used:
> 
> $ ~/usr/android-standalone-toolchain.api-27/bin/arm-linux-androideabi-gcc --version
> Android (5058415 based on r339409) clang version 8.0.2 (https://android.googlesource.com/toolchain/clang 40173bab62ec746213857d083c0e8b0abb568790) (https://android.googlesource.com/toolchain/llvm 7a6618d69e7e8111e1d49dc9e7813767c5ca756a) (based on LLVM 8.0.2svn)
> Target: armv7a-unknown-linux-android27
> Thread model: posix
> InstalledDir: ~/usr/android-standalone-toolchain.api-27/bin

Thanks. Yes include directories are specified both in gen.bp and also in 
Android.bp at the top level of our LTP repo.

cheers,
Steve
