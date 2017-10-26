From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Oct 2017 10:16:54 +0200
Subject: [LTP] [PATCH] android: io/diotest4: remove dependency on
 <sys/shm.h>
In-Reply-To: <20171018054923.GJ21774@sspatil-macbookpro.roam.corp.google.com>
References: <20170919232713.57314-1-sspatil@google.com>
 <20171011121505.GA12177@rei>
 <20171018054923.GJ21774@sspatil-macbookpro.roam.corp.google.com>
Message-ID: <20171026081654.GA3873@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thank you very much for the history. I guess I can make this change under
> __BIONIC__ check (like some of the other tests) and that should work fine ..

Or we may as well fix this in a clean way and once for all. What about
adding a constant to include/lapi/mmap.h something as MMAP_GRANULARITY
and defining it to SHMLBA if the shm headers are present and to
getpagesize() if they are not?

-- 
Cyril Hrubis
chrubis@suse.cz
