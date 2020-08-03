From: Li Wang <liwang@redhat.com>
Date: Mon, 3 Aug 2020 15:52:34 +0800
Subject: [LTP] [PATCH 3/3] build system: Silence the output a bit more
In-Reply-To: <20200731121508.12805-4-chrubis@suse.cz>
References: <20200731121508.12805-1-chrubis@suse.cz>
 <20200731121508.12805-4-chrubis@suse.cz>
Message-ID: <CAEemH2cesasP_fwGu18S4tKuWP4_+69ssKSx1ErL=0E6kNcRvA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +ifdef VERBOSE
>         @set -e; for dir in $(SUBDIRS); do \
>             $(MAKE) -C "$$dir" -f "$(abs_srcdir)/$$dir/Makefile" $@; \
>         done
> +else
> +       @set -e; for dir in $(SUBDIRS); do \
> +           echo "DIR $$dir"; \
>

I don't think to print the DIR has any help for debugging, we could find
the correct source file easily without it too.

Otherwise, the patchset looks pretty good.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200803/0341da2c/attachment.htm>
