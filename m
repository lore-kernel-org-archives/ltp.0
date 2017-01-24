From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jan 2017 14:59:00 +0100
Subject: [LTP] [RFC PATCH v2 1/1] test.sh: colorize the output
In-Reply-To: <20170123121209.GA22484@rei.lan>
References: <20170120161024.1744-1-pvorel@suse.cz>
 <20170123121209.GA22484@rei.lan>
Message-ID: <20170124135900.kueiezajhxxgcu2h@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for review. Fixed most things, I'll post it as v2. Before just a couple comments:

> > * Allow user to define colors (overwrite with environment variables) -
> >   allow to handle dark vs. light terminal background.
> I still think that this is too much work for no real gain...
OK.

> > * Colorize also "ltp-pan reported PASS|FAIL".

> I would avoid doing any changes to ltp-pan, that code is old and complex
> and in maintenance mode only.

I mean these:
$ git grep -i "echo ltp-pan reported"
testscripts/diskio.sh:  echo ltp-pan reported PASS
testscripts/diskio.sh:  echo ltp-pan reported FAIL
testscripts/network.sh:	echo ltp-pan reported PASS
testscripts/network.sh:	echo ltp-pan reported FAIL
testscripts/runEALtests.sh:  echo ltp-pan reported PASS
testscripts/runEALtests.sh:  echo ltp-pan reported FAIL

Not really important, just nice to have complete. It'd just use colors from
tst_ansi_color.sh (separate color file).


> > * DOC: where to put docs?

> I'm unsure as well. I guess that we can start a new file under doc/ if
> we do not find a better fit.

Syntax: plain doc or github markdown? Some of files are used for github wiki, but not all.


Kind regards,
Petr
