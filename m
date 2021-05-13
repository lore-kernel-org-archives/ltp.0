From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 13 May 2021 08:08:09 +0100
Subject: [LTP] [PATCH] API: Give user hint when checkpoints were not
 initialised
In-Reply-To: <YJve64fqcEBm/fvN@yuki>
References: <20210512101738.31118-1-rpalethorpe@suse.com>
 <YJvbKL2zrEWof6+m@pevik> <YJve64fqcEBm/fvN@yuki>
Message-ID: <87o8dfkt5y.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Currently the user gets an error about EOVERFLOW. This will hopefully
>> > save some searching.
>> 
>> Nice! I'm for merging it before release (with that fixed whitespace).
>
> Looks safe enough, I will fix the whitespaces and apply.

Thanks, but I would not put this in the release. There is no advantage
to the end user, only test authors. It can only break the tests from an
end user POV.

-- 
Thank you,
Richard.
