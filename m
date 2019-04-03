From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Apr 2019 17:19:49 +0200
Subject: [LTP] [PATCH v4 1/2] include/SAFE_UNSHARE() macro added
In-Reply-To: <20190328202235.7872-1-fedebonfi95@gmail.com>
References: <20190326192052.GA15776@rei.lan>
 <20190328202235.7872-1-fedebonfi95@gmail.com>
Message-ID: <20190403151949.GB26464@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes:

* Added missing Signed-off-by: lines to the patch description

* Changed the tst_brk_() message on failure
  (both were saying unsupported which is not true)

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
