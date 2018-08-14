From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Aug 2018 17:24:02 +0800
Subject: [LTP] [PATCH v2 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <20180813135908.30752-4-rpalethorpe@suse.com>
References: <20180813135908.30752-1-rpalethorpe@suse.com>
 <20180813135908.30752-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2d3E3U2tHW1zCBb+=OwSAGHFXPPC0Rkcc1oDHvq2NJYDA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.com> wrote:

Use the tst_timer library to check how long the main test loop has been
> running for and break the loop if it exceeds 60 seconds. This prevents an
>

This summary needs a minor adjustment for v2 too. Otherwise patch set looks
good to me.

Btw, I think the whole fuzzy synchronisation maybe a bit complicated to LTP
users, I read all of the fuzzy_sync functions and spent much time to learn
the code logic :). Of course, if we want to do some improvement work,
better in new divided patch then.

overall test timeout which is reported as a failure.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180814/7e5e5669/attachment-0001.html>
