Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZjV9-0007aF-Po
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 16:12:55 +0000
Date: Mon, 14 Apr 2014 18:12:09 +0200
From: chrubis@suse.cz
Message-ID: <20140414161209.GA15595@rei.Home>
References: <20140411183712.7ca33b6c@mats-desktop>
	<534B5C8E.1070500@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534B5C8E.1070500@cn.fujitsu.com>
Subject: Re: [LTP] Problems compiling
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
> > I recently updated my master branch of my ltp git repository, but I now
> > have a compile error:
> >
> > make[6]: Entering directory `/nfs/hosts/sestonas06/homes/mlil/git/ltp/testcases/kernel/mem/lib'
> > make[6]: ../../../../../testcases/kernel/mem/lib/Makefile: No such file or directory
> >
> > Anyone else having this problem?
> 
> Yeah, I also met this problem.
> I guess it may be "testcases/kernel/mem/include/libmem.mk"  causing this issue.
> 
> I can reproduce this fail by following steps:
> 
> 1, cd testcases/kernel/mem/lib
>     rm libmem.a
> 
> 2, then back to testcases/kernel/mem/hugetlb/hugemmap
>     make
> 
> I got the similar error message:
> make -C ../../../../../testcases/kernel/mem/lib -f "../../../../../testcases/kernel/mem/lib/Makefile" all
> make[1]: Entering directory `/root/ltp-dev/testcases/kernel/mem/lib'
> make[1]: ../../../../../testcases/kernel/mem/lib/Makefile: No such file or directory
> make[1]: *** No rule to make target `../../../../../testcases/kernel/mem/lib/Makefile'.  Stop.
> make[1]: Leaving directory `/root/ltp-dev/testcases/kernel/mem/lib'
> make: *** [../../../../../testcases/kernel/mem/lib/libmem.a] Error 2
> 
> In testcases/kernel/mem/include/libmem.mk:
> 
> MEM_SRCDIR              := $(top_srcdir)/testcases/kernel/mem
> LIBMEM_SRCDIR           := $(MEM_SRCDIR)/lib
> 
> MEM_DIR                 := $(top_builddir)/testcases/kernel/mem
> LIBMEM_DIR              := $(MEM_DIR)/lib
> LIBMEM                  := $(LIBMEM_DIR)/libmem.a
> FILTER_OUT_DIRS         := $(LIBMEM_DIR)
> CFLAGS                  += -I$(MEM_SRCDIR)/include
> LDLIBS                  += $(NUMA_LIBS) -lmem -lltp
> LDFLAGS                 += -L$(LIBMEM_DIR)
> 
> $(LIBMEM_DIR):
>         mkdir -p "$@"
> 
> $(LIBMEM): $(LIBMEM_DIR)
>         $(MAKE) -C $^ -f "$(LIBMEM_SRCDIR)/Makefile" all
> 
> MAKE_DEPS               += $(LIBMEM)
> 
> See the target $(LIBMEM). Since we have executed make command using the "-C" option, we do
> not need to specify a make file with relative path.  We can just
> execute like that: $(MAKE) -C $^ -f  "Makefile" all in this case.

Wouldn't that break out-of-tree build? Because the LIBMEM_DIR is in the
build path and the Makefile is in the LIBMEM_SRCDIR?

Does this change fix the build?

--- a/testcases/kernel/mem/include/libmem.mk
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -16,7 +16,7 @@
 #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 #
 
-MEM_SRCDIR             := $(top_srcdir)/testcases/kernel/mem
+MEM_SRCDIR             := $(abs_top_srcdir)/testcases/kernel/mem


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
