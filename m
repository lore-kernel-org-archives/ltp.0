From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jun 2018 09:31:22 +0200
Subject: [LTP] Regarding Use the Latest LTP on Latest YOCTO build
In-Reply-To: <CALYWmf_QWDGFUCqNdm3su1xxKeOR4x+3Mwfqs9R7HV0ngMGCeQ@mail.gmail.com>
References: <CALYWmf98UHkNKAeR3EKTSGhKYzWCs-LjVoDSo=Ze1yfPGduYAQ@mail.gmail.com>
 <20180627141145.GC32300@rei>
 <CALYWmf_QWDGFUCqNdm3su1xxKeOR4x+3Mwfqs9R7HV0ngMGCeQ@mail.gmail.com>
Message-ID: <20180628073121.GA8182@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have some doubt please clarify
> I am getting following errors while building LTP with YOCTO(2.3)
> {{{
> 
>      ltp-20170116-r0 do_compile: NOTE: ltp: compiling from external source
> tree /home/sathishc/kapil/build/https:/github.com/linux-test-project/ltp.git
>      ERROR: ltp-20170116-r0 do_compile: oe_runmake failed
>      ERROR: ltp-20170116-r0 do_compile: Function failed: do_compile (log
> file is located at
> /home/sathishc/kapil/build/tmp/work/cortexa9hf-neon-agl-linux-gnueabi/ltp/20170116-
> r0/temp
>      /log.do_compile.161006)
>      ERROR: Logfile of failure stored in:
> /home/sathishc/kapil/build/tmp/work/cortexa9hf-neon-agl-
> linux-gnueabi/ltp/20170116-r0/temp/log.do_compile.161006
>      Log data follows:
>      | DEBUG: Executing python function externalsrc_compile_prefunc
>      | NOTE: ltp: compiling from external source tree
> /home/sathishc/kapil/build/https:/github.com/linux-test-project/ltp.git
>      | DEBUG: Python function externalsrc_compile_prefunc finished
>      | DEBUG: SITE files ['endian-little', 'bit-32', 'arm-common',
> 'arm-32', 'common-linux', 'common-glibc', 'arm-linux', 'arm-linux-gnueabi',
> 'common']
>      | DEBUG: Executing shell function do_compile
>      | NOTE: make -j 16
>      | ERROR: oe_runmake failed
>      | make: Entering directory '/home/sathishc/kapil/build/https:/
> github.com/linux-test- project/ltp.git/testcases/kernel'
>      | make: 'include/linux_syscall_numbers.h' is up to date.
>      | make: Leaving directory '/home/sathishc/kapil/build/https:/
> github.com/linux-test- project/ltp.git/testcases/kernel'
>      | /home/sathishc/kapil/build/https:/github.com/linux-test-
> project/ltp.git/include/mk/automake.mk:108: *** target pattern contains no
> '%'.  Stop.

This looks like the build fails because there is colon (:) in the path
the LTP sources are stored in, which confuses make because it tries to
interpret the path as a rule.

-- 
Cyril Hrubis
chrubis@suse.cz
