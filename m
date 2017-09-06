From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 14:29:21 +0200
Subject: [LTP] [PATCH 3/3] cve/cve-2016-7042: Make use of the fallback
 functions in lapi/keyctl.h
In-Reply-To: <20170906095623.10358-3-fenggw-fnst@cn.fujitsu.com>
References: <20170906095623.10358-1-fenggw-fnst@cn.fujitsu.com>
 <20170906095623.10358-3-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170906122921.GC24177@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +LDLIBS			+= $(KEYUTILS_LIBS)

This should be set only for the particular test and not for all of them,
like we do with -lrt and -lutil for the rest of the test.

-- 
Cyril Hrubis
chrubis@suse.cz
