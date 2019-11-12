From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Nov 2019 07:52:37 -0500 (EST)
Subject: [LTP] [PATCH] acct02: relax ac_btime checks
In-Reply-To: <20191112123744.GA760@dell5510>
References: <95d94fede00533a07fc604de3252636b094fc8f8.1573550061.git.jstancek@redhat.com>
 <20191112123744.GA760@dell5510>
Message-ID: <1574856631.11670519.1573563157342.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > ac_btime is calculated back from current time and isn't accurate.
> > Problems include nanoseconds accumulation (lags behind gettimeofday),
> > suspend/resume isn't taken into account and any adjtime() (like DST
> > change) will cause ac_btime to jump as well.
> 
> > Relax the condition to ~2h around gettimeofday value at start of
> > the test. That should be enough to cover usual DST time jumps.
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> on both 390x and intel.
> 
> LGTM, although on in intel I got quite a lot of entries:
> 
> acct02.c:202: INFO: Number of accounting file entries tested: 159

That could be normal if there was something running in the background.
Do you have full output? What was the ac_comm string in those entries?

