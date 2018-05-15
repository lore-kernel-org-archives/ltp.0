From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 15 May 2018 12:23:23 +0100
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <20180515105743.GA21783@rei> (Cyril Hrubis's message of "Tue, 15
 May 2018 12:57:43 +0200")
References: <20180515095118.26282-1-rpalethorpe@suse.com>
 <20180515103042.GB7220@rei> <87bmdhyyrf.fsf@rpws.prws.suse.cz>
 <20180515105743.GA21783@rei>
Message-ID: <8736yt40yc.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard, Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Otherwise it looks fine.
>> 
>> Well spotted, yes it should.
>
> I will push it with that change then, thanks.

I can confirm that with the change the system no longer generates aborts
while reading nodes in /dev.

Thanks for pushing this through before the release.

Punit
