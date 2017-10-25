From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 10:59:31 +0200
Subject: [LTP] [RFC PATCH 0/7] Remove network test for ancient software
In-Reply-To: <CAL+h-jATfeJYYLa26c8TR5msL+cr9SJBLjZX17OQpNuU5KVvyQ@mail.gmail.com>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <CAL+h-jATfeJYYLa26c8TR5msL+cr9SJBLjZX17OQpNuU5KVvyQ@mail.gmail.com>
Message-ID: <20171025085931.GC5969@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> fwiw, rsh/rcp are still used in the embedded world where security is not a
> concern, but speed/size matters much more (e.g. development)

The question is how much do we care about maintaing the testcases for
these. I guess that rsh and rcp may be still useful in a certain cases
but for a general usage it has been replaced by scp and ssh long time
ago.

-- 
Cyril Hrubis
chrubis@suse.cz
