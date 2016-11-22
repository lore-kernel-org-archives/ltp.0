From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 11:22:27 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_SETPRIORITY() && Drop
 redundant space
In-Reply-To: <583412F7.5070403@cn.fujitsu.com>
References: <1479375382-28964-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161122080944.GE5620@rei.lan> <583412F7.5070403@cn.fujitsu.com>
Message-ID: <20161122102226.GE7048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And also this is 1/2, shouldn't there be a second patch that uses this?
> 
> Yes, I should have sent the second patch that uses this, but I faced a problem
> below and was still working on it.
> 
> I found that setpriority01 with PRIO_USER as root will change system environment,
> set the priorities of all specified processes to 19.

Well that is kind of expected, since it should operate on all processes
whose user real id matches the who parameter. I guess that the only safe
way how to test this flag is to:

* Pick unused user id and sets it as a real user id
* Start a few processes there
* One of them calls setpriority and checks that all of them got it

-- 
Cyril Hrubis
chrubis@suse.cz
