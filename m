From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Jun 2016 03:34:35 -0400 (EDT)
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
Message-ID: <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 14 June, 2016 4:37:29 PM
> Subject: Re: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
> 
> Hi Jan,
> 
> On Tue, Jun 14, 2016 at 7:27 PM, Jan Stancek <jstancek@redhat.com> wrote:
> > This patch adds 2 new functions that both parse data
> > from /proc/meminfo.
> 
> It is a good proposal, but the achieved function seems a little bit
> narrow for ltp-lib.

OK, let me try to come up with something more generic.

> Can we
> rename the tst_mem.h to tst_proc.h, and makes the whole items of
> procfs could be readable via the same interfaces?

They don't all share same format, so there have to be some limitations.

> And the strict
> parameter is not necessary for the function i think.

We could leave that up to caller.

Regards,
Jan
