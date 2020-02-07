From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2020 10:47:49 -0500 (EST)
Subject: [LTP] [PATCH v6 1/2] safe_macros: Use tst_umount() in
 safe_umount()
In-Reply-To: <20200207152406.GA16951@rei.lan>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207152406.GA16951@rei.lan>
Message-ID: <285421765.6549099.1581090469387.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > To get retry workaround for gvfsd-trash background daemon.
> > 
> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,
> > 
> > this should be ok, but better to double check.
> > Used in fsmount01.
> 
> My expectation is that retrying on EBUSY will not break anything. Jan
> what do you think?

I agree. Though I'd like to point out that tst_umount() currently loops
on any error, not just EBUSY.

