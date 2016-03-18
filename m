From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2016 15:57:39 +0800
Subject: [LTP] [PATCH RFC 5/9] ftrace_regression: add a new testcase
In-Reply-To: <20160317165020.GF31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <20160317165020.GF31815@rei.lan>
Message-ID: <CAEemH2ekX2w0NiZj5V6Q1vjPxwPEdJFwGOMaQOx4YKJFNaBm7A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for reviewing. Comments in follows:

On Fri, Mar 18, 2016 at 12:50 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >
> +###############################################################################
> > +#
>        #
> > +# Copyright (c) 2015, Red Hat Inc.
>       #
> > +#
>        #
> > +# This program is free software; you can redistribute it and/or modify
> it     #
> > +# under the terms of the GNU General Public License as published by the
> Free  #
> > +# Software Foundation; either version 2 of the License, or (at your
> option)   #
> > +# any later version.
>       #
> > +#
>        #
> > +# PURPOSE: check signal:signal_generate gives 2 more fields: grp res
>       #
> > +#
>        #
> > +# This testcase is verifing signal events change:
>        #
> > +#        6c303d3 tracing: let trace_signal_generate() report more
> info...     #
> > +#        163566f tracing: send_sigqueue() needs trace_signal_generate()
> too   #
> > +#
>        #
> >
> +###############################################################################
> > +
> > +
> > +# Set envent
> > +echo 'signal:signal_generate' > $TRACING_PATH/set_event
> > +
> > +echo 1 > $TRACING_PATH/tracing_on
> > +
> > +echo > $TRACING_PATH/trace
> > +
> > +sleep 10
>
> Why sleep 10 here?
>

It's waiting for ftrace capture the system trace. There probably no any
trace be recorded if we check it at once.


> > +grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
> > +if [ $? -eq 0 ]; then
> > +     exit 0
> > +else
> > +     exit 1
> > +fi
>
> Use test.sh and tst_resm instead.
>

Sure, I'd like to make change of the patches(2/9  -- 5/9) as your suggested.

CC' chuhu@ here. Since the patches(6/9  -- 9/9) were signed off by him.



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160318/2cd9dac2/attachment.html>
