From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 15:30:43 +0100
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
References: <20190315160142.GA8921@rei>
 <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
 <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
 <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
Message-ID: <20190319143043.GJ6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> That's all sounds reasonable.
> 
> We only need to make sure the bug fixed by 77bf45e78050 will not be
> re-introduced.

Well, we can turn the reproducer from that commit into an automated
test, that's the only way to make sure bugs are not reintroduced
anyways...

-- 
Cyril Hrubis
chrubis@suse.cz
