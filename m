From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 21 Jun 2017 08:42:06 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
In-Reply-To: <20170620134218.13461-2-chrubis@suse.cz>
References: <20170620134218.13461-1-chrubis@suse.cz>
 <20170620134218.13461-2-chrubis@suse.cz>
Message-ID: <1505342784.40797880.1498048926551.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 20 June, 2017 3:42:18 PM
> Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
> 
> This commit adds a timer measurement library, mostly based on changes
> done to the pselect01.c test and changes all tests that measure timer
> precision to use it.
> 
> The timer testcases that measure timeouts now just define sampling function
> and
> optional setup and cleanup. The rest of the functionality is implemented in
> the
> lib/tst_timer_test.c library. This change not only removes fair amount of
> duplicated code but also allows us to tune thresholds and define testcases in
> a
> single place for all testcases.
> 
> The timer measurement library also supports for passing sleep time and
> number of iterations as a command-line parameters, can print nifty
> frequency plot into the terminal, as well as save test measurements into
> a text file.
> 

Hi,

looks good to me.

It compiled fine across RHEL 5/6/7 x86_64. No failures when I run it
on my laptop. 

I plan to also run it across multiple arches/distros on randomly
picked systems from lab.

Regards,
Jan
