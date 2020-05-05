From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 May 2020 16:57:07 +0200
Subject: [LTP] [PATCH v2] openposix/twoptimers: handle signal correctly
In-Reply-To: <1585112820-30322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5E71F152.5010909@cn.fujitsu.com>
 <1585112820-30322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200505145707.GE27810@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've also changed the code so that the test fails if we got wrong signal
and removed the useless sleep() in the child and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
