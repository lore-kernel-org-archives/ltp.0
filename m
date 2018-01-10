From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jan 2018 12:09:46 +0100
Subject: [LTP] [RFC PATCH 0/2] Allow to compile on archs without
	atomic	support
In-Reply-To: <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
References: <20180104204250.7032-1-pvorel@suse.cz>
 <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
Message-ID: <20180110110946.GC18314@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What if we made general implementation with some locking? It would be
> slower, but I think we don't use atomics that much for it to matter.

Atomic increment was easiest way how to make the test library thread
safe I wasn't concerned with speed at all. But that is not true for the
CVE tests which use atomic operation to synchronize threads to trigger
races.

-- 
Cyril Hrubis
chrubis@suse.cz
