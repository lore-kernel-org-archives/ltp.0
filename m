From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Apr 2020 15:58:56 +0200
Subject: [LTP] [PATCH v2 09/10] syscalls/ioctl_loop07: Add dio with
 logic block size error test
In-Reply-To: <1586429086-22975-9-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-9-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200422135856.GB5529@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This test fails for me, i.e. the attempt to enabe direct IO succeeds. I
will have to have a closer look later on.

-- 
Cyril Hrubis
chrubis@suse.cz
