From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Nov 2020 16:54:58 +0100
Subject: [LTP] [PATCH v2 05/11] syscalls: Add a few documentation
 comments
In-Reply-To: <d0e937e67108585af4423e9f688941cb194476ba.camel@suse.com>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201103191327.11081-6-pvorel@suse.cz>
 <d0e937e67108585af4423e9f688941cb194476ba.camel@suse.com>
Message-ID: <20201104155458.GB12971@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Rado, all,

> Hello Petr,

> On Tue, 2020-11-03 at 20:13 +0100, Petr Vorel wrote:

> > + * [DESCRIPTION]
> > + *  Checks that process which called abort() gets killed by SIGIOT
> > and dumps core.

> ...

> > +/*\
> > + * [DOCUMENTATION]
> > + *  Verify that acct() returns proper errno on failure.
> > +\*/
> > +

> I noticed that in some places the DESCRIPTION tag is used and in
> another DOCUMENTATION. What is the difference between the two and which
> should be used when?
I'd suggest to use [DESCRIPTION] and drop [DOCUMENTATION] (whole metadata are
documentation).

It'd be good to document that in README.md

Kind regards,
Petr
