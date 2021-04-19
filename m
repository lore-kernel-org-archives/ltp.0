From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Apr 2021 09:52:18 +0200
Subject: [LTP] [PATCH v2] pec: Fix multiple event test
In-Reply-To: <1672a8d4-e278-801b-a2f6-babdc473f42e@jv-coder.de>
References: <20210415090542.960158-1-lkml@jv-coder.de> <YHnLrGS1lXy5Awvk@pevik>
 <1672a8d4-e278-801b-a2f6-babdc473f42e@jv-coder.de>
Message-ID: <YH02siPsNaI1mtIW@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi,

> On 4/16/2021 7:38 PM, Petr Vorel wrote:
> > Hi Joerg,

> > ...
> > > +# Find a free file handle
> > > +free_fd()
> > > +{
> > > +	local fd
> > > +
> > > +	for fd in $(seq 200); do
> > > +		# Sapwn a new sh, because redirecting to a non existing file handle
> > > +		# will trigger a syntax error.
> > > +		/bin/sh -c ": 2>/dev/null >&$fd || : 2>/dev/null <&$fd" 2>/dev/null
> > Probably better to use sh -c "..."
> I used? /bin/sh, because that is the same interpreter specified in the
> shebang. Just using sh could theoretically fail or spawn a different shell.
> Maybe $SHELL would be better, but I don't know how widely this is
> supported...
I meant that 'sh' is on any linux system /bin/sh (or a symlink to
/usr/bin/sh, i.e. a default shell. No need to specify it with full path.
We happily use elsewhere just sh, not /bin/sh.


> > > +		if [ $? -eq 2 ]; then
> > > +			echo $fd
> > > +			return
> > > +		fi
> > > +	done
> > maybe I do something wrong, but this version fails for me
> > (and I'm still testing it only on bash):

> > cn_pec 1 TINFO: timeout per run is 0h 5m 0s
> > cn_pec 1 TINFO: Test process events connector
> > cn_pec 1 TINFO: Testing fork event (nevents=10)
> > cn_pec 1 TBROK: No free filehandle found

> > I guess there is something wrong free_fd().

> Damn shells... I just realized /bin/sh on my system was dash's sh emulation
> and it does not emulate sh the same way bash does...
Yes, unfortunately it's required to test shell tests at least on bash and dash.

I also try to test on busybox sh (ash implementation), which commonly used on
embedded (it mostly works if dash works). Some time ago I tested even on android
shell, but I give up (expecting anybody playing with LTP on android should
install busybox).

> The return value in bash is 1, not two... Can you please check the patch
> with [ $? -ne 0 ]? That should work for all shells.
Yes it works. I'll have a look at the rest of the patch today.

Kind regards,
Petr

> J?rg
