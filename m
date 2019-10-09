From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2019 08:48:00 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Add check for pipe
In-Reply-To: <20191009091145.GA7561@rei.lan>
References: <20191008151624.19815-1-chrubis@suse.cz>
 <1365327078.5308904.1570610176976.JavaMail.zimbra@redhat.com>
 <20191009091145.GA7561@rei.lan>
Message-ID: <335049795.5352699.1570625280674.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > The original patch that was adding this fell under a table:
> > > 
> > > http://patchwork.ozlabs.org/patch/1112976/
> > > 
> > > I guess there is no harm checking that we get EINVAL for pipe as well,
> > > or does anyone disagree?
> > 
> > Do you know what is kernel behaviour prior to commit 11cbfb10775a ?
> > Does it pass/fail/crash/different errno?
> 
> The test is disabled unless cross FS copy support is implemented in
> kernel, so the test is disabled for anything older than v5.3 anyways.

Thanks, I don't see any potential issues then, ACK.
