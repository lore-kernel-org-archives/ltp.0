From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Apr 2018 13:15:24 +0200
Subject: [LTP] [PATCH v4 1/2] preadv/preadv03.c: Add new testcase
In-Reply-To: <1523327559-22075-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180409125757.GA26048@rei.lan>
 <1523327559-22075-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180412111524.GB27415@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Both pushed with a minor changes, thanks.

I've changed the test to close the dev_fd in the test setup() as there
is no need to keep it open during the test. And also removed the
capitalization of the first letter of the syscall from the messages,
which may have caused confusing when grepping the logs.

-- 
Cyril Hrubis
chrubis@suse.cz
