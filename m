Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XJLPM-0002ZS-KQ
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 11:47:28 +0000
Date: Mon, 18 Aug 2014 13:46:29 +0200
From: chrubis@suse.cz
Message-ID: <20140818114628.GA5202@rei.suse.cz>
References: <02d3651008f483ee4298d802ace785c4944ce1de.1408015922.git.jstancek@redhat.com>
	<20140818095931.GA3627@rei.suse.cz>
	<805855742.8408932.1408357068816.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <805855742.8408932.1408357068816.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] profil01: rewrite testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > +	size_t offset = (size_t) &test_profil, count = 0;
> > > +	int ret, i, data[8];
> > > +
> > > +	/* make data depend on runtime value, so gcc can't make assumptions */
> > > +	memset(data, getpid(), sizeof(data));
> > > +
> > > +	/* reset for test looping */
> > > +	profil_done = 0;
> > > +
> > > +	/* profil_count in glibc calculates offset as
> > > +	 *   i = (pc - pc_offset - (void *) 0) / 2
> > > +	 *   i = i * pc_scale / 65536
> > > +	 * set scale to 2*65536 to have 1:1 mapping for $pc */
> > > +	ret = profil(buf, PROFIL_BUFSZ, offset, 2*65536);
> >                             ^                   ^
> > 			    sizeof(buf) ?       why 2* ?
> 
> profil_count() formula divides by 2, I'm not sure why.
> It doesn't make a big difference for test, but it made it easier when
> comparing output from testcase with disassembled code.

Strange, looking into glibc sources to sysdeps/posix/profil.c

/* Enable statistical profiling, writing samples of the PC into at most
   SIZE bytes of SAMPLE_BUFFER; every processor clock tick while
   profiling is enabled, the system examines the user PC and increments
   SAMPLE_BUFFER[((PC - OFFSET) / 2) * SCALE / 65536].  If SCALE is zero,
   disable profiling.  Returns zero on success, -1 on error. */

but man page suggests that the formula is (PC - OFFSET) * SCALE / 65536

The glibc sources mentions POSIX.1 but recent enough POSIX does not seem
to contain any reference to profil()....

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
