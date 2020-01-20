From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Jan 2020 15:55:55 -0500 (EST)
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.13-rc1-7f1b863.cki
 (stable)
In-Reply-To: <20200116153741.GA558@rei>
References: <cki.FA900DB853.LBD049H627@redhat.com>
 <84944fa0-3c18-f8a4-47ca-7627eb4e0594@redhat.com> <20200116153741.GA558@rei>
Message-ID: <270741803.2885047.1579553755871.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > One or more kernel tests failed:
> > > 
> > >      ppc64le:
> > >       ??? LTP
> > 
> > Hi, I see max_map_count failed on ppc64le:
> > https://artifacts.cki-project.org/pipelines/385189/logs/ppc64le_host_2_LTP_mm.run.log
> 
> That's strange, we do attempt to map 65536 mappings but we do not touch
> them, so these shouldn't be faulted in, so there is no real reason why
> mmap() in the child process should stop prematurely at 65532.
> 

We do not touch them, but the test is setting OVERCOMMIT_NEVER since ~2012.
It tries to estimate number of pages that can be used with global CommitLimit
and Committed_AS.

But we sporadically fail at __vm_enough_memory() on a percpu counter:
... 
        if (percpu_counter_read_positive(&vm_committed_as) < allowed)
                return 0;
which can be presumably increased by anything else running on system.

Comments say this is to avoid certain bad OOM behaviour, but given its age,
it might be long invalid.

Regards,
Jan





