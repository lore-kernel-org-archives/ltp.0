From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 11:05:41 +0200
Subject: [LTP] [PATCH] ltp: keep the .tid hidden in the test library
In-Reply-To: <CAEemH2ekrPr8OJAwKP4Zog+M1xNCR7wqW-QBt-6AOUiCxbMWPQ@mail.gmail.com>
References: <20171025081150.11206-1-liwang@redhat.com>
 <CAEemH2ekrPr8OJAwKP4Zog+M1xNCR7wqW-QBt-6AOUiCxbMWPQ@mail.gmail.com>
Message-ID: <20171025090541.GD4244@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Attaching a new patch to achieve the same target in another way. It
> just remove the .tid from test struct and take use of TCID to replace.
> 
> Which one do you think is better?

I think that removing it from the test structure is better, but reusing
the oldlib TCID seems to be a bit messy solution to me. We may get rid
of that one in the future, if we happen to convert all the oldlib
testcases. I would be a bit happier if we decleared static char *tid in
the tst_test.c instead.

-- 
Cyril Hrubis
chrubis@suse.cz
