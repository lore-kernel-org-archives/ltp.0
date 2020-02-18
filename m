From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 18 Feb 2020 09:44:19 +0100
Subject: [LTP] [PATCH v3 2/3] Split off executable code from
 bpf/bpf_common.h
In-Reply-To: <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
 <20200217141622.26912-2-mdoucha@suse.cz>
 <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
Message-ID: <7d52d4b5-c9ae-2cf8-5742-85ce4e55ff67@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/18/20 9:15 AM, Li Wang wrote:
>     diff --git a/testcases/kernel/syscalls/bpf/Makefile
>     b/testcases/kernel/syscalls/bpf/Makefile
>     index 990c8c83c..2241bce9b 100644
>     --- a/testcases/kernel/syscalls/bpf/Makefile
>     +++ b/testcases/kernel/syscalls/bpf/Makefile
>     @@ -5,6 +5,9 @@ top_srcdir? ? ? ? ? ? ? ?= ../../../..
> 
>     ?include $(top_srcdir)/include/mk/testcases.mk <http://testcases.mk>
> 
>     +FILTER_OUT_MAKE_TARGETS? ? ? ? := bpf_common
>     ?CFLAGS? ? ? ? ? ? ? ? ?+= -D_GNU_SOURCE
> 
>     ?include $(top_srcdir)/include/mk/generic_leaf_target.mk
>     <http://generic_leaf_target.mk>
>     +
>     +$(MAKE_TARGETS): %: %.o bpf_common.o
> 
> 
> May I ask why we need to reserve these *.o binary files in the compiling?

Sorry, I don't understand the question.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
