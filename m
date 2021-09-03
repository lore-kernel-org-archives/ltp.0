From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Sep 2021 10:53:33 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
In-Reply-To: <73036de1-6a17-36c2-4ce0-663d1bd6a267@jv-coder.de>
References: <20210902103740.19446-1-pvorel@suse.cz>
 <015140e9-0eba-4057-4a91-35d958af2bb8@jv-coder.de>
 <YTDpQxDDPY3HCli6@pevik>
 <16028467-ecd5-ecc0-26d7-b7a617045970@jv-coder.de>
 <YTHSO4IQ+Qn1Fo8l@pevik>
 <73036de1-6a17-36c2-4ce0-663d1bd6a267@jv-coder.de>
Message-ID: <YTHijSezRFjCP/C+@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> On 9/3/2021 9:43 AM, Petr Vorel wrote:

> > > > > $ checkbashisms testcases/kernel/connectors/pec/cn_pec.sh
> > > > > possible bashism in testcases/kernel/connectors/pec/cn_pec.sh line 127
> > > > > (should be >word 2>&1):
> > > > >   ??????????????? done <&${fd_act}
> > > > > This one is just a false positive and I have no clue how to prevent this.
> > > > > I think the script does not like the <&, but this is posix...
> > > > The same here, I'm not sure if it's POSIX. &> definitely is not POSIX.
> > > > I remember we were talking about it. Can we avoid it somehow?
> > > <&n is the only way to use the file handle n for input. <n would use the
> > > file n.
> > > See: https://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_07_05
> > > checkbashisms has no problems if n is a number, not a variable. There is
> > > nothing in the standard about n being a variable, but I guess this should be
> > > posix as well.
> > > Furthermore the suggested fix "(should be >word 2>&1)" clearly shows, that
> > > checkbashisms thinks, this is &>.
> > Agree, it's very likely checkbashims bug which should be fixed.

> > > I don't see another way to implement this (but using an implementation in
> > > c). And I am not really happy to bend my code around bugs in a tool, that is
> > > supposed to ensure better code.
> > +1
> > > I'd rather try to fix checkbashims in this case. Even the ((-case should be
> > > fixed, after checking if it is posix. The suggestion (replace with "$((")
> > > indicates at least a bug in the tool.
> > I'll try to search for $(( )) in POSIX docs.

> > What is the outcome? Should I first fix checkbashisms before merging these?
> > I suggest to merge it for local checking (similar to checkpatch.pl for C).
> > Because it cannot be used in CI right now, not even because these 2 false
> > positives, but because not everything has been converted to use new shell API.
> I am not sure what the best way is here. I am not against integrating it,
> even with the bugs,
Thanks! Feel free to add your ack to patches.

> just against being "religious" about fixing "bugs" found by it.
Agree.

> Of course that means, no way,
> to enable it for ci, at least not without enforcement... But it allows
> developers, to quickly run it.
My short term goal is to run make check-* for those library parts which are
ready for it (both C and shell). That means to list specific targets (some work,
but I'd really have in CI before we convert all tests which allows us to convert
library). We could also add some filtering target to make check, which would be
enabled by environment variable (default off to allow see errors locally,
enabled only for CI).

> > > To be honest, I am a bit disappointed from this tool. It doesn't seem to be
> > > tested very well... Probably barely good enough for scripting in the kernel.
> > This tool comes from Debian, written long time ago (2009) for release goal to
> > use dash as /bin/sh [1] [2]. Kernel developers usually don't care about POSIX
> > shell and happily use /bin/bash with all arrays and other crazy bashisms.
> Yeah I mixed up checkbashisms and checkpatch... That's why I pulled linux
> into this :)
Ah :).

> > There is tool shellcheck, which IMHO has a lot of false positives (I suppose
> > Cyril agrees with it, as he added checkbashisms to our docs long time ago) and
> > we both aren't happy about occasional patches which are based on it's output.
> > See full output below for comparison. E.g. in "In POSIX sh, 'local' is undefined" is
> > useless, if we decide to trust local, at least for "local msg" i.e. without
> > assignment. Or other not useful for us:
> > SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.

> > Not sure about: TST_ARGS="$@":
> > SC2124: Assigning an array to a string! Assign as array, or use * instead of @ to concatenate.

> > The only good thing about shellcheck is that it has full shell parser [3],
> > unlike checkbashisms.

> Actually scrolling over the results, there are a lot of valid complaints,
> e.g. missing quotes.
> At least there are no false-positives (as per definition of spellcheck), as
> far as I see.
Yep, I have better impression now than I had before. But integrating it would
require even more fixes than checkbashisms.

> Would it be possible to tailor it for ltp?
Would you prefer to have just shellcheck or use both?

Also both checkbashisms [4] and shellcheck [5] are supported on various distros.
We have vendored checkpatch.pl to allow modifications, the same is for
checkbashisms. Both are perl, which is ok for us as not-required dependency for
building LTP (we already use perl partly for docparse). shellcheck is Haskell
=> we don't want to bring Cabal to LTP build toolchain. But it looks it
shouldn't be needed as it's configurable via .shellcheckrc or in runtime with
--exclude=CODE.

@Cyril?

[4] https://pkgs.org/search/?q=checkbashisms
[5] https://pkgs.org/search/?q=shellcheck
[6] https://github.com/koalaman/shellcheck/tree/master/src/ShellCheck
