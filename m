From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Aug 2018 17:16:32 +0200
Subject: [LTP] [PATCH] fs: exclude 'wakeup_count' from read_all_sys test.
In-Reply-To: <87mutp4cek.fsf@rpws.prws.suse.cz>
References: <20180803152018.13701-1-sspatil@google.com>
 <87sh3m48jn.fsf@rpws.prws.suse.cz>
 <20180813150202.GB140438@sspatil-desktop.mtv.corp.google.com>
 <87mutp4cek.fsf@rpws.prws.suse.cz>
Message-ID: <20180814151632.GB20278@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So, unless the upstream ABI says the semantics are different for some files,
> > I don't think we should do this. 'wakeup_count' is the one I found and after
> > I exclude this, the test passes just fine on Pixel phones for example.
> > (Including the debugfs mount point under /sys/kernel/debug).
> >
> > I say we wait for another case of exclusion show up before considering your
> > approach as I think we will miss real problem if we start timing out. Plus,
> > there is the question of whether we report the test as PASS / FAIL in those
> > cases. The exclusion list is the right approach IMO. We may just have to
> > figure out how to add more than one in the command line as they show up.
> >
> > Agree?
> >
> 
> Yes, but possibly we should add a feature which allows us to annotate some
> file's. Then we can mark this file as 'can_block', so if we do timeout
> while reading it then we still know to PASS. Whereas for other files, we
> can FAIL if it blocks. We discussed doing something like this
> previously, but decided to wait for feedback before trying anything like
> this. We already had to drop privileges due to /dev/watchdog, but
> annotations could allow us to avoid this as well. This could perhaps go
> into read_all02 and read_all01 just continues to use an exclude list and
> drop privs.
> 
> I would be happy to implement said feature, but it may take a while. In
> the meantime I'm not against merging this patch and waiting for another
> file with similar problems to appear.

Sounds good, I will apply this band aid for now, then we can look into
better solutions.

> What do you think Metan? We could probably replace proc01 with
> read_all02 as well.

Sounds good as well.

-- 
Cyril Hrubis
chrubis@suse.cz
