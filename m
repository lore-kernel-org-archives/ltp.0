From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Dec 2019 14:30:43 +0100
Subject: [LTP] [PATCH] syscalls/shmat03: Remove CVE tag
In-Reply-To: <20191126111953.GA11567@dell5510>
References: <20191121133414.19808-1-chrubis@suse.cz>
 <20191126111953.GA11567@dell5510>
Message-ID: <20191209133043.GA7221@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The CVE was proved to be bogus so as far as I can tell we shouldn't list
> > it in tags.
> ack (although a link claiming it bogus would be nice).

I've added added a commit hash of the commit that removed the test from
runtest/cve to this commit message. It's nicely explained in the
original commit so there is no need to copy the information over to the
new commit. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
