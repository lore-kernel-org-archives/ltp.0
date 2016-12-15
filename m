From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Dec 2016 15:34:15 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/mq_open: fix old tests + convert
 to use new API
In-Reply-To: <20161215135234.GA16771@rei.lan>
References: <20161210202909.22260-1-pvorel@suse.cz>
 <20161210202909.22260-2-pvorel@suse.cz>
 <20161215135234.GA16771@rei.lan>
Message-ID: <20161215143415.i75dfl2ltcpprmpi@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril!

Thank you for your review, ideas, examples!

> > +		SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
> We can get the rlimit once in the test setup.

> > +		SAFE_FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues);
> Here as well, we can read the max_queues fil,e once in the test setup.

I thought it would be safer to read it before test to get actual value. I still think too
complicatedly about tests :-(.


> Why can't we just do setup() and cleanup() for each of the
> testcases, instead of this trickery?
I didn't like it either, I just didn't come up with simple function pointer idea.

> Or do I miss something and there is a reason why we can't write the test
> this way?
No you don't, I just haven't achieved the zen of programming yet :-(. How nice and simple,
I'll use it.


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161215/543a0c85/attachment.sig>
