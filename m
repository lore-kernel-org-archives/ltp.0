From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Feb 2020 09:55:36 +0100
Subject: [LTP] [PATCH v3 2/3] Split off executable code from
 bpf/bpf_common.h
In-Reply-To: <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
 <20200217141622.26912-2-mdoucha@suse.cz>
 <CAEemH2fvquWe_+-Au-Z0wRaYt0V943A1zszJVPCXO6HrLWH9Yg@mail.gmail.com>
Message-ID: <20200218085536.GB25228@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> May I ask why we need to reserve these *.o binary files in the compiling?

> # ls
> bpf_common.c  bpf_common.o  bpf_map01.c  bpf_prog01    bpf_prog01.o
>  bpf_prog02.c  bpf_prog03    bpf_prog03.o
> bpf_common.h  bpf_map01     bpf_map01.o  bpf_prog01.c  bpf_prog02
>  bpf_prog02.o  bpf_prog03.c  Makefile


> Otherwise, the patchset looks good.
>     Acked-by: Li Wang <liwang@redhat.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
(+1 for Li change to Makefile).

Kind regards,
Petr
