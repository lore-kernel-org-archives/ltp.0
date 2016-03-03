From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Mar 2016 09:10:21 -0500 (EST)
Subject: [LTP] [PATCH v2 2/2] numa_helper: add min_nodes parameter to
 is_numa()
In-Reply-To: <20160303133548.GA3055@rei.lan>
References: <83c57fb26e06f81d4b71cb89dfcd36706bf28093.1456220777.git.jstancek@redhat.com>
 <11305bbeff8a3b83ee9da6c4a17fc1cd9c37b9f5.1456220777.git.jstancek@redhat.com>
 <20160303133548.GA3055@rei.lan>
Message-ID: <153067601.4724228.1457014221497.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, liwang@redhat.com
> Sent: Thursday, 3 March, 2016 2:35:48 PM
> Subject: Re: [PATCH v2 2/2] numa_helper: add min_nodes parameter to is_numa()
> 
> Hi!
> > get_allowed_nodes() can fail if callers request more nodes than
> > are available. This patch changes is_numa() by adding a parameter
> > to it, which allows to easily check that system supports NUMA and
> > has at least certain number of nodes and it also updates tests
> > that used get_allowed_nodes() without checking node count first.
> 
> Shouldn't we pass the NH_MEMS/NH_CPUS flags to the is_numa() as well?

We probably should, we have maybe 1 or 2 tests that care about cpus,
not just mem. I'll add it.

> 
> Otherwise the patchset looks good to me.

Thanks for review,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
