From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 26 Apr 2021 14:17:50 +0200
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <YIE0INnCJOMGYQQR@pevik>
References: <YH7Z8nOX90qjsMpa@yuki> <YIE0INnCJOMGYQQR@pevik>
Message-ID: <CADYN=9L9ic-q44dNPvDmDo1T+-=U+gDqUrKWGX_L2tUkpamYPA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 22 Apr 2021 at 10:30, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Cyril,
>
> Thank you for bringing the discussion to upstream runltp-ng.
>
> I'd prefer to add the project to ltp git

I agree with that too.
Also if we can seamlessly move from runltp to runltp-ng, since we
don't want the behavior to change.
Or we need to support both for a release or two and then remove runltp.


Cheers,
Anders

>, in runltp-ng/ in root directory.
> And add either a symlink runltp-ng/runltp-ng to the root directory or have a
> shell script which runs it:
> perl -I$(readlink -f $0)/runltp-ng $(readlink -f $0)/runltp-ng/runltp-ng $@
>
> Kind regards,
> Petr
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
