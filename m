From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 14:36:28 +0200
Subject: [LTP] [PATCH 0/6] rewrite exec() family tests to newlib
In-Reply-To: <20180808055434.26293-1-liwang@redhat.com>
References: <20180808055434.26293-1-liwang@redhat.com>
Message-ID: <20180808123628.GB19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch set are base on Cyril's new patch(lib: Fix result
> propagation after exec() + tst_reinit()) to rewrite all exec[lvpe]
> testcase in new API. 

I was thinking about doing exactly this yesterday, it's nice to see it
done so fast :-).

The patches 1-5 are pushed with two changes:

* There is no need to set the .needs_root flag for exec*01 testcases

* It's wrong to do waitpid() for the child that reports the results
  (and it's even written in the test-writing-guidelines) that is because
  tst_brk() is propagated using the exit value, hence children that use
  the test library API has to be waited for in the test library (which
  happens automatically once the main test process exits the test
  function)

-- 
Cyril Hrubis
chrubis@suse.cz
