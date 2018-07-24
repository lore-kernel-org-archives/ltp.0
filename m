From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 24 Jul 2018 10:12:35 +0200
Subject: [LTP] [PATCH] testcases: cve-2017-2671: Set attempts according
	to cpus
In-Reply-To: <20180723090415.25e487f2@dell-desktop.home>
References: <20180713134618.29552-1-mylene.josserand@bootlin.com>
 <87zhyrbk6f.fsf@rpws.prws.suse.cz>
 <20180723090415.25e487f2@dell-desktop.home>
Message-ID: <87bmaxhx1o.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

Mylène Josserand writes:

> Hello,
>
> Thank you for your review.
>
> On Mon, 16 Jul 2018 11:32:08 +0200
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>> Hello,
>>
>> Mylène Josserand writes:
>>
>> > This test tries to run commands with 0x8000 attempts.
>> > In a slow system platform, it leads to a failure
>> > because of a timeout even when it is configured with
>> > LTP_TIMEOUT_MUL=10.
>> >
>> > This commit adds a way to configure the number of attempts
>> > according to the number of CPUs.
>> > In case of 1 CPU and a slow platform, using 0x2000 attempts
>> > with a LTP_TIMEOUT_MUL=3 make the test pass.
>>
>> I think the Fuzzy Sync library needs to be improved to remove the
>> iteration constants altogether. That is, we specify how long the test(s)
>> should run for, not how many iterations each one should do.
>
> Okay, I will have a look at the Fuzzy Sync library because, honestly, I
> have no idea what is it :)
>
>>
>> We can do this by taking a moving average of the iteration time and
>> using it to predict when the next iteration will exceed the time
>> limit. Then exit the loop at that point.
>
> okay, I see what you mean, thanks.

Hopefully I should be able to implement something like this fairly
soon. However it would help if more people knew how the library works.

>
>>
>> Also Cyril thinks that we can improve the time Fuzzy Sync takes to reach
>> the synchronisation point by using a PID controller algorithm which
>> makes a lot of sense.
>
> Could you explain me more in details what you have in mind here?

We currently try to synchronise the execution of two functions by timing
how long it takes to reach each function. If one function is reached
quicker then we add or subtract a static number of cycles from a delay
loop. Eventually the delay loop should be sufficiently large to
synchronise the two functions.

To improve this we can use a PID algorithm
(https://en.wikipedia.org/wiki/PID_controller) to set the delay. I am
not exactly sure how we will implement that yet.

>
> Thank you in advance,
> Best regards,
>
> Mylène
>
>>
>> >
>> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
>> > ---
>> >  testcases/cve/cve-2017-2671.c | 10 +++++++---
>> >  1 file changed, 7 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
>> > index b0471bfff..a56bb45a8 100644
>> > --- a/testcases/cve/cve-2017-2671.c
>> > +++ b/testcases/cve/cve-2017-2671.c
>> > @@ -49,7 +49,7 @@
>> >
>> >  #include "tst_fuzzy_sync.h"
>> >
>> > -#define ATTEMPTS 0x80000
>> > +#define ATTEMPTS 0x2000
>> >  #define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
>> >
>> >  static int sockfd;
>> > @@ -109,9 +109,13 @@ static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
>> >
>> >  static void run(void)
>> >  {
>> > -	int i;
>> > +	int i, total_cpus;
>> >
>> > -	for (i = 0; i < ATTEMPTS; i++) {
>> > +	total_cpus = tst_ncpus();
>> > +	if (total_cpus > 4)
>> > +		total_cpus = 4;
>> > +
>> > +	for (i = 0; i < ATTEMPTS * total_cpus; i++) {
>> >  		SAFE_CONNECT(sockfd,
>> >  			     (struct sockaddr *)nn&iaddr, sizeof(iaddr));
>> >
>> > --
>> > 2.11.0
>>
>>
>> --
>> Thank you,
>> Richard.
>
> Best regards,


--
Thank you,
Richard.
