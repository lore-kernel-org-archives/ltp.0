From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jan 2018 21:08:59 +0100
Subject: [LTP] [RFC PATCH 2/2] cve/cve-2018-1000001: Add Realpath Buffer
 Underflow test
In-Reply-To: <20180119165252.GD7954@rei>
References: <20180118131134.11945-1-pvorel@suse.cz>
 <20180118131134.11945-3-pvorel@suse.cz> <20180119165252.GD7954@rei>
Message-ID: <20180119200859.tymzoaejuily2ioj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for your review and explanation.

> > ---
> > NOTE: I didn't use TEST() macro due warning assignment makes integer
> > from pointer without a cast. Am I blind not to see how to use it?

> You are not, the TEST() macro supports only integer return values.

> We may as well add a support for this, maybe just rename the TEST_RETURN
> to tst_ret and add void* tst_ret_ptr. If we make the tst_ret to intptr_t
> we may as well safely do something as:

> 	tst_ret_ptr = (void*)(tst_ret = (intptr_t) SCALL);

> And we should rename TEST_ERRNO tst_errno as well just to keep it
> consistent.

> Or we can as well avoid this trickery by defining second TESTPTR() macro
> that will use tst_ret_ptr instead.
IMHO this is better.


Kind regards,
Petr
