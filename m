From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Sep 2018 01:50:21 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] lib: introduce tst_timeout_remaining()
In-Reply-To: <20180830124151.GE6363@rei.lan>
References: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
 <706273620.43655984.1535626905479.JavaMail.zimbra@redhat.com>
 <20180830112246.GB6363@rei.lan> <20180830113034.GC6363@rei.lan>
 <1443598375.43662526.1535630056840.JavaMail.zimbra@redhat.com>
 <20180830120256.GD6363@rei.lan>
 <1490142235.43668138.1535631426014.JavaMail.zimbra@redhat.com>
 <20180830124151.GE6363@rei.lan>
Message-ID: <1553589857.44165913.1535953821539.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Ok. So do we stay with v4 (with updated elapsed line) or should I
> > replace tst_clock_gettime in testrun() with call to heartbeat?
> 
> I would go for the one with the heartbeat() at the start of the
> testrun().

Thanks, pushed.

Jan
