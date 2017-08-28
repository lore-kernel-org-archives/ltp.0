From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 28 Aug 2017 08:30:06 -0400 (EDT)
Subject: [LTP] RFC: Drop support for libnuma API version < 2
In-Reply-To: <20170828122405.smk4icypnbywlybj@dell5510>
References: <20170828083904.4kc7ndp2jdwugs7f@dell5510>
 <367492676.4269530.1503921292583.JavaMail.zimbra@redhat.com>
 <20170828122405.smk4icypnbywlybj@dell5510>
Message-ID: <1430015439.4279887.1503923406174.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> > I would go with "no" for writing new code against libnuma < 2. Looking at
> > LTP, I see only handful of tests that have specific code for old (< 2)
> > libnuma.
> 
> > But I'd like to keep LTP compilable with these old distros,
> > since there are lot of tests that still can be used.
> 
> Thanks for info.
> OK, I'll keep legacy code in mbind/mbind01.

Just to  be clear, I wasn't asking to keep legacy code in mbind01,
I was only asking that new version can still be at least compiled
(and presumably run to exit with TCONF) on old distros.

Regards,
Jan
