From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Tue, 28 Mar 2017 08:42:23 -0700
Subject: [LTP] Failing tests (aio01/aio02) show up in log file but not
 failed list
In-Reply-To: <20170328122708.GE1045@rei>
References: <201703272218.v2RMIp4R006418@sellcey-dt.caveonetworks.com>
 <20170328122708.GE1045@rei>
Message-ID: <1490715743.19074.106.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, 2017-03-28 at 14:27 +0200, Cyril Hrubis wrote:
> Hi!
> > 
> > I noticed an odd thing when running LTP.  There are two tests that
> > show up as FAIL in my results/LTP*.log file (aio01 and aio02) but
> > are
> > not listed in the LTP*.failed list in the output directory.
> Can you post a snippet of the log that shows the failure?
> 
> I glanced over the code, but there does not seem to be any obvious
> mistakes.
> 
> > 
> > Does anyone know why these tests don't get listed?  All my other
> > failures show up in both places.
> Without further debugging, no idea.

Here is the output for aio01.  Is there an aio01 command that I am
missing?  It looks like this is something that should have been built
when I built LTP but I don't see it in the install directory and I
 don't see any reference to it in my build output.  I do see aio01.c
and a Makefile for it in the source tree.

Steve Ellcey



<<<execution_status>>>
initiation_status="ok"
duration=1983 termination_type=exited termination_id=0 corefile=no
cutime=1646326 cstime=241114
<<<test_end>>>
<<<test_start>>>
tag=aio01 stime=1490643879
cmdline="aio01"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(4455): execvp of 'aio01' (tag aio01)
failed.  errno:2  No such file or directory"duration=0
termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=aio02 stime=1490643879
cmdline="aio_tio"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(4455): execvp of 'aio_tio' (tag aio02)
failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>


