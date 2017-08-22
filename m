From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 10:04:02 +0200
Subject: [LTP] [PATCH v2 1/1] ltp-pan: Log start of test in kernel log
In-Reply-To: <20170821180323.GA17165@rei.lan>
References: <20170821141106.30862-1-pvorel@suse.cz>
 <20170821180323.GA17165@rei.lan>
Message-ID: <20170822080402.dvr66i662vpgiosg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> I guess that we should add the -Q flag to the runltp script as well,
> otherwise it looks good to me.

I'll add to runltp and testscripts/network.sh as these are used.

If there are any other scripts you want me to add it please let me know (candidates are runltplite.sh and testscripts/*.sh - these using getopt/getopts.


Kind regards,
Petr
