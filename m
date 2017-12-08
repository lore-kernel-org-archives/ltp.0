From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Dec 2017 12:37:42 +0100
Subject: [LTP] [PATCH v3 09/12] syscalls/mount03: Copy setuid_test to
 execute instead of 'TEST FILE'
In-Reply-To: <87vahhv64c.fsf@e105922-lin.cambridge.arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-10-punit.agrawal@arm.com>
 <20171208102658.GA13286@rei>
 <87609hwlkr.fsf@e105922-lin.cambridge.arm.com>
 <20171208104302.GD13286@rei>
 <87vahhv64c.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20171208113741.GE13286@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Apologies for not being more specific. We do it twice because in the
> quoted text you say (emphasis mine) -
> 
> "it should be done _once_ in the test setup _as well as_ the code that
> sets the actual setuid bit."
>
> I took that to mean that you're asking for the file to be copied in
> setup() as well as in the code before it gets used. Obviously I've
> misunderstood your statement. What are you actually suggesting there?

Ah, that's where the misunderstanding happened, "the code that sets the
actual setuid bit" == chmod(file, SUID_MODE);

I was trying to state that the actual test setup that could be done only
once should be put into the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz
