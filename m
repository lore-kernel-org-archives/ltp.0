Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sulfurfff@gmail.com>) id 1Umm88-0007Ut-S4
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 14:34:32 +0000
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Umm86-0007Lw-L2
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 14:34:32 +0000
Received: by mail-we0-f175.google.com with SMTP id t59so6907032wes.20
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Jun 2013 07:34:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <880296419.1609038.1371019910126.JavaMail.root@redhat.com>
References: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
	<880296419.1609038.1371019910126.JavaMail.root@redhat.com>
Date: Wed, 12 Jun 2013 09:34:24 -0500
Message-ID: <CANXECd7uzb9Rc2H1LMDuBXcExC6RHbHhJ2rv-tEz9uOcDW+Vhw@mail.gmail.com>
From: =?UTF-8?Q?Ismael_Farf=C3=A1n?= <sulfurfff@gmail.com>
Subject: Re: [LTP] Help compiling in AIX 6.1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Thanks for the answer.

Since configure didn't fail I thought it didn't mind a few missing
headers. Here it is:


ltp-full-20130109/ ~$ ./configure
checking for a BSD-compatible install... ./install-sh -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... ./install-sh -c -d
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking build system type... powerpc-ibm-aix6.1.0.0
checking host system type... powerpc-ibm-aix6.1.0.0
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... none
checking for ar... ar
checking for flex... no
checking for lex... lex
checking lex output file root... lex.yy
checking lex library... -ll
checking whether yytext is a pointer... no
checking for ranlib... ranlib
checking for strip... strip
checking for bison... no
checking for byacc... no
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dmapi.h usability... no
checking dmapi.h presence... no
checking for dmapi.h... no
checking ifaddrs.h usability... no
checking ifaddrs.h presence... no
checking for ifaddrs.h... no
checking libaio.h usability... no
checking libaio.h presence... no
checking for libaio.h... no
checking mm.h usability... no
checking mm.h presence... no
checking for mm.h... no
checking pthread.h usability... yes
checking pthread.h presence... yes
checking for pthread.h... yes
checking attr/xattr.h usability... no
checking attr/xattr.h presence... no
checking for attr/xattr.h... no
checking linux/genetlink.h usability... no
checking linux/genetlink.h presence... no
checking for linux/genetlink.h... no
checking linux/mempolicy.h usability... no
checking linux/mempolicy.h presence... no
checking for linux/mempolicy.h... no
checking linux/module.h usability... no
checking linux/module.h presence... no
checking for linux/module.h... no
checking linux/netlink.h usability... no
checking linux/netlink.h presence... no
checking for linux/netlink.h... no
checking sys/epoll.h usability... no
checking sys/epoll.h presence... no
checking for sys/epoll.h... no
checking sys/inotify.h usability... no
checking sys/inotify.h presence... no
checking for sys/inotify.h... no
checking sys/jfsdmapi.h usability... no
checking sys/jfsdmapi.h presence... no
checking for sys/jfsdmapi.h... no
checking sys/prctl.h usability... no
checking sys/prctl.h presence... no
checking for sys/prctl.h... no
checking for mkdtemp... yes
checking sys/capability.h usability... no
checking sys/capability.h presence... no
checking for sys/capability.h... no
checking openssl/sha.h usability... yes
checking openssl/sha.h presence... yes
checking for openssl/sha.h... yes
checking sys/ptrace.h usability... yes
checking sys/ptrace.h presence... yes
checking for sys/ptrace.h... yes
checking sys/reg.h usability... yes
checking sys/reg.h presence... yes
checking for sys/reg.h... yes
checking asm/ptrace.h usability... no
checking asm/ptrace.h presence... no
checking for asm/ptrace.h... no
checking linux/ptrace.h usability... no
checking linux/ptrace.h presence... no
checking for linux/ptrace.h... no
checking for struct user_regs_struct... no
checking for struct pt_regs... no
checking whether PTRACE_GETSIGINFO is declared... no
checking whether PTRACE_O_TRACEVFORKDONE is declared... no
checking whether PTRACE_SETOPTIONS is declared... no
checking for fork... yes
checking for daemon... no
checking for vfork... yes
checking for sys/prctl.h... (cached) no
checking linux/securebits.h usability... no
checking linux/securebits.h presence... no
checking for linux/securebits.h... no
checking selinux/selinux.h usability... no
checking selinux/selinux.h presence... no
checking for selinux/selinux.h... no
checking for struct sigaction.sa_sigaction... yes
checking for libaio.h... (cached) no
checking for modify_ldt... no
checking asm/ldt.h usability... no
checking asm/ldt.h presence... no
checking for asm/ldt.h... no
checking for linux/mempolicy.h... (cached) no
checking numa.h usability... no
checking numa.h presence... no
checking for numa.h... no
checking numaif.h usability... no
checking numaif.h presence... no
checking for numaif.h... no
configure: WARNING: Couldn't determine quota version (please submit
config.log and manpage to ltp-list@lists.sourceforge.net)
checking for signalfd... no
checking sys/signalfd.h usability... no
checking sys/signalfd.h presence... no
checking for sys/signalfd.h... no
checking linux/types.h usability... no
checking linux/types.h presence... no
checking for linux/types.h... no
checking for linux/signalfd.h... no
checking for signalfd.h... no
checking for unshare... no
checking for linux/taskstats.h... no
checking whether CLOCK_MONOTONIC_RAW is declared... no
checking whether CLOCK_REALTIME_COARSE is declared... no
checking whether CLOCK_MONOTONIC_COARSE is declared... no
checking whether MADV_MERGEABLE is declared... no
checking sys/acl.h usability... yes
checking sys/acl.h presence... yes
checking for sys/acl.h... yes
checking for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>... no
checking for MREMAP_FIXED in <sys/mman.h>... no
configure: creating ./config.status
config.status: creating include/mk/config.mk
config.status: creating include/mk/features.mk
config.status: creating lib/ltp.pc
config.status: creating ltp-devel.spec
config.status: creating m4/Makefile
config.status: creating execltp
config.status: creating README.ltp-devel
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: executing depfiles commands




