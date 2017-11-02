From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 02 Nov 2017 10:51:46 +0100
Subject: [LTP] [PATCH v6] Add test for CVE-2017-7308 on a raw socket's
	ring buffer
In-Reply-To: <20171101154943.GE11108@rei.lan>
References: <20171013111932.28671-1-rpalethorpe@suse.com>
 <20171101154943.GE11108@rei.lan>
Message-ID: <87inetj9e5.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

>
> Also I wonder if we should put it under syscalls/setsockopt(). Maybe we
> should adopt a rule that if it's reasonably clear which syscall the test
> belongs to we would put it into the syscalls/ directory and use the cve
> directory as a fallback for all the rest of the cve reproducers. What do
> you think?

I'm happy with that. I like having all the CVE tests in one place, but
the runtest file appears to do a good enough job of that. 

-- 
Thank you,
Richard.
