From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Nov 2018 16:58:12 +0100
Subject: [LTP] [PATCH v3] syscalls/fanotify10: new test for mount ignore
	mask
In-Reply-To: <CAOQ4uxgKVQt3j8hUBS3YrMS4AmBWJNK33e5_LVXdFrnQ=R52Fg@mail.gmail.com>
References: <20180928075117.4789-1-amir73il@gmail.com>
 <CAOQ4uxgKVQt3j8hUBS3YrMS4AmBWJNK33e5_LVXdFrnQ=R52Fg@mail.gmail.com>
Message-ID: <20181102155812.GD30704@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FYI, I pushed an independent clean branch to:
> https://github.com/amir73il/ltp/commits/fanotify_cleanup

Should I pull them from there or will you send it to the ML?

> You may want to start herding those cleanup patches,
> because I have more patches based on top of them to test new fanotify
> functionality that was just merged to master:
> https://github.com/amir73il/ltp/commits/fanotify_tid

Ok.

> BTW, what is the policy w.r.t tests of new API?
> Would you like me to post those tests only after a point release? (i.e. 4.20)
> or is posting the tests during early -rc preferred so new API can get test
> wider test coverage (on different systems) before the point release?

We usually wait for the changes to hit a point release since the API is
set into stone at that point. But given that LTP is supposedly being
used to test the linux-next tree as well, we may reconsider that in the
future. If the test is correctly skipped on older kernels I wouldn't
mind including it earlier.

-- 
Cyril Hrubis
chrubis@suse.cz
