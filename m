From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 19 Jul 2018 15:37:52 +0200
Subject: [LTP] [PATCH v3 3/3] Add Doxygen configuration
In-Reply-To: <20180718145425.GA23229@rei>
References: <20180705145635.27244-1-rpalethorpe@suse.com>
 <20180705145635.27244-3-rpalethorpe@suse.com> <20180718123050.GB7117@rei>
 <87r2k0bs6z.fsf@rpws.prws.suse.cz> <20180718145425.GA23229@rei>
Message-ID: <87k1prbb2n.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> > Not that this is a bad thing quite contrary actually, but it's quite
>> > confusing that this is a 3/3 of this patchset.
>> >
>> > Haven you send this by a mistake?
>> 
>> Nope, but maybe I should have included a covering letter. I mentioned
>> that it is not part of the patch set in the notes on the first
>> commit. I just included it so that you can easily verify the
>> documentation comments if you want to do that.
>
> Ah, I missed that note in the first commit.
>
> Hmm, if we decide to go that way we should probably get this in with all
> the bells and whistles in a separate patchset. I.e. add doxygen target
> to the doc/Makefile, convert the headers we have and introduce the
> config.

Are you saying that you want me to submit the patch with the
documentation in the kernel format, then submit another patch set
updating all the documentation later?

-- 
Thank you,
Richard.
