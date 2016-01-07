From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jan 2016 06:08:25 -0500 (EST)
Subject: [LTP] [PATCH] Declare lio_async_callback_handler() for linux too
In-Reply-To: <688E52BD-3F72-4D3F-99A1-6ED776FA1524@gmail.com>
References: <1452152227-128032-1-git-send-email-raj.khem@gmail.com>
 <1044387943.5068757.1452158191583.JavaMail.zimbra@redhat.com>
 <688E52BD-3F72-4D3F-99A1-6ED776FA1524@gmail.com>
Message-ID: <895346623.5174985.1452164905075.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Khem Raj" <raj.khem@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 7 January, 2016 10:58:19 AM
> Subject: Re: [LTP] [PATCH] Declare lio_async_callback_handler() for linux too
> 
> Hi Jan
> 
> > On Jan 7, 2016, at 1:16 AM, Jan Stancek <jstancek@redhat.com> wrote:
> > 
> > 
> > 
> > ----- Original Message -----
> >> From: "Khem Raj" <raj.khem@gmail.com>
> >> To: ltp@lists.linux.it
> >> Sent: Thursday, 7 January, 2016 8:37:07 AM
> >> Subject: [LTP] [PATCH] Declare lio_async_callback_handler() for linux too
> > 
> > Hi,
> > 
> >> 
> >> sigval_t is glibc only construct, we use a union of sigval
> >> which pretty much is same effect as sigval_t
> >> 
> >> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> >> ---
> >> lib/tlibio.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/lib/tlibio.c b/lib/tlibio.c
> >> index 6b6103f..b7d9faa 100644
> >> --- a/lib/tlibio.c
> >> +++ b/lib/tlibio.c
> >> @@ -130,7 +130,7 @@
> >> #endif
> >> 
> >> static void lio_async_signal_handler();
> >> -#ifdef sgi
> >> +#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> > 
> > What difference does this make? Isn't this just a forward declaration,
> > that's not that useful anyway?
> 
> I am getting undeclared errors e.g.
> 
> | tlibio.c:1274:7: error: 'lio_async_callback_handler' undeclared (first use
> | in this function)
> |        lio_async_callback_handler;
> |        ^
> 

Definition of that function, with same exact ifdef around it,
is way before that, on line 444. Am I missing something?

I can remove both fwd declarations and it still compiles fine.
(I went as far back as gcc version 4.1.2 / rhel5.6)

What distro/arch/compiler/c_library are you using?

> 
> moreover it makes it consistent with rest of the file.
> 
> > 
> > Regards,
> > Jan
> > 
> >> static void lio_async_callback_handler();
> >> #endif
> >> 
> >> @@ -441,7 +441,7 @@ static void lio_async_signal_handler(int sig)
> >>  * If the handler is called, it will increment the Received_callback
> >>  * global variable.
> >>  ***********************************************************************/
> >> -static void lio_async_callback_handler(sigval_t sigval)
> >> +static void lio_async_callback_handler(union sigval sigval)
> >> {
> >> 	if (Debug_level)
> >> 		printf
> >> --
> >> 2.7.0
> >> 
> >> 
> >> --
> >> Mailing list info: http://lists.linux.it/listinfo/ltp
> >> 
> 
> 
