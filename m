From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jul 2021 10:51:13 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
In-Reply-To: <YO/l6yni/AAOGhn9@pevik>
References: <20210714142001.20566-1-pvorel@suse.cz> <YO70PiTdyxzTw0k2@pevik>
 <YO77+MmmxwMewgnQ@yuki> <YO8UIP310jsAmq8I@pevik>
 <YO/l6yni/AAOGhn9@pevik>
Message-ID: <YO/3AYqt8tAABFxy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Thanks! Testing it in https://github.com/pevik/ltp/actions/runs/1031005963
> 
> The result is much better but still not correct:
> https://github.com/pevik/ltp/runs/3068932859?check_suite_focus=true#step:11:707

If tests are printing into stdout as well it will be easier to redirect
the test output in the script so that the CI gets it all into a single
file descriptor.

What about doing ./$i 1>&2 in the loop that runs the tests instead?

-- 
Cyril Hrubis
chrubis@suse.cz
