From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Nov 2018 11:06:36 +0100
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <9aae07a5-3a03-9da7-d8fd-0326fe3f4cc5@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
 <9aae07a5-3a03-9da7-d8fd-0326fe3f4cc5@google.com>
Message-ID: <20181105100624.GB8687@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> About this statemement that you made:
> 
>     "Function signatures aren't needed when used just in one file." 
> 
> To whch I replied:
> 
>     "ARE required unless you reorganize you code to be all in the order
>     of called functions preceding called functions"
> 
> To which you replied:
> 
>     "Actually neither of that is true"

I actually answered only the part about 'static' being useless. Sorry
for not being clear on that.

> If you don't use prototypes you do have to reorganize the functions in 
> the order they are called.

That is indeed true.

> Are you really questioning that? I don't want to have to explain that 
> unless you don't understand why prototypes are required in some cases.

Not at all.

> If you are not questioning that. Are you ok with me using prototypes?

I do prefer to organize tests so that we don't have to use them, but I
can live with code that does not follow that as well.

> I don't mind adding static, but do realize that that will indeed mean 
> that in some compilation systems the sysmbols won't be in the symbol 
> table and will make debugging harder. I don't care if you question this 
> statment, don't have time to explain that.

For modern enough compilers and debuggers this is not true. Ancient
tooling may loose some debugging information when functions are inlined
though.

-- 
Cyril Hrubis
chrubis@suse.cz