>
>
>
>
> ----- Original Message -----

>> To: ltp-list@lists.sourceforge.net
>> Sent: Tuesday, 11 June, 2013 10:37:36 PM
>> Subject: [LTP] Help compiling in AIX 6.1
>>
>> Hello list
>>
>> We have this AIX 6.1 box running LTP 2005-something. Now I'm trying to
>> compile 20130109 without much luck.
>>
>> I'm running this without much luck:
>>
>> ./configure
>> gmake
>>
>> Any ideas?
>
> include/mk/env_pre.mk:100 is include of "$(abs_top_builddir)/include/mk/config.mk",
> so I'm guessing something went wrong with ./configure.
> Can you send output of "./configure"?
>
> Regards,
> Jan
>
>>
>>
>>
>> ltp-full-20130109/ ~$ gmake
>> /tmp/ltp-full-20130109/include/mk/env_pre.mk:100: -n: A file or
>> directory in the path name does not exist.
>> /tmp/ltp-full-20130109/include/mk/env_pre.mk:101: -n: A file or
>> directory in the path name does not exist.
>> /tmp/ltp-full-20130109/include/mk/automake.mk:115: target `-n' given
>> more than once in the same rule.
>> Makefile:107: warning: overriding commands for target `-n'
>> /tmp/ltp-full-20130109/include/mk/automake.mk:117: warning: ignoring
>> old commands for target `-n'
>> Makefile:182: warning: overriding commands for target `-n'
>> Makefile:107: warning: ignoring old commands for target `-n'
>> Makefile:188: warning: overriding commands for target `-n'
>> Makefile:182: warning: ignoring old commands for target `-n'
>> Makefile:187: target `-n' given more than once in the same rule.
>> Makefile:187: target `-n' given more than once in the same rule.
>> Makefile:187: target `-n' given more than once in the same rule.
>> Makefile:187: target `-n' given more than once in the same rule.
>> if git describe >/dev/null 2>&1; then \
>>         git describe > "Version"; \
>> else \
>>         cp VERSION "Version"; \
>> fi
>> gmake: Circular -n <- -n dependency dropped.
>> gmake: Circular -n <- -n dependency dropped.
>> gmake: Circular -n <- -n dependency dropped.
>> gmake: Circular -n <- -n dependency dropped.
>> gmake: Circular -n <- -n dependency dropped.
>> gmake: Circular -n <- -n dependency dropped.
>> install -m 00755 "/tmp/ltp-full-20130109/-n" "-n"
>> install: 0653-233 File 00755 was not found.
>> gmake: *** [-n] Error 2
>>
>>
>>
>>
>> --
>> Do not let me induce you to satisfy my curiosity, from an expectation,
>> that I shall gratify yours. What I may judge proper to conceal, does
>> not concern myself alone.
>>
>> ------------------------------------------------------------------------------
>> This SF.net email is sponsored by Windows:
>>
>> Build for Windows Store.
>>
>> http://p.sf.net/sfu/windows-dev2dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>



--
Do not let me induce you to satisfy my curiosity, from an expectation,
that I shall gratify yours. What I may judge proper to conceal, does
not concern myself alone.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
