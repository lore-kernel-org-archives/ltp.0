Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmjjY-0007WG-K7
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 13:05:32 +0000
Date: Tue, 20 May 2014 15:05:15 +0200
From: chrubis@suse.cz
Message-ID: <20140520130515.GC28216@rei.suse.cz>
References: <1400147025-17705-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140519123450.GA4331@rei> <537B4607.3030207@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <537B4607.3030207@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH RFC v2] change MAKE_TARGETS's dependency to normal
 prerequisites and order-only prerequisites
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Here I met some issues. Could you please give me some hint and  currently I
> do not know how to fix it.
> 
> When I applied the v2 Patch and according to your comments,
> make "MAKE_NORMAL_DEPS        := $(LIBLTP) $(LSN_H)" in include/mk/testcases.mk.
> 
> For this rule "$(MAKE_TARGETS): $(MAKE_NORMAL_DEPS) | $(MAKE_ORDER_ONLY_DEPS)" in
> include/mk/generic_leaf_target.inc.
> 
> The implicit rule in Makefile will also make  "MAKE_NORMAL_DEPS" in the compile command.
> 
> For example:
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/home/lege/extern_stroage/test/ltp-dev/testcases/kernel/include -I../../../../include -I../../../../include   -L../../../../lib  access05.c /home/lege/extern_stroage/test/ltp-dev/lib/libltp.a /home/lege/extern_stroage/test/ltp-dev/testcases/kernel/include/linux_syscall_numbers.h   -lltp -o access05
> 
> But before this patch,
> the command will be:
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/home/lege/extern_stroage/test/ltp-dev/testcases/kernel/include -I../../../../include -I../../../../include   -L../../../../lib  access05.c   -lltp -o access05
> 
> How can I remove these "MAKE_NORMAL_DEPS" from the command. I googled this issue, but
> do not find any useful, thanks.

Well that is the problem with implicit rule that pulls in all the dependencies.

The problem is that Make is confused because we don't go the *.c + *.h
-> *.o -> binary route but take shortcut *.c -> binary instead.

If you look at the list of implicit rules (make --print-data-base) there is:

LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)

%: %.c
        $(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@


So the final command used to link the testcase is:

$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LOADLIBES) $(LDLIBS) -o $@

If you get choose to use the .c -> .o rule instead it uses:

%.o: %.c:
        $(COMPILE.c) $(OUTPUT_OPTION) $<

Note the $< instead of $^. In this case only first dependency is passed to the
compiler.


One solution would be to override the build-in rule with our own:

% %.c:
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LOADLIBES) $(LDLIBS) -o $@

However there may be places that will break by this change.

Or we may do a big step forward and stop using the implicit rules complety and
write our own rules (which is what quite a lot of projects does). We can even
utilize the gcc -MM and generate all testcase dependencies automatically...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
