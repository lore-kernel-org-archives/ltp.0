From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2016 14:54:56 +0100
Subject: [LTP] [PATCH v2 2/3] llistxattr/llistxattr02.c: add new testcase
In-Reply-To: <1455857746-25721-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160218120305.GE19157@rei.lan>
 <1455857746-25721-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1455857746-25721-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160224135456.GD8292@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with the same changes, added tst_require_root() and changed TFAIL
to TBROK in setup(). Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
