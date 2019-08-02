From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 16:23:09 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190802135944.GA17684@rei>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <1879623564.3992300.1564655982672.JavaMail.zimbra@redhat.com>
 <87a7crd606.fsf@rpws.prws.suse.cz> <20190802135944.GA17684@rei>
Message-ID: <20190802142309.GC17684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If we have runtime free then we need to figure out which map the
> > address belongs to or what its offset is (if any).
> 
> That's easy, we will store the returned pointer to the map structure
> and use it for comparsion...

Or we even don't have to do that, we do have a buffer start address and
length so we just need to make sure that the pointer fits the range...

-- 
Cyril Hrubis
chrubis@suse.cz
