From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Apr 2019 14:35:10 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190430090406.GA30997@rei.lan>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
 <20190429204527.GA30772@dell5510> <20190430090406.GA30997@rei.lan>
Message-ID: <20190430123510.GA30176@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > Tested-by: Petr Vorel <pvorel@suse.cz>

> > This one looks ok. Also testing with machine with 32 cores, ok as well (but it's
> > hard to trigger this bug even current master).

> Sigh, apparenlty this has patch has two obvious typos, both
> abs_top_builddir and abs_top_srcdir are spelled incorrectly, no wonder
> it does not work, sorry for that.
With this fix (used as commits [1] [2]) looks it fixed it.
21 times or fewer was needed o trigger the build on master, now ok with 33
builds. I'll keep it running during the day just for sure, but consider it
fixed.

> And the only reason why this works for in-tree build is because with
> typos we do no replace anything and the path to the Makefile is correct
> for in-tree build.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/commit/22fd15ad08166dc2ec4c8e93884e51be4a46c1b6
[2] https://github.com/pevik/ltp/commit/10a783538331df8616384f1d9d62c334c117c918
