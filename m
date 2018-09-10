From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Sep 2018 13:04:22 +0200
Subject: [LTP] [PATCH v7 4/4] Testing statx syscall
In-Reply-To: <20180903121828.3806-1-vaishnavi.d@zilogic.com>
References: <20180903121828.3806-1-vaishnavi.d@zilogic.com>
Message-ID: <20180910110422.GA12187@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've split this test into two, one for the encryption flag and one for
the rest so that the commonly implemented flags could be executed
against all filesystems, which increases the coverate a lot.

I've also fixed the same problem as in the previous tests.

And also changed the encryption test not to fail on kernels that do not
have CONFIG_EXT4_ENCRYPTION compiled in the kernel.

Thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
