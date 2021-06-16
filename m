From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 09:03:29 +0200
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YKzX7FPWGGROn6kR@pevik>
 <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YMmiQfWgvqtCzOmg@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> +++ b/testcases/kernel/syscalls/mallinfo2/Makefile
...
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS += -I../mallinfo
Also this needs to be
CFLAGS += -I$(abs_srcdir)/../mallinfo

otherwise out of tree builds fail:
https://github.com/pevik/ltp/actions/runs/941820122

BTW Cyril also suggested recently to drop out of tree support, because build
system dependencies are broken and fixing it would be much easier when
supporting only in tree build.

Kind regards,
Petr
