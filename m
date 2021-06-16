From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 12:01:50 +0200
Subject: [LTP] [RFC PATCH 3/3] doc: Update LTPROOT and PATH environment
 variables
In-Reply-To: <CAEemH2eLDk8rb3wUMCjz6Txo333f4Mae1AWZy0Rt6mTYuvYf6w@mail.gmail.com>
References: <20210615163307.10755-1-pvorel@suse.cz>
 <20210615163307.10755-4-pvorel@suse.cz>
 <CAEemH2eLDk8rb3wUMCjz6Txo333f4Mae1AWZy0Rt6mTYuvYf6w@mail.gmail.com>
Message-ID: <YMnMDulm9C+SDdXa@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> > +$ LTPROOT=/opt/ltp testcases/bin/wc01.sh

> I'm wondering does this really work? or, did I miss something?
Oops, I'm sorry to send broken patchset, this is obviously wrong.
We have to keep path set when calling script directly, because tst_test.sh would
be missing.

when in LPTROOT directory:
LTPROOT=/opt/ltp testcases/bin/wc01.sh
testcases/bin/wc01.sh: line 13: .: tst_test.sh: file not found

But we don't want to set path in each script nor load library as
. testcases/bin/tst_test.sh

Thus I guess setting PATH in LTP API doesn't make much sense if it works only
when using LTP runner (runltp{,-ng}, which BTW set path as well.
=> closing this.

> Experiment in my kvm guest (with apply your patches):

> # LTPROOT=/root/ltp-install wc01.sh
> bash: wc01.sh: command not found...
I would not expect this to be running, for this you obviously need to have set
PATH correctly.

> # LTPROOT=/root/ltp-install testcases/bin/wc01.sh
> -bash: testcases/bin/wc01.sh: No such file or directory
Nor this one.

Kind regards,
Petr

> # LTPROOT=/root/ltp-install PATH="$PATH:$LTPROOT/testcases/bin" wc01.sh
> wc01 1 TINFO: timeout per run is 0h 5m 0s
> wc01 1 TPASS: wc passed with -c option.
> wc01 2 TPASS: wc passed with --bytes option.
> wc01 3 TPASS: wc passed with -l option.
> wc01 4 TPASS: wc passed with --lines option.
> wc01 5 TPASS: wc passed with -L option.
> wc01 6 TPASS: wc passed with --max-line-length option.
> wc01 7 TPASS: wc passed with -w option.
> wc01 8 TPASS: wc passed with --words option.
> wc01 9 TPASS: wc passed with -m option.
> wc01 10 TPASS: wc passed with --chars option.
> wc01 11 TPASS: wc passed with --help option.
> wc01 12 TPASS: wc passed with --version option.

> Summary:
> passed   12
> failed   0
> broken   0
> skipped  0
> warnings 0
