From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Mar 2017 09:29:35 +0100
Subject: [LTP] [PATCH] kmsg01: fix race in SEEK_SET 0 test
In-Reply-To: <1967673779.3483232.1488788306768.JavaMail.zimbra@redhat.com>
References: <6629de071a23c5a8df8eca358a55e5ae9ccc969e.1488447021.git.jstancek@redhat.com>
 <20170303143643.GC16323@rei.lan>
 <1967673779.3483232.1488788306768.JavaMail.zimbra@redhat.com>
Message-ID: <20170306082934.GA23159@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +		/*
> > > +		 * Open 2 fds. Use fd1 to read seqno1, then seek to
> > > +		 * begininng and read seqno2. Use fd2 to check if
> > > +		 * first entry in buffer got overwritten. If so,
> > > +		 * we'll have to repeat the test.
> > > +		 */
> > > +		fd = SAFE_OPEN(cleanup, "/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > > +		fd2 = SAFE_OPEN(cleanup, "/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > > +
> > > +		if (read_msg_seqno(fd, &seqno[0]))
> > > +			goto close_fds;
> > > +
> > > +		if (lseek(fd, 0, SEEK_SET) == -1) {
> > > +			tst_resm(TFAIL|TERRNO, "SEEK_SET 0 failed");
> > > +			goto done;
> > 
> > I wonder if this should be tst_brkm() rather than tst_resm(), since as
> > it is we would end up printing the TFAIL message below, or am I
> > mistaken?
> 
> I can skip the TFAIL message below, but I find TFAIL here more fitting,
> because it is directly related to what's being tested. 

Sounds reasonable, let's go with that.

-- 
Cyril Hrubis
chrubis@suse.cz
