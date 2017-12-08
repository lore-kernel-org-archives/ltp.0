From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 08 Dec 2017 11:49:41 +0000
Subject: [LTP] [PATCH v3 08/12] sigwaitinfo01: catch SEGV and report
	success for bad_address2 testcase
In-Reply-To: <20171208102852.GC13286@rei> (Cyril Hrubis's message of "Fri, 8
 Dec 2017 11:28:52 +0100")
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-9-punit.agrawal@arm.com>
 <20171208102852.GC13286@rei>
Message-ID: <87fu8lv3qi.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> I've also added a follow up patch that adds this test to the syscalls
> runtest file.
>
> Other than the two patches I've commented on the rest of the patchset
> has been pushed, thanks!

Thanks for applying the patches.

I don't see Patch 7 "sigwaitinfo01: fix race between sending and
dequeueing RT signals" in the repo.

Did this one get missed out?

Thanks,
Punit
