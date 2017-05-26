From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 16:16:55 +0200
Subject: [LTP] [PATCH 1/2] syscall/write02.c: Cleanup && convert to new
 API.
In-Reply-To: <1492771707-7554-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1492771707-7554-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20170526141655.GE6492@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The write01 seems to do pretty much the same but only with a buffer
sized 1 byte. Can you rather add a few lines of code to the write01.c
test so that it tries with different buffer sizes and remove write02.c?

It does not make much sense to keep two tests that does basically the
same.

-- 
Cyril Hrubis
chrubis@suse.cz
