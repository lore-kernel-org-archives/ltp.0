From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Sep 2019 17:39:08 +0200
Subject: [LTP] 12abeb544d: ltp.read_all_dev.fail
In-Reply-To: <871rw7l9dv.fsf@rpws.prws.suse.cz>
References: <20190923003846.GB15734@shao2-debian>
 <871rw7l9dv.fsf@rpws.prws.suse.cz>
Message-ID: <20190923153908.GA379@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > FYI, we noticed the following commit (built with gcc-7):

> > commit: 12abeb544d548f55f56323fc6e5e6c0fb74f58e1 ("horrible test hack")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git random/kill-it

...
> > tst_test.c:1108: INFO: Timeout per run is 0h 05m 00s
> > Test timeouted, sending SIGKILL!
> > tst_test.c:1148: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > tst_test.c:1149: BROK: Test killed! (timeout?)

> So perhaps this is caused by reads of /dev/random hanging?

> At any rate,
> I suppose this is intended to deliberately break something, so we can
> ignore it.
Yep, I'd ignore it, [1] really looks like the commit description "horrible test hack" :)

Kind regards,
Petr

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git/+/12abeb544d548f55f56323fc6e5e6c0fb74f58e1%5E%21/#F0
