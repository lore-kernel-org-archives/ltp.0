From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Nov 2018 02:54:51 -0500 (EST)
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: Restrict that tst_brk() only
 works with TBROK/TCONF
In-Reply-To: <5BE4F51E.3060900@cn.fujitsu.com>
References: <1541681733-18845-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
 <5BE4F51E.3060900@cn.fujitsu.com>
Message-ID: <1919219905.71573908.1541750091092.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 2018/11/09 1:53, Jan Stancek wrote:
> > ----- Original Message -----
> >> 1) Add tst_check_ttype() to check if TPASS/TFAIL/TWARN/TINFO is
> >>     passed into tst_brk() and convert it to TBROK forcely.
> >> 2) Only update test result in library process and main test process
> >>     because the exit status of child can be passed into main test
> >>     process by check_child_status().
> >> 3) Increase the number of skipped when calling tst_brk(TCONF).
> >> 4) Increase the number of warnings when calling tst_brk(TBROK) in
> >>     test cleanup(), other than that print "Test broken!" when calling
> >>     tst_brk(TBROK).
> >>
> >> Fix: #408
> >>
> >> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >> ---
> >>   lib/tst_test.c | 28 ++++++++++++++++++++++++++--
> >>   1 file changed, 26 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/tst_test.c b/lib/tst_test.c
> >> index 661fbbf..c8d8eff 100644
> >> --- a/lib/tst_test.c
> >> +++ b/lib/tst_test.c
> >> @@ -55,6 +55,7 @@ struct results {
> >>   	int skipped;
> >>   	int failed;
> >>   	int warnings;
> >> +	int broken;
> > Hi,
> >
> > I don't follow what benefit this provides. It generates message "Test
> > broken",
> > but we already know that test is broken by message in tst_vbrk_() /
> > tst_cvres().
> Hi Jan,
> 
> We can remove the unnecessary message "Test broken", and also apply the check
> for
> ttype in tst_brk() written by your patch.

Or maybe add "Broken: " to summary?

> 
> According to the issue #$08, we want to increase result counters when calling
> tst_brk().
> e.g.
> 1) Increase the skipped counter when calling tst_brk(TCONF).
> 2) Increase the warnings counter when calling tst_brk(TBROK/FAIL) in
>     test cleanup(), other than that increase the failed counter when
>     calling tst_brk(TBROK/FAIL).

I'd keep counters reflecting the messages. I imagine if summary says
"warnings: 1", people would be searching for 'WARN' in output.

TCONF - print CONF message, increase skipped
TFAIL - print FAIL message, increase failed
TBROK - print BROK message, increase broken

What do you think?

Regards,
Jan

