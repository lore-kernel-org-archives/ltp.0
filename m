From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Sep 2019 13:08:19 +0200
Subject: [LTP] [PATCH v3] BPF: Regression test for 64bit arithmetic
In-Reply-To: <874l1bl6vj.fsf@rpws.prws.suse.cz>
References: <20190911095422.11767-1-rpalethorpe@suse.com>
 <1568372120.3306.13.camel@suse.de> <20190913114613.GA7939@rei>
 <874l1bl6vj.fsf@rpws.prws.suse.cz>
Message-ID: <20190927110819.GB17233@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Technically we should be using PRIu64 which expands to %lu on 64 bit and
> > to %llu on 32 bit. But given that sizeof(long long) == sizeof(long) on
> > 64 bit on Linux %llu should work as well.
> 
> Ack.

In the end I've pushed this with the PRIu64 since the compiler was
throwing warnings for %llu on 64 bit.

-- 
Cyril Hrubis
chrubis@suse.cz
