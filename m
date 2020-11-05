From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Nov 2020 13:48:10 +0100
Subject: [LTP] [PATCH v2 05/11] syscalls: Add a few documentation
 comments
In-Reply-To: <d0e937e67108585af4423e9f688941cb194476ba.camel@suse.com>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201103191327.11081-6-pvorel@suse.cz>
 <d0e937e67108585af4423e9f688941cb194476ba.camel@suse.com>
Message-ID: <20201105124810.GC10395@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > + * [DESCRIPTION]
> > + *  Checks that process which called abort() gets killed by SIGIOT
> > and dumps core.
> 
> ...
> 
> > +/*\
> > + * [DOCUMENTATION]
> > + *  Verify that acct() returns proper errno on failure.
> > +\*/
> > +
> 
> I noticed that in some places the DESCRIPTION tag is used and in
> another DOCUMENTATION. What is the difference between the two and which
> should be used when?

This is one of the open points at the moment. The exact format of the
test description needs to be decided on and written down.

However I wanted to get the code reviewed and included in upstream even
though there are a few loose ends since it's complex enough as it is and
the detail can be worked on later. Especially since I want to make use
of the metadata for parallel test execution and the documentation part
is not that important there.

-- 
Cyril Hrubis
chrubis@suse.cz
