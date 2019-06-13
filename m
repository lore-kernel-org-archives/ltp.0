From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 17:17:39 +0200
Subject: [LTP] [PATCH v2 3/3] syscalls/bind01: convert to new library.
In-Reply-To: <20190613145507.GD29926@rei.lan>
References: <20190610002610.2187-1-sspatil@android.com>
 <20190610002610.2187-4-sspatil@android.com>
 <20190613145507.GD29926@rei.lan>
Message-ID: <20190613151738.GF29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> However the test fails with -i 2 after this patch since on second
> iteration since the socket is already bind for the possitive test
> because we no longer close the socket after each iteration. Looking at
> the bind tests we should move this one into a separate testcase and add
> a few more positive tests as well we seem to test only AF_INET,
> SOCK_STREAM combination which does not even cover ipv4 nor we attemp to
> connect to the socket that have been bind.

FYI I've added an issue so that this is not forgotten:

https://github.com/linux-test-project/ltp/issues/538

-- 
Cyril Hrubis
chrubis@suse.cz
