From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jul 2021 15:48:54 +0200
Subject: [LTP] [PATCH] Add set_mempolicy05, CVE-2017-7616
In-Reply-To: <875ywsrmoh.fsf@suse.de>
References: <20210726154605.7828-1-rpalethorpe@suse.com>
 <YQALVdEAGOVa+g4H@yuki> <878s1rlqa6.fsf@suse.de>
 <YQPTkYcAFcsmp+UV@yuki> <875ywsrmoh.fsf@suse.de>
Message-ID: <YQQDRtIqfwFZFJy4@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I suppose that compat syscalls seem to have a lot of CVEs. So reviewing
> them and trying to come up with general tests is probably worth it. I'm
> not sure if the user stack is the right place to look though.

Looks like the userspace stack allocations are going to get removed
soon anyways, so we shouldn't invest into testing it:

https://www.spinics.net/lists/linux-api/msg49545.html

-- 
Cyril Hrubis
chrubis@suse.cz
