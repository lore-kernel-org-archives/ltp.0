From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Oct 2019 14:56:48 +0200
Subject: [LTP] [PATCH v5 3/5] shell: Add timeout shell API tests
In-Reply-To: <20191011125413.GA30000@dell5510>
References: <20191011095442.10541-1-pvorel@suse.cz>
 <20191011095442.10541-4-pvorel@suse.cz>
 <1570797394.4238.7.camel@suse.de> <20191011125413.GA30000@dell5510>
Message-ID: <20191011125648.GF2591@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> timeout02 1 TCONF: LTP_TIMEOUT_MUL must be number >= 1! (0)
> BTW I wonder if TBROK shouldn't be used instead of TCONF.
> Anybody strong opinion?

If we fail to run a test because user passed wrong input data it has to
be TBROK because TCONF can end up unnoticed.

-- 
Cyril Hrubis
chrubis@suse.cz
