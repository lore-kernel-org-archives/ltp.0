From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Sep 2020 16:43:57 +0200
Subject: [LTP] [PATCH 00/10] Fanotify tests for v5.9
In-Reply-To: <CAOQ4uxi3fv-ONsJoXYwTh2iP5fM2Ssj7GgcrzcEGRtsEbYgNLw@mail.gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
 <20200910112730.GA7194@dell5510>
 <CAOQ4uxjAwQcmSnsJ5=O88bi2zxAzAe8uXCgg4+5mF6qOmSBfGQ@mail.gmail.com>
 <CAOQ4uxi3fv-ONsJoXYwTh2iP5fM2Ssj7GgcrzcEGRtsEbYgNLw@mail.gmail.com>
Message-ID: <20200910144357.GA10114@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Sure I did not know about tst_parse_kver() I will send a patch.
> >
> > BTW, sorry for the wrong commit id in the test.
> > Your fix missed removing the old commit from comment:
> >
> >   * Test cases #17-#23 are regression tests for commit:
> >   *
> >   *     497b0c5a7c06 fsnotify: send event to parent and child with single...
> >   *     eca4784cbb18 fsnotify: send event to parent and child with single...
> >   */
> >
> 
> Actually, I don't see any examples of tests that use tst_kvcmp()

It's tst_kvercmp() the tst_kvcmp() is internal library function that
shouldn't be used in testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
