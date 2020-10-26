From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2020 15:34:24 +0100
Subject: [LTP] syscalls/timer_settime01: adjust for rounding from nsec
 to usec
In-Reply-To: <87v9exf5hb.fsf@oc8242746057.ibm.com>
References: <87v9exf5hb.fsf@oc8242746057.ibm.com>
Message-ID: <20201026143424.GA31934@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> the patch from Chris fixes the below issue on s390x:

And what about the simpler solution I've proposed in the reply, does
that one work fine as well?

-- 
Cyril Hrubis
chrubis@suse.cz
