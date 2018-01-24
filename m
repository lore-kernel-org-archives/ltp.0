From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jan 2018 15:13:19 +0100
Subject: [LTP] [PATCH 1/1] network/stress: Update README
In-Reply-To: <20180124132104.GA32270@rei>
References: <20170920092918.19960-1-pvorel@suse.cz>
 <20180124111834.GB14773@rei.lan>
 <20180124131043.dbufum2zn6ekrkzc@dell5510>
 <20180124132104.GA32270@rei>
Message-ID: <20180124141319.aftcv6gp7k6nm2mh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > I'd propose to use simple relative path, e.g. INSTALL. Most of the projects use it (at
> > least for files like README or INSTALL in root of source tree.

> > Or, if we really need absolute path, lets use $LTPROOT, e.g. $LTPROOT/INSTALL.

> Sounds good.
I suppose you meant first variant (just 'INSTALL').
String 'ltp-yyyymmdd/' is in 421 files. If you don't mind I'll keep this commit how it is
and remove 'ltp-yyyymmdd/' from all files in one commit.


Kind regards,
Petr
