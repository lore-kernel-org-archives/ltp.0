From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 14 Aug 2018 11:58:57 +0200
Subject: [LTP] [PATCH v2 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <CAEemH2d3E3U2tHW1zCBb+=OwSAGHFXPPC0Rkcc1oDHvq2NJYDA@mail.gmail.com>
References: <20180813135908.30752-1-rpalethorpe@suse.com>
 <20180813135908.30752-4-rpalethorpe@suse.com>
 <CAEemH2d3E3U2tHW1zCBb+=OwSAGHFXPPC0Rkcc1oDHvq2NJYDA@mail.gmail.com>
Message-ID: <87k1ot46ce.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> Use the tst_timer library to check how long the main test loop has been
>> running for and break the loop if it exceeds 60 seconds. This prevents an
>>
>
> This summary needs a minor adjustment for v2 too. Otherwise patch set looks
> good to me.
>
> Btw, I think the whole fuzzy synchronisation maybe a bit complicated to LTP
> users, I read all of the fuzzy_sync functions and spent much time to learn
> the code logic :). Of course, if we want to do some improvement work,
> better in new divided patch then.

Yes, I agree and have some ideas about that (see comments in V1 patches
covering letter). Thanks for the feedback.

Maybe the implementation can detect some common usage mistakes, which I
think is the main issue here. For example if the user has a different
number of waits in one thread than the other, we should be able to
detect that. Then people can learn how to use it more through
experimentation which is much easier than reading the implementation or
even documentation.

>
> overall test timeout which is reported as a failure.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>>
>
> Reviewed-by: Li Wang <liwang@redhat.com>


--
Thank you,
Richard.
