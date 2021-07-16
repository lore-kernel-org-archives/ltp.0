From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jul 2021 11:51:27 +0200
Subject: [LTP] [PATCH] crypto/af_alg02: use pthread_tryjoin_np() instead
 of pthread_kill()
In-Reply-To: <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
References: <20210715102813.106843-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
Message-ID: <YPFWn+/sbK1vlJKt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi Alexey,

> On Thu, Jul 15, 2021 at 6:29 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> wrote:

> > musl doesn't return ESRCH for pthread_kill() if thread id is not found.
Maybe ask on MUSL mailing list?

> > POSIX only recommends to return ESRCH, and also says that pthread_kill()
> > produces undefined behavior if tid lifetime has ended [1].

> > [1]: https://man7.org/linux/man-pages/man3/pthread_kill.3.html

> > Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> > ---
> >  testcases/kernel/crypto/af_alg02.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/crypto/af_alg02.c
> > b/testcases/kernel/crypto/af_alg02.c
> > index 31d30777c..0f5793c16 100644
> > --- a/testcases/kernel/crypto/af_alg02.c
> > +++ b/testcases/kernel/crypto/af_alg02.c
> > @@ -60,7 +60,7 @@ static void run(void)

> >         TST_CHECKPOINT_WAIT(0);

> > -       while (pthread_kill(thr, 0) != ESRCH) {
> > +       while (pthread_tryjoin_np(thr, NULL) == EBUSY) {


> I'm not sure if safe enough to use because it is nonstandard GNU extensions
> and the "_np" means nonportable.
Others please double check, but pthread_tryjoin_np() seems to be in uclibc-ng
and musl (+ of course in glibc). It's only missing in bionic (it looks like
people would like to have it [1]).

> Maybe another workaround is to define a volatile flag 'thread_complete',
> initialize it to '0' when thread_B starts and reset to '1' while exit, and
> just
> do a value check in the while loop of thread_A should acquire thread_B
> status.
> Is this way a bit better?
Sounds as reasonable workaround for me.

Kind regards,
Petr

[1] https://github.com/kito-cheng/android-checkpoint/blob/master/bionic/0003-bionic-Implement-pthread_tryjoin_np.patch
