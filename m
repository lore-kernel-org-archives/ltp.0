From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 21 Nov 2019 10:58:04 +0000
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.0-rc8-4b17a56.cki
 (stable-next)
In-Reply-To: <20191121093150.GA14186@rei.lan>
References: <cki.6D94BD5731.3IAGHB25D8@redhat.com>
 <20191120113534.GC14963@rei.lan>
 <57f8e29e-1d49-e93f-2b03-75a3fd3e6e21@redhat.com>
 <20191121093150.GA14186@rei.lan>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF978BCF95@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From:  Cyril Hrubis
> 
> Hi!
> > >> One or more kernel tests failed:
> > >>
> > >>      ppc64le:
> > >>       ??? LTP lite
> > >>       ??? xfstests: ext4
> > >
> > > Both logs shows missing files, that may be an infrastructure problem as
> > > well.
> > >
> > > Also can we include links to the logfiles here? Bonus points for showing
> > > the snippet with the actual failure in the email as well. I takes a fair
> > > amount of time locating them manually in the pipeline repository, it
> > > would be much much easier just with the links to the right logfile...

My preference would be to include the failure snippet somewhere in
the e-mail as well (as opposed to just a link).

> > >
> >
> > Thanks for the feedback Cyril, we did have links to each failure listed
> > before but we were told it made the email look cluttered especially
> > if there are multiple failures.
> 
> So it's exactly how Dmitry described it, you can't please everyone..,
> 
> > The test logs are sorted by arch|host|TC, is there something we can
> > do to make it easier to find related logs ?
> > https://artifacts.cki-project.org/pipelines/296781/logs/
> >
> > Maybe we can look into adding the linked logs to the bottom of the
> > email with a reference id next to the failures in the summary, so
> > for example:
> >
> >      ppc64le:
> >       ??? LTP lite [1]
> >       ??? xfstests: ext4 [2]
> 
> That would work for me.
> 

Maybe combine the 'footnote' idea with the 'inline' idea, and have
the footnote include a link to the full log and a snippet with just the
output from the failing testcase, from the full log?

> > We could also look into merging the ltp run logs into a single file
> > as well.
> 
> That would make it too big I guess. Actually the only part I'm
> interested in most of the time is the part of the log with the failing
> test. I would be quite happy if we had logs/failures file on the
> pipelines sever that would contain only failures extracted from
> different logfiles. The question is if that's feasible with your
> framework.

Fuego has an LTP log-splitter and link generator.
It's Fuego-specific and generates
files referred to by links in the result  tables that Fuego
shows to users.

I don't know how CKI is generating it's data or storing it,
but I can take a look and see if it could be applied
to their use case.  It's a python program that is fairly small.

See here:
https://bitbucket.org/fuegotest/fuego-core/src/master/tests/Functional.LTP/parser.py

It might not be applicable, depending on whether CKI stores their LTP output similarly
to how Fuego does, but IMHO it's worth taking a look.  If there is sufficient interest,
maybe this could be generalized and submitted to upstream LTP.  The Fuego log-splitter
produces individual files.

Another idea would be to write a program that takes an LTP log,
and the name of a failing testcase, and outputs (on stdout)  the snippet from the log
for that testcase.  I think this would be very easy to do, and might be suitable to
use in multiple contexts: on the command line, in a report
generator, or as a CGI script for a results server.
 -- Tim

