From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Aug 2019 14:18:38 +0200
Subject: [LTP] [RFC PATCH 0/1] tst API for dropping or requiring
 capabilities
In-Reply-To: <20190808153825.18363-1-rpalethorpe@suse.com>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
Message-ID: <20190809121838.GB32115@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It can be used like this:
> 
> 	.caps = (struct tst_cap []) {
> 		TST_CAP(TST_DROP, CAP_SYS_ADMIN),
> 		{0, 0, 0},

A minor note, the {0, 0, 0} should be equivalent to {}

-- 
Cyril Hrubis
chrubis@suse.cz
