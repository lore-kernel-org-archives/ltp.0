From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 14:41:07 +0100
Subject: [LTP] [RFC] Users of memory_hotplug/memtoy
Message-ID: <20171031134107.de3sdhy5ycu6gaqp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi there,

does anyone use memtoy from testcases/kernel/hotplug/memory_hotplug/ ?
Or know how to use it? Is it useful?

This was imported to LTP from linux foundation [1] long time ago.
The project then moved into github [2] but it hasn't been updated for 9 years.

I have some tiny fixes touching it in my patch-set "fix 32 bit cross-compilation"
[3] [4] [5] [6] [7], but as Cyril pointed out [8], we're not actually running it
so it's a question whether is useful (and we should run it) or delete whole directory.


Kind regards,
Petr

[1] http://devresources.linux-foundation.org/dev/hotplug/
[2] https://github.com/kosaki/memtoy
[3] http://lists.linux.it/pipermail/ltp/2017-October/006143.html
[4] http://lists.linux.it/pipermail/ltp/2017-October/006146.html
[5] http://lists.linux.it/pipermail/ltp/2017-October/006147.html
[6] http://lists.linux.it/pipermail/ltp/2017-October/006148.html
[7] http://lists.linux.it/pipermail/ltp/2017-October/006149.html
[8] http://lists.linux.it/pipermail/ltp/2017-October/006222.html
