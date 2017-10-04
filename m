From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 04 Oct 2017 10:04:37 +0200
Subject: [LTP] [RFC PATCH] newlib: Allow sub-tests to be specified in a
	list
In-Reply-To: <20171003144157.GD11692@rei>
References: <20171003135520.19580-1-rpalethorpe@suse.com>
 <20171003144157.GD11692@rei>
Message-ID: <8760bvwd7u.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
> That is even more complicated than my patch with array:
>
> http://lists.linux.it/pipermail/ltp/2017-July/005132.html
>
> And Jan didn't even liked mine because it adds complexity complexity
> that is uncalled for...

I think it is called for (atleast the idea in general is) because it
encourages people to write similar tests in a clean way which should
save time in the long run.

I am hoping someone comes up with an acceptable way of doing it.

--
Thank you,
Richard.
