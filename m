From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 28 Aug 2018 16:20:58 +0200
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
In-Reply-To: <20180828125808.GB24095@rei>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
 <20180828125808.GB24095@rei>
Message-ID: <87wosashbp.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> It's just an idea, but we can make this even more elegant API.
>
> We measure the time in the test library anyway, so what about we added
> something as tst_timeout_reached() that would return number of seconds
> remaining to 80% of the real timeout or 0 if in a case that the timeout
> was reached. Then we can use this as a soft-timeout in all the testcases
> without any additional steps.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

80% is probably way more than many of the CVE test cases need unless the
overall timeout is reduced from 5 minutes. Probably 20% would be
OK. Assuming this is the kind of usage scenario you had in mind.

We could also call it tst_timeout_approaching, tst_timeout_near or
tst_time_to_fail... not sure if they are any better.

--
Thank you,
Richard.
