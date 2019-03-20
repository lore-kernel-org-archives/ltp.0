From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Mar 2019 16:28:44 +0100
Subject: [LTP] [PATCH] Add ltp pivot_root test
In-Reply-To: <20190319223157.47453-1-paullawrence@google.com>
References: <20190319223157.47453-1-paullawrence@google.com>
Message-ID: <20190320152843.GA17281@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Added .gitignore for the pivot_root01 binary

* Changed tst_brk(TFAIL, ...) to tst_brk(TBROK, ...)
  (see https://github.com/linux-test-project/ltp/issues/462)

* Made use of TERRNO flag instead of strerror(), we avoid using
  strerror() since it produces localized sentencies instead of
  errno symbolic names. Instead we use either TERRNO or tst_strerrno()
  function.

-- 
Cyril Hrubis
chrubis@suse.cz
