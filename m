From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 16:50:14 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <877e7vd489.fsf@rpws.prws.suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <1879623564.3992300.1564655982672.JavaMail.zimbra@redhat.com>
 <87a7crd606.fsf@rpws.prws.suse.cz> <20190802135944.GA17684@rei>
 <877e7vd489.fsf@rpws.prws.suse.cz>
Message-ID: <20190802145014.GD17684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> If we have runtime free then we need to figure out which map the
> >> address belongs to or what its offset is (if any).
> >
> > That's easy, we will store the returned pointer to the map structure
> > and use it for comparsion...
> 
> So that free() is an O(n) operation where n is the number of maps or you
> will use a hash map to make it O(1)?

I doubt that we will ever allocate more than a few buffers, so it's
perfectly fine that way. Also if you keep allocating and freeing buffer
in a loop it would be at the start of the list, so it would be O(1) as
well.

The only patological case would be allocating thousands of buffers and
then freeing them in a reversed order, which would be O(n^2).

Other options would be storing the pointer to the map before the buffer,
just as malloc does, but I doubt that we will ever need that.

-- 
Cyril Hrubis
chrubis@suse.cz
