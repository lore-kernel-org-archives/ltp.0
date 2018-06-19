From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jun 2018 07:29:32 -0400 (EDT)
Subject: [LTP] [PATCH] testcases: cve-2014-0196: Set attempts
	according	to nb of cpus
In-Reply-To: <877en0i4zz.fsf@rpws.prws.suse.cz>
References: <20180615080810.9814-1-mylene.josserand@bootlin.com>
 <877en0i4zz.fsf@rpws.prws.suse.cz>
Message-ID: <448349350.27477876.1529407772302.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> Hello,
> 
> Mylène Josserand writes:
> 
> > This test tries to cause a buffer overflow by doing 0x7000
> > attempts. In a slow system platform, it leads to a failure
> > because of the timeout even when it is configured with
> > LTP_TIMEOUT_MUL=10.
> >
> > This commit adds a way to configure the number of attempts
> > according to the number of CPUs.
> > In case of 1 CPU and a slow platform, using 0x2000 attempts
> > with a LTP_TIMEOUT_MUL=2 make the test pass.
> >
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >
> > Hello,
> >
> > This is a way to fix the issue I got but let me know
> > what you think of it. There is maybe a better way to
> > handle that.
> 
> Another way would be to measure the time a few iterations take and limit
> the number of attempts based on that.

Or measure total time and break the loop early if we come close to TESTTIME:

#define THRESHOLD 5000

tst_timer_start(CLOCK_MONOTONIC);
while (i < attempts) {
  tst_timer_stop();
  elapsed_ms = tst_timer_elapsed_ms();
  if (elapsed_ms + THRESHOLD > TESTTIME)
    break;
}

Regards,
Jan

> We should perhaps add that as a
> feature to the fuzzy sync library.
> >
> > Thank you,
> > Mylène
> >
