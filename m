From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 30 Nov 2017 15:56:53 +0000
Subject: [LTP] [PATCH v2 09/13] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171130131720.GC2924@rei> (Cyril Hrubis's message of "Thu, 30
 Nov 2017 14:17:20 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-10-punit.agrawal@arm.com>
 <20171129132019.GC18489@rei>
 <87609t112h.fsf@e105922-lin.cambridge.arm.com>
 <20171130122142.GA2924@rei>
 <87tvxcylfy.fsf@e105922-lin.cambridge.arm.com>
 <20171130131720.GC2924@rei>
Message-ID: <87o9njzrne.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> The copying can't be done in setup() as the test filesystem hasn't been
>> mounted yet.
>
> Well we can always mount it in the setup, prepare it for the testing,
> then umount it again...

Ok, done that now.

>
>> Let me know if you're done reviewing the rest of the series - I can send
>> out an update with the changes we've discussed in the next day or so
>> after a bit of testing and tidy-up.
>
> I will look closely on the cpu_hotplug patches then I'm done. The rest
> of the patches I haven't commeted are OK.

Cool, thanks!
