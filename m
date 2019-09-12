From: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
Date: Thu, 12 Sep 2019 10:16:37 +0000
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <e07d08e2-df58-2114-0278-8f1e50f2ac3a@arm.com>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
 <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
 <20190830104609.GA9330@dell5510>
 <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
 <1568279073.3621.12.camel@suse.de>
 <CAEemH2cw+O5ZrZyQV5qy7wp6-h1SSinu3ENueRG7Gr--xJCRfA@mail.gmail.com>
 <e07d08e2-df58-2114-0278-8f1e50f2ac3a@arm.com>
Message-ID: <1568283397.3621.23.camel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2019-09-12 at 10:55 +0100, Cristian Marussi wrote:
> Hi
> 
> > Hmm, what we want to do is:
> > 
> > If a testcase needs timeout value is larger than the default (300
> > sec), we
> > could only define a variable LTP_TIMEOUT_MUL_MIN in the test, then
> > the
> > _tst_setup_timer() will detect if LTP_TIMEOUT_MUL_MIN is valid and
> > reset
> > the minimum time for the test.
> > 
> > @Petr and @Cristian, If I misunderstand anything, please correct
> > me.
> 
> my understanding was that:
> 
> - we should already be able to set a non default per-test timeout
> using
>   the existing global LTP_TIMEOUT_MUL (and we are)
> 
> - in this test we hardcoded such LTP_TIMEOUT_MUL to 7 because is the
> minimum sane
>   value for this test (less than 7 and it fails 100%)
> 
> - we want to allow again the user to specify its own LTP_TIMEOUT_MUL
> if he wants
>   BUT also being able to enforce on a test by test basis a MINIMUM
> allowed value:
>   so we would define LTP_TIMEOUT_MUL_MIN=7 here, and then a user
> would be free to 
>   run LTP with a different global LTP_TIMEOUT_MUL but when running
> this test
>   
>   + if LTP_TIMEOUT_MUL < LTP_TIMEOUT_MUL_MIN ===> use local
> LTP_TIMEOUT_MUL_MIN
>   + if LTP_TIMEOUT_MUL >= LTP_TIMEOUT_MUL_MIN  ===> use global
> LTP_TIMEOUT_MUL
> 
> This way you don't break specific tests' needs while allowing the
> user to global reduce
> run-time....now basically the user cannot enforce a higher timeout on
> this test
> using the global LTP_TIMEOUT_MUL even if it should be allowed to
> since this wouldn't
> break the test.
> 
> ...unless I misunderstood too o_O :D

Thanks for explaining. That's how I understood the idea of
LTP_TIMEOUT_MUL_MIN, too.

But what I understood from current "c" approach is:
We have a fixed (minimal) timeout value, specified in (struct
tst_test*)->timeout, which can be adjusted by user with environment
variable TST_TIMEOUT_MUL.
This behavior is missing in shell.

And if we now introduce a LTP_TIMEOUT_MUL_MIN, it doesn't make much
sense, cause we have already a timeout min. So I think, we only need
something to specify the default minimum timeout in seconds for shell
(like we already do in c) and we are done.

Thanks
Clemens
