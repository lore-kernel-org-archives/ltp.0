From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 26 Oct 2020 16:07:52 +0100
Subject: [LTP] syscalls/timer_settime01: adjust for rounding from nsec
 to usec
In-Reply-To: <20201026143424.GA31934@yuki.lan>
References: <87v9exf5hb.fsf@oc8242746057.ibm.com>
 <20201026143424.GA31934@yuki.lan>
Message-ID: <87sga1f2k7.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> the patch from Chris fixes the below issue on s390x:
>
> And what about the simpler solution I've proposed in the reply, does
> that one work fine as well?

Hi Cyril,

first, sorry for butchering your name :/

Second, I tested now both patches on a heavy loaded system (with
stress-ng) and both seem to solve my issues. I ran a test 1000 times
(-i 1000) and couldn't reproduce it anymore.

Regards
Alex
