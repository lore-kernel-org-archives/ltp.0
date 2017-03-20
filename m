From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Mar 2017 16:11:04 +0100
Subject: [LTP] [PATCH] setxattr: prefer not to run tests in tmpfs
In-Reply-To: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
References: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
Message-ID: <20170320151104.GB6102@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
NACK tests must not create any files outside it's temporary directory.

We can either exit the test with TCONF if /tmp is on tmpfs or format and
mount a device and run these testcases on a file created there in that
case.

-- 
Cyril Hrubis
chrubis@suse.cz
