From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Oct 2019 11:57:24 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <87tv8awj36.fsf@rpws.prws.suse.cz>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-2-chrubis@suse.cz>
 <CAEemH2e+xD2OCFZs14ejmppKu2rLXKsr16Vfc3tqw-YoesWuJg@mail.gmail.com>
 <87tv8awj36.fsf@rpws.prws.suse.cz>
Message-ID: <20191015095724.GC14021@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It may be better just to print "Associated Linux kernel commit: ..." and
> "Associated bug ID: CVE-..." in the loop. Then we can avoid any
> discussions about what type of test it is.

I will try that.

> Also, a test description tag could be added if necessary.

My plan is actually to keep the description in the top level comment but
parse that by the docparse tool, then we will have a browseable test
documentation that could be put to the web and we can point to that
here.

> Maybe it would also be a good idea to link back to the test source code
> on github? Possibly this info could be injected at build time?

I tried to inject things at a build time and it wasn't pretty, so I
would like to avoid that.

-- 
Cyril Hrubis
chrubis@suse.cz
