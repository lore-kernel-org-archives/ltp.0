From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 14:03:51 +0200
Subject: [LTP] [PATCH 1/1] docparse: Make tags in table clickable
In-Reply-To: <20210503150415.18835-1-pvorel@suse.cz>
References: <20210503150415.18835-1-pvorel@suse.cz>
Message-ID: <YJE4J0gMjhTfsNCO@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> linked to the section.

Looks good, acked.


Btw, when I was looking at the page today I noticed that in the tags
table the tag points to the git/CVE page and not the actuall hash or ID.
I would expect that linux-git would be normal text and the commit id
would link to the kernel.org repo, and same for the CVE...

-- 
Cyril Hrubis
chrubis@suse.cz
