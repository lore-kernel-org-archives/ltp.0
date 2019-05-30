From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 May 2019 11:48:12 +0200
Subject: [LTP] [PATCH] lib/tst_test: print INFO msg for test variants
In-Reply-To: <20190530085834.21432-1-xzhou@redhat.com>
References: <20190530085834.21432-1-xzhou@redhat.com>
Message-ID: <20190530094812.GA31468@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Make the test output clearer about what's going on when we
> run multiple variants.

Actually the test itself is supposed to print which variant it's about
the test. Printing the variant number does not help much.

-- 
Cyril Hrubis
chrubis@suse.cz
