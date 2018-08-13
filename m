From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Aug 2018 18:31:56 +0800
Subject: [LTP] [PATCH 2/2] fzsync: Limit execution time to prevent test
	timeouts
In-Reply-To: <20180810083654.28938-3-rpalethorpe@suse.com>
References: <20180810083654.28938-1-rpalethorpe@suse.com>
 <20180810083654.28938-3-rpalethorpe@suse.com>
Message-ID: <CAEemH2cxfeEt=VfwMYqbkFURRO8kNXjoo1MwytKXYwG3HSxFqg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.com> wrote:

> Use the tst_timer library to check how long the main test loop has been
> running for and break the loop if it exceeds 60 seconds. This prevents an
>

How about setting the timer_state value base on LTP_TIMEOUT_MUL?

I'm worried that 60 seconds maybe not satisfies to all situations because
many LTP users like to extend
the test timeout by passing LTP_TIMEOUT_MUL on slow machine.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180813/e5f0e6f1/attachment.html>
