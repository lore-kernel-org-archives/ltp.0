From: Li Wang <liwang@redhat.com>
Date: Thu, 27 May 2021 12:11:01 +0800
Subject: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
In-Reply-To: <78d1900a-cdc7-77c6-8f01-73ce4236a162@jv-coder.de>
References: <20210519085812.27263-1-liwang@redhat.com>
 <78d1900a-cdc7-77c6-8f01-73ce4236a162@jv-coder.de>
Message-ID: <CAEemH2d8tcBVsrmL1-bWWSchy6EpcKCoTO2ZA85jcnsEhESoxA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 19, 2021 at 5:19 PM Joerg Vehlow <lkml@jv-coder.de> wrote:
>
> Hi,
>
> On 5/19/2021 10:58 AM, Li Wang wrote:
> > diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
> > index cd548d9a2..dabef32a2 100755
> > --- a/lib/newlib_tests/shell/timeout03.sh
> > +++ b/lib/newlib_tests/shell/timeout03.sh
> > @@ -6,8 +6,9 @@
> >   # expected output:
> >   # timeout03 1 TINFO: timeout per run is 0h 0m 1s
> >   # timeout03 1 TINFO: testing killing test after TST_TIMEOUT
> > -# timeout03 1 TBROK: Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > -# timeout03 1 TBROK: test interrupted or timed out
> > +# timeout03 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > +# Terminated
> Nit: This Message seems to be only there for bash... I tried to find why
> and if it can be suppressed, but found nothing. I guess it comes from
> the terminated sleep process.

Yes, but that's not a big deal, it only appears in timed out and we
can tolerate:).

-- 
Regards,
Li Wang

