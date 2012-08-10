Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SzkFM-0005As-2W
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:07:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzkFG-0006cz-2S
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:07:04 +0000
Message-ID: <5024BFF9.7050703@redhat.com>
Date: Fri, 10 Aug 2012 16:02:01 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<b9b0b345b3f8305ca1964914c0e1696c6106a0b1.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <b9b0b345b3f8305ca1964914c0e1696c6106a0b1.1344492473.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 5/6] mm: use new numa_helper
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> This patch makes the tests in mem/ dir use numa_helper in libkerntest.
>
> Signed-off-by: Caspar Zhang<caspar@casparzhang.com>
> ---
>   testcases/kernel/mem/cpuset/Makefile           |    1 +
>   testcases/kernel/mem/cpuset/cpuset01.c         |   16 ++++----
>   testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
>   testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
>   testcases/kernel/mem/include/mem.h             |    2 +-
>   testcases/kernel/mem/ksm/Makefile              |    1 +
>   testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
>   testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
>   testcases/kernel/mem/lib/Makefile              |    1 +
>   testcases/kernel/mem/lib/mem.c                 |   50 ++++++++++++++++-=
-------
>   testcases/kernel/mem/oom/Makefile              |    1 +
>   testcases/kernel/mem/oom/oom02.c               |    4 --
>   testcases/kernel/mem/oom/oom04.c               |    4 --
>   testcases/kernel/mem/swapping/Makefile         |    1 +
>   testcases/kernel/mem/thp/Makefile              |    1 +
>   testcases/kernel/mem/tunable/Makefile          |    1 +
>   testcases/kernel/mem/vma/Makefile              |    3 +-
>   testcases/kernel/mem/vma/vma02.c               |   19 ++++++---
>   testcases/kernel/mem/vma/vma04.c               |   11 ++++-
>   19 files changed, 81 insertions(+), 55 deletions(-)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/=
cpuset/Makefile
> index f0c34ba..c9d03bf 100644
> --- a/testcases/kernel/mem/cpuset/Makefile
> +++ b/testcases/kernel/mem/cpuset/Makefile
> @@ -41,5 +41,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/me=
m/cpuset/cpuset01.c
> index b20485f..2be6953 100644
> --- a/testcases/kernel/mem/cpuset/cpuset01.c
> +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> @@ -51,6 +51,7 @@
> #include=B7"test.h"
> #include=B7"usctest.h"
> #include=B7"mem.h"
> +#include=B7"numa_helper.h"
> char=B7*TCID=B7=3D=B7"cpuset01";
> int=B7TST_TOTAL=B7=3D=B71;
> @@ -58,9 +59,9 @@
> int=B7TST_TOTAL=B7=3D=B71;
> #if=B7HAVE_NUMA_H=B7&&=B7HAVE_LINUX_MEMPOLICY_H=B7&&=B7HAVE_NUMAIF_H=B7\
> =BB &&=B7HAVE_MPOL_CONSTANTS
> volatile=B7int=B7end;
> -static=B7long=B7nodes[MAXNODES];
> -static=B7long=B7nnodes;
> +static=B7int=B7*nodes;
> +static=B7int=B7nnodes;
> static=B7long=B7ncpus;
> static=B7void=B7testcpuset(void);
> @@ -77,12 +78,11 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB =BB tst_brkm(TBROK,=B7NULL,=B7"OPTION=B7PARSING=B7ERROR=B7-=B7%s",=B7=
msg);
> =BB ncpus=B7=3D=B7count_cpu();
> -=BB nnodes=B7=3D=B7count_numa(nodes);
> -=BB tst_resm(TINFO,=B7"The=B7system=B7has=B7%ld=B7CPUs,=B7%ld=B7NUMA=B7n=
odes",
> -=BB =BB =BB ncpus,=B7nnodes);
> +=BB if=B7(get_allowed_nodes_arr(NH_MEMS|NH_CPUS,=B7&nnodes,=B7&nodes)=B7=
<=B70)
> +=BB =BB tst_brkm(TBROK|TERRNO,=B7NULL,=B7"get_allowed_nodes_arr");
> =BB if=B7(nnodes=B7<=3D=B71)
> -=BB =BB tst_brkm(TCONF,=B7NULL,=B7"required=B7a=B7NUMA=B7system.");
> +=BB =BB tst_brkm(TCONF,=B7NULL,=B7"requires=B7a=B7NUMA=B7system.");
> =BB setup();
> =BB testcpuset();
> @@ -115,10 +115,10 @@
> static=B7void=B7testcpuset(void)
> =BB }
> =BB for=B7(lc=B7=3D=B70;=B7TEST_LOOPING(lc);=B7lc++)=B7{
> =BB =BB Tst_count=B7=3D=B70;
> -=BB =BB snprintf(buf,=B7BUFSIZ,=B7"%ld",=B7nodes[0]);
> +=BB =BB snprintf(buf,=B7BUFSIZ,=B7"%d",=B7nodes[0]);
> =BB =BB write_cpuset_files(CPATH_NEW,=B7"mems",=B7buf);
> -=BB =BB snprintf(buf,=B7BUFSIZ,=B7"%ld",=B7nodes[1]);
> +=BB =BB snprintf(buf,=B7BUFSIZ,=B7"%d",=B7nodes[1]);
> =BB =BB write_cpuset_files(CPATH_NEW,=B7"mems",=B7buf);
> =BB }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel=
/mem/hugetlb/Makefile.inc
> index c7073a5..1831fbb 100644
> --- a/testcases/kernel/mem/hugetlb/Makefile.inc
> +++ b/testcases/kernel/mem/hugetlb/Makefile.inc
> @@ -41,5 +41,6 @@
> MAKE_DEPS=BB =BB +=3D=B7$(LIBMEM)=B7$(LIBIPC)
> lib-clean::=B7$(LIBMEMDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> #=B7vim:=B7syntax=3Dmake
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/k=
ernel/mem/hugetlb/hugemmap/Makefile
> index 15ae693..0b1b60c 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -34,5 +34,6 @@
> LDFLAGS=BB=BB =BB +=3D=B7-L$(abs_builddir)/$(LIBMEMDIR)
> LDLIBS=BB =BB =BB +=3D=B7$(NUMA_LIBS)=B7-lmem=B7-lltp
> MAKE_DEPS=BB =BB +=3D=B7$(LIBMEM)
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/in=
clude/mem.h
> index cdc326b..16a65db 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -67,8 +67,8 @@
> void=B7mount_mem(char=B7*name,=B7char=B7*fs,=B7char=B7*options,=B7char=B7=
*path,=B7char=B7*path_new); =

>
> void=B7umount_mem(char=B7*path,=B7char=B7*path_new);
> /*=B7shared=B7*/
> -long=B7count_numa(long=B7nodes[]);
> +unsigned=B7int=B7get_a_numa_node(void=B7(*cleanup_fn)(void));
> int=B7=B7path_exist(const=B7char=B7*path,=B7...);
> long=B7read_meminfo(char=B7*item);
> void=B7set_sys_tune(char=B7*sys_file,=B7long=B7tune,=B7int=B7check);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm=
/Makefile
> index c8e064c..b17845b 100644
> --- a/testcases/kernel/mem/ksm/Makefile
> +++ b/testcases/kernel/mem/ksm/Makefile
> @@ -40,5 +40,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/=
ksm02.c
> index 92f1493..5546309 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -88,15 +88,15 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB char=B7*msg;
> =BB int=B7size=B7=3D=B7128,=B7num=B7=3D=B73,=B7unit=B7=3D=B71;
> =BB unsigned=B7long=B7nmask=B7=3D=B70;
> -=BB long=B7nodes[MAXNODES];
> +=BB unsigned=B7int=B7node;
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7ksm_options,=B7ksm_usage);
> =BB if=B7(msg=B7!=3D=B7NULL)
> =BB =BB tst_brkm(TBROK,=B7NULL,=B7"OPTION=B7PARSING=B7ERROR=B7-=B7%s",=B7=
msg);
> -=BB if=B7(count_numa(nodes)=B7<=3D=B71)
> -=BB =BB tst_brkm(TCONF,=B7NULL,=B7"required=B7a=B7NUMA=B7system.");
> +=BB node=B7=B7=3D=B7get_a_numa_node(tst_exit);
> +=BB nmask=B7=3D=B71=B7<<=B7node;
> =BB setup();
> @@ -103,8 +103,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB =BB Tst_count=B7=3D=B70;
> =BB =BB check_ksm_options(&size,=B7&num,=B7&unit);
> -=BB =BB nmask=B7=3D=B71=B7<<=B7nodes[1];
> =BB =BB if=B7(set_mempolicy(MPOL_BIND,=B7&nmask,=B7MAXNODES)=B7=3D=3D=B7-=
1)=B7{
> =BB =BB =BB if=B7(errno=B7!=3D=B7ENOSYS)
> =BB =BB =BB =BB tst_brkm(TBROK|TERRNO,=B7cleanup,
> @@ -115,8 +114,8 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB =BB }
> =BB =BB create_same_memory(size,=B7num,=B7unit);
> -=BB =BB write_cpusets(nodes[1]);
> +=BB =BB write_cpusets(node);
> =BB =BB create_same_memory(size,=B7num,=B7unit);
> =BB }
> =BB cleanup();
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/=
ksm04.c
> index 8a31051..6ecf3d0 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -88,15 +88,15 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB char=B7*msg;
> =BB int=B7size=B7=3D=B7128,=B7num=B7=3D=B73,=B7unit=B7=3D=B71;
> =BB unsigned=B7long=B7nmask=B7=3D=B70;
> -=BB long=B7nodes[MAXNODES];
> +=BB unsigned=B7int=B7node;
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7ksm_options,=B7ksm_usage);
> =BB if=B7(msg=B7!=3D=B7NULL)
> =BB =BB tst_brkm(TBROK,=B7NULL,=B7"OPTION=B7PARSING=B7ERROR=B7-=B7%s",=B7=
msg);
> -=BB if=B7(count_numa(nodes)=B7<=3D=B71)
> -=BB =BB tst_brkm(TCONF,=B7NULL,=B7"required=B7a=B7NUMA=B7system.");
> +=BB node=B7=B7=3D=B7get_a_numa_node(tst_exit);
> +=BB nmask=B7=3D=B71=B7<<=B7node;
> =BB setup();
> @@ -105,8 +105,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB =BB write_memcg();
> -=BB =BB nmask=B7=3D=B71=B7<<=B7nodes[1];
> =BB =BB if=B7(set_mempolicy(MPOL_BIND,=B7&nmask,=B7MAXNODES)=B7=3D=3D=B7-=
1)=B7{
> =BB =BB =BB if=B7(errno=B7!=3D=B7ENOSYS)
> =BB =BB =BB =BB tst_brkm(TBROK|TERRNO,=B7cleanup,
> @@ -117,8 +116,8 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB =BB }
> =BB =BB create_same_memory(size,=B7num,=B7unit);
> -=BB =BB write_cpusets(nodes[1]);
> +=BB =BB write_cpusets(node);
> =BB =BB create_same_memory(size,=B7num,=B7unit);
> =BB }
> =BB cleanup();
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib=
/Makefile
> index b22b1dd..399e290 100644
> --- a/testcases/kernel/mem/lib/Makefile
> +++ b/testcases/kernel/mem/lib/Makefile
> @@ -23,5 +23,6 @@
> include=B7$(top_srcdir)/include/mk/env_pre.mk
> CFLAGS=BB =BB =BB :=3D=B7-I../include
> LIB=BB =BB =BB :=3D=B7libmem.a
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/lib.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/me=
m.c
> index 81410d8..2077003 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -22,6 +22,7 @@
> #include=B7"safe_macros.h"
> #include=B7"_private.h"
> #include=B7"mem.h"
> +#include=B7"numa_helper.h"
> /*=B7OOM=B7*/
> @@ -67,8 +68,12 @@
> void=B7oom(int=B7testcase,=B7int=B7mempolicy,=B7int=B7lite)
> #if=B7HAVE_NUMA_H=B7&&=B7HAVE_LINUX_MEMPOLICY_H=B7&&=B7HAVE_NUMAIF_H=B7\
> =BB &&=B7HAVE_MPOL_CONSTANTS
> =BB unsigned=B7long=B7nmask=B7=3D=B70;
> -=BB long=B7nodes[MAXNODES];
> +=BB unsigned=B7int=B7node;
> +
> +=BB if=B7(mempolicy)
> +=BB =BB node=B7=3D=B7get_a_numa_node(cleanup);
> +=BB nmask=B7+=3D=B71=B7<<=B7node;
> #endif
> =BB switch=B7(pid=B7=3D=B7fork())=B7{
> @@ -76,9 +81,7 @@
> void=B7oom(int=B7testcase,=B7int=B7mempolicy,=B7int=B7lite)
> =BB case=B70:
> #if=B7HAVE_NUMA_H=B7&&=B7HAVE_LINUX_MEMPOLICY_H=B7&&=B7HAVE_NUMAIF_H=B7\
> =BB &&=B7HAVE_MPOL_CONSTANTS
> -=BB =BB count_numa(nodes);
> -=BB =BB nmask=B7+=3D=B71=B7<<=B7nodes[1];
> =BB =BB if=B7(mempolicy)
> =BB =BB =BB if=B7(set_mempolicy(MPOL_BIND,=B7&nmask,=B7MAXNODES)=B7=3D=3D=
=B7-1)
> =BB =BB =BB =BB tst_brkm(TBROK|TERRNO,=B7cleanup,
> @@ -107,13 +110,9 @@
> void=B7testoom(int=B7mempolicy,=B7int=B7lite,=B7int=B7numa)
> {
> =BB long=B7nodes[MAXNODES];
> -=BB if=B7(numa=B7&&=B7!mempolicy)=B7{
> -=BB =BB if=B7(count_numa(nodes)=B7<=3D=B71)
> -=BB =BB =BB tst_brkm(TCONF,=B7cleanup,=B7"required=B7a=B7NUMA=B7system."=
);
> -=BB =BB /*=B7write=B7cpusets=B7to=B72nd=B7node=B7*/
> -=BB =BB write_cpusets(nodes[1]);
> -=BB }
> +=BB if=B7(numa=B7&&=B7!mempolicy)
> +=BB =BB write_cpusets(get_a_numa_node(cleanup));
> =BB tst_resm(TINFO,=B7"start=B7normal=B7OOM=B7testing.");
> =BB oom(NORMAL,=B7mempolicy,=B7lite);
> @@ -715,17 +714,36 @@
> void=B7mount_mem(char=B7*name,=B7char=B7*fs,=B7char=B7*options,=B7char=B7=
*path,=B7char=B7*path_new) =

>
> /*=B7shared=B7*/
> -long=B7count_numa(long=B7nodes[])
> +/*=B7Warning:=B7*DO=B7NOT*=B7use=B7this=B7function=B7in=B7child=B7*/
> +unsigned=B7int=B7get_a_numa_node(void=B7(*cleanup_fn)(void))
> {
> -=BB long=B7nnodes,=B7i;
> +=BB unsigned=B7int=B7nd1,=B7nd2;
> +=BB int=B7ret;
> -=BB nnodes=B7=3D=B70;
> -=BB for=B7(i=B7=3D=B70;=B7i=B7<=3D=B7MAXNODES;=B7i++)
> -=BB =BB if=B7(path_exist(PATH_SYS_SYSTEM=B7"/node/node%d",=B7i))
> -=BB =BB =BB nodes[nnodes++]=B7=3D=B7i;
> +=BB ret=B7=3D=B7get_allowed_nodes(0,=B72,=B7&nd1,=B7&nd2);
> +=BB switch=B7(ret)=B7{
> +=BB case=B70:
> +=BB =BB break;
> +=BB case=B7-3:
> +=BB =BB tst_brkm(TCONF,=B7cleanup_fn,=B7"requires=B7a=B7NUMA=B7system.");
> +=BB default:
> +=BB =BB tst_brkm(TBROK|TERRNO,=B7cleanup_fn,=B7"1st=B7get_allowed_nodes"=
);
> +=BB }
> -=BB return=B7nnodes;
> +=BB ret=B7=3D=B7get_allowed_nodes(NH_MEMS|NH_CPUS,=B71,=B7&nd1);

Caspar, I found get_a_numa_node always return the first node id, which =

will make all cases called the function
only run in the first node, I don't think it's a good way, it decrease =

the coverage.

we should prefer to run cases on the second node, we can chose the first =

only if it just only has
one node with NH_MEMS|NH_CPUS. do you think so?

and others is good for me.

Thanks,
Zhouping
> +=BB switch=B7(ret)=B7{
> +=BB case=B70:
> +=BB =BB tst_resm(TINFO,=B7"get=B7node%lu.",=B7nd1);
> +=BB =BB return=B7nd1;
> +=BB case=B7-3:
> +=BB =BB tst_brkm(TCONF,=B7cleanup_fn,=B7"requires=B7a=B7NUMA=B7system=B7=
that=B7has=B7"
> +=BB =BB =BB =BB "at=B7least=B7one=B7node=B7with=B7both=B7memory=B7and=B7=
CPU=B7"
> +=BB =BB =BB =BB "available.");
> +=BB default:
> +=BB =BB break;
> +=BB }
> +=BB tst_brkm(TBROK|TERRNO,=B7cleanup_fn,=B7"2nd=B7get_allowed_nodes");
> }
> int=B7path_exist(const=B7char=B7*path,=B7...)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom=
/Makefile
> index c8e064c..b17845b 100644
> --- a/testcases/kernel/mem/oom/Makefile
> +++ b/testcases/kernel/mem/oom/Makefile
> @@ -40,5 +40,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/=
oom02.c
> index 551aad5..f0e784f 100644
> --- a/testcases/kernel/mem/oom/oom02.c
> +++ b/testcases/kernel/mem/oom/oom02.c
> @@ -48,8 +48,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> {
> =BB char=B7*msg;
> =BB int=B7lc;
> -=BB long=B7nodes[MAXNODES];
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7NULL,=B7NULL);
> =BB if=B7(msg=B7!=3D=B7NULL)
> @@ -58,10 +57,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB tst_brkm(TCONF,=B7NULL,=B7"test=B7is=B7not=B7designed=B7for=B732-bit=
=B7system.");
> #endif
> -=BB if=B7(count_numa(nodes)=B7<=3D=B71)
> -=BB =BB tst_brkm(TCONF,=B7NULL,=B7"required=B7a=B7NUMA=B7system.");
> -
> =BB setup();
> =BB for=B7(lc=B7=3D=B70;=B7TEST_LOOPING(lc);=B7lc++)=B7{
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/=
oom04.c
> index 4b15b2f..15ba660 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -49,8 +49,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB char=B7*msg;
> =BB int=B7lc;
> =BB int=B7swap_acc_on=B7=3D=B71;
> -=BB long=B7nodes[MAXNODES];
> =BB char=B7buf[BUFSIZ],=B7mem[BUFSIZ];
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7NULL,=B7NULL);
> @@ -60,10 +59,7 @@
> int=B7main(int=B7argc,=B7char=B7*argv[])
> =BB tst_brkm(TCONF,=B7NULL,=B7"test=B7is=B7not=B7designed=B7for=B732-bit=
=B7system.");
> #endif
> -=BB if=B7(count_numa(nodes)=B7<=3D=B71)
> -=BB =BB tst_brkm(TCONF,=B7NULL,=B7"required=B7a=B7NUMA=B7system.");
> -
> =BB setup();
> =BB for=B7(lc=B7=3D=B70;=B7TEST_LOOPING(lc);=B7lc++)=B7{
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/swapping/Makefile b/testcases/kernel/me=
m/swapping/Makefile
> index c8e064c..b17845b 100644
> --- a/testcases/kernel/mem/swapping/Makefile
> +++ b/testcases/kernel/mem/swapping/Makefile
> @@ -40,5 +40,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp=
/Makefile
> index 9eb197e..3ef9288 100644
> --- a/testcases/kernel/mem/thp/Makefile
> +++ b/testcases/kernel/mem/thp/Makefile
> @@ -41,5 +41,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/tunable/Makefile b/testcases/kernel/mem=
/tunable/Makefile
> index 9eb197e..3ef9288 100644
> --- a/testcases/kernel/mem/tunable/Makefile
> +++ b/testcases/kernel/mem/tunable/Makefile
> @@ -41,5 +41,6 @@
> trunk-clean::=B7|=B7lib-clean
> lib-clean::=B7$(LIBDIR)
> =BB $(MAKE)=B7-C=B7$^=B7-f=B7"$(abs_srcdir)/$^/Makefile"=B7clean
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma=
/Makefile
> index 3899fcb..949db9a 100644
> --- a/testcases/kernel/mem/vma/Makefile
> +++ b/testcases/kernel/mem/vma/Makefile
> @@ -21,7 +21,6 @@
> top_srcdir=B7=B7=B7=B7=B7=B7=B7=B7=B7=B7=B7=B7=B7=B7?=3D=B7../../../..
> include=B7$(top_srcdir)/include/mk/testcases.mk
> -LDLIBS=B7=BB=BB =BB +=3D=B7$(NUMA_LIBS)
> -
> +include=B7$(top_srcdir)/testcases/kernel/include/lib.mk
> include=B7$(top_srcdir)/include/mk/generic_leaf_target.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/=
vma02.c
> index f63bf77..13f0ce2 100644
> --- a/testcases/kernel/mem/vma/vma02.c
> +++ b/testcases/kernel/mem/vma/vma02.c
> @@ -43,6 +43,8 @@
> #include=B7<unistd.h>
> #include=B7"test.h"
> #include=B7"usctest.h"
> +#include=B7"safe_macros.h"
> +#include=B7"numa_helper.h"
> char=B7*TCID=B7=3D=B7"vma02";
> int=B7TST_TOTAL=B7=3D=B71;
> @@ -73,15 +75,18 @@
> int=B7main(int=B7argc,=B7char=B7**argv)
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7options,=B7usage);
> =BB if=B7(msg=B7!=3D=B7NULL)
> =BB =BB tst_brkm(TBROK,=B7NULL,=B7"OPTION=B7PARSING=B7ERROR=B7-=B7%s",=B7=
msg);
> +
> =BB if=B7(opt_node)=B7{
> -=BB =BB node=B7=3D=B7atoi(optarg);
> -=BB =BB if=B7(node=B7<=B71)
> -=BB =BB =BB tst_brkm(TBROK,=B7NULL,
> -=BB =BB =BB =BB "Number=B7of=B7NUMA=B7nodes=B7cannot=B7be=B7less=B7that=
=B71.");
> -=BB =BB numa_bitmask_setbit(nmask,=B7node);
> -=BB }=B7else
> -=BB =BB numa_bitmask_setbit(nmask,=B70);
> +=BB =BB node=B7=3D=B7SAFE_STRTOL(NULL,=B7opt_nodestr,=B71,=B7LONG_MAX);
> +=BB }=B7else=B7{
> +=BB =BB err=B7=3D=B7get_allowed_nodes(NH_MEMS|NH_MEMS,=B71,=B7&node);
> +=BB =BB if=B7(err=B7=3D=3D=B7-3)
> +=BB =BB =BB tst_brkm(TCONF,=B7NULL,=B7"requires=B7at=B7least=B7one=B7nod=
e.");
> +=BB =BB else=B7if=B7(err=B7<=B70)
> +=BB =BB =BB tst_brkm(TBROK|TERRNO,=B7NULL,=B7"get_allowed_nodes");
> +=BB }
> +=BB numa_bitmask_setbit(nmask,=B7node);
> =BB for=B7(lc=B7=3D=B70;=B7TEST_LOOPING(lc);=B7lc++)=B7{
> =BB =BB Tst_count=B7=3D=B70;
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/=
vma04.c
> index cff0342..eca4567 100644
> --- a/testcases/kernel/mem/vma/vma04.c
> +++ b/testcases/kernel/mem/vma/vma04.c
> @@ -48,6 +48,7 @@
> #include=B7"test.h"
> #include=B7"usctest.h"
> #include=B7"safe_macros.h"
> +#include=B7"numa_helper.h"
> char=B7*TCID=B7=3D=B7"vma04";
> int=B7TST_TOTAL=B7=3D=B75;
> @@ -85,8 +86,8 @@
> static=B7void=B7usage(void);
> int=B7main(int=B7argc,=B7char=B7**argv)
> {
> -=BB int=B7lc,=B7node;
> +=BB int=B7lc,=B7node,=B7err;
> =BB char=B7*msg;
> =BB msg=B7=3D=B7parse_opts(argc,=B7argv,=B7options,=B7usage);
> @@ -95,11 +96,15 @@
> int=B7main(int=B7argc,=B7char=B7**argv)
> =BB nmask=B7=3D=B7numa_allocate_nodemask();
> =BB if=B7(opt_node)=B7{
> =BB =BB node=B7=3D=B7SAFE_STRTOL(NULL,=B7opt_nodestr,=B71,=B7LONG_MAX);
> -=BB =BB numa_bitmask_setbit(nmask,=B7node);
> =BB }=B7else=B7{
> -=BB =BB numa_bitmask_setbit(nmask,=B70);
> +=BB =BB err=B7=3D=B7get_allowed_nodes(NH_MEMS|NH_MEMS,=B71,=B7&node);
> +=BB =BB if=B7(err=B7=3D=3D=B7-3)
> +=BB =BB =BB tst_brkm(TCONF,=B7NULL,=B7"requires=B7at=B7least=B7one=B7nod=
e.");
> +=BB =BB else=B7if=B7(err=B7<=B70)
> +=BB =BB =BB tst_brkm(TBROK|TERRNO,=B7NULL,=B7"get_allowed_nodes");
> =BB }
> +=BB numa_bitmask_setbit(nmask,=B7node);
> =BB setup();
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats.http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
>
>


---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
