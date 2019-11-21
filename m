From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Nov 2019 10:31:50 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.0-rc8-4b17a56.cki
 (stable-next)
In-Reply-To: <57f8e29e-1d49-e93f-2b03-75a3fd3e6e21@redhat.com>
References: <cki.6D94BD5731.3IAGHB25D8@redhat.com>
 <20191120113534.GC14963@rei.lan>
 <57f8e29e-1d49-e93f-2b03-75a3fd3e6e21@redhat.com>
Message-ID: <20191121093150.GA14186@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> One or more kernel tests failed:
> >>
> >>      ppc64le:
> >>       ??? LTP lite
> >>       ??? xfstests: ext4
> > 
> > Both logs shows missing files, that may be an infrastructure problem as
> > well.
> > 
> > Also can we include links to the logfiles here? Bonus points for showing
> > the snippet with the actual failure in the email as well. I takes a fair
> > amount of time locating them manually in the pipeline repository, it
> > would be much much easier just with the links to the right logfile...
> > 
> 
> Thanks for the feedback Cyril, we did have links to each failure listed
> before but we were told it made the email look cluttered especially
> if there are multiple failures.

So it's exactly how Dmitry described it, you can't please everyone..,

> The test logs are sorted by arch|host|TC, is there something we can
> do to make it easier to find related logs ?
> https://artifacts.cki-project.org/pipelines/296781/logs/
> 
> Maybe we can look into adding the linked logs to the bottom of the
> email with a reference id next to the failures in the summary, so
> for example:
> 
>      ppc64le:
>       ??? LTP lite [1]
>       ??? xfstests: ext4 [2]

That would work for me.

> We could also look into merging the ltp run logs into a single file
> as well.

That would make it too big I guess. Actually the only part I'm
interested in most of the time is the part of the log with the failing
test. I would be quite happy if we had logs/failures file on the
pipelines sever that would contain only failures extracted from
different logfiles. The question is if that's feasible with your
framework.

-- 
Cyril Hrubis
chrubis@suse.cz
