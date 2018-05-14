From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 May 2018 11:04:48 +0200
Subject: [LTP] [PATCH] runtest/fs: Don't read files in /dev
	indiscriminately
In-Reply-To: <20180514085324.GA20130@rei.lan>
References: <20180511173156.30197-1-punit.agrawal@arm.com>
 <87lgcmy9uq.fsf@rpws.prws.suse.cz> <20180514085324.GA20130@rei.lan>
Message-ID: <87y3gm1ubz.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> > It would be better to replace indiscriminate reading of /dev files
>> > with tests targeting specific files in /dev which have defined known
>> > behaviour, e.g., /dev/null, /dev/urandom, etc.
>> >
>> > In the meanwhile, drop the indiscriminate reading of files in /dev.
>> 
>> Another solution might be to add an option which drops privileges before
>> running the test on /dev. An unprivileged user should not have access to files
>> like /dev/port, but will for /dev/null and /dev/urandom.
>
> That sounds like a better solution to me, can we get that in before the
> release?

Yes, I can give this priority.

-- 
Thank you,
Richard.
