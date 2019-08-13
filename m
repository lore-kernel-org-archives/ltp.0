From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 16:37:03 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/ftruncate: Rewrite ftruncate03
 and add new error test
In-Reply-To: <1564645349-10859-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190813143703.GB23369@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a very minor change, thanks.

I've removed the tst_fill_file() since we don't have to have non-empty
file for the test and added O_CREAT and mode to the open in the test
setup.

-- 
Cyril Hrubis
chrubis@suse.cz
