From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Feb 2020 09:53:28 +0100
Subject: [LTP] [PATCH v3 2/3] Split off executable code from
 bpf/bpf_common.h
In-Reply-To: <CAEemH2esmZq12fFL4U-TzzvaKrKS1a-+nz7jZoN923880+dTZw@mail.gmail.com>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
 <20200217141622.26912-2-mdoucha@suse.cz>
 <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
 <7d52d4b5-c9ae-2cf8-5742-85ce4e55ff67@suse.cz>
 <CAEemH2esmZq12fFL4U-TzzvaKrKS1a-+nz7jZoN923880+dTZw@mail.gmail.com>
Message-ID: <20200218085328.GA25228@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Sorry for the unclear question. I mean can we modify the Makefile as:

> --- a/testcases/kernel/syscalls/bpf/Makefile
> +++ b/testcases/kernel/syscalls/bpf/Makefile
> @@ -10,4 +10,4 @@ CFLAGS                        += -D_GNU_SOURCE

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

> -$(MAKE_TARGETS): %: %.o bpf_common.o
> +$(MAKE_TARGETS): %: bpf_common.o
+1 that removes object files.


Kind regards,
Petr
