From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Sep 2020 22:11:17 +0200
Subject: [LTP] LTP release
In-Reply-To: <20200908073138.GB2475@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
Message-ID: <20200909201117.GB27395@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> As usual we should start preparing for a next release.

...
> What else should go in?

I haven't done review of Amir's fanotify tests for v5.9, but on first look they
look ok
https://patchwork.ozlabs.org/project/ltp/list/?series=200606

How about Richie's Wrapper for Syzkaller reproducers?
https://patchwork.ozlabs.org/project/ltp/patch/20200610072928.1331-1-rpalethorpe@suse.com/

I wanted to post docparser patch in next few days. But that will be probably too
late for including in this release.

Kind regards,
Petr
