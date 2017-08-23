From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2017 10:40:20 +0200
Subject: [LTP] [PATCH v3] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170823041558.33vhtfsdswenhcfa@XZHOUW.usersys.redhat.com>
References: <20170821160047.GB6479@rei.lan>
 <1503390908-13620-1-git-send-email-xzhou@redhat.com>
 <20170822142356.GB23381@rei.lan>
 <20170823041558.33vhtfsdswenhcfa@XZHOUW.usersys.redhat.com>
Message-ID: <20170823084019.GA8175@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +	if (tst_fill_file(fname, 1, write_size, thread_cnt)) {
> > > +		tst_brk(TBROK, "Failed to create tst file");
> > > +	}
> > 
> > No need for the curly braces around single line statement here.
> 
> I thought it's safer for a macro. Now it's one line function in
> the macro, not hurting to remove the braces.

Even macros that have several lines are safe in LTP since we use the
do { ... } while (0) idiom.

-- 
Cyril Hrubis
chrubis@suse.cz
