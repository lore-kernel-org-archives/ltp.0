Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGWX8-00063l-Qc
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 15:59:18 +0000
Date: Mon, 2 Sep 2013 17:59:29 +0200
From: chrubis@suse.cz
Message-ID: <20130902155929.GA2146@rei>
References: <20130828095459.GB22849@rei.Home>
	<1377782535-15955-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377782535-15955-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 1/3] syscalls/utils/compat_16.mk: fix build
 dependencies
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> If we create/modify/touch file syscalls/utils/compat_16.h and execute
> 'make' in any of syscalls directories which includes compat_16.mk, then
> nothing will happen, because this approach:
> 
>    %.c: $(COMPAT_16_H)
> 
> is not working.
> 
> Fixed this.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/utils/compat_16.mk |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
> index 371bd43..36ece1b 100644
> --- a/testcases/kernel/syscalls/utils/compat_16.mk
> +++ b/testcases/kernel/syscalls/utils/compat_16.mk
> @@ -55,6 +55,7 @@ CPPFLAGS		+= -I$(abs_srcdir) -I$(abs_srcdir)/../utils
>  SRCS			?= $(wildcard $(abs_srcdir)/*.c)
>  
>  MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
> +MAKE_TARGETS_OBJS_WO_COMPAT_16	:= $(addsuffix .o,$(MAKE_TARGETS))
>  
>  ifneq ($(TST_COMPAT_16_SYSCALL),no)
>  MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
> @@ -69,7 +70,8 @@ COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
>  ifneq ($(wildcard $(COMPAT_16_H)),)
>  HAS_COMPAT_16		:= 1
>  
> -%.c: $(COMPAT_16_H)
> +$(MAKE_TARGETS_OBJS_WO_COMPAT_16): $(COMPAT_16_H)
> +.INTERMEDIATE: $(MAKE_TARGETS_OBJS_WO_COMPAT_16)
>  
>  else
>  HAS_COMPAT_16		:= 0
> @@ -78,5 +80,5 @@ endif
>  %_16: CPPFLAGS += -D$(DEF_16)=1
>  # XXX (garrcoop): End section of code in question..
>  
> -%_16.o: %.c
> +%_16.o: %.c $(COMPAT_16_H)
>  	$(COMPILE.c) $(OUTPUT_OPTION) $<

Perhaps we can do this more cleanly by making the _16 binaries depend on
the compat_16.h as with:

--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -57,7 +57,8 @@ SRCS			?= $(wildcard $(abs_srcdir)/*.c)
 MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
 
 ifneq ($(TST_COMPAT_16_SYSCALL),no)
-MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
+MAKE_TARGETS_16	 = $(addsuffix _16,$(MAKE_TARGETS))
+MAKE_TARGETS		+= $(MAKE_TARGETS_16)
 endif
 
 # XXX (garrcoop): This code should be put in question as it cannot be applied
@@ -69,8 +70,7 @@ COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
 ifneq ($(wildcard $(COMPAT_16_H)),)
 HAS_COMPAT_16		:= 1
 
-%.c: $(COMPAT_16_H)
-
+$(MAKE_TARGETS_16): $(COMPAT_16_H)
 else
 HAS_COMPAT_16		:= 0
 endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
