From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Oct 2018 16:12:26 +0800
Subject: [LTP] [PATCH v2 2/4] fzsync: Simplify API with start/end race
 calls and limit exec time
In-Reply-To: <87ftxgy5y7.fsf@rpws.prws.suse.cz>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-3-rpalethorpe@suse.com>
 <CAEemH2f1NZut2amfmntr0+rr7GTzFCCgT3LoOQmO_n=jMhmKdA@mail.gmail.com>
 <87ftxgy5y7.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2dUZpQn9hwgr0QC6DRrSDDHuxwWiQOcwTfFutknk6yxKQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

>
> > Here we start to get the whole remain time before reaching timeout
> > aborting, and base on that to comparing in tst_fzsync_run_a() to
> guarantee
> > test exit when execute time exceed. That's fine, but it is too early to
> get
> > the time here I guess, because samples collection will also cost some of
> > the limitation_time(~30 seconds), and we don't know what proportion the
> > sampling occupied in exec_time_p, if it's too much, then there only has
> > very little time on race execution.
>
> The race can still happen during the sampling period (although for some
> tests it is unlikely).
>

Sounds right.


>
> >
> > To avoid this, maybe we should make the limitation time all spend on race
> > execution but any on samplings.
> > So, I suggest to get pair->exec_time_start value after samples data
> > collection in the end of tst_fzsync_pair_update() function.
>
> I don't like the sampling time being bounding only by the overall test
> timeout. Users really hate test broken messages. Possibly if the test
> timeouts before the sampling period has finished, then we could return
> TWARN or TCONF saying that the test did not have enough time to execute?
>

Sure, that makes users know when timeout occurred, in sampling period or
after, at least good for debugging work sometimes.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181009/9d0467fa/attachment.html>
