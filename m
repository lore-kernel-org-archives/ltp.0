From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Mar 2017 13:46:20 +0100
Subject: [LTP] [PATCH] Remove unneeded time() declaration.
In-Reply-To: <1488317719-29809-1-git-send-email-sellcey@caviumnetworks.com>
References: <1488317719-29809-1-git-send-email-sellcey@caviumnetworks.com>
Message-ID: <20170301124620.GA32207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The 'extern long time()' declaration conflicts with time.h which
> declares time() to be of type time_t which may or may not be long.
> This declaration causes a build failure on x86_64 if the file is
> compiled with the -mx32 flag.  The time() function does not appear
> to be used anywhere in fcntl14 so I am not sure why the declaration
> is there anyway.

This is obviously correct, but the patch misses the Signed-of-by: line.

Also usually the first line of the patch describes what testcase it
fixes so it should have been something like:

syscalls/fcntl14: Remove unneeded time() declaration.

Can you please resend with fixed commit description?

-- 
Cyril Hrubis
chrubis@suse.cz
