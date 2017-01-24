From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 15:05:23 +0100
Subject: [LTP] [RFC PATCH v2 1/1] test.sh: colorize the output
In-Reply-To: <20170124135900.kueiezajhxxgcu2h@dell5510>
References: <20170120161024.1744-1-pvorel@suse.cz>
 <20170123121209.GA22484@rei.lan>
 <20170124135900.kueiezajhxxgcu2h@dell5510>
Message-ID: <20170124140523.GF29054@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I mean these:
> $ git grep -i "echo ltp-pan reported"
> testscripts/diskio.sh:  echo ltp-pan reported PASS
> testscripts/diskio.sh:  echo ltp-pan reported FAIL
> testscripts/network.sh:	echo ltp-pan reported PASS
> testscripts/network.sh:	echo ltp-pan reported FAIL
> testscripts/runEALtests.sh:  echo ltp-pan reported PASS
> testscripts/runEALtests.sh:  echo ltp-pan reported FAIL
> 
> Not really important, just nice to have complete. It'd just use colors from
> tst_ansi_color.sh (separate color file).

Hmm, I wouldn't touch these scripts at all...

> > > * DOC: where to put docs?
> 
> > I'm unsure as well. I guess that we can start a new file under doc/ if
> > we do not find a better fit.
> 
> Syntax: plain doc or github markdown? Some of files are used for github wiki, but not all.

Well I started to use asciidoc for the documents before we moved to the
GitHub which uses markdown by default. However GitHub supports most of
the asciidoc syntax as well, so I would just continue using that.

-- 
Cyril Hrubis
chrubis@suse.cz
