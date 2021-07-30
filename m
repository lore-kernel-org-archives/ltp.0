From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 30 Jul 2021 12:57:06 +0200
Subject: [LTP] [PATCH v2] crypto/af_alg02: thread termination fixes
In-Reply-To: <CAEemH2d8sHSWCAst9-q6KiKfJTSULYS8-KivWHrS04mR6ZXjzQ@mail.gmail.com>
References: <20210720101249.10118-1-aleksei.kodanev@bell-sw.com>
 <YQPCcew5Are2VrDh@yuki> <0c978fd5-9772-ad4e-c14e-c8b4a8344506@jv-coder.de>
 <CAEemH2d8sHSWCAst9-q6KiKfJTSULYS8-KivWHrS04mR6ZXjzQ@mail.gmail.com>
Message-ID: <668aa923-dda1-b3ce-8f5e-042e3a2174f5@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

On 7/30/2021 12:38 PM, Li Wang wrote:
>
>
> On Fri, Jul 30, 2021 at 5:32 PM Joerg Vehlow <lkml@jv-coder.de 
> <mailto:lkml@jv-coder.de>> wrote:
>
>     Hi
>
>     On 7/30/2021 11:12 AM, Cyril Hrubis wrote:
>     > Hi!
>     >> On musl, pthread_kill() doesn't return ESRCH if thread id is
>     not found
>     >> (POSIX only recommends to return ESRCH). Use
>     tst_atomic_store/load()
>     >> instead, when waiting for the thread.
>     >>
>     >> Also, the thread's resources wasn't properly freed after the run(),
>     >> so adding pthread_join() should fix that.
>     > I do not think that we even need atomic operations here as we do not
>     > have competing threads setting the value, it should work fine with
>     > regular assignments as long as the completed variable is marked as
>     > volatile (which will prevent compiler mis-optimizations).
>
>     +1 Using a volatile variable should be enough here.
>
>
> I have no preference for atomic or volatile methods.
> Both should be fine.
>
>     If only pthread_timedjoin_np was not _np... This is exactly the
>     function
>     that could be used here without any boilerplate.
>     But is the custom timeout handling in this test even required?
>     Does the
>     default timeout using SIGALRM not work?
>
>
> The default timeout obviously works.
>
> But with introducing the thread_B (custom timeout) can get a fine-grained
> report when the read() was stuck. That's the advantage I can think of.
>
>     The thread was introduced, because SIG_ALRM was apparently not
>     able to
>     interrupt the read call on linux < 4.14.
>     But even there it should be possible to interrupt pthread_join. So
>     just
>     replacing the whole loop with pthread_join should be enough.
>
>
> That should work but no precise log to indicate where goes wrong,
> so I vote to go the loop way:).
Does it really matter? The being stuck in the read does not seem to be 
the failure case tested with this test. Otherwise it would TFAIL.
Additionally the loop and "custom" timeout was only introduced at a 
later stage of the test. Initially it relied on the default timeout 
handling.
If my assumption, that being stuck in the read is not the failure case 
of this test, then your argument is invalid. Your argument would work for
each and every line of code, that might be executed, when the timeout hits.


Joerg
