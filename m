From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jul 2020 11:13:33 +0200
Subject: [LTP] [PATCH 1/1] numa01.sh: Handle computation error
In-Reply-To: <20200701233133.122801-1-petr.vorel@gmail.com>
References: <20200701233133.122801-1-petr.vorel@gmail.com>
Message-ID: <20200702091333.GA2445@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Simple fix for https://github.com/linux-test-project/ltp/issues/702,
> I guess there should be more checks. Not tested.
> BTW I thought numa01.sh was intended to be replaced with C (@Cyril: am I
> correct?), thus I didn't bother to split syntax fix into 2 commits.

In the long term yes, a few tests have been removed from it since they
were reimplemented in C already. The rest is on TODO with a low
priority. For instance we already have tests for migrate_pages, if we
cleanup these we can remove the test8 from the numa01.sh etc...

-- 
Cyril Hrubis
chrubis@suse.cz
