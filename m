From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 16:54:08 +0100
Subject: [LTP] [PATCH v3 2/2] removexattr/removexattr02.c: add new
	testcase
In-Reply-To: <1457059628-26560-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160303181230.GB14084@rei.lan>
 <1457059628-26560-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1457059628-26560-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160307155408.GA6055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Both patches pushed with tst_require_root() removed (since user
namespace does not need it) and with one typo fixed. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
