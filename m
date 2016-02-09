From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2016 18:46:18 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160209165703.GA5441@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
Message-ID: <20160209174618.GB5441@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> And I was writing faster than thinking. We will need another one where
> starting and reaping child is split between two functions. I will work
> on that tomorrow.

And I've split the function into two now:

https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h#L50

-- 
Cyril Hrubis
chrubis@suse.cz
