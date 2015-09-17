From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Sep 2015 10:47:13 +0200
Subject: [LTP] [PATCH v2] Include config.mk and features.mk in
 env_pre.mk for all targets
In-Reply-To: <1442414775-16702-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1442414775-16702-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20150917084713.GA3375@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# If config.mk or features.mk doesn't exist it's not an error for
> +# some targets which are filtered below (e.g. clean). However these
> +# config files may be needed for those targets thus it would be wise
> +# to do silent inclusion.

I've added one more sentence here, to make it clear that open posix
testsuite is not cleaned up if we do not include these config files and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
