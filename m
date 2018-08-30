From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Aug 2018 13:22:47 +0200
Subject: [LTP] [PATCH v4 1/2] lib: introduce tst_timeout_remaining()
In-Reply-To: <706273620.43655984.1535626905479.JavaMail.zimbra@redhat.com>
References: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
 <20180830104219.GA6363@rei.lan>
 <706273620.43655984.1535626905479.JavaMail.zimbra@redhat.com>
Message-ID: <20180830112246.GB6363@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I didn't want to do that, because a test might want calculate something
> based on timeout in setup(), for example to find current overall timeout
> value with LTP_TIMEOUT_MUL taken into account.
> 
> For that to work, we have to initialize tst_start_time prior to
> tst_test->setup().

Fair enough, also the alarm() in the test library pid is set before we
run the test setup, so if the test setup would take a few seconds we
will be off with the calculation. Although that could be fixed by
calling heartbeat before we run the loop in testrun(), which I guess
should be done anyway. That in turn would allow for your patch to have
the clock_gettime only in the heartbeat function, right?

-- 
Cyril Hrubis
chrubis@suse.cz
