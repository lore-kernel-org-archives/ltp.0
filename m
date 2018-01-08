From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Jan 2018 10:09:32 -0500 (EST)
Subject: [LTP] [RFC PATCH 0/2] Allow to compile on archs without
	atomic	support
In-Reply-To: <20180104204250.7032-1-pvorel@suse.cz>
References: <20180104204250.7032-1-pvorel@suse.cz>
Message-ID: <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,

Hi,

> 
> I know as this has quite low priority (benefit only people with old
> compilers and archs), but why not to give a chance them to have at least
> something from LTP?

Compiler shouldn't matter, we have fallbacks.
So I assume this concerns only some architectures we currently don't support.

> Quite a lot of tests it's working, affected are only tests using threads
> on new API or fuzzy synchronization and counting results for tests using
> new api.

What if we made general implementation with some locking? It would be
slower, but I think we don't use atomics that much for it to matter.

Regards,
Jan
