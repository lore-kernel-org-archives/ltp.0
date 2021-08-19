From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Aug 2021 11:59:22 +0800
Subject: [LTP] [PATCH 1/3] tst_test.sh: Simplify tst_cmd_available()
In-Reply-To: <YRzVpQT1zYOvxlWe@pevik>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-2-pvorel@suse.cz>
 <7ac7a1d6-2d97-f8f5-8d60-040eb0753681@jv-coder.de> <YRzVpQT1zYOvxlWe@pevik>
Message-ID: <CAEemH2es_CzWugkyOworVLFe+ZbtFxpYXK5HjdE_g_w4wHvzVQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 18, 2021 at 5:41 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Joerg,
>
> ...
> > > +   type $1 >/dev/null 2>&1
> > I guess there was a reason, why command was used here in the first place.
> > Iirc type is often a shell builtin, that can have different behavior,
> while
> > command -v is posix and should be extremely portable.
> > So maybe it is better to use "command -v" instead of type here. I hope
> most
> > distributions have a command-command...
> Well, I wrote that code, in dba1d50cb :). IMHO both are POSIX and both are
> shell
> builtin.
>

Another reason, I guess, is `command -v ` looks to match the function name
more:).
But it depends on you, I'm OK with any of them.

Reviewed-by: Li Wang <liwang@redhat.com>



>
> I tested it on all implementations and the only difference is that both
> "type"
> and "command -v" on dash and busybox sh returns 127 on missing command,
> the rest
> return 1.
>

Sounds great!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210819/e923ea43/attachment.htm>
