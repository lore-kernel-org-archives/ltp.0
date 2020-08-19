From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 19 Aug 2020 09:34:12 +0800
Subject: [LTP] [PATCHv2 1/2] lib/tst_kvercmp: Add support to get
 distname for different OS in tst_kvcmp_distname
In-Reply-To: <20200818183019.GH27964@yuki.lan>
References: <20200818100422.27775-1-po-hsu.lin@canonical.com>
 <20200818100422.27775-2-po-hsu.lin@canonical.com>
 <20200818152941.GG27964@yuki.lan>
 <CAMy_GT9kZbvC9=t9e2J4nrfW+vMHzK-DH2bU3=ZbkJepk4TrEQ@mail.gmail.com>
 <20200818183019.GH27964@yuki.lan>
Message-ID: <CAMy_GT8Ek5f=tNVH-s2yo1iJ5D8oGcUx6ypUzsNqNZYraNo1FA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 19, 2020 at 2:29 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > oh indeed, the delimiter in strtok will become null character anyway.
> > I think just tok = distname can do the trick here.
> > I will send v3 tomorrow.
>
> I can easily fix that before I push the patch, no need for v3.

Hello Cyril,
that would be great, thanks for the review!

>
> --
> Cyril Hrubis
> chrubis@suse.cz
