From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 2 Aug 2017 02:43:05 -0400 (EDT)
Subject: [LTP] LTP build issues
In-Reply-To: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
References: <20170801213931.gajssq5kldsv46rz@yury-thinkpad>
Message-ID: <120904092.64905035.1501656185854.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi all,
> 
> I just pulled latest LTP sources and try to build it for the arm64/ilp32 with
> toolchain provided by Linaro.
> http://people.linaro.org/~maxim.kuvyrkov/experimental/preview-cross-aarch64-linux-gnu_ilp32.tar.xz
> 
> And I see that build fails due to multiple reasons. At first I had to revert
> patches 817d8095f (Rename linux_syscall_numbers.h to lapi/syscalls.h)
> and 4d0d149c4 (Remove linux_syscall_numbers.h Makefile)
> because there'ds no lapi/syscalls.h file, and so build becomes broken.

Did you re-run "make autotools" and "./configure"?
./include/lapi/syscalls.h should be generated during configure.

If that still doesn't work, you can try it by hand:
cd ./include/lapi/syscalls
./regen.sh

> 
> There are also other reasons for build failures that dirty-fixed in patch
> below. Could someone comment it and/or share proper fix?

Can you also post build error messages?

Regards,
Jan
