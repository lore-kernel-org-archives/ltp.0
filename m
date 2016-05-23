From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 May 2016 10:59:42 -0400 (EDT)
Subject: [LTP] [PATCH] mem/oom: fork may fail before test
In-Reply-To: <20160523143611.GD25488@rei.lan>
References: <9e8fc1797bd3bf0fe725a4b589e4fabda09ea0b8.1463669846.git.jstancek@redhat.com>
 <20160523143611.GD25488@rei.lan>
Message-ID: <629001822.73045.1464015582893.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 23 May, 2016 4:36:11 PM
> Subject: Re: [LTP] [PATCH] mem/oom: fork may fail before test
> 
> Hi!
> > On systems with small RAM and vm.overcommit_memory == 2,
> > the system may already be in state where Committed_AS is
> > larger than CommitLimit due to various backround daemons
> > (NM, tuned, polkitd,...) asking for big allocations.
> > 
> > In such instances oom testcases report TBROK on very first fork.
> > This patch allows this to be a valid outcome (TPASS).
> 
> Looks good to me, acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
