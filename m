From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Aug 2020 14:45:04 +0200
Subject: [LTP] [PATCH 1/2] lib/tst_kvercmp: Add support to get distname
 for Ubuntu in tst_kvcmp_distname
In-Reply-To: <20200817123403.GA8445@yuki.lan>
References: <20200817120644.9401-1-po-hsu.lin@canonical.com>
 <20200817120644.9401-2-po-hsu.lin@canonical.com>
 <20200817123403.GA8445@yuki.lan>
Message-ID: <20200817124504.GC8445@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It should be as easy as one SAFE_FILE_SCANF() in the case that the file
> exists.

It's SAFE_FILE_LINES_SCANF()

-- 
Cyril Hrubis
chrubis@suse.cz
