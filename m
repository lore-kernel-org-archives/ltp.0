From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Apr 2020 11:46:22 +0200
Subject: [LTP] Purpose of clock_nanosleep2 tests ?
In-Reply-To: <20200421094422.GE6577@yuki.lan>
References: <CAKohponWBU_pSDk6sjsMFBkJzwPDz71DcyC1_X6x1=0bZMb=aQ@mail.gmail.com>
 <20200421092045.GC6577@yuki.lan>
 <20200421092616.lnktrr4e4pv7wemm@vireshk-i7>
 <20200421094422.GE6577@yuki.lan>
Message-ID: <20200421094622.GF6577@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > clock_nanosleep03.c already tests ABSTIME. I think we can just drop
> > clock_nanosleep2 directory completely. I will send a patch if that looks okay.
> 
> clock_nanosleep03 is testing that inside of a time namespace, I think
> that there is still value of having the simpler test as well.

Moreover the time namespaces does not support CLOCK_REALTIME so we
should implement clock_nanosleep() test with CLOCK_REALTIME and
TIMER_ABSTIME which is not covered at the moment anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
