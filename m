From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 12:28:34 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <20210519063109.224352-2-lkml@jv-coder.de>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de>
Message-ID: <YKToUgBnK6ZQ5I0Q@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There are some differences especially in signal handling
> between the shells, so execute the tests on as many
> shells as possible.

I'm not sure that we want to support anything but bash, dash and
busybox and even these three are enough trouble.

One of my friends once told me that it's easier to write a portable
shell than portable shell code and it looks like he was right...

-- 
Cyril Hrubis
chrubis@suse.cz
