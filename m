From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 13 Aug 2018 14:01:26 +0200
Subject: [LTP] [PATCH 2/2] fzsync: Limit execution time to prevent test
	timeouts
In-Reply-To: <CAEemH2cxfeEt=VfwMYqbkFURRO8kNXjoo1MwytKXYwG3HSxFqg@mail.gmail.com>
References: <20180810083654.28938-1-rpalethorpe@suse.com>
 <20180810083654.28938-3-rpalethorpe@suse.com>
 <CAEemH2cxfeEt=VfwMYqbkFURRO8kNXjoo1MwytKXYwG3HSxFqg@mail.gmail.com>
Message-ID: <87pnym4grt.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
>> Use the tst_timer library to check how long the main test loop has been
>> running for and break the loop if it exceeds 60 seconds. This prevents an
>>
>
> How about setting the timer_state value base on LTP_TIMEOUT_MUL?
>
> I'm worried that 60 seconds maybe not satisfies to all situations because
> many LTP users like to extend
> the test timeout by passing LTP_TIMEOUT_MUL on slow machine.


Yes, this makes a lot of sense to me. Possibly we could simply multiply
the value passed to tst_timer_expired by LTP_TIMEOUT_MUL.

--
Thank you,
Richard.
