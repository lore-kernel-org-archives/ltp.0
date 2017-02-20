From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Feb 2017 11:11:16 +0100
Subject: [LTP] [PATCH 0/1] uname26 exploit regression test
In-Reply-To: <20170217113653.595ce1b4@linux-v3j5>
References: <20170217113653.595ce1b4@linux-v3j5>
Message-ID: <20170220101116.GA8829@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have essentially rewritten the following expoit to be used in the LTP:
> https://www.exploit-db.com/exploits/37937/ (Metan's idea AFAIK). There are
> some issues which I came across while doing this, even though it is quite an
> easy exploit to recreate.
> 
> 1) How should we organise the exploit tests? I see Metan has added dirtyc0w
>    under that name in its own folder. Not all exploits have a fancy or unique
>    name however. I have just named the uname exploit with its CVE name and put
>    it in a new uname folder, but I'm not sure that is the best way either.

Sounds reasonable. I guess that for some exploits there is no single
syscall to blame so putting these into syscalls/ does not make much
sense.

Maybe we can just put all these tests into an security/exploits or
security/CVE directory or something.

> 2) What is the appropriate runtest file for security tests? I think they
>    should be separated from functional tests.

If there is none we should start one. Something as runtest/security. I'm
also wondering if we should add these into the runtest/syscalls as well,
at least these that are directly related to a syscall of some kind.

> 3) The exploit code from the link is licensed under GPLv3. Although I rewrote
>    the LTP test from scratch, the fact I saw the exploit code raises the
>    question of whether my test is a derivative work. The easiest thing to do
>    would be to attribute the exploit code author and simply state that the
>    test is an adaptation, but then I believe the test would need to be GPLv3.
>    Of course, I can just ask the author to relicense the original under GPLv2,
>    but lets assume they don't consent or can't be contacted.

I will double check if there are any problems with having GPLv3 test but
I do not see any. As far as the LTP library is 'GPLv2 or any later' we
can link GPLv3 test against it. And since we basically distribute source
code only GPLv3 test should not do any harm.

It would be better to have the test code under GPLv2+ but if original
author cannot be reached this should not stop us.

> 4) This is maybe a question for a security/kernel mailing list, but which
>    exploits are most likely to be reintroduced to the kernel? I am not sure
>    that this exploit is at high risk of being reintroduced. At least not into
>    mainline or any of the major distro branches.

I guess that anything that expects precise memory layout and works only
on a single distro is out of a question. Generally I would expect race
conditions to be much more easily reintroduced than anything else, since
locking in kernel is tricky. But yes, this is question to be discussed
with kernel developers as well.

-- 
Cyril Hrubis
chrubis@suse.cz
